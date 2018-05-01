Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZoeEkyOqs3XBFla36TW/Ij4QmfApKbU3e+5JKO8oKdTwnuUhQHrkS55yY+yu/otZQh9ZIDV
ARC-Seal: i=1; a=rsa-sha256; t=1525146842; cv=none;
        d=google.com; s=arc-20160816;
        b=i8YvEz9AfFdov1ijWSs/vKNcbvzovHkr6zJdQL3u/6Qhx5UmZTwtQzGENCRPtL9kYN
         Dq502wL+f2z6iJLjhRJ36vexXqspbVXMf3GI382+oHpaqAm31vOwY/GkbmRRdapopr7D
         x3LI4U9dj+hPcDgOvuQSuUqCEjsww+Cia9cnt2CWDtOZVN6NS1FM9dCSkP7+MpElVUAo
         wp2hjGgcwAv2BdZce5JCnlsdbix5xE/iKqk9vxE447Zk15HfxcPdIgN61fYxDoLSJD5F
         iu1aa0TSEO+Xe9vMeXfG/4cR5JvuNf54b/m1yCfTENl/Ylk5be7HxLdLbEbwjbR7VfOb
         BlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=pM2bWkPvq0iCemUVuf66g/qo+5OTdmblgEOvGKafcPA=;
        b=rFhM4wdv1C8BIrwlkypLQPN2v6ILpFsMEyTEKj2+LdhJEgMn9kTarFIqHNVWB3zxQV
         WflW0XWwUOi7bkg+wuVm4KOyeQzYRcjERhYo+itmy9vODdNHCLpeoNcKnzTI4bR3mAiS
         JZ00woBw91sIaIQonzdJ8PZSQYIFrOsunDCn0lv6EZbUA56ZeJfP2yDwe6W77Waf+CsX
         wx0Pr2ZRjq1d2phKYDH6N26tRIpxmzFwS06z5UEAYgfNWgLfraeMKtToopxT+ACKkYF0
         d1f1chIiPIm8h2Ndg0Rte/kBDNqkMMmDSFSBLj33FKHQnN4V3lfe0i3OVtRcG2fjU3HN
         gsjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Tue, 01 May 2018 13:52:39 +1000
Subject: [PATCH 08/10] staging: lustre: move misc-device registration closer
 to related code.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152514675910.17843.16005951911891583421.stgit@noble>
In-Reply-To: <152514658325.17843.11455067361317157487.stgit@noble>
References: <152514658325.17843.11455067361317157487.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232376014079452?=
X-GMAIL-MSGID: =?utf-8?q?1599232376014079452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ioctl handler for the misc device is in  lnet/libcfs/module.c
but is it registered in lnet/libcfs/linux/linux-module.c.

Keeping related code together make maintenance easier, so move the
code.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |    2 -
 .../lustre/lnet/libcfs/linux/linux-module.c        |   28 ------------------
 drivers/staging/lustre/lnet/libcfs/module.c        |   31 +++++++++++++++++++-
 3 files changed, 30 insertions(+), 31 deletions(-)

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
index 4b9acd7bc5cf..3fb150a57f49 100644
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
@@ -161,6 +161,35 @@ int libcfs_ioctl(unsigned long cmd, void __user *uparam)
 	return err;
 }
 
+
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
