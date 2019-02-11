Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806C5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADB62146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfBKJau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:30:50 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33437 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725986AbfBKJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:30:50 -0500
X-IronPort-AV: E=Sophos;i="5.58,358,1544457600"; 
   d="scan'208";a="54051484"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Feb 2019 17:30:48 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 945424BAD925;
        Mon, 11 Feb 2019 17:30:42 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 17:30:48 +0800
Date:   Mon, 11 Feb 2019 17:30:33 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <kirill.shutemov@linux.intel.com>, <bp@suse.de>,
        <mingo@redhat.com>, <thomas.lendacky@amd.com>,
        <yamada.masahiro@socionext.com>, <caoj.fnst@cn.fujitsu.com>,
        <jgross@suse.com>, <mingo@kernel.org>, <keescook@chromium.org>,
        <x86@kernel.org>, <hpa@zytor.com>,
        <linux-tip-commits@vger.kernel.org>
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190211093033.GA1651@localhost.localdomain>
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190208190248.GA10854@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 945424BAD925.ABB73
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 11:02:48AM -0800, Guenter Roeck wrote:
>Hi,
>
>On Fri, Feb 01, 2019 at 03:01:11AM -0800, tip-bot for Chao Fan wrote:
>> Commit-ID:  3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
>> Gitweb:     https://git.kernel.org/tip/3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
>> Author:     Chao Fan <fanc.fnst@cn.fujitsu.com>
>> AuthorDate: Wed, 23 Jan 2019 19:08:48 +0800
>> Committer:  Borislav Petkov <bp@suse.de>
>> CommitDate: Fri, 1 Feb 2019 11:52:55 +0100
>> 
>> x86/boot: Early parse RSDP and save it in boot_params
>> 
>> The RSDP is needed by KASLR so parse it early and save it in
>> boot_params.acpi_rsdp_addr, before KASLR setup runs.
>> 
>> RSDP is needed by other kernel facilities so have the parsing code
>> built-in instead of a long "depends on" line in Kconfig.
>> 
>>  [ bp:
>>     - Trim commit message and comments
>>     - Add CONFIG_ACPI dependency in the Makefile
>>     - Move ->acpi_rsdp_addr assignment with the rest of boot_params massaging in extract_kernel().
>>  ]
>> 
>
>This patch causes x86_64 boots with efi32 bios to crash early and hard
>(before any console output is seen).
>
>Sample qemu command line:
>
>qemu-system-x86_64 -kernel arch/x86/boot/bzImage -M q35 -cpu SandyBridge \
>	-no-reboot -snapshot -smp 4 \
>	-bios OVMF-pure-efi-32.fd \
>	-m 1G \
>	-usb -device usb-storage,drive=d0 \
>	-drive file=rootfs.squashfs,if=none,id=d0,format=raw \
>	--append 'earlycon=uart8250,io,0x3f8,9600n8 root=/dev/sda rootwait panic=-1 console=ttyS0' \
>	-nographic
>
>This is with qemu 3.1, though details other than "-bios OVMF-pure-efi-32.fd"
>don't really matter.

Yes, I download your ovmf file in linux-build-test/rootfs/firmware/ from
your link. There are two files, efi32 and efi64. Then I try to run:

BIOS=/usr/share/edk2/ovmf/OVMF-pure-efi-32.fd
qemu-system-x86_64 \
-bios $BIOS \
-cdrom /var/lib/libvirt/images/iso/Fedora-Workstation-Live-x86_64-29-1.2.iso \
-hda /var/lib/libvirt/images/fedora-efi32.qcow2 \
-enable-kvm \
-m 5G \
-serial stdio

It can't boot, but if I changed as:
BIOS=/usr/share/edk2/ovmf/OVMF-pure-efi-64.fd

Then the machine booted. So I am not sure how to use this
OVMF-pure-efi-32.fd. If there is somethins wrong in my understand,
please let me know.

Thanks,
Chao Fan

>
>Files used above are available from https://github.com/groeck/linux-build-test/.
>
>The patch can not be reverted alone, but
>
>Revert "x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only"
>Revert "x86/boot: Parse SRAT table and count immovable memory regions"
>Revert "x86/boot: Early parse RSDP and save it in boot_params"
>
>fixes the problem.
>
>Bisect log attached below.
>
>Guenter
>
>---
># bad: [a46228f6598a191e25ca160870f20c3cd1743d13] Add linux-next specific files for 20190208
># good: [8834f5600cf3c8db365e18a3d5cac2c2780c81e5] Linux 5.0-rc5
>git bisect start 'HEAD' 'v5.0-rc5'
># good: [d5ee02f33ec5ade9c9afb9d45bfc4f5cb1375e58] Merge remote-tracking branch 'spi-nor/spi-nor/next'
>git bisect good d5ee02f33ec5ade9c9afb9d45bfc4f5cb1375e58
># good: [f34bff29873986d260d7a491fb6f543d12fbe7cd] Merge remote-tracking branch 'devicetree/for-next'
>git bisect good f34bff29873986d260d7a491fb6f543d12fbe7cd
># bad: [68182cb929ec6a676655887cbfb12b09662c1e5b] Merge remote-tracking branch 'icc/icc-next'
>git bisect bad 68182cb929ec6a676655887cbfb12b09662c1e5b
># bad: [0a5c6189664123753c298d90dec3a5a6b907f06f] Merge remote-tracking branch 'driver-core/driver-core-next'
>git bisect bad 0a5c6189664123753c298d90dec3a5a6b907f06f
># bad: [e2a43b09bfc24369719437b5f8f703c5d7003af2] Merge remote-tracking branch 'tip/auto-latest'
>git bisect bad e2a43b09bfc24369719437b5f8f703c5d7003af2
># good: [ba1ef96ac73d2a9851dc64d0a991ac8699aa6a22] Merge branch 'timers/core'
>git bisect good ba1ef96ac73d2a9851dc64d0a991ac8699aa6a22
># good: [473a78a7bbeb7c77b81b596095f59ce4fbbd49dc] spi-atmel: support inter-word delay
>git bisect good 473a78a7bbeb7c77b81b596095f59ce4fbbd49dc
># bad: [132dc31173c99bd252f6a54e3a9fba90f7417a43] Merge branch 'x86/cleanups'
>git bisect bad 132dc31173c99bd252f6a54e3a9fba90f7417a43
># bad: [6eb09d138a331121740a4cf7458ab317979d9a17] Merge branch 'x86/boot'
>git bisect bad 6eb09d138a331121740a4cf7458ab317979d9a17
># good: [e2c403557ebbcd1f0052e1ae51cfaff596cf259d] Merge branch 'x86/asm'
>git bisect good e2c403557ebbcd1f0052e1ae51cfaff596cf259d
># good: [33f0df8d843deb9ec24116dcd79a40ca0ea8e8a9] x86/boot: Search for RSDP in the EFI tables
>git bisect good 33f0df8d843deb9ec24116dcd79a40ca0ea8e8a9
># bad: [3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce] x86/boot: Early parse RSDP and save it in boot_params
>git bisect bad 3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
># good: [93a209aaaad495d7d0bc9b6186a4495934f70402] x86/boot: Search for RSDP in memory
>git bisect good 93a209aaaad495d7d0bc9b6186a4495934f70402
># first bad commit: [3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce] x86/boot: Early parse RSDP and save it in boot_params
>
>


