Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEF2C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6E92083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfBFTun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:50:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfBFTun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:50:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07ED925EC6;
        Wed,  6 Feb 2019 19:50:43 +0000 (UTC)
Received: from [10.10.124.78] (ovpn-124-78.rdu2.redhat.com [10.10.124.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD93A87DB;
        Wed,  6 Feb 2019 19:50:41 +0000 (UTC)
Subject: Re: [PATCH] x86/boot/compressed/64: Do not corrupt EDX on EFER.LME=1
 setting
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kyle D Pelton <kyle.d.pelton@intel.com>
References: <20190206115253.1907-1-kirill.shutemov@linux.intel.com>
From:   Wei Huang <wei@redhat.com>
Message-ID: <ac67e82b-7e66-8325-a1e3-43c0c0b06024@redhat.com>
Date:   Wed, 6 Feb 2019 13:50:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190206115253.1907-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 06 Feb 2019 19:50:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/19 5:52 AM, Kirill A. Shutemov wrote:
> RDMSR in the trampoline code overrides EDX, but we use the register to
> indicate if 5-level paging has to enabled. It leads to failure to boot
> on a 5-level paging machine.
> 
> Preserve EDX on the stack while we are dealing with EFER.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: b677dfae5aa1 ("x86/boot/compressed/64: Set EFER.LME=1 in 32-bit trampoline before returning to long mode")
> Reported-by: Kyle D Pelton <kyle.d.pelton@intel.com>
> Cc: Wei Huang <wei@redhat.com>
> ---
>  arch/x86/boot/compressed/head_64.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index f105ae8651c9..f62e347862cc 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -602,10 +602,12 @@ ENTRY(trampoline_32bit_src)
>  3:
>  	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
>  	pushl	%ecx
> +	pushl	%edx
>  	movl	$MSR_EFER, %ecx
>  	rdmsr
>  	btsl	$_EFER_LME, %eax
>  	wrmsr
> +	popl	%edx
>  	popl	%ecx
>  
>  	/* Enable PAE and LA57 (if required) paging modes */
> 

Oops, rdmsr indeed corrupts EDX.

Acked-by: Wei Huang <wei@redhat.com>

