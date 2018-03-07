Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965291AbeCGUOU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:14:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935049AbeCGUOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:14:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C40C20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Wed, 7 Mar 2018 21:14:11 +0100
From: Jessica Yu <jeyu@kernel.org>
To: Jia Zhang <zhang.jia@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] module: Support to show the current enforcement
 policy
Message-ID: <20180307201408.ssuzsmbatntk67yz@redbean>
References: <1519895346-7961-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1519895346-7961-3-git-send-email-zhang.jia@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1519895346-7961-3-git-send-email-zhang.jia@linux.alibaba.com>
X-OS: Linux redbean 4.15.0-next-20180207 x86_64
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jia Zhang [01/03/18 17:09 +0800]:
>/sys/kernel/security/modsign/enforce gives the result of current
>enforcement policy of loading module.
>
>Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

Why is this being added as part of securityfs? AFAIK that's primarily used by LSMs.

And we already export sig_enforce to sysfs (See /sys/module/module/parameters/sig_enforce).
It already does exactly what your patchset tries to do, it only allows for enablement. 

Jessica

>---
> kernel/module.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 55 insertions(+)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index 79825ea..e3c6c8e 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2794,11 +2794,60 @@ static int module_sig_check(struct load_info *info, int flags)
>
> 	return err;
> }
>+
>+#ifdef CONFIG_SECURITYFS
>+static ssize_t modsign_enforce_read(struct file *filp, char __user *ubuf,
>+				    size_t count, loff_t *offp)
>+{
>+	char buf[2];
>+
>+	sprintf(buf, "%d", !!sig_enforce);
>+
>+	return simple_read_from_buffer(ubuf, count, offp, buf, 1);
>+}
>+
>+static const struct file_operations modsign_enforce_ops = {
>+	.read = modsign_enforce_read,
>+	.llseek = generic_file_llseek,
>+};
>+
>+static int __init securityfs_init(void)
>+{
>+	struct dentry *modsign_dir;
>+	struct dentry *enforce;
>+
>+	modsign_dir = securityfs_create_dir("modsign", NULL);
>+	if (IS_ERR(modsign_dir))
>+		return -1;
>+
>+	enforce = securityfs_create_file("enforce",
>+					 S_IRUSR | S_IRGRP, modsign_dir,
>+					 NULL, &modsign_enforce_ops);
>+	if (IS_ERR(enforce))
>+		goto out;
>+
>+	return 0;
>+out:
>+	securityfs_remove(modsign_dir);
>+
>+	return -1;
>+}
>+#else /* !CONFIG_SECURITYFS */
>+static int __init securityfs_init(void)
>+{
>+	return 0;
>+}
>+#endif
> #else /* !CONFIG_MODULE_SIG */
> static int module_sig_check(struct load_info *info, int flags)
> {
> 	return 0;
> }
>+
>+static int __init securityfs_init(void)
>+{
>+	return 0;
>+}
> #endif /* !CONFIG_MODULE_SIG */
>
> /* Sanity checks against invalid binaries, wrong arch, weird elf version. */
>@@ -4395,8 +4444,14 @@ void module_layout(struct module *mod,
>
> static int __init initialize_module(void)
> {
>+	int ret;
>+
> 	proc_modules_init();
>
>+	ret = securityfs_init();
>+	if (unlikely(ret))
>+		return ret;
>+
> 	return 0;
> }
> module_init(initialize_module);
>-- 
>1.8.3.1
>
