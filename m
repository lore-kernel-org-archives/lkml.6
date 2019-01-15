Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28870C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA4620656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfAOEW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:22:26 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37330 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfAOEWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 23:22:25 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id C4B9929E64; Mon, 14 Jan 2019 23:22:23 -0500 (EST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <40e675256e1e3270360440c933085c48b4da38cd.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 03/22] char/nvram: Re-order functions to remove forward
 declarations and #ifdefs
Date:   Tue, 15 Jan 2019 15:18:56 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also give functions more sensible names: nvram_misc_* for misc device ops,
nvram_proc_* for proc file ops and nvram_module_* for init and exit
functions. This prevents name collisions with nvram.h helper functions
and improves readability.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/char/nvram.c | 167 +++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 95 deletions(-)

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index a9d4652f9e90..c660cff9faf4 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -55,11 +55,6 @@ static int nvram_open_mode;	/* special open modes */
 #define NVRAM_WRITE		1 /* opened for writing (exclusive) */
 #define NVRAM_EXCL		2 /* opened with O_EXCL */
 
-#ifdef CONFIG_PROC_FS
-static void pc_nvram_proc_read(unsigned char *contents, struct seq_file *seq,
-			       void *offset);
-#endif
-
 /*
  * These functions are provided to be called internally or by other parts of
  * the kernel. It's up to the caller to ensure correct checksum before reading
@@ -171,14 +166,14 @@ void nvram_set_checksum(void)
  * The are the file operation function for user access to /dev/nvram
  */
 
-static loff_t nvram_llseek(struct file *file, loff_t offset, int origin)
+static loff_t nvram_misc_llseek(struct file *file, loff_t offset, int origin)
 {
 	return generic_file_llseek_size(file, offset, origin, MAX_LFS_FILESIZE,
 					NVRAM_BYTES);
 }
 
