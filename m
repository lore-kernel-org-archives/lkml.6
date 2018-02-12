Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x226omSbUA/QcCgGhXE6PaYL2ReWQnNogTgSF6sUGXCXgc0ZAQYfnccvdFB98xn1XzKfQwfb+
ARC-Seal: i=1; a=rsa-sha256; t=1518471094; cv=none;
        d=google.com; s=arc-20160816;
        b=wXgyqj0lHss8TbjBVim+8chbYpUR/YzmxUKF8lNy4abRSvQx5Tz/8Tppieam80LPzC
         g5XKQBf9DJ8sZUAM+VbJJis8F2jO3ny2e8yx4sjA55E3hIwNWAfriLTOor+IQsFqnwNx
         CAvZ5o1NeGub3XvZpUXmppsd9HkQoCY+CCOiHnt4s12iW7+WOpFll7ekSbcXrfL515m6
         kwPQJD39w6Sd42c1xKBe/TlbGa3GPHO50RHsK06XvSAZWS0/O/baY5w13RwXPvk6gS3Z
         L60dMeiUv2+4tRavv3FNYz/ofujDrhnGRLqbOXo6W2XC1q34gKnQf0fVaHpOgiFu7tMn
         f4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=C+diicdm/ptQ/X5OgPIV59FfbAUYvqFzyR/R/OYbcHA=;
        b=rEJEGaC1fiMAflWHtFqu4WjeYuD3U57Rm/YHVTPKMCc44zQuP913FKuuL2V2fsCWbe
         EHhZ+W5ISqQzh+Kxfy1biakrobg/MvBJMcKQKcwj3qYoSMGV+hfFBye0dza7qee4QhAN
         Uo/0TJVpbNxYk5WfiMa3panvuBUlLj2emRo2EKR73hxKbvBM0LzKuxaYATmB8h80K1io
         8USTEldgi0av4ArPNRVV1Kq36jV/XOaGPRWGD889xqZXb3FWZEVH8GB3/38EXQRC4Ptq
         8/xs4/UY54djeglOvM0LHodv8GE2li7/93TzolHKf0BxvuJdDfM58ipX8C/n2PQSfd4t
         C8Zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>, Al Viro <viro@ZenIV.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2018 08:30:48 +1100
Subject: [PATCH 3/5] staging: lustre: llite: remove directory-specific code
 from ll_find_alias()
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847104800.26699.1742105991834584712.stgit@noble>
In-Reply-To: <151847081541.26699.3911837371411314092.stgit@noble>
References: <151847081541.26699.3911837371411314092.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592232346163869586?=
X-GMAIL-MSGID: =?utf-8?q?1592232346163869586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that ll_find_alias() is never called for directories,
we can remove code that only applies to directories.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/llite/namei.c |   26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/staging/lustre/lustre/llite/namei.c
index 60fb18f83bf8..2322328155d6 100644
--- a/drivers/staging/lustre/lustre/llite/namei.c
+++ b/drivers/staging/lustre/lustre/llite/namei.c
@@ -380,21 +380,15 @@ void ll_i2gids(__u32 *suppgids, struct inode *i1, struct inode *i2)
 }
 
 /*
- * try to reuse three types of dentry:
- * 1. unhashed alias, this one is unhashed by d_invalidate (but it may be valid
- *    by concurrent .revalidate).
- * 2. INVALID alias (common case for no valid ldlm lock held, but this flag may
- *    be cleared by others calling d_lustre_revalidate).
- * 3. DISCONNECTED alias.
+ * Try to reuse unhashed or invalidated dentries.
  */
 static struct dentry *ll_find_alias(struct inode *inode, struct dentry *dentry)
 {
-	struct dentry *alias, *discon_alias, *invalid_alias;
+	struct dentry *alias, *invalid_alias;
 
 	if (hlist_empty(&inode->i_dentry))
 		return NULL;
 
-	discon_alias = NULL;
 	invalid_alias = NULL;
 
 	spin_lock(&inode->i_lock);
@@ -402,22 +396,18 @@ static struct dentry *ll_find_alias(struct inode *inode, struct dentry *dentry)
 		LASSERT(alias != dentry);
 
 		spin_lock(&alias->d_lock);
-		if ((alias->d_flags & DCACHE_DISCONNECTED) &&
-		    S_ISDIR(inode->i_mode))
-			/* LASSERT(last_discon == NULL); LU-405, bz 20055 */
-			discon_alias = alias;
-		else if (alias->d_parent == dentry->d_parent	     &&
-			 alias->d_name.hash == dentry->d_name.hash       &&
-			 alias->d_name.len == dentry->d_name.len	 &&
-			 memcmp(alias->d_name.name, dentry->d_name.name,
-				dentry->d_name.len) == 0)
+		if (alias->d_parent == dentry->d_parent	     &&
+		    alias->d_name.hash == dentry->d_name.hash       &&
+		    alias->d_name.len == dentry->d_name.len	 &&
+		    memcmp(alias->d_name.name, dentry->d_name.name,
+			   dentry->d_name.len) == 0)
 			invalid_alias = alias;
 		spin_unlock(&alias->d_lock);
 
 		if (invalid_alias)
 			break;
 	}
-	alias = invalid_alias ?: discon_alias ?: NULL;
+	alias = invalid_alias ?: NULL;
 	if (alias) {
 		spin_lock(&alias->d_lock);
 		dget_dlock(alias);
