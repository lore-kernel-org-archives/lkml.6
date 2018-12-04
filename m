Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A029CC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0F22082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0F22082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbeLDSJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:09:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38440 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbeLDSJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:09:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD485A78;
        Tue,  4 Dec 2018 10:09:22 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD2453F59C;
        Tue,  4 Dec 2018 10:09:20 -0800 (PST)
Date:   Tue, 4 Dec 2018 18:09:18 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        daniel.thompson@linaro.org, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        joel@joelfernandes.org, Dave Martin <dave.martin@arm.com>
Subject: Re: [PATCH v6 21/24] arm64: Handle serror in NMI context
Message-ID: <20181204180917.GE19210@arrakis.emea.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-22-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542023835-21446-22-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 11:57:12AM +0000, Julien Thierry wrote:
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 5f4d9ac..66344cd 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -897,13 +897,17 @@ bool arm64_is_fatal_ras_serror(struct pt_regs *regs, unsigned int esr)
>  
>  asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
>  {
> -	nmi_enter();
> +	const bool was_in_nmi = in_nmi();
> +
> +	if (!was_in_nmi)
> +		nmi_enter();
>  
>  	/* non-RAS errors are not containable */
>  	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
>  		arm64_serror_panic(regs, esr);
>  
> -	nmi_exit();
> +	if (!was_in_nmi)
> +		nmi_exit();
>  }

Do we actually need nmi_enter/exit in the outer do_serror() function?
Could we just move it to arm64_serror_panic()?

-- 
Catalin
