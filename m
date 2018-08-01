Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA50EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210A420841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="pYFKLptI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210A420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbeHAIWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:22:24 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:33440 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbeHAIWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:22:23 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 7C07C3BD178;
        Wed,  1 Aug 2018 08:38:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1533105494;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=7A90u1Ua7tw5ZpW2yxxAXzOixNxENpJ/9VkmoWyl7JU=;
        b=pYFKLptIqHd/cbkSqJMrkAi+M1QWstjCDHG9WUaOeTP+UbHwPqvDgtT2YUvlhIcSgjfixu
        NiGeHSt6yIda2BtMFggOqqbnVuJYFjxO+jdCIV9Rb+TiqHfyMvO6kGumxykMFcV6Pdo4RK
        BbBn1Hkl2YgEClwD7l5xTd1k/8um0Mw=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 7C07C3BD178
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Aug 2018 08:38:14 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     prarit@redhat.com
Cc:     bp@alien8.de, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, sironi@amazon.de,
        stable@vger.kernel.org, tony.luck@intel.com
Subject: Re: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
In-Reply-To:  <<20180731112739.32338-1-prarit@redhat.com>>
Message-ID: <d8ac835211e5649b5494141a0decc3bc@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.6
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1533105495;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=7A90u1Ua7tw5ZpW2yxxAXzOixNxENpJ/9VkmoWyl7JU=;
        b=sWpIg5wvy0bCAZrBjJuSAdeofdkEkyFxIJJJJkTyLE3ujAcGl2x4CsMRx1V/cZfMcxmxjL
        TJ++Mt0uQxdOpuheqdY859soh4YmjjtfxeQMVluX8gJnbLiaGB0VIylphvfu6DMb4cXpDq
        0U388wILpfkHmH8hhXE4+uX/UXwoGCc=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1533105495; a=rsa-sha256;
        cv=none;
        b=nHqE7FmzWJRMHowrjt1cp6WC/JFZpejrsMTCS0t+100FwWkPafZjfN9bTjRdT7sGGmUqcD04B/v8EotmYq16lmGCNDJDux9WNz6zXAUCYuc8ykfc0LInizdmdlXxz3ZENgzZD+AIGUEFYLnxXA4SHaP9NiMlLDkmRkCX1in0wJw=
ARC-Authentication-Results: i=1; vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> I tested this on AMD Ryzen & Intel Broadwell system and dumped the
> boot_cpu_data before and after a microcode update.  On the Intel
> system I also did a fatal MCE using mce-inject to confirm the output
> from the mce handling code.
> 
> P.
> 
> ---8<---
> 
> On systems where a runtime microcode update has occurred the microcode
> version output in a MCE log record is wrong because
> boot_cpu_data.microcode is not updated during runtime.
> 
> Update boot_cpu_data.microcode when the BSP's microcode is updated.
> 
> Fixes: fa94d0c6e0f3 ("x86/MCE: Save microcode revision in machine check 
> records")
> Suggested-by: Borislav Petkov <bp@alien8.com>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: sironi@amazon.de
> Cc: tony.luck@intel.com
> ---
> Changes in v2: Use mc_amd->hdr.patch_id on AMD
> 
>  arch/x86/kernel/cpu/microcode/amd.c   | 4 ++++
>  arch/x86/kernel/cpu/microcode/intel.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c 
> b/arch/x86/kernel/cpu/microcode/amd.c
> index 0624957aa068..63b072377ba4 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -537,6 +537,10 @@ static enum ucode_state apply_microcode_amd(int 
> cpu)
>  	uci->cpu_sig.rev = mc_amd->hdr.patch_id;
>  	c->microcode = mc_amd->hdr.patch_id;
> 
> +	/* Update boot_cpu_data's revision too, if we're on the BSP: */
> +	if (c->cpu_index == boot_cpu_data.cpu_index)
> +		boot_cpu_data.microcode =  mc_amd->hdr.patch_id;
> +
>  	return UCODE_UPDATED;
>  }
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c 
> b/arch/x86/kernel/cpu/microcode/intel.c
> index 97ccf4c3b45b..256d336cbc04 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -851,6 +851,10 @@ static enum ucode_state apply_microcode_intel(int 
> cpu)
>  	uci->cpu_sig.rev = rev;
>  	c->microcode = rev;
> 
> +	/* Update boot_cpu_data's revision too, if we're on the BSP: */
> +	if (c->cpu_index == boot_cpu_data.cpu_index)
> +		boot_cpu_data.microcode = rev;
> +
>  	return UCODE_UPDATED;
>  }
> 
> --
> 2.17.0

After this patch, do we preserve an original microcode version 
somewhere? If no, why? Sometimes it is useful while debugging another 
crash because of faulty microcode.

Thanks.

-- 
   Oleksandr Natalenko (post-factum)
