Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494BBC282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1659320873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfBKBIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 20:08:13 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51749 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726120AbfBKBIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 20:08:13 -0500
X-IronPort-AV: E=Sophos;i="5.58,357,1544457600"; 
   d="scan'208";a="54005207"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Feb 2019 09:08:10 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 1C7FD4C4BB9D;
        Mon, 11 Feb 2019 09:08:06 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 09:08:09 +0800
Date:   Mon, 11 Feb 2019 09:07:57 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Guenter Roeck <linux@roeck-us.net>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <kirill.shutemov@linux.intel.com>,
        <mingo@redhat.com>, <thomas.lendacky@amd.com>,
        <yamada.masahiro@socionext.com>, <caoj.fnst@cn.fujitsu.com>,
        <jgross@suse.com>, <mingo@kernel.org>, <keescook@chromium.org>,
        <x86@kernel.org>, <hpa@zytor.com>,
        <linux-tip-commits@vger.kernel.org>
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190211010756.GA1544@localhost.localdomain>
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net>
 <20190208191024.GL674@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190208191024.GL674@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 1C7FD4C4BB9D.AFBB4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 08:10:24PM +0100, Borislav Petkov wrote:
>On Fri, Feb 08, 2019 at 11:02:48AM -0800, Guenter Roeck wrote:
>> Hi,
>> 
>> On Fri, Feb 01, 2019 at 03:01:11AM -0800, tip-bot for Chao Fan wrote:
>> > Commit-ID:  3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
>> > Gitweb:     https://git.kernel.org/tip/3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
>> > Author:     Chao Fan <fanc.fnst@cn.fujitsu.com>
>> > AuthorDate: Wed, 23 Jan 2019 19:08:48 +0800
>> > Committer:  Borislav Petkov <bp@suse.de>
>> > CommitDate: Fri, 1 Feb 2019 11:52:55 +0100
>> > 
>> > x86/boot: Early parse RSDP and save it in boot_params
>> > 
>> > The RSDP is needed by KASLR so parse it early and save it in
>> > boot_params.acpi_rsdp_addr, before KASLR setup runs.
>> > 
>> > RSDP is needed by other kernel facilities so have the parsing code
>> > built-in instead of a long "depends on" line in Kconfig.
>> > 
>> >  [ bp:
>> >     - Trim commit message and comments
>> >     - Add CONFIG_ACPI dependency in the Makefile
>> >     - Move ->acpi_rsdp_addr assignment with the rest of boot_params massaging in extract_kernel().
>> >  ]
>> > 
>> 
>> This patch causes x86_64 boots with efi32 bios to crash early and hard
>> (before any console output is seen).
>> 
>> Sample qemu command line:
>> 
>> qemu-system-x86_64 -kernel arch/x86/boot/bzImage -M q35 -cpu SandyBridge \
>> 	-no-reboot -snapshot -smp 4 \
>> 	-bios OVMF-pure-efi-32.fd \
>> 	-m 1G \
>> 	-usb -device usb-storage,drive=d0 \
>> 	-drive file=rootfs.squashfs,if=none,id=d0,format=raw \
>> 	--append 'earlycon=uart8250,io,0x3f8,9600n8 root=/dev/sda rootwait panic=-1 console=ttyS0' \
>> 	-nographic
>> 
>> This is with qemu 3.1, though details other than "-bios OVMF-pure-efi-32.fd"
>> don't really matter.
>> 
>> Files used above are available from https://github.com/groeck/linux-build-test/.
>> 
>> The patch can not be reverted alone, but
>> 
>> Revert "x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only"
>> Revert "x86/boot: Parse SRAT table and count immovable memory regions"
>> Revert "x86/boot: Early parse RSDP and save it in boot_params"
>> 
>> fixes the problem.
>
>Does it per chance at least continue booting if you return 0 and early
>from efi_get_rsdp_addr() ?
>
>Chao, pls take a look.

Sorry for delay, last several days were holiday, so I was away from
keyboard. I will take a look.

Thanks,
Chao Fan
>
>Thx.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


