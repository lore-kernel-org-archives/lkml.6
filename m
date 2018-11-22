Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D413C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD1D20821
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD1D20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403922AbeKVMcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:32:32 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8369 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730718AbeKVMcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:32:31 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="48531308"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Nov 2018 09:55:26 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 1098D4B714DF;
        Thu, 22 Nov 2018 09:55:26 +0800 (CST)
Received: from [10.167.226.45] (10.167.226.45) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.408.0; Thu, 22 Nov 2018 09:55:32 +0800
Subject: Re: [PATCH] initramfs: clean old path before creating a hardlink
To:     <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <zhijianx.li@intel.com>, Philip Li <philip.li@intel.com>
References: <1542352368-13299-1-git-send-email-lizhijian@cn.fujitsu.com>
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
Organization: fnst-ulinux
Message-ID: <2ac09b0f-2c26-3e19-1a33-f2d5ea1ae3ad@cn.fujitsu.com>
Date:   Thu, 22 Nov 2018 09:55:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542352368-13299-1-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: 1098D4B714DF.AF756
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

This patch is to fix initrd cannot be extracted properly in some cases.


Thanks


On 11/16/2018 03:12 PM, Li Zhijian wrote:
> Previously, sys_link() will fail due to the new path is already existed.
> this case ofen appears when we use a concated initrd, below is an
> sample:
>
> 1) prepare a basic rootfs, it contains a regular files rc.local
> lizhijian@:~/yocto-tiny-i386-2016-04-22$ cat etc/rc.local
>   #!/bin/sh
>   echo "Running /etc/rc.local..."
> yocto-tiny-i386-2016-04-22$ find . | sed 's,^\./,,' | cpio -o -H newc | gzip -n -9 >../rootfs.cgz
>
> 2) create a extra initrd which also includes a etc/rc.local
> lizhijian@:~/lkp-x86_64/etc$ echo "append initrd" >rc.local
> lizhijian@:~/lkp/lkp-x86_64/etc$ cat rc.local
> append initrd
> lizhijian@:~/lkp/lkp-x86_64/etc$ ln rc.local rc.local.hardlink
> append initrd
> lizhijian@:~/lkp/lkp-x86_64/etc$ stat rc.local rc.local.hardlink
>    File: 'rc.local'
>    Size: 14        	Blocks: 8          IO Block: 4096   regular file
> Device: 801h/2049d	Inode: 11296086    Links: 2
> Access: (0664/-rw-rw-r--)  Uid: ( 1002/lizhijian)   Gid: ( 1002/lizhijian)
> Access: 2018-11-15 16:08:28.654464815 +0800
> Modify: 2018-11-15 16:07:57.514903210 +0800
> Change: 2018-11-15 16:08:24.180228872 +0800
>   Birth: -
>    File: 'rc.local.hardlink'
>    Size: 14        	Blocks: 8          IO Block: 4096   regular file
> Device: 801h/2049d	Inode: 11296086    Links: 2
> Access: (0664/-rw-rw-r--)  Uid: ( 1002/lizhijian)   Gid: ( 1002/lizhijian)
> Access: 2018-11-15 16:08:28.654464815 +0800
> Modify: 2018-11-15 16:07:57.514903210 +0800
> Change: 2018-11-15 16:08:24.180228872 +0800
>   Birth: -
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
>
> CC: Philip Li <philip.li@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>   init/initramfs.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 6405577..381fd4c 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -291,12 +291,16 @@ static int __init do_reset(void)
>   	return 1;
>   }
>   
> +static void __init clean_path(char *path, umode_t fmode);
> +
>   static int __init maybe_link(void)
>   {
>   	if (nlink >= 2) {
>   		char *old = find_link(major, minor, ino, mode, collected);
> -		if (old)
> +		if (old) {
> +			clean_path(collected, 0);
>   			return (ksys_link(old, collected) < 0) ? -1 : 1;
> +		}
>   	}
>   	return 0;
>   }


