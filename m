Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x225E0JXR8BS417z1W/pon3LhGAL9cmmdBuNO9FuGYkTabXQAciu7Oowy3difaeOVxY7oL2bV
ARC-Seal: i=1; a=rsa-sha256; t=1518471101; cv=none;
        d=google.com; s=arc-20160816;
        b=jmLpleuBknsyP6ZPKnMLdQBdIxVixiyobJ2edGgSqUQ2Hju4lgWqwk7EIx6aJ82g+3
         tIQnQZ2Zrn4rJWYW36/O1jM8ko7uoyVa6ZIUMqoK++pVk68Qhzo5agp0agPviT8vivKI
         l6Mz7ifBwC99XyhuTtaV77JqaOHKfRJYkoNbD1NxyDn/KR8EKyMZk0d5UfFMtUp9pOBm
         xsIqcnYEat0oE/Wxg3ELy60uNC4DA1BTiq+X1I5A/bLDTayKOiA1ebfA0oooNZkfyhWr
         52193HaFserv42N4H7jhkbCMuh17IyXLuP9Q82ARWVrJw/FQjL4XPp7yqTXMSY2XglMd
         74Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=WOLJyu/1h0DOrLc9jwi/C+LrAZAidrkqrmPOPoJE+M0=;
        b=feVSzJLXje5YDZYasrSf40DB0fWi+4v0IU8UZI5gIlgHDTkBYUI+aswgtj4+HbaPfH
         8Ab+ngEDJPdSg5WiquMYgjcQny7h/Xmt7b1t1wWYZhR04hKEyWhDLHjtHUdKByH3Ulei
         MnPSYRWvMvmXkNqxzQfEPk4cNGo5gKypV5FAru9HvNg9bsTPvbb7cwmdyqcJ3HP819lF
         UgXFoc8yCioX6azsSLftvfVbRhYLdpvbnLO996HyoWe/eG9ZbPQzJ7wlNGp/eWtk3ywP
         mA8GSi1Mq94X0FcJ2RJxGNASoYajkQkESpFdRBeemLRUuf5sqGC9dH2vSk6Nw4TD85FP
         wxhw==
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
Subject: [PATCH 4/5] staging: lustre: llite: simplify ll_find_alias()
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847104803.26699.4826721577063033284.stgit@noble>
In-Reply-To: <151847081541.26699.3911837371411314092.stgit@noble>
References: <151847081541.26699.3911837371411314092.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592232354102823818?=
X-GMAIL-MSGID: =?utf-8?q?1592232354102823818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that ll_find_alias is only searching for one type
of dentry, we can return as soon as we find it.
This allows substantial simplification, and brings the
bonus that we don't need to take the d_lock again just
to increment the ref-count.  We can increment it immediately
that the dentry is found.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/llite/namei.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/staging/lustre/lustre/llite/namei.c
index 2322328155d6..baf94f4bcee9 100644
--- a/drivers/staging/lustre/lustre/llite/namei.c
+++ b/drivers/staging/lustre/lustre/llite/namei.c
@@ -384,13 +384,11 @@ void ll_i2gids(__u32 *suppgids, struct inode *i1, struct inode *i2)
  */
 static struct dentry *ll_find_alias(struct inode *inode, struct dentry *dentry)
 {
-	struct dentry *alias, *invalid_alias;
+	struct dentry *alias;
 
 	if (hlist_empty(&inode->i_dentry))
 		return NULL;
 
-	invalid_alias = NULL;
-
 	spin_lock(&inode->i_lock);
 	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
 		LASSERT(alias != dentry);
@@ -400,22 +398,17 @@ static struct dentry *ll_find_alias(struct inode *inode, struct dentry *dentry)
 		    alias->d_name.hash == dentry->d_name.hash       &&
 		    alias->d_name.len == dentry->d_name.len	 &&
 		    memcmp(alias->d_name.name, dentry->d_name.name,
-			   dentry->d_name.len) == 0)
-			invalid_alias = alias;
-		spin_unlock(&alias->d_lock);
-
-		if (invalid_alias)
-			break;
-	}
-	alias = invalid_alias ?: NULL;
-	if (alias) {
-		spin_lock(&alias->d_lock);
-		dget_dlock(alias);
+			   dentry->d_name.len) == 0) {
+			dget_dlock(alias);
+			spin_unlock(&alias->d_lock);
+			spin_unlock(&inode->i_lock);
+			return alias;
+		}
 		spin_unlock(&alias->d_lock);
 	}
 	spin_unlock(&inode->i_lock);
 
-	return alias;
+	return NULL;
 }
 
 /*
