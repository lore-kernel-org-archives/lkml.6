Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D6C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278E620645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278E620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJCM5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:57:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33075 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbeJCM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:57:33 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7aMi-0007Xz-4O; Wed, 03 Oct 2018 08:10:32 +0200
Date:   Wed, 3 Oct 2018 08:10:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kan Liang <kan.liang@linux.intel.com>
cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf/x86/intel: Add counter freezing quirk for
 Goldmont
In-Reply-To: <1538515812-8808-1-git-send-email-kan.liang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810030803260.1435@nanos.tec.linutronix.de>
References: <1538515812-8808-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018, kan.liang@linux.intel.com wrote:
> +static bool intel_atom_v4_counter_freezing_broken(int cpu)
>  {
>  	u32 rev = UINT_MAX; /* default to broken for unknown stepping */
>  
> -	switch (cpu_data(cpu).x86_stepping) {
> -	case 1:
> -		rev = 0x28;
> +	switch (cpu_data(cpu).x86_model) {
> +	case INTEL_FAM6_ATOM_GOLDMONT:
> +		switch (cpu_data(cpu).x86_stepping) {
> +		case 2:
> +			rev = 0xe;
> +			break;
> +		case 9:
> +			rev = 0x2e;
> +			break;
> +		case 10:
> +			rev = 0x8;
> +			break;
> +		}
>  		break;
> -	case 8:
> -		rev = 0x6;
> +
> +	case INTEL_FAM6_ATOM_GOLDMONT_X:
> +		switch (cpu_data(cpu).x86_stepping) {
> +		case 1:
> +			rev = 0x1a;
> +			break;
> +		}
>  		break;
> +
> +	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
> +		switch (cpu_data(cpu).x86_stepping) {
> +		case 1:
> +			rev = 0x28;
> +			break;
> +		case 8:
> +			rev = 0x6;
> +			break;
> +		}
>  	}
>  
>  	return (cpu_data(cpu).microcode < rev);

There is another variant of model/stepping micro code verification code in
intel_snb_pebs_broken(). Can we please make this table based and use a
common function? That's certainly not the last quirk we're going to have.

We already have a table based variant of ucode checking in
bad_spectre_microcode(). It's trivial enough to generalize that.

Thanks,

	tglx






