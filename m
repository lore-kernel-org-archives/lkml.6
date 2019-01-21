Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ED0C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34ABD21726
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548088010;
	bh=ivb6FET/75tes04EFLig2SXP8yPgwTA8LdPoxQ1sc1k=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=riAvv6rp7zZxMA0N8vh5Iu3g+fqFcdOU34vyNaH5tmRA/Xd0HGzMzhfYmCvxCaPY7
	 zFTK5cP6b2nwZwjTnsKOjfh9DI1QYbHsp3e5vIibuIjTjXAZDjZvcvenmZwykqw4Ej
	 aovjMEgmJVB86MCt+Gu1la0II1NS5t8xsBGOldCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfAUQ0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfAUQ0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:26:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C5621019;
        Mon, 21 Jan 2019 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548088005;
        bh=ivb6FET/75tes04EFLig2SXP8yPgwTA8LdPoxQ1sc1k=;
        h=Date:From:To:Cc:Subject:From;
        b=EIorTJ7LmMh/xD6sndMoVqZxTENVXX5tdxnO5g357ymmuRi13Fvw7m2AFI3labh6c
         G+2UxsoZ5aG/jcWIiXlijNbvOOVIlgFSSvIl9/gCi11+l2FAywFCPRhTugxnwAEh8S
         rDTtpKG5wNmSWNhYPQMihNgveXCSInBfzMKfB+sk=
Date:   Mon, 21 Jan 2019 17:26:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] tty: ldisc: add sysctl to prevent autoloading of ldiscs
Message-ID: <20190121162642.GA2944@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the kernel will automatically load the module of any line
dicipline that is asked for.  As this sometimes isn't the safest thing
to do, provide a sysctl to disable this feature.

By default, we set this to 'y' as that is the historical way that Linux
has worked, and we do not want to break working systems.  But in the
future, perhaps this can default to 'n' to prevent this functionality.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Every once in a while people are really surprised that any line
discipline can be loaded by any user.  Despite the ability to just
disable the modules from the modules.conf file, sometimes it is good to
provide protection from within the kernel instead of relying on a module
configuration file.

So that's why I wrote this patch up.  Anyone have any objections to it.
It keeps the functionality that we have today by default, but allows
admins to disable the auto-loading if they want to at runtime.



 drivers/tty/Kconfig     | 24 +++++++++++++++++++++
 drivers/tty/tty_io.c    |  3 +++
 drivers/tty/tty_ldisc.c | 47 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 0840d27381ea..e0a04bfc873e 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -441,4 +441,28 @@ config VCC
 	depends on SUN_LDOMS
 	help
 	  Support for Sun logical domain consoles.
+
+config LDISC_AUTOLOAD
+	bool "Automatically load TTY Line Disciplines"
+	default y
+	help
+	  Historically the kernel has always automatically loaded any
+	  line discipline that is in a kernel module when a user asks
+	  for it to be loaded with the TIOCSETD ioctl, or through other
+	  means.  This is not always the best thing to do on systems
+	  where you know you will not be using some of the more
+	  "ancient" line disciplines, so prevent the kernel from doing
+	  this unless the request is coming from a process with the
+	  CAP_SYS_MODULE permissions.
+
+	  Say 'Y' here if you trust your userspace users to do the right
+	  thing, or if you have only provided the line disciplines that
+	  you know you will be using, or if you wish to continue to use
+	  the traditional method of on-demand loading of these modules
+	  by any user.
+
+	  This functionality can be changed at runtime with the
+	  dev.tty.ldisc_autoload sysctl, this configuration option will
+	  only set the default value of this functionality.
+
 endif # TTY
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 21ffcce16927..5fa250157025 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -513,6 +513,8 @@ static const struct file_operations hung_up_tty_fops = {
 static DEFINE_SPINLOCK(redirect_lock);
 static struct file *redirect;
 
+extern void tty_sysctl_init(void);
+
 /**
  *	tty_wakeup	-	request more data
  *	@tty: terminal
@@ -3483,6 +3485,7 @@ void console_sysfs_notify(void)
  */
 int __init tty_init(void)
 {
+	tty_sysctl_init();
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 45eda69b150c..e38f104db174 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -156,6 +156,13 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
  *		takes tty_ldiscs_lock to guard against ldisc races
  */
 
+#if defined(CONFIG_LDISC_AUTOLOAD)
+	#define INITIAL_AUTOLOAD_STATE	1
+#else
+	#define INITIAL_AUTOLOAD_STATE	0
+#endif
+static int tty_ldisc_autoload = INITIAL_AUTOLOAD_STATE;
+
 static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 {
 	struct tty_ldisc *ld;
@@ -170,6 +177,8 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 	 */
 	ldops = get_ldops(disc);
 	if (IS_ERR(ldops)) {
+		if (!capable(CAP_SYS_MODULE) && !tty_ldisc_autoload)
+			return ERR_PTR(-EPERM);
 		request_module("tty-ldisc-%d", disc);
 		ldops = get_ldops(disc);
 		if (IS_ERR(ldops))
@@ -845,3 +854,41 @@ void tty_ldisc_deinit(struct tty_struct *tty)
 		tty_ldisc_put(tty->ldisc);
 	tty->ldisc = NULL;
 }
+
+static int zero;
+static int one = 1;
+static struct ctl_table tty_table[] = {
+	{
+		.procname	= "ldisc_autoload",
+		.data		= &tty_ldisc_autoload,
+		.maxlen		= sizeof(tty_ldisc_autoload),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+	{ }
+};
+
+static struct ctl_table tty_dir_table[] = {
+	{
+		.procname	= "tty",
+		.mode		= 0555,
+		.child		= tty_table,
+	},
+	{ }
+};
+
+static struct ctl_table tty_root_table[] = {
+	{
+		.procname	= "dev",
+		.mode		= 0555,
+		.child		= tty_dir_table,
+	},
+	{ }
+};
+
+void tty_sysctl_init(void)
+{
+	register_sysctl_table(tty_root_table);
+}
-- 
2.20.1

