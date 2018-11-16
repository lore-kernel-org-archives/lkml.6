Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60040C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194BC2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194BC2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbeKPQaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:30:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:6790 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389066AbeKPQaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:30:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 22:19:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,239,1539673200"; 
   d="scan'208";a="86386106"
Received: from unknown (HELO haswell-OptiPlex-9020.ccr.corp.intel.com) ([10.255.30.228])
  by fmsmga007.fm.intel.com with ESMTP; 15 Nov 2018 22:19:03 -0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     zhijianx.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>,
        Philip Li <philip.li@intel.com>
Subject: [PATCH] initramfs: clean old path before creating a hardlink
Date:   Fri, 16 Nov 2018 15:12:48 +0800
Message-Id: <1542352368-13299-1-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, sys_link() will fail due to the new path is already existed.
this case ofen appears when we use a concated initrd, below is an
sample:

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

In this case, sys_link(2) will fail and return -EEXIST, so we can only
get the rc.local at rootfs.cgz instead of rc-local.cgz

CC: Philip Li <philip.li@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 init/initramfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 6405577..381fd4c 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -291,12 +291,16 @@ static int __init do_reset(void)
 	return 1;
 }
 
+static void __init clean_path(char *path, umode_t fmode);
+
 static int __init maybe_link(void)
 {
 	if (nlink >= 2) {
 		char *old = find_link(major, minor, ino, mode, collected);
-		if (old)
+		if (old) {
+			clean_path(collected, 0);
 			return (ksys_link(old, collected) < 0) ? -1 : 1;
+		}
 	}
 	return 0;
 }
-- 
2.7.4

