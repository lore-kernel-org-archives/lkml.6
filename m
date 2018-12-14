Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A386C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25D82147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789198;
	bh=8ZJHuDY+b7OObQPRfemSvLrU4JxH6zqO1p0d1btbU2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pnPn8jzWes4h2ro3DaTMpTZ0m7bVSgziKCpkJEn4iyKBvhqG1PUczpGw2J+OEcXJp
	 LJyFsW7Sps5Q8UePhsb5PiDVQ0Re3l4hNvSF9js2LoNyO6FpJhW1WSGkFaT9zMhaOJ
	 n0WTQsjg8JKq87Ne2oQIXXtHrCOTR633nVt/VNVA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25D82147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbeLNMGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:06:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730434AbeLNMGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10E721486;
        Fri, 14 Dec 2018 12:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789194;
        bh=8ZJHuDY+b7OObQPRfemSvLrU4JxH6zqO1p0d1btbU2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xj6xXGbKG8HPtxgXfA1dehWs9O/9zH9YKziWMow+t7rHdvdBeZHQqSn0cQKnOnhlr
         NL3TOsP/3ZN2InU7/K7X6Lge/GU9suo8aiaBGKVXi5om0tleU5wwBBMdT4i1vqWEt0
         cwN022IFsNsR4BR8facLL7i9h5cNrAlOwY3DtOF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Zhijian <lizhijian@cn.fujitsu.com>,
        Philip Li <philip.li@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Li Zhijian <zhijianx.li@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 131/142] initramfs: clean old path before creating a hardlink
Date:   Fri, 14 Dec 2018 13:00:16 +0100
Message-Id: <20181214115752.281723541@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7c0950d455d6ab610d2990a13120f935b75abf2c ]

sys_link() can fail due to the new path already existing.  This case
ofen occurs when we use a concated initrd, for example:

1) prepare a basic rootfs, it contains a regular files rc.local
lizhijian@:~/yocto-tiny-i386-2016-04-22$ cat etc/rc.local
 #!/bin/sh
 echo "Running /etc/rc.local..."
yocto-tiny-i386-2016-04-22$ find . | sed 's,^\./,,' | cpio -o -H newc | gzip -n -9 >../rootfs.cgz

2) create a extra initrd which also includes a etc/rc.local
lizhijian@:~/lkp-x86_64/etc$ echo "append initrd" >rc.local
lizhijian@:~/lkp/lkp-x86_64/etc$ cat rc.local
append initrd
lizhijian@:~/lkp/lkp-x86_64/etc$ ln rc.local rc.local.hardlink
append initrd
lizhijian@:~/lkp/lkp-x86_64/etc$ stat rc.local rc.local.hardlink
  File: 'rc.local'
  Size: 14        	Blocks: 8          IO Block: 4096   regular file
Device: 801h/2049d	Inode: 11296086    Links: 2
Access: (0664/-rw-rw-r--)  Uid: ( 1002/lizhijian)   Gid: ( 1002/lizhijian)
Access: 2018-11-15 16:08:28.654464815 +0800
Modify: 2018-11-15 16:07:57.514903210 +0800
Change: 2018-11-15 16:08:24.180228872 +0800
 Birth: -
  File: 'rc.local.hardlink'
  Size: 14        	Blocks: 8          IO Block: 4096   regular file
Device: 801h/2049d	Inode: 11296086    Links: 2
Access: (0664/-rw-rw-r--)  Uid: ( 1002/lizhijian)   Gid: ( 1002/lizhijian)
Access: 2018-11-15 16:08:28.654464815 +0800
Modify: 2018-11-15 16:07:57.514903210 +0800
Change: 2018-11-15 16:08:24.180228872 +0800
 Birth: -

lizhijian@:~/lkp/lkp-x86_64$ find . | sed 's,^\./,,' | cpio -o -H newc | gzip -n -9 >../rc-local.cgz
lizhijian@:~/lkp/lkp-x86_64$ gzip -dc ../rc-local.cgz | cpio -t
.
etc
etc/rc.local.hardlink <<< it will be extracted first at this initrd
etc/rc.local

3) concate 2 initrds and boot
lizhijian@:~/lkp$ cat rootfs.cgz rc-local.cgz >concate-initrd.cgz
lizhijian@:~/lkp$ qemu-system-x86_64 -nographic -enable-kvm -cpu host -smp 1 -m 1024 -kernel ~/lkp/linux/arch/x86/boot/bzImage -append "console=ttyS0 earlyprint=ttyS0 ignore_loglevel" -initrd ./concate-initr.cgz -serial stdio -nodefaults

In this case, sys_link(2) will fail and return -EEXIST, so we can only get
the rc.local at rootfs.cgz instead of rc-local.cgz

[akpm@linux-foundation.org: move code to avoid forward declaration]
Link: http://lkml.kernel.org/r/1542352368-13299-1-git-send-email-lizhijian@cn.fujitsu.com
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Philip Li <philip.li@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Li Zhijian <zhijianx.li@intel.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 init/initramfs.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 640557788026..f6f4a1e4cd54 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -291,16 +291,6 @@ static int __init do_reset(void)
 	return 1;
 }
 
-static int __init maybe_link(void)
-{
-	if (nlink >= 2) {
-		char *old = find_link(major, minor, ino, mode, collected);
-		if (old)
-			return (ksys_link(old, collected) < 0) ? -1 : 1;
-	}
-	return 0;
-}
-
 static void __init clean_path(char *path, umode_t fmode)
 {
 	struct kstat st;
@@ -313,6 +303,18 @@ static void __init clean_path(char *path, umode_t fmode)
 	}
 }
 
+static int __init maybe_link(void)
+{
+	if (nlink >= 2) {
+		char *old = find_link(major, minor, ino, mode, collected);
+		if (old) {
+			clean_path(collected, 0);
+			return (ksys_link(old, collected) < 0) ? -1 : 1;
+		}
+	}
+	return 0;
+}
+
 static __initdata int wfd;
 
 static int __init do_name(void)
-- 
2.19.1



