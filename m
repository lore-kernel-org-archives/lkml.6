Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C3FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A01208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A01208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeK0K3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:29:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbeK0K3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:29:50 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 86DEF6C;
        Mon, 26 Nov 2018 23:34:01 +0000 (UTC)
Date:   Mon, 26 Nov 2018 15:34:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        zhijianx.li@intel.com, Philip Li <philip.li@intel.com>
Subject: Re: [PATCH] initramfs: clean old path before creating a hardlink
Message-Id: <20181126153400.4985207970edfb39cb47eb61@linux-foundation.org>
In-Reply-To: <1542352368-13299-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1542352368-13299-1-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 15:12:48 +0800 Li Zhijian <lizhijian@cn.fujitsu.com> wrote:

> Previously, sys_link() will fail due to the new path is already existed.
> this case ofen appears when we use a concated initrd, below is an
> sample:
> 
> 1) prepare a basic rootfs, it contains a regular files rc.local
> lizhijian@:~/yocto-tiny-i386-2016-04-22$ cat etc/rc.local
>  #!/bin/sh
>  echo "Running /etc/rc.local..."
> yocto-tiny-i386-2016-04-22$ find . | sed 's,^\./,,' | cpio -o -H newc | gzip -n -9 >../rootfs.cgz
> 
> 2) create a extra initrd which also includes a etc/rc.local
> lizhijian@:~/lkp-x86_64/etc$ echo "append initrd" >rc.local
> lizhijian@:~/lkp/lkp-x86_64/etc$ cat rc.local
> append initrd
> lizhijian@:~/lkp/lkp-x86_64/etc$ ln rc.local rc.local.hardlink
> append initrd
> lizhijian@:~/lkp/lkp-x86_64/etc$ stat rc.local rc.local.hardlink
>   File: 'rc.local'
>   Size: 14        	Blocks: 8          IO Block: 4096   regular file
> Device: 801h/2049d	Inode: 11296086    Links: 2
> Access: (0664/-rw-rw-r--)  Uid: ( 1002/lizhijian)   Gid: ( 1002/lizhijian)
> Access: 2018-11-15 16:08:28.654464815 +0800
> Modify: 2018-11-15 16:07:57.514903210 +0800
> Change: 2018-11-15 16:08:24.180228872 +0800
>  Birth: -
>   File: 'rc.local.hardlink'
>   Size: 14        	Blocks: 8          IO Block: 4096   regular file
> Device: 801h/2049d	Inode: 11296086    Links: 2
> Access: (0664/-rw-rw-r--)  Uid: ( 1002/lizhijian)   Gid: ( 1002/lizhijian)
> Access: 2018-11-15 16:08:28.654464815 +0800
> Modify: 2018-11-15 16:07:57.514903210 +0800
> Change: 2018-11-15 16:08:24.180228872 +0800
>  Birth: -
> 
> lizhijian@:~/lkp/lkp-x86_64$ find . | sed 's,^\./,,' | cpio -o -H newc | gzip -n -9 >../rc-local.cgz
> lizhijian@:~/lkp/lkp-x86_64$ gzip -dc ../rc-local.cgz | cpio -t
> .
> etc
> etc/rc.local.hardlink <<< it will be extracted first at this initrd
> etc/rc.local
> 
> 3) concate 2 initrds and boot
> lizhijian@:~/lkp$ cat rootfs.cgz rc-local.cgz >concate-initrd.cgz
> lizhijian@:~/lkp$ qemu-system-x86_64 -nographic -enable-kvm -cpu host -smp 1 -m 1024 -kernel ~/lkp/linux/arch/x86/boot/bzImage -append "console=ttyS0 earlyprint=ttyS0 ignore_loglevel" -initrd ./concate-initr.cgz -serial stdio -nodefaults
> 
> In this case, sys_link(2) will fail and return -EEXIST, so we can only
> get the rc.local at rootfs.cgz instead of rc-local.cgz

I can't claim to understand this, but I believe you ;)

How serious is this problem?  Do you think a 4.20 merge is justified? 
Or a -stable backport?  If so, why?

> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -291,12 +291,16 @@ static int __init do_reset(void)
>  	return 1;
>  }
>  
> +static void __init clean_path(char *path, umode_t fmode);
> +
>  static int __init maybe_link(void)
>  {
>  	if (nlink >= 2) {
>  		char *old = find_link(major, minor, ino, mode, collected);
> -		if (old)
> +		if (old) {
> +			clean_path(collected, 0);
>  			return (ksys_link(old, collected) < 0) ? -1 : 1;
> +		}
>  	}
>  	return 0;
>  }

The forward declaration is unpleasing.  Why not simply move the function?

--- a/init/initramfs.c~initramfs-clean-old-path-before-creating-a-hardlink-fix
+++ a/init/initramfs.c
@@ -291,7 +291,17 @@ static int __init do_reset(void)
 	return 1;
 }
 
-static void __init clean_path(char *path, umode_t fmode);
+static void __init clean_path(char *path, umode_t fmode)
+{
+	struct kstat st;
+
+	if (!vfs_lstat(path, &st) && (st.mode ^ fmode) & S_IFMT) {
+		if (S_ISDIR(st.mode))
+			ksys_rmdir(path);
+		else
+			ksys_unlink(path);
+	}
+}
 
 static int __init maybe_link(void)
 {
@@ -305,18 +315,6 @@ static int __init maybe_link(void)
 	return 0;
 }
 
-static void __init clean_path(char *path, umode_t fmode)
-{
-	struct kstat st;
-
-	if (!vfs_lstat(path, &st) && (st.mode ^ fmode) & S_IFMT) {
-		if (S_ISDIR(st.mode))
-			ksys_rmdir(path);
-		else
-			ksys_unlink(path);
-	}
-}
-
 static __initdata int wfd;
 
 static int __init do_name(void)
_

