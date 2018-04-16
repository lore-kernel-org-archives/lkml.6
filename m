Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx49M2qZx5b1NAdo3LuWIwBEKtrFk9Xy8GvkN/ZJSQrmtPF6/cEa/C5+BqedRvvCABrEwCesq
ARC-Seal: i=1; a=rsa-sha256; t=1523839416; cv=none;
        d=google.com; s=arc-20160816;
        b=Ip4jLVTa2b91OMs7ucGvgZPrUiAHs61cfhl1nKbBYbQUVGyIl1VmGdaJD+dqIGrWe9
         zesEJdokznBgS1vLWvda8x9pmyT8tIETbeiMj1vldq6/4M39bwJS256DTESMUvDERC/5
         5IETCg7chkmGtzNo1fp9ifIMO3iSrGdII5fJEGgKDaGR+090XUw8fo4EgGOqiipWlPN7
         YxHrYPWSqpag1tizLnuDYkpAWQ+AEZpEgKGvJPwCqR98eEBZzg+CCa1N9yrw/lHeLglC
         AM42wCFdsTnxDLlfRZRfOB1DP0b2Ob/FjhP9rVJVki7aoFZyZfl/0nGqzznTxtWiBzkx
         llVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=LQxWrg+rxnDjMeki3lBOonqx4Qah16RxQBG7gg8nlJY=;
        b=X8VkJdMuCfiEkfJf+w1Be391kNZ2lDamQj7dC9AN6rAqusTRmS9A+tgTDhD0mB6HsT
         cHLtYb1F/EhjGFu2rnPA2jBuvl6vv/3JtDg0rpFajanWt+qoNf68dnRni/PxO5t9GISZ
         sPmbcJ0bsl+W8lm1Lr9zO+nFMUqMOXyFXRAcrZCC11zavkK1bE2/jT3HaPtCagqQrqFL
         Kj8Nu74kqJFFscdWdasomJiShna7o/JvM27IcUY2SkW7DbxH5B7twpsmWTdZoKLUVdSE
         CDK8SoOIMICf+T0+XfJ0J1RHk1uOXzDHWuqIXhlnV5uaVifOH+0uOCzEUYggo92u9Fo7
         w7hA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 16 Apr 2018 10:42:37 +1000
Subject: [PATCH 5/6] staging: lustre: move misc-device registration closer
 to related code.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152383935745.23409.17743342143483291145.stgit@noble>
In-Reply-To: <152383910760.23409.2327082725637657049.stgit@noble>
References: <152383910760.23409.2327082725637657049.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597861439657084520?=
X-GMAIL-MSGID: =?utf-8?q?1597861439657084520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ioctl handler for the misc device is in  lnet/libcfs/module.c
but is it registered in lnet/libcfs/linux/linux-module.c.

Keeping related code together make maintenance easier, so move the
code.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |    2 -
 .../lustre/lnet/libcfs/linux/linux-module.c        |   28 ------------------
 drivers/staging/lustre/lnet/libcfs/module.c        |   31 +++++++++++++++++++-
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
index aca1f19c4977..19dae42b9a94 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
@@ -140,11 +140,9 @@ int libcfs_deregister_ioctl(struct libcfs_ioctl_handler *hand);
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
index f93f3cf58127..aab0eb7b7632 100644
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
