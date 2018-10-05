Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B670CC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819FE20652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819FE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=foss.arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeJEP65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:58:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48444 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbeJEP65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:58:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A359B80D;
        Fri,  5 Oct 2018 02:01:09 -0700 (PDT)
Received: from [10.2.206.71] (e113077-lin.cambridge.arm.com [10.2.206.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82A1F3F5B3;
        Fri,  5 Oct 2018 02:01:06 -0700 (PDT)
Subject: Re: [RFC 17/17] arm64: compile the kernel with ptrauth
 -msign-return-address
To:     Kristina Martsenko <kristina.martsenko@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Christoffer Dall <Christoffer.Dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-18-kristina.martsenko@arm.com>
From:   Ramana Radhakrishnan <ramana.radhakrishnan@foss.arm.com>
Message-ID: <cd1eface-aebb-b654-c57c-91690087957f@foss.arm.com>
Date:   Fri, 5 Oct 2018 10:01:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181005084754.20950-18-kristina.martsenko@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 09:47, Kristina Martsenko wrote:
> Compile all functions with two ptrauth instructions: paciasp in the
> prologue to sign the return address, and autiasp in the epilogue to
> authenticate the return address. This should help protect the kernel
> against attacks using return-oriented programming.
> 
> CONFIG_ARM64_PTR_AUTH enables pointer auth for both userspace and the
> kernel.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>   arch/arm64/Makefile | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 106039d25e2f..dbcd43ea99d8 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -56,6 +56,10 @@ KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
>   KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
>   KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
>   
> +ifeq ($(CONFIG_ARM64_PTR_AUTH),y)
> +KBUILD_CFLAGS	+= -msign-return-address=all

Glad to see this being done and being proposed for mainline.

I can see why you would prefer this though have you guys experimented at 
all with -msign-return-address=non-leaf as well ?

Orthogonally and just fair warning - the command lines for this are also 
being revised to provide ROP and JOP protection using BTI from v8.5-a 
during the GCC-9 timeframe but I suspect that's a different option.

regards
Ramana

Reviewed-by: Ramana Radhakrishnan  <ramana.radhakrishnan@arm.com>
