Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDF1C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0C320651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fDxY3f83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbfAOQxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:53:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37161 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733227AbfAOQnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:43:23 -0500
Received: by mail-qt1-f194.google.com with SMTP id t33so3671395qtt.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 08:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y+V+kKBPiZCpoTn8VAMV6dpXygIxPvhwLC4JN5lt0p4=;
        b=fDxY3f8352ogTdcck7ZOLDJkELxx3qywO25gdFZSd1UlSzyH7TaxCkTTRi4/ErrlQH
         eD6Oo1xFSKF2kTWSn6R0uRIZ8yd6RpakFdANTpY/UQWy1zJN7tmCO62bRNawpjpSBcnu
         P5Mof6XKxOSE+yPTo/AIrd8hkHd8D1G3WkPrZn45GVFphLwyTgbzsL4qMDMNKEkoaVH8
         IloS1G+gnGesm1FJfyWbPs5VIF+h+ha1Q0pkEY9PiBRYmafdFKm57v4AxE2qVVnIpUS2
         L1rc+ES9++Cm9uDPt75Vq4zZhiKUlTYBFfz83ynUCDfryDIAVEjZmJFC44yuqi/x5kWv
         SpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y+V+kKBPiZCpoTn8VAMV6dpXygIxPvhwLC4JN5lt0p4=;
        b=RsFcai927r7vC3tGYc7cuj8P+PjHM0ySPYBWHiM1n5myR1dMrk2CnuWjUvK1KG/xqk
         YID5im55JkgPFnYRWiiPAsKbekcwbAAUrRy37x3aXEGiqz8fharGRqJR4u5b6KMkjrfb
         5tvbta2tCYdVDiDhXGPON4cXRN6S6+udrw15fr8g+mJ9+pdNDjToSoMp01sc3NqWbkbo
         iDTyNTC5cnrGORi7LaBlSLYkTcg4Mw11ZqYHK+0COBfZGMeOZH1KmrtU3B6UKiDhXzMP
         v/cHZdn5xsEmbXjqznbgOrtRqIhte+8oaB9cKcoBYuH5DcNR/M9BBm3Tmveozfkmcow2
         691w==
X-Gm-Message-State: AJcUukenSTsfx9j/V3qCJpyedXQkQ+1VcTo+HVjWbPtwCfnWHt9XuQux
        mGTO1RtflJGi2BvXL/mW3Cp34mvNnLe9Iw==
X-Google-Smtp-Source: ALg8bN6iKbtu3F2g6OK0mk22cgoGck0u+LYd7lI5AK7ysLPU/mtuHCUdNn6xIsJPCBI8ywyYQ6BWuQ==
X-Received: by 2002:ac8:7545:: with SMTP id b5mr3549878qtr.244.1547570602177;
        Tue, 15 Jan 2019 08:43:22 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p8sm52897748qtk.70.2019.01.15.08.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 08:43:21 -0800 (PST)
Subject: Re: [PATCH] kvm: add proper frame pointer logic for vmx
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com
Cc:     sean.j.christopherson@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190115064459.70513-1-cai@lca.pw>
 <a6477022-bbc0-fc00-2c8e-75007b468d3f@lca.pw>
 <5109b3c2-cac0-aa19-9cc7-801340afe198@redhat.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <7d6ae0bc-b7c7-63ea-ae94-4437a29a31b1@lca.pw>
Date:   Tue, 15 Jan 2019 11:43:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <5109b3c2-cac0-aa19-9cc7-801340afe198@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/19 2:13 AM, Paolo Bonzini wrote:
> Hmm, maybe like this:
> 
> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index bcef2c7e9bc4..33122fa9d4bd 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -26,19 +26,17 @@ ENTRY(vmx_vmenter)
>  	ret
> 
>  2:	vmlaunch
> +3:
>  	ret
> 
> -3:	cmpb $0, kvm_rebooting
> -	jne 4f
> -	call kvm_spurious_fault
> -4:	ret
> -
>  	.pushsection .fixup, "ax"
> -5:	jmp 3b
> +4:	cmpb $0, kvm_rebooting
> +	jne 3b
> +	jmp kvm_spurious_fault
>  	.popsection
> 
> -	_ASM_EXTABLE(1b, 5b)
> -	_ASM_EXTABLE(2b, 5b)
> +	_ASM_EXTABLE(1b, 4b)
> +	_ASM_EXTABLE(2b, 4b)
> 
>  ENDPROC(vmx_vmenter)

No, that will not work. The problem is in vmx.o where I just sent another patch
for it.

I can see there are five options to solve it.

1) always inline vmx_vcpu_run()
2) always noinline vmx_vcpu_run()
3) add -fdiable-ipa-fnsplit option to Makefile for vmx.o
4) let STACK_FRAME_NON_STANDARD support part.* syntax.
5) trim-down vmx_vcpu_run() even more to not causing splitting by GCC.

Option 1) and 2) seems give away the decision for user with
CONFIG_CC_OPTIMIZE_FOR_(PERFORMANCE/SIZE).

Option 3) prevents other functions there for splitting for optimization.

Option 4) and 5) seems tricky to implement.

I am not more leaning to 3) as only other fuction will miss splitting is
vmx_segment_access_rights().
