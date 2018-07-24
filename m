Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0861BECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58E020880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBUktD1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58E020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbeGXCwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:52:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388267AbeGXCwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:52:00 -0400
Received: from [192.168.0.217] (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C2EE20852;
        Tue, 24 Jul 2018 01:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532396881;
        bh=7VhrONIrhUb1PELHnDWvvakBkhQ+kSUGYS2FCZeAhgQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iBUktD1GZXxUZhtblOfqH4mfg3kayjQWwa9DImaKUBaEQ8Tjyft4ZMRNPuB4xSScA
         T6nNtIYdCNDCSbSJZg4vbuVEsTAELgUVRnx7b8umD/gsTpfjRXSadMNQ4v4xMejEo6
         USEvfkzz4N5ucnJa3utPOoH88BCXgTLdjPK0QgpA=
Subject: Re: [PATCH 5/7] x86/vdso: Add vDSO functions for direct store
 instructions
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>
Cc:     Ashok Raj <ashok.raj@intel.com>, Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com>
 <1532350557-98388-6-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <10870309-993a-0abc-635a-92c05bbad140@kernel.org>
Date:   Mon, 23 Jul 2018 18:48:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1532350557-98388-6-git-send-email-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 05:55 AM, Fenghua Yu wrote:
> User wants to query if direct store instructions are supported and use
> the instructions. The vDSO functions provides fast interface for user
> to query the support and use the instructions.
> 
> movdiri_supported and its alias __vdso_movdiri_supported check if
> movdiri instructions are supported.
> 
> movdir64b_supported and its alias __vdso_movdir64b_supported checks
> if movdir64b instruction is supported.
> 
> movdiri32 and its alias __vdso_movdiri32 provide user APIs for calling
> 32-bit movdiri instruction.
> 
> movdiri64 and its alias __vdso_movdiri64 provide user APIs for calling
> 64-bit movdiri instruction.
> 
> movdir64b and its alias __vdso_movdir64b provide user APIs to move
> 64-byte data through movdir64b instruction.
> 
> The instructions can be implemented in intrinsic functions in future
> GCC. But the vDSO interfaces are available to user without the
> intrinsic functions support in GCC and the APIs movdiri_supported and
> movdir64b_supported cannot be implemented as GCC functions.

I'm not convinced that any of this belongs in the vDSO at all.  You 
could just add AT_HWCAP (or AT_HWCAP2) flags for the new instructions. 
Or user code could use CPUID just like for any other new instruction. 
But, if there really is some compelling reason to add this to the vDSO, 
then see below:


+
> +notrace bool __vdso_movdiri_supported(void)
> +{
> +	return _vdso_funcs_data->movdiri_supported;

return static_cpu_has(X86_FEATURE_MOVDIRI);

And all the VVAR stuff can be removed.
