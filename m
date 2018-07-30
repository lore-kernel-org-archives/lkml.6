Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAACF16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A759120857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A759120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbeG3T36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:29:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbeG3T36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:29:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01995CFB47;
        Mon, 30 Jul 2018 17:53:51 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6952112D189;
        Mon, 30 Jul 2018 17:53:50 +0000 (UTC)
Subject: Re: [PATCH] arch/x86: Fix boot_cpu_data.microcode version output
To:     bp@alien8.de
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        sironi@amazon.de, tony.luck@intel.com, stable@vger.kernel.org
References: <20180601121939.GA23298@nazgul.tnic>
 <20180730174911.26238-1-prarit@redhat.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <ee722f10-ea30-56a5-6efa-6b3c82a72d8f@redhat.com>
Date:   Mon, 30 Jul 2018 13:53:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180730174911.26238-1-prarit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 30 Jul 2018 17:53:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 30 Jul 2018 17:53:51 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'prarit@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/30/2018 01:49 PM, Prarit Bhargava wrote:
> On systems where a runtime microcode update has occurred the microcode
> version output in a MCE log record is wrong because
> boot_cpu_data.microcode is not updated during runtime.
> 
> Update boot_cpu_data.microcode when the BSP's microcode is updated.
> 
> Fixes: fa94d0c6e0f3 ("x86/MCE: Save microcode revision in machine check records")
> Suggested-by: Borislav Petkov <bp@alien8.com>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: sironi@amazon.de
> Cc: tony.luck@intel.com
> ---
>  arch/x86/kernel/cpu/microcode/amd.c   | 4 ++++
>  arch/x86/kernel/cpu/microcode/intel.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 0624957aa068..7f5b32535ac7 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -537,6 +537,10 @@ static enum ucode_state apply_microcode_amd(int cpu)
>  	uci->cpu_sig.rev = mc_amd->hdr.patch_id;
>  	c->microcode = mc_amd->hdr.patch_id;
>  
> +	/* Update boot_cpu_data's revision too, if we're on the BSP: */
> +	if (c->cpu_index == boot_cpu_data.cpu_index)
> +		boot_cpu_data.microcode = rev;
> +

Borislav, hold off on this.  I want to double check something with AMD.

I think this has to be

	boot_cpu_data.microcode = mc_amd->hdr.patch_id;

I'm going to grab some old/new microcode and test.  I do know that the Intel
update below works.

P.

>  	return UCODE_UPDATED;
>  }
>  
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 97ccf4c3b45b..256d336cbc04 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -851,6 +851,10 @@ static enum ucode_state apply_microcode_intel(int cpu)
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
> 
