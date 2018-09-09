Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86D5C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 04:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8EE2087E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 04:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8EE2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeIIJAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 05:00:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42934 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeIIJAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 05:00:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fyr4F-0004NB-Kp; Sun, 09 Sep 2018 04:11:33 +0000
Date:   Sun, 9 Sep 2018 05:11:23 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/11] compat_ioctl: remove /dev/random commands
Message-ID: <20180909041114.GD19965@ZenIV.linux.org.uk>
References: <20180908142837.2819693-1-arnd@arndb.de>
 <20180908142837.2819693-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180908142837.2819693-6-arnd@arndb.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 04:28:12PM +0200, Arnd Bergmann wrote:
> These are all handled by the random driver, so instead of listing
> each ioctl, we can just use the same function to deal with both
> native and compat commands.

Umm...  I don't think it's right -

>  	.unlocked_ioctl = random_ioctl,
> +	.compat_ioctl = random_ioctl,


->compat_ioctl() gets called in
                        error = f.file->f_op->compat_ioctl(f.file, cmd, arg);
so you do *NOT* get compat_ptr() for those - they have to do it on their
own.  It's not hard to provide a proper compat_ioctl() instance for that
one, but this is not it.  What you need in drivers/char/random.c part of
that one is something like

diff --git a/drivers/char/random.c b/drivers/char/random.c
index bf5f99fc36f1..1de75c784cf6 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1954,10 +1954,9 @@ static ssize_t random_write(struct file *file, const char __user *buffer,
 	return (ssize_t)count;
 }
 
-static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+static long __random_ioctl(struct file *f, unsigned int cmd, int __user *p)
 {
 	int size, ent_count;
-	int __user *p = (int __user *)arg;
 	int retval;
 
 	switch (cmd) {
@@ -2011,6 +2010,18 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	}
 }
 
+static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	return __random_ioctl(f, cmd, (int __user *)arg);
+}
+
+#ifdef CONFIG_COMPAT
+static long compat_random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	return __random_ioctl(f, cmd, compat_ptr(arg));
+}
+#endif
+
 static int random_fasync(int fd, struct file *filp, int on)
 {
 	return fasync_helper(fd, filp, on, &fasync);
@@ -2021,6 +2032,9 @@ const struct file_operations random_fops = {
 	.write = random_write,
 	.poll  = random_poll,
 	.unlocked_ioctl = random_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = compat_random_ioctl,
+#endif
 	.fasync = random_fasync,
 	.llseek = noop_llseek,
 };
