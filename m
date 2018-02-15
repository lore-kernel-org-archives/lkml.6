Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224oKIUTkoYbeGuzC9691puM41Qw4LANpalaWKv+A42gVX4riz5AYXr/1W4KWVrBc0sFzZ0S
ARC-Seal: i=1; a=rsa-sha256; t=1518708561; cv=none;
        d=google.com; s=arc-20160816;
        b=Rk7XsQqCKmcmDVxNXnLAYJKnFv5E5tRmNe/Do8EotYAjD7f8tFWbp1Ra0j5QedlmV4
         pfOJMQPiudtskNMA+faP/COny+eJjAZRddDTYORtj49wZrxXr55mIU1Y5VR7hkIUzQGB
         9yHrJT2b52aft0yuqMtvrZGIVOApbIc5HKWA+RSnnVbOgE2JJ+05xCmY/bsxNxiMYL6w
         LYl6yw3M42w99OusqqPl4HaLCBcOCksDwsVMuqsndxbSUI9B9FIwtw1L+iiK5PIC4hMk
         l2YwCY4E7vq+iwU3mSV6zcHPCuZyslZBCh2F2faxENKLMDNpg8suxWdhUOh9wQg6BrWZ
         nvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/Z+odxrSOTfCnSprv6jwt2ir0Wa3NJ5JrgpqYRbkuWE=;
        b=mrLvYnkPsjlHLRQ0cyyyCFrsYc5gzfjxkBD5lKu8AtOkondocNAW+kPZlSLsivXIuW
         sPw9DSPkKAU3Bm0uA0hoQVGpciEaUbTEiHwklJ0wa5u3Hp+tUi2v8ukDW+iybs+IqhH3
         W/Y9W4jTZUW9LIuZXfH2GSi4skLz1hf8HqdGbB+A/rRhW12S90l3RhYmFHVdbpQqeTWn
         2Ba9orVI+SPWVE/fAb+1MUN8SDryMYH7BnvW3cB1kbTSFrHJktJzuADrhr70yQUl5ONj
         sUiyUm/1yOGNXgG0uOcgGJ+xYwovitDBZurDlG38DgiOFly4fCTpBb/JGgSzhq8lDuMe
         FryA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Raphael Hertzog <raphael@ouaza.com>,
	Amir Goldstein <amir73il@gmail.com>,
	=?UTF-8?q?Rapha=C3=ABl=20Hertzog?= <hertzog@debian.org>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.9 86/88] ovl: fix failure to fsync lower dir
Date: Thu, 15 Feb 2018 16:17:53 +0100
Message-Id: <20180215151234.349440340@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481085875936301?=
X-GMAIL-MSGID: =?utf-8?q?1592481348573312775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit d796e77f1dd541fe34481af2eee6454688d13982 upstream.

As a writable mount, it is not expected for overlayfs to return
EINVAL/EROFS for fsync, even if dir/file is not changed.

This commit fixes the case of fsync of directory, which is easier to
address, because overlayfs already implements fsync file operation for
directories.

The problem reported by Raphael is that new PostgreSQL 10.0 with a
database in overlayfs where lower layer in squashfs fails to start.
The failure is due to fsync error, when PostgreSQL does fsync on all
existing db directories on startup and a specific directory exists
lower layer with no changes.

Reported-by: Raphael Hertzog <raphael@ouaza.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Tested-by: Raphaël Hertzog <hertzog@debian.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/readdir.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -434,10 +434,14 @@ static int ovl_dir_fsync(struct file *fi
 	struct dentry *dentry = file->f_path.dentry;
 	struct file *realfile = od->realfile;
 
+	/* Nothing to sync for lower */
+	if (!OVL_TYPE_UPPER(ovl_path_type(dentry)))
+		return 0;
+
 	/*
 	 * Need to check if we started out being a lower dir, but got copied up
 	 */
-	if (!od->is_upper && OVL_TYPE_UPPER(ovl_path_type(dentry))) {
+	if (!od->is_upper) {
 		struct inode *inode = file_inode(file);
 
 		realfile = lockless_dereference(od->upperfile);
