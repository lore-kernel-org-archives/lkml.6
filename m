Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F673C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062A7218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfBKNDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:03:20 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33086 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727182AbfBKNDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:03:20 -0500
X-IronPort-AV: E=Sophos;i="5.58,358,1544457600"; 
   d="scan'208";a="54061256"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Feb 2019 21:03:17 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 124094BAD925;
        Mon, 11 Feb 2019 21:03:14 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 21:03:20 +0800
Date:   Mon, 11 Feb 2019 21:03:05 +0800
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
Message-ID: <20190211130304.GB5333@localhost.localdomain>
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net>
 <20190211093033.GA1651@localhost.localdomain>
 <20190211100800.GA19041@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211100800.GA19041@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 124094BAD925.ABFA0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:08:00AM +0100, Borislav Petkov wrote:
>On Mon, Feb 11, 2019 at 05:30:33PM +0800, Chao Fan wrote:
>> Yes, I download your ovmf file in linux-build-test/rootfs/firmware/ from
>> your link. There are two files, efi32 and efi64. Then I try to run:
>
>You need both OVMF-pure-efi-32.fd and rootfs.squashfs from the repo. And
>then this works here. Just put the script below and the two files in a
>directory and point to the kernel where you're building with -kernel.
>
>---
>#!/bin/bash
>
>qemu-system-x86_64 -kernel ~/kernel/linux/arch/x86/boot/bzImage -M q35 -cpu SandyBridge \
>        -no-reboot -snapshot -smp 1 \
>        -gdb tcp::1235 \
>        -bios OVMF-pure-efi-32.fd \
>        -m 1G \
>        -net nic,model=rtl8139,macaddr=12:34:56:78:12:34 \
>        -usb -device usb-storage,drive=d0 \
>        -drive file=rootfs.squashfs,if=none,id=d0,format=raw \
>        --append 'earlycon=uart8250,io,0x3f8,9600n8 root=/dev/sda rootwait panic=-1 earlyprintk=ttyS0,115200,keep console=ttyS0,115200' \
>        -monitor pty \
>        -serial file:log
>
>I've added some options for debugging.

So many thanks!
Since I learn much about how to debug kernel code before
start_kernel(). I only tried to debug code after start_kernel().
Seems you can debug the code in compressed code.

Thanks,
Chao Fan
>
>-- 
>Regards/Gruss,
>    Boris.
>
>SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
>
>


