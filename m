Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAD4C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F9E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F9E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeG0Ehh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:37:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:49621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbeG0Ehg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:37:36 -0400
Received: from homer.simpson.net ([185.191.216.17]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQQzk-1fZ5562bj2-00Tnug; Fri, 27
 Jul 2018 05:17:24 +0200
Message-ID: <1532661443.10554.5.camel@gmx.de>
Subject: Re: [PATCH RT v3] arm64: fpsimd: use preemp_disable in addition to
 local_bh_disable()
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 27 Jul 2018 05:17:23 +0200
In-Reply-To: <20180726150634.cl3wccqur6qhle6p@linutronix.de>
References: <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
         <20180522132429.6f1dcf92@gandalf.local.home>
         <20180522173333.aawadhkcekzvrswp@linutronix.de>
         <20180711092555.268adf7f@gandalf.local.home>
         <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
         <20180711093346.782af07a@gandalf.local.home>
         <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
         <20180716151737.GO9486@e103592.cambridge.arm.com>
         <20180718091209.u76gzacanj5avhdl@linutronix.de>
         <20180724094623.37430032@gandalf.local.home>
         <20180726150634.cl3wccqur6qhle6p@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bk/uvIiYuqB6ln/RHapkzlhZxPjq3jnUrSi0BIsOhR1K51j8/qB
 W7dNc2whT+8abPGNotPTYu2J+Y1hBU7Pse2bo8/LinUlqEJktx2NREpCLOpLUdIBre1Ponk
 dWl7dl4Fjg+hYeNMjb9lXpS9pxuubUor81uoui/eDK6qFEd8fwr10dkfa6oU8csSbXaxQcV
 LIFRqtvxxxcaX5ZV/3XOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XYQ28oBEgAQ=:so/RZZ/Kv6ehIRlUnyaolF
 P4q3meAw2/kZiYOruWdCFUt0qkuCfyj1tyf90Dmxt2QPQ6GnZF2nx4PdUzzTVVCdyD6Lz5H4G
 bGH0kxkGL5rUET0JVYSRs2ZsmJ9mX6XxuwKKpHfRnrqi6932gLhQXfZHbOW6Ozqv3Wcph7rOU
 SMdJCR+TXnWulxCoTwCiPNFzXET438StUNSvrac4M81okmAjXoiZvK5LhC4YOkJTkvT3JEwto
 N0Rn/L6sozANUChw14BcGQIImb02XzKtKK0OKt0lkrdWxYNAvZ4k8d4WhmitDnaPq4WFNxZXk
 20wY4uwFSRTScpEGAV+gvSeuB87VwWfNH67V1Q/FuBfhynPjSiIGbf/BM5t2VWt6Bkiy87svL
 6dmFGKGbNj0HdrkCOR2YaJ5epttdsqsnlkzunoIsYSPJ3jwQayqSts9/dKfIry7/DNJ3ptNNI
 BzB9ss5fX2z76perzC/2fVBH42meyPGsC1zOkfma/U2ZPQvEfvv48yLattkj6frecFzwQK6uy
 8tnMEbO6j/1rITw32vR47HtC7IuTOZMs5IlozzkZSyj3oNPZ05y2ciCjtpH1JtwzsvbETd3RB
 3i+qvnjbHTPU9znn8XGrFzLndOBnugaEKtKiQ0MUVDJzPwZ3BvwzRCk+dHEmzPZwFCjTc3LXm
 f9nchbmiDsZPlEIUINU+Q7XO5sUrvzvtJpJR5McYjnCJIw7luEVeWTDWhHkJyuaWrqQ8oPGPY
 Pj+WAQY7KoujWFqedeW4zzBGe7evoMCUzp75j76eUTll19dTAg25pNG7CnrPkDfaWfE2tnOKw
 IRDulXJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-26 at 17:06 +0200, Sebastian Andrzej Siewior wrote:
> 
> @@ -1115,6 +1139,7 @@ void kernel_neon_begin(void)
>  
>  	BUG_ON(!may_use_simd());
>  
> +	preempt_disable();
>  	local_bh_disable();
>  
>  	__this_cpu_write(kernel_neon_busy, true);
> @@ -1131,6 +1156,7 @@ void kernel_neon_begin(void)
>  	preempt_disable();

Nit: this preempt_disable() could be removed...
 
>  	local_bh_enable();
> +	preempt_enable();
>  }
>  EXPORT_SYMBOL(kernel_neon_begin);

...instead of adding this one.

	-Mike
