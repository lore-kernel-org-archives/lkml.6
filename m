Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46255C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3C12054F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3C12054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeLLNFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:05:25 -0500
Received: from ozlabs.org ([203.11.71.1]:43999 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbeLLNFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:05:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43FH9G67rBz9s4s;
        Thu, 13 Dec 2018 00:05:22 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/8xx: hide itlbie and dtlbie symbols
In-Reply-To: <8a48b395c3468f8020ea56af679530854b090e4c.1543404405.git.christophe.leroy@c-s.fr>
References: <8a48b395c3468f8020ea56af679530854b090e4c.1543404405.git.christophe.leroy@c-s.fr>
Date:   Thu, 13 Dec 2018 00:05:23 +1100
Message-ID: <87ftv2x5d8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> When disassembling InstructionTLBError we get the following messy code:
>
> c000138c:       7d 84 63 78     mr      r4,r12
> c0001390:       75 25 58 00     andis.  r5,r9,22528
> c0001394:       75 2a 40 00     andis.  r10,r9,16384
> c0001398:       41 a2 00 08     beq     c00013a0 <itlbie>
> c000139c:       7c 00 22 64     tlbie   r4,r0
>
> c00013a0 <itlbie>:
> c00013a0:       39 40 04 01     li      r10,1025
> c00013a4:       91 4b 00 b0     stw     r10,176(r11)
> c00013a8:       39 40 10 32     li      r10,4146
> c00013ac:       48 00 cc 59     bl      c000e004 <transfer_to_handler>
>
> For a cleaner code dump, this patch replaces itlbie and dtlbie
> symbols by numeric symbols.
>
> c000138c:       7d 84 63 78     mr      r4,r12
> c0001390:       75 25 58 00     andis.  r5,r9,22528
> c0001394:       75 2a 40 00     andis.  r10,r9,16384
> c0001398:       41 a2 00 08     beq     c00013a0 <InstructionTLBError+0xa0>
> c000139c:       7c 00 22 64     tlbie   r4,r0
> c00013a0:       39 40 04 01     li      r10,1025
> c00013a4:       91 4b 00 b0     stw     r10,176(r11)
> c00013a8:       39 40 10 32     li      r10,4146
> c00013ac:       48 00 cc 59     bl      c000e004 <transfer_to_handler>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/head_8xx.S | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 3b67b9533c82..8c848acfe249 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -552,11 +552,10 @@ InstructionTLBError:
>  	mr	r4,r12
>  	andis.	r5,r9,DSISR_SRR1_MATCH_32S@h /* Filter relevant SRR1 bits */
>  	andis.	r10,r9,SRR1_ISI_NOPT@h
> -	beq+	1f
> +	beq+	1301f
>  	tlbie	r4
> -itlbie:
>  	/* 0x400 is InstructionAccess exception, needed by bad_page_fault() */
> -1:	EXC_XFER_LITE(0x400, handle_page_fault)
> +1301:	EXC_XFER_LITE(0x400, handle_page_fault)

You could use a local symbol, something like:

	beq+	1f
 	tlbie	r4
.Litlbie:
 	/* 0x400 is InstructionAccess exception, needed by bad_page_fault() */
1:	EXC_XFER_LITE(0x400, handle_page_fault)


cheers
