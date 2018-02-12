Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x226HLaFqOEqUq+zS3WbxbDqgRkt7rkVD6CLg7eYB3PxomrOMxqITonuJfW4Ur2C0BB5RD9g4
ARC-Seal: i=1; a=rsa-sha256; t=1518471087; cv=none;
        d=google.com; s=arc-20160816;
        b=JJkE8ZFm1dwsVimCyxQB4n582Xrv9+D3900VOKVXEcD4NYmF7br1LkCE0/ITk6DGLM
         gKFTI0C1SNV2xDL1aDYImz010+rTgpEzuSm+FtOMYUvTesurMRl6iAiFzjL3FNvIYr4S
         +StO3sdIaR0nSvC4zdMch3SrwHxKe+NgVolTEJ1vD44gxxmCb9X4LDu5bzvRdyBOu3KQ
         Kzuuh+hRGH7ZxLP15fUOjPdo3D+3xu7r8nfcj1um3TACP1/HoKs4El6KtHIYnnCVhkBn
         09zaNEafGWezSpl59VDrjOeDTnynBp4+4RQiMmIEITTSIXmCtcgXAg0ytyJsvoYc5OeB
         OO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=FJCX4MBg5brfEqVtg3+ky9G6rzPwK9HOmKCd1/m0ehU=;
        b=m4rDDA3nv5JxGEcRV1qUNr+MM7iYWKWvQ6DTJhHdRNoMSVb3EqwNHWITwGSSd9r3/T
         y4JIG9mI09aw2E9zhJsIQxXtoOnzAp+OR48d6QB7P1icbJ5Q8nm1Ezz6euTZywT84Qkg
         Md2y2Iq0uKFtp/hui7oeh5GzrqjmwjjWKF2gNsiJ/diyd7GoUHpO/dBDIvctySxBCt6h
         tcbx+ZJxNxw7BPlE8buJ73NVqXLTSdu9fy3S27dG/IY9RjlmdyEZeMJNYVwMCYOl7atW
         t6JduqJHhqaO8zZzvtTOaH3OIcooZlsdjkwGfLuf4j624rgZP46AjNkVqFCX2lK9SDQn
         /3Jw==
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
Subject: [PATCH 2/5] staging: lustre: llite: use d_splice_alias for
 directories.
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151847104797.26699.15971881529877617500.stgit@noble>
In-Reply-To: <151847081541.26699.3911837371411314092.stgit@noble>
References: <151847081541.26699.3911837371411314092.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592232339103633670?=
X-GMAIL-MSGID: =?utf-8?q?1592232339103633670?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the Linux dcache a directory only ever has one dentry,
so d_splice_alias() can be used by ll_splice_alias() for directories.
It will find the one dentry whether it is DCACHE_DISCONNECTED or
IS_ROOT() or d_lustre_invalid().
Separating out the directories from non-directories will allow us
to simplify the non-directory code.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/llite/namei.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/staging/lustre/lustre/llite/namei.c
index a2687f46a16d..60fb18f83bf8 100644
--- a/drivers/staging/lustre/lustre/llite/namei.c
+++ b/drivers/staging/lustre/lustre/llite/namei.c
@@ -434,7 +434,7 @@ static struct dentry *ll_find_alias(struct inode *inode, struct dentry *dentry)
  */
 struct dentry *ll_splice_alias(struct inode *inode, struct dentry *de)
 {
-	if (inode) {
+	if (inode && !S_ISDIR(inode->i_mode)) {
 		struct dentry *new = ll_find_alias(inode, de);
 
 		if (new) {
@@ -445,8 +445,13 @@ struct dentry *ll_splice_alias(struct inode *inode, struct dentry *de)
 			      new, d_inode(new), d_count(new), new->d_flags);
 			return new;
 		}
+		d_add(de, inode);
+	} else {
+		struct dentry *new = d_splice_alias(inode, de);
+
+		if (new)
+			de = new;
 	}
-	d_add(de, inode);
 	CDEBUG(D_DENTRY, "Add dentry %p inode %p refc %d flags %#x\n",
 	       de, d_inode(de), d_count(de), de->d_flags);
 	return de;
