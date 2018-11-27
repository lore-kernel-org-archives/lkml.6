Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C45C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621B421479
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621B421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeK0PBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 10:01:12 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:30693 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727633AbeK0PBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 10:01:12 -0500
X-IronPort-AV: E=Sophos;i="5.56,285,1539619200"; 
   d="scan'208";a="48725023"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Nov 2018 12:04:40 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 121B74B7348C;
        Tue, 27 Nov 2018 12:04:40 +0800 (CST)
Received: from [10.167.226.45] (10.167.226.45) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.408.0; Tue, 27 Nov 2018 12:04:39 +0800
Subject: Re: [PATCH] initramfs: clean old path before creating a hardlink
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        <zhijianx.li@intel.com>, Philip Li <philip.li@intel.com>
References: <1542352368-13299-1-git-send-email-lizhijian@cn.fujitsu.com>
 <20181126153400.4985207970edfb39cb47eb61@linux-foundation.org>
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
Organization: fnst-ulinux
Message-ID: <70f9063e-9c80-03de-93c7-0f604225b544@cn.fujitsu.com>
Date:   Tue, 27 Nov 2018 12:04:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181126153400.4985207970edfb39cb47eb61@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: 121B74B7348C.ADE00
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/27/2018 07:34 AM, Andrew Morton wrote:
> On Fri, 16 Nov 2018 15:12:48 +0800 Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
>> Previously, sys_link() will fail due to the new path is already existed.
>> this case ofen appears when we use a concated initrd, below is an
>> sample:
>>
>> 1) prepare a basic rootfs, it contains a regular files rc.local
>> lizhijian@:~/yocto-tiny-i386-2016-04-22$ cat etc/rc.local
>>   #!/bin/sh
>>   echo "Running /etc/rc.local..."
>> yocto-tiny-i386-2016-04-22$ find . | sed 's,^\./,,' | cpio -o -H newc | gzip -n -9 >../rootfs.cgz
>>
>> 2) create a extra initrd which also includes a etc/rc.local
>> lizhijian@:~/lkp-x86_64/etc$ echo "append initrd" >rc.local
>> lizhijian@:~/lkp/lkp-x86_64/etc$ cat rc.local
>> append initrd
>> lizhijian@:~/lkp/lkp-x86_64/etc$ ln rc.local rc.local.hardlink
>> append initrd
>> lizhijian@:~/lkp/lkp-x86_64/etc$ stat rc.local rc.local.hardlink
>>    File: 'rc.local'
>>    Size: 14        	Blocks: 8          IO Block: 4096   regular file
>> Device: 801h/2049d	Inode: 11296086    Links: 2
>> Access: (0664/-rw-rw-r--)  Uid: ( 1002/lizhijian)   Gid: ( 1002/lizhijian)
>> Access: 2018-11-15 16:08:28.654464815 +0800
>> Modify: 2018-11-15 16:07:57.514903210 +0800
>> Change: 2018-11-15 16:08:24.180228872 +0800
>>   Birth: -
>>    File: 'rc.local.hardlink'
>>    Size: 14        	Blocks: 8          IO Block: 4096   regular file
>> Device: 801h/2049d	Inode: 11296086    Links: 2
>> Access: (0664/-rw-rw-r--)  Uid: ( 1002/lizhijian)   Gid: ( 1002/lizhijian)
>> Access: 2018-11-15 16:08:28.654464815 +0800
>> Modify: 2018-11-15 16:07:57.514903210 +0800
>> Change: 2018-11-15 16:08:24.180228872 +0800
>>   Birth: -
>>
>> lizhijian@:~/lkp/lkp-x86_64$ find . | sed 's,^\./,,' | cpio -o -H newc | gzip -n -9 >../rc-local.cgz
>> lizhijian@:~/lkp/lkp-x86_64$ gzip -dc ../rc-local.cgz | cpio -t
>> .
>> etc
>> etc/rc.local.hardlink <<< it will be extracted first at this initrd
>> etc/rc.local
>>
>> 3) concate 2 initrds and boot
>> lizhijian@:~/lkp$ cat rootfs.cgz rc-local.cgz >concate-initrd.cgz
>> lizhijian@:~/lkp$ qemu-system-x86_64 -nographic -enable-kvm -cpu host -smp 1 -m 1024 -kernel ~/lkp/linux/arch/x86/boot/bzImage -append "console=ttyS0 earlyprint=ttyS0 ignore_loglevel" -initrd ./concate-initr.cgz -serial stdio -nodefaults
>>
>> In this case, sys_link(2) will fail and return -EEXIST, so we can only
>> get the rc.local at rootfs.cgz instead of rc-local.cgz
> I can't claim to understand this, but I believe you ;)

thank you.

IMO, people who use concatenated initrd(cat rootfs.cgz rc-local.cgz >concatenated-initrd.cgz),
could expect that the later initrd(rc-local.cgz) can overwrite the previous initrd(rootfs.cgz).

However the previous kernel can not ensure this.

>
> How serious is this problem?  Do you think a 4.20 merge is justified?

It's critical for our scenario where it always concatenates multiple initrds.
and our scenario often use the latest kernel, so 4.20+ is good to us.



> Or a -stable backport?  If so, why?
>
> The forward declaration is unpleasing.  Why not simply move the function?

Got it, i will update in V2


Thanks

>
> --- a/init/initramfs.c~initramfs-clean-old-path-before-creating-a-hardlink-fix
> +++ a/init/initramfs.c
> @@ -291,7 +291,17 @@ static int __init do_reset(void)
>   	return 1;
>   }
>   
> -static void __init clean_path(char *path, umode_t fmode);
> +static void __init clean_path(char *path, umode_t fmode)
> +{
> +	struct kstat st;
> +
> +	if (!vfs_lstat(path, &st) && (st.mode ^ fmode) & S_IFMT) {
> +		if (S_ISDIR(st.mode))
> +			ksys_rmdir(path);
> +		else
> +			ksys_unlink(path);
> +	}
> +}
>   
>   static int __init maybe_link(void)
>   {
> @@ -305,18 +315,6 @@ static int __init maybe_link(void)
>   	return 0;
>   }
>   
> -static void __init clean_path(char *path, umode_t fmode)
> -{
> -	struct kstat st;
> -
> -	if (!vfs_lstat(path, &st) && (st.mode ^ fmode) & S_IFMT) {
> -		if (S_ISDIR(st.mode))
> -			ksys_rmdir(path);
> -		else
> -			ksys_unlink(path);
> -	}
> -}
> -
>   static __initdata int wfd;
>   
>   static int __init do_name(void)
> _
>
>
>
> .
>


