Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520960136; cv=none;
        d=google.com; s=arc-20160816;
        b=G2mE/LJtr2vIxrJioNy0RZpZwaQYN7sAQWF8u0eSvFM3mFE80f+0Wk6DZ/+Y9AZEep
         DXDkVri4kei8ugPjfoXUrx+pqf0xYvhv7chWh3re6tdGcR7UY+Dn8gQsNGf6/T/Z/YXC
         QAKyblOZJxr+Ex4okwobadYma6JlPBbj6DMDqMDc5MgLUH2ahfe+oA5nWw6tZGLUvhcG
         VfUGefvj6A9qeiLVie5jYALWc0KrXBTgYzbjFK7aPcRK/qIrsjR1bjNUkuvJfWn5zD/L
         fWtzk2y11I++Ep66qIxOMteum+6ueMLeSiPWuw9artTx8b3NN+GOUT7SsIez3zT9PuB8
         /VoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=bv+oQvsOje9d6G3OSc9VuGO1o+H11KuvSeNs2NTn+mw=;
        b=yReQlnPxSkndz2d0dpzoWVIgKLSBwJuqjVjrjoyu+PjgXbkqQXMHTp/TZE1nISdfZt
         RcH8zbco824xeRh/swrlnzKX7+O4HmfWEkPHk/0ixVsXyPSgsMkaxZuc00WpFwZq+/C1
         CETAliBqHEnQzkndS3t4Mp5rdJDuquUYyW742AUCMqZybLCjhrO5IoN3iUmZ3MbEBg1I
         08CO0OpVLyovgw9BT/aExxbGUpDbdeIVdB33cQTwsj6oDI4cHTTMF5B/RvlqUSkHozCE
         C4eAZbsjwbq4z/82O+Fr/I+x3vSPOr4paL0svsKgPpmvaW/5EOChuM37DW4Z2BHqSeGW
         wfZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AG47ELtWhCfJuLtZBynd29AGTzTG4W4o3hB/a9BxjCER1v74KCTeai6VI98e4MFChklLaaaWBGNzLg==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	ebiederm@xmission.com,
	torvalds@linux-foundation.org,
	gregkh@linuxfoundation.org
Cc: containers@lists.linux-foundation.org,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/4 v5 RESEND] devpts: hoist out check for DEVPTS_SUPER_MAGIC
Date: Tue, 13 Mar 2018 17:55:24 +0100
Message-Id: <20180313165527.24038-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180313165527.24038-1-christian.brauner@ubuntu.com>
References: <20180313165527.24038-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594842296498151684?=
X-GMAIL-MSGID: =?utf-8?q?1594842296498151684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hoist the check whether we have already found a suitable devpts filesystem
out of devpts_ptmx_path() in preparation for the devpts bind-mount
resolution patch. This is a non-functional change.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
---
ChangeLog v4->v5:
* dput() dentry
ChangeLog v3->v4:
* patch unchanged
ChangeLog v2->v3:
* patch unchanged
ChangeLog v1->v2:
* patch added
ChangeLog v0->v1:
* patch not present
---
 fs/devpts/inode.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index e31d6ed3ec32..71b901936113 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -138,10 +138,6 @@ static int devpts_ptmx_path(struct path *path)
 	struct super_block *sb;
 	int err;
 
-	/* Has the devpts filesystem already been found? */
-	if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
-		return 0;
-
 	/* Is a devpts filesystem at "pts" in the same directory? */
 	err = path_pts(path);
 	if (err)
@@ -159,21 +155,25 @@ static int devpts_ptmx_path(struct path *path)
 struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
 {
 	struct path path;
-	int err;
+	int err = 0;
 
 	path = filp->f_path;
 	path_get(&path);
 
-	err = devpts_ptmx_path(&path);
+	/* Has the devpts filesystem already been found? */
+	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC)
+		err = devpts_ptmx_path(&path);
 	dput(path.dentry);
 	if (err) {
 		mntput(path.mnt);
 		return ERR_PTR(err);
 	}
+
 	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
 		mntput(path.mnt);
 		return ERR_PTR(-ENODEV);
 	}
+
 	return path.mnt;
 }
 
@@ -182,15 +182,19 @@ struct pts_fs_info *devpts_acquire(struct file *filp)
 	struct pts_fs_info *result;
 	struct path path;
 	struct super_block *sb;
-	int err;
 
 	path = filp->f_path;
 	path_get(&path);
 
-	err = devpts_ptmx_path(&path);
-	if (err) {
-		result = ERR_PTR(err);
-		goto out;
+	/* Has the devpts filesystem already been found? */
+	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) {
+		int err;
+
+		err = devpts_ptmx_path(&path);
+		if (err) {
+			result = ERR_PTR(err);
+			goto out;
+		}
 	}
 
 	/*
-- 
2.15.1
