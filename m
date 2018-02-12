Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x227TsLzD6JTuqPg5kNGZ7Bp8aKfBZQXL4hbkvWsvBoGi/ANQ7mG5uAPIAuU1XnvZx3qc5j88
ARC-Seal: i=1; a=rsa-sha256; t=1518471079; cv=none;
        d=google.com; s=arc-20160816;
        b=urg/zXHKG1q76IcPHYM8L3j4Vi/Kzm/0D9clbUd4SA0zbVGQt6EPiO3FOwPIvU8UW2
         Kn54oPwQUSYKA+5HciiFk7VkEY3+qxLIgUEJ6d7U5hx/8Rb5v+Awmtpj+ivQaD4HXyG8
         x4xNL3stcaqKWskFb5k2I0NBlUTfNyBgCfzfIf29I+MnoIwaNYRDa8mnkDDDVU3ldtVa
         BYWCgnsDqBGwKfFVEddsh29cjD0GgnuwOqSFDY6JWcO0m8T1yKCLt3S90FhJ+qJ7lZHk
         kIf6pl/yzK0wwIjDN7iSBihUgIztrGwGTN3lOMJfys3vFO+CZbzWJme4CJIYxkB6dWHx
         7q7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=bybd3I1RwW1nhYG0thXTK6uT/to32XzUDjyG7xOET80=;
        b=gJifenBFvO0T7friGQEqYDKrE6bxmzxt7JCJgsd/vgr8+yGF+F0WOCcSMF+w41xEwq
         vAOL1VGLml9FCERxPKku6+buP8W2uH6oSX62stjYNszLRxdqHG4162bFLhnnoJm+0l68
         Nu8EboVnDUQUk+Gr3RkMjVvH4ALosny8NZeLvH6lvEIC+lpVejHtFikA+U+7GWwuYlrV
         A81641mk3eQGxr9wKmjAnb1SX0nzBIC/gUWwE/KllgZzpXdMMCNWfoPGgksQr1E5+0Uv
         NEWw1tncVm5JsNLeSAvdCllJZsFN7FDPm5rcF7vpjw1MuoJ1OF88ALod6FmcW2h5dk61
         GUbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>, Al Viro <viro@ZenIV.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2018 08:30:47 +1100
Subject: [PATCH 1/5] staging: lustre: llite: handle DCACHE_PAR_LOOKUP in
 ll_dcompare
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847104793.26699.5632904371432185858.stgit@noble>
In-Reply-To: <151847081541.26699.3911837371411314092.stgit@noble>
References: <151847081541.26699.3911837371411314092.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592232330850537692?=
X-GMAIL-MSGID: =?utf-8?q?1592232330850537692?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ll_dcompare is used in two slightly different contexts.
It is called (from __d_lookup, __d_lookup_rcu, and d_exact_alias)
to compare a name against a dentry that is already in the dcache.
It is also called (from d_alloc_parallel) to compare a name against
a dentry that is not in the dcache yet, but is part of an active
"lookup" or "atomic_open" call.

In the first case we need to avoid matching against "invalid" dentries
as a match implies something about ldlm locks which is not accurate.
In the second case we need to allow matching against "invalid" dentries
as the dentry will always be invalid (set by ll_d_init()) but we still
want to guard against multiple concurrent lookups of the same name.
d_alloc_parallel() will repeat the call to ll_dcompare() after
the lookup has finished, and if the dentry is still invalid, the whole
d_alloc_parallel() process is repeated.  This assures us that it is safe
to report success whenever d_in_lookup().

With this patch, there will never be two threads concurrently in
ll_lookup_nd(), looking up the same name in the same directory.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/llite/dcache.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/lustre/lustre/llite/dcache.c b/drivers/staging/lustre/lustre/llite/dcache.c
index 549369739d80..dc30b4582234 100644
--- a/drivers/staging/lustre/lustre/llite/dcache.c
+++ b/drivers/staging/lustre/lustre/llite/dcache.c
@@ -74,6 +74,12 @@ static void ll_release(struct dentry *de)
  * an AST before calling d_revalidate_it().  The dentry still exists (marked
  * INVALID) so d_lookup() matches it, but we have no lock on it (so
  * lock_match() fails) and we spin around real_lookup().
+ *
+ * This race doesn't apply to lookups in d_alloc_parallel(), and for
+ * those we want to ensure that only one dentry with a given name is
+ * in ll_lookup_nd() at a time.  So allow invalid dentries to match
+ * while d_in_lookup().  We will be called again when the lookup
+ * completes, and can give a different answer then.
  */
 static int ll_dcompare(const struct dentry *dentry,
 		       unsigned int len, const char *str,
@@ -93,6 +99,10 @@ static int ll_dcompare(const struct dentry *dentry,
 	if (d_mountpoint((struct dentry *)dentry))
 		return 0;
 
+	/* ensure exclusion against parallel lookup of the same name */
+	if (d_in_lookup((struct dentry*)dentry))
+		return 0;
+
 	if (d_lustre_invalid(dentry))
 		return 1;
 
