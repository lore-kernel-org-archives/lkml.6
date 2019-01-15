Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940EFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF5120645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfAOPzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:55:31 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbfAOPza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:55:30 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjR3c-0006US-VN; Tue, 15 Jan 2019 16:55:17 +0100
Date:   Tue, 15 Jan 2019 16:55:16 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
cc:     Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>, kirill.shutemov@linux.intel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: question about head_64.S
In-Reply-To: <6aebbf86-2ba1-c517-dc47-054279daec49@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1901151641000.1561@nanos.tec.linutronix.de>
References: <6aebbf86-2ba1-c517-dc47-054279daec49@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019, Cao jin wrote:

> Hi,
>   I have been digging into this file for a while, and I still have 2
> questions unclear, hope to get your help.
> 
> 1.
> At the entry of startup_64, we set all the data segment registers to 0,
> according to commit 08da5a2ca("x86_64: Early segment setup for VT"), it
> is said to accelerate the decompression under VT. I don't know Intel VT,
> but I did test under physical machine and virtual machine(with KVM, and
> intel VT enabled in BIOS) with following patch:
> 
> diff --git a/arch/x86/boot/compressed/head_64.S
> b/arch/x86/boot/compressed/head_64.S
> index 58f6a467f1fa..595f3c300173 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -260,12 +260,12 @@ ENTRY(startup_64)
>          */
> 
>         /* Setup data segments. */
> -       xorl    %eax, %eax
> -       movl    %eax, %ds
> -       movl    %eax, %es
> -       movl    %eax, %ss
> -       movl    %eax, %fs
> -       movl    %eax, %gs
> +//     xorl    %eax, %eax
> +//     movl    %eax, %ds
> +//     movl    %eax, %es
> +//     movl    %eax, %ss
> +//     movl    %eax, %fs
> +//     movl    %eax, %gs
> 
> I don't see any obvious booting time difference, is there anything I missed?
> Also, I don't find explicit document saying we should zero these
> registers under VT.

The decompressor is position independent code, so all segments have to be
set to 0.

The patch you mentioned was just adding fs/gs to the list of segments
which are cleared and the commit message is not very clear. Though if you
dig further down then you find the original version of that patch:

  commit ffb6017563aa("[PATCH] x86-64: x86_64 - Fix FS/GS registers for VT execution")

That one has a proper explantaion.

Thanks,

	tglx


