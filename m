Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B874ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5BD206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5BD206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeGTHZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:25:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58488 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbeGTHZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:25:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94BB118A;
        Thu, 19 Jul 2018 23:38:42 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3C973F246;
        Thu, 19 Jul 2018 23:38:40 -0700 (PDT)
Date:   Fri, 20 Jul 2018 07:38:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCHv2 1/2] arm64: Add stack information to on_accessible_stack
Message-ID: <20180720063837.5c5nxypv4urumz2m@salmiak>
References: <20180719232806.3397-1-labbott@redhat.com>
 <20180719232806.3397-2-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719232806.3397-2-labbott@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 04:28:05PM -0700, Laura Abbott wrote:
> 
> In preparation for enabling the stackleak plugin on arm64,
> we need a way to get the bounds of the current stack. Extend
> on_accessible_stack to get this information.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Switched to using struct stack_info for argument passing.
> on_accessible_stack is now the primary API. Split STACK_TYPE_SDEI
> into STACK_TYPE_SDEI_NORMAL and STACK_TYPE_SDEI_CRITICAL.

[...]

> -static inline bool on_irq_stack(unsigned long sp)
> +static inline bool on_irq_stack(unsigned long sp,
> +				struct stack_info *info)
>  {
>  	unsigned long low = (unsigned long)raw_cpu_read(irq_stack_ptr);
>  	unsigned long high = low + IRQ_STACK_SIZE;
> @@ -47,46 +63,79 @@ static inline bool on_irq_stack(unsigned long sp)
>  	if (!low)
>  		return false;
>  
> -	return (low <= sp && sp < high);
> +	if (sp < low || sp >= high)
> +		return false;
> +
> +	if (info) {
> +		info->low = low;
> +		info->high = high;
> +		info->type = STACK_TYPE_IRQ;
> +	}
> +
> +	return true;
>  }

[...]

> -bool _on_sdei_stack(unsigned long sp)
> +bool on_sdei_normal_stack(unsigned long sp,
> +			struct stack_info *info)
> +{
> +	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
> +	unsigned long high = low + SDEI_STACK_SIZE;
> +
> +	if (low <= sp && sp < high) {
> +		if (info) {
> +			info->low = low;
> +			info->high = high;
> +			info->type = STACK_TYPE_SDEI_NORMAL;
> +		}
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +bool on_sdei_critical_stack(unsigned long sp,
> +			struct stack_info *info)
> +{
> +	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_critical_ptr);
> +	unsigned long high = low + SDEI_STACK_SIZE;
> +
> +	if (low <= sp && sp < high) {
> +		if (info) {
> +			info->low = low;
> +			info->high = high;
> +			info->type = STACK_TYPE_SDEI_CRITICAL;
> +		}
> +		return true;
> +	}
> +
> +	return false;
> +}

Minor nit, but it would be good to avoid the nested conditionals for these two
by bailing out early when the SP is out of bounds, as with the other
on_<foo>_stack() functions, e.g.

bool on_sdei_normal_stack(unsigned long sp,
			struct stack_info *info)
{
	unsigned long low = (unsigned long)raw_cpu_read(sdei_stack_normal_ptr);
	unsigned long high = low + SDEI_STACK_SIZE;

	if (sp < low || sp >= high)
		return false;

	if (info) {
		info->low = low;
		info->high = high;
		info->type = STACK_TYPE_SDEI_NORMAL;
	}

	return true;
}

Otherwise, this all looks good to me. With that:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks for working on this!

Mark.
