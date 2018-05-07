Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZqWNfyB8RjPyVZ6Z1LocmLiGBtfpfdTXy6DUL82uWUPdS5aTbmC3VIvmlsgoe4f7QJSxBvz
ARC-Seal: i=1; a=rsa-sha256; t=1525654582; cv=none;
        d=google.com; s=arc-20160816;
        b=V8y9tsmxi13zV8XGv2Z+ukqnENzmznLfZcjNK1cyrapSvpovZ3nTDk3MA2pOWaGiBJ
         eb2DlcFdllQmGaUkiETIE/iNvlCej4AlVHORBGt1smtKT9re4GHXomWj9hrvjfw4G8Re
         lAbEx3Zjxo4Jc1sDeVQelnCbtr3KgIkiOjYTwkOMytEKATNBCkva3cpxcI8HinPKd9kC
         KeZFfHy3ywTGDD7PhoN4LkuzR5X8uLkU0/bdkDTQkSgxRml87P0jX7QRTynUtgqb3AIK
         KJR4JOfw6wwzvx32dOy/RyNx5zcVHKb3AUfPujqKaNv3yqplD6lLJHrdRCjc+aj1GprE
         BGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=zJM9tTyfB8qAX5aiV6ZAEXuRolXWXmxkrh2iGYz2I5k=;
        b=XM4csE0KbbhBywwbqgWn+C+A2uuOcVcSd6owwsAAUdn6n8xQ/i+yRm1l1u5iVS8uov
         w5Wb54+CKOasjr7bPxzZ2wmcfnIR1avltFM+j/NkCQlRi9lm5MWuFsKH9+dqfveugimN
         9yaFapR4YFGMU5dItPchEFwAKEOOHwbFbDjA9qBSqP+pwt7H4PGW9LODRzhzics/Yym1
         mw3oyrqKs7Bg7GT6SB87DIb63iHVRcsw3+AbwAwEDfu0VMpXZ6UJhKU07+k6KMly1ewB
         VqySGgMIAIeVcj08MtGJ2bnGHXPFLWObsIrs84xCn53HzbTOXFbk9Hl8CmKphIup3Rf/
         b+SA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 07 May 2018 10:54:48 +1000
Subject: [PATCH 08/10] staging: lustre: move misc-device registration closer
 to related code.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152565448823.30131.117037183796639201.stgit@noble>
In-Reply-To: <152565436690.30131.2229703651041382739.stgit@noble>
References: <152565436690.30131.2229703651041382739.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599764778863074299?=
X-GMAIL-MSGID: =?utf-8?q?1599764778863074299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ioctl handler for the misc device is in  lnet/libcfs/module.c
but is it registered in lnet/libcfs/linux/linux-module.c.

Keeping related code together make maintenance easier, so move the
code.

Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |    2 -
 .../lustre/lnet/libcfs/linux/linux-module.c        |   28 -------------------
 drivers/staging/lustre/lnet/libcfs/module.c        |   30 +++++++++++++++++++-
 3 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
index 6e7754b2f296..9263e151451b 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
@@ -141,11 +141,9 @@ int libcfs_deregister_ioctl(struct libcfs_ioctl_handler *hand);
 int libcfs_ioctl_getdata(struct libcfs_ioctl_hdr **hdr_pp,
 			 const struct libcfs_ioctl_hdr __user *uparam);
 int libcfs_ioctl_data_adjust(struct libcfs_ioctl_data *data);
-int libcfs_ioctl(unsigned long cmd, void __user *arg);
 
 #define _LIBCFS_H
 
-extern struct miscdevice libcfs_dev;
 /**
  * The path of debug log dump upcall script.
  */
diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c
index c8908e816c4c..954b681f9db7 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c
@@ -166,31 +166,3 @@ int libcfs_ioctl_getdata(struct libcfs_ioctl_hdr **hdr_pp,
 	kvfree(*hdr_pp);
 	return err;
 }
-
-static long
-libcfs_psdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if (_IOC_TYPE(cmd) != IOC_LIBCFS_TYPE ||
-	    _IOC_NR(cmd) < IOC_LIBCFS_MIN_NR  ||
-	    _IOC_NR(cmd) > IOC_LIBCFS_MAX_NR) {
-		CDEBUG(D_IOCTL, "invalid ioctl ( type %d, nr %d, size %d )\n",
-		       _IOC_TYPE(cmd), _IOC_NR(cmd), _IOC_SIZE(cmd));
-		return -EINVAL;
-	}
-
-	return libcfs_ioctl(cmd, (void __user *)arg);
-}
-
-static const struct file_operations libcfs_fops = {
-	.owner		= THIS_MODULE,
-	.unlocked_ioctl	= libcfs_psdev_ioctl,
-};
-
-struct miscdevice libcfs_dev = {
-	.minor = MISC_DYNAMIC_MINOR,
-	.name = "lnet",
-	.fops = &libcfs_fops,
-};
diff --git a/drivers/staging/lustre/lnet/libcfs/module.c b/drivers/staging/lustre/lnet/libcfs/module.c
index 4b9acd7bc5cf..f627b2d1beb5 100644
--- a/drivers/staging/lustre/lnet/libcfs/module.c
+++ b/drivers/staging/lustre/lnet/libcfs/module.c
@@ -95,7 +95,7 @@ int libcfs_deregister_ioctl(struct libcfs_ioctl_handler *hand)
 }
 EXPORT_SYMBOL(libcfs_deregister_ioctl);
 
-int libcfs_ioctl(unsigned long cmd, void __user *uparam)
+static int libcfs_ioctl(unsigned long cmd, void __user *uparam)
 {
 	struct libcfs_ioctl_data *data = NULL;
 	struct libcfs_ioctl_hdr *hdr;
@@ -161,6 +161,34 @@ int libcfs_ioctl(unsigned long cmd, void __user *uparam)
 	return err;
 }
 
+static long
+libcfs_psdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (_IOC_TYPE(cmd) != IOC_LIBCFS_TYPE ||
+	    _IOC_NR(cmd) < IOC_LIBCFS_MIN_NR  ||
+	    _IOC_NR(cmd) > IOC_LIBCFS_MAX_NR) {
+		CDEBUG(D_IOCTL, "invalid ioctl ( type %d, nr %d, size %d )\n",
+		       _IOC_TYPE(cmd), _IOC_NR(cmd), _IOC_SIZE(cmd));
+		return -EINVAL;
+	}
+
+	return libcfs_ioctl(cmd, (void __user *)arg);
+}
+
+static const struct file_operations libcfs_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= libcfs_psdev_ioctl,
+};
+
+struct miscdevice libcfs_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "lnet",
+	.fops = &libcfs_fops,
+};
+
 int lprocfs_call_handler(void *data, int write, loff_t *ppos,
 			 void __user *buffer, size_t *lenp,
 			 int (*handler)(void *data, int write, loff_t pos,
