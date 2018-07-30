Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5B3FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DF0208A2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DF0208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeG3Nn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:43:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56071 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeG3Nn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:43:29 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fk6yj-0001X4-C3; Mon, 30 Jul 2018 14:08:45 +0200
Date:   Mon, 30 Jul 2018 14:08:45 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jacek Tomaka <jacekt@dug.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jacek Tomaka <jacekt@dugeo.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf/x86/intel: Add support for MISPREDICT bit on Knights
 Landing cpus
In-Reply-To: <20180728065641.26595-1-jacek.tomaka@poczta.fm>
Message-ID: <alpine.DEB.2.21.1807301357100.2518@nanos.tec.linutronix.de>
References: <20180728065641.26595-1-jacek.tomaka@poczta.fm>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jul 2018, Jacek Tomaka wrote:

> From: Jacek Tomaka <jacekt@dugeo.com>
> 
> Knights Landing supports half baked LBR_FORMAT_TIME format. The addresses are linear but it does have MISPREDICT bit but nothing else.

I really have no idea what you are trying to explain here.

> Unfortunately IA32_PERF_CAPABILITIES[5:0] will report LBR_FORMAT_LIP. This change teaches LBR about this Knights Landing quirk.

Please use proper line breaks around 78 characters. Also 'This change...'
is equally wrong as 'This patch...'. We know already that this is a
change/patch, right?

See Documentation/process/submitting-patches.rst and search for 'This
patch'.

> ---
>  arch/x86/events/intel/lbr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index cf372b9055..0f73e60315 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1230,4 +1230,10 @@ void intel_pmu_lbr_init_knl(void)
>  
>  	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
>  	x86_pmu.lbr_sel_map  = snb_lbr_sel_map;
> +
> +	/* Knights Landing supports half baked LBR format. The addresses are linear but it does have MISPREDICT bit.
> +	 * Unfortunately IA32_PERF_CAPABILITIES[5:0] will report LBR_FORMAT_LIP.
> +	 */

This also wants proper line breaks and please use proper comment style:

       /*
        * This is how a proper multi-line should
	* be formatted.
	*/

> +	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_LIP)
> +		lbr_desc[LBR_FORMAT_LIP] |= LBR_EIP_FLAGS;

Thanks,

	tglx