-static ssize_t nvram_read(struct file *file, char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t nvram_misc_read(struct file *file, char __user *buf,
+			       size_t count, loff_t *ppos)
 {
 	unsigned char contents[NVRAM_BYTES];
 	unsigned i = *ppos;
@@ -206,8 +201,8 @@ static ssize_t nvram_read(struct file *file, char __user *buf,
 	return -EIO;
 }
 
-static ssize_t nvram_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t nvram_misc_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
 {
 	unsigned char contents[NVRAM_BYTES];
 	unsigned i = *ppos;
@@ -245,8 +240,8 @@ static ssize_t nvram_write(struct file *file, const char __user *buf,
 	return -EIO;
 }
 
-static long nvram_ioctl(struct file *file, unsigned int cmd,
-			unsigned long arg)
+static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
+			     unsigned long arg)
 {
 	int i;
 
@@ -286,7 +281,7 @@ static long nvram_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
-static int nvram_open(struct inode *inode, struct file *file)
+static int nvram_misc_open(struct inode *inode, struct file *file)
 {
 	spin_lock(&nvram_state_lock);
 
@@ -308,7 +303,7 @@ static int nvram_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int nvram_release(struct inode *inode, struct file *file)
+static int nvram_misc_release(struct inode *inode, struct file *file)
 {
 	spin_lock(&nvram_state_lock);
 
@@ -325,87 +320,6 @@ static int nvram_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-#ifndef CONFIG_PROC_FS
-static int nvram_add_proc_fs(void)
-{
-	return 0;
-}
-
-#else
-
-static int nvram_proc_read(struct seq_file *seq, void *offset)
-{
-	unsigned char contents[NVRAM_BYTES];
-	int i = 0;
-
-	spin_lock_irq(&rtc_lock);
-	for (i = 0; i < NVRAM_BYTES; ++i)
-		contents[i] = __nvram_read_byte(i);
-	spin_unlock_irq(&rtc_lock);
-
-	pc_nvram_proc_read(contents, seq, offset);
-
-	return 0;
-}
-
-static int nvram_add_proc_fs(void)
-{
-	if (!proc_create_single("driver/nvram", 0, NULL, nvram_proc_read))
-		return -ENOMEM;
-	return 0;
-}
-
-#endif /* CONFIG_PROC_FS */
-
-static const struct file_operations nvram_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= nvram_llseek,
-	.read		= nvram_read,
-	.write		= nvram_write,
-	.unlocked_ioctl	= nvram_ioctl,
-	.open		= nvram_open,
-	.release	= nvram_release,
-};
-
-static struct miscdevice nvram_dev = {
-	NVRAM_MINOR,
-	"nvram",
-	&nvram_fops
-};
-
-static int __init nvram_init(void)
-{
-	int ret;
-
-	ret = misc_register(&nvram_dev);
-	if (ret) {
-		printk(KERN_ERR "nvram: can't misc_register on minor=%d\n",
-		    NVRAM_MINOR);
-		goto out;
-	}
-	ret = nvram_add_proc_fs();
-	if (ret) {
-		printk(KERN_ERR "nvram: can't create /proc/driver/nvram\n");
-		goto outmisc;
-	}
-	ret = 0;
-	printk(KERN_INFO "Non-volatile memory driver v" NVRAM_VERSION "\n");
-out:
-	return ret;
-outmisc:
-	misc_deregister(&nvram_dev);
-	goto out;
-}
-
-static void __exit nvram_cleanup_module(void)
-{
-	remove_proc_entry("driver/nvram", NULL);
-	misc_deregister(&nvram_dev);
-}
-
-module_init(nvram_init);
-module_exit(nvram_cleanup_module);
-
 #ifdef CONFIG_PROC_FS
 
 static const char * const floppy_types[] = {
@@ -483,7 +397,70 @@ static void pc_nvram_proc_read(unsigned char *nvram, struct seq_file *seq,
 	return;
 }
 
+static int nvram_proc_read(struct seq_file *seq, void *offset)
+{
+	unsigned char contents[NVRAM_BYTES];
+	int i = 0;
+
+	spin_lock_irq(&rtc_lock);
+	for (i = 0; i < NVRAM_BYTES; ++i)
+		contents[i] = __nvram_read_byte(i);
+	spin_unlock_irq(&rtc_lock);
+
+	pc_nvram_proc_read(contents, seq, offset);
+
+	return 0;
+}
 #endif /* CONFIG_PROC_FS */
 
+static const struct file_operations nvram_misc_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= nvram_misc_llseek,
+	.read		= nvram_misc_read,
+	.write		= nvram_misc_write,
+	.unlocked_ioctl	= nvram_misc_ioctl,
+	.open		= nvram_misc_open,
+	.release	= nvram_misc_release,
+};
+
+static struct miscdevice nvram_misc = {
+	NVRAM_MINOR,
+	"nvram",
+	&nvram_misc_fops,
+};
+
+static int __init nvram_module_init(void)
+{
+	int ret;
+
+	ret = misc_register(&nvram_misc);
+	if (ret) {
+		pr_err("nvram: can't misc_register on minor=%d\n", NVRAM_MINOR);
+		return ret;
+	}
+
+#ifdef CONFIG_PROC_FS
+	if (!proc_create_single("driver/nvram", 0, NULL, nvram_proc_read)) {
+		pr_err("nvram: can't create /proc/driver/nvram\n");
+		misc_deregister(&nvram_misc);
+		return -ENOMEM;
+	}
+#endif
+
+	pr_info("Non-volatile memory driver v" NVRAM_VERSION "\n");
+	return 0;
+}
+
+static void __exit nvram_module_exit(void)
+{
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry("driver/nvram", NULL);
+#endif
+	misc_deregister(&nvram_misc);
+}
+
+module_init(nvram_module_init);
+module_exit(nvram_module_exit);
+
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(NVRAM_MINOR);
-- 
2.19.2

