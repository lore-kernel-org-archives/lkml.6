Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCCFECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CEE21479
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CEE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeIOPce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 11:32:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51596 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbeIOPce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 11:32:34 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g17aL-0005nz-O2; Sat, 15 Sep 2018 12:13:53 +0200
Date:   Sat, 15 Sep 2018 12:13:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 1/9] x86/intel_rdt: Fix MBA parsing callback
In-Reply-To: <1536957129-70380-2-git-send-email-fenghua.yu@intel.com>
Message-ID: <alpine.DEB.2.21.1809151206340.1650@nanos.tec.linutronix.de>
References: <1536957129-70380-1-git-send-email-fenghua.yu@intel.com> <1536957129-70380-2-git-send-email-fenghua.yu@intel.com>
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

On Fri, 14 Sep 2018, Fenghua Yu wrote:
>  int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d);
> -int parse_bw(void *_buf, struct rdt_resource *r,  struct rdt_domain *d);
> +int parse_bw(void *_data, struct rdt_resource *r, struct rdt_domain *d);

Sorry no. This keeps the code equally error prone as it was. Why is that
argument a void pointer in the first place? 

>  extern struct mutex rdtgroup_mutex;
>  
> diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
> index af358ca05160..d427c86e7cd0 100644
> --- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
> @@ -28,6 +28,11 @@
>  #include <linux/slab.h>
>  #include "intel_rdt.h"
>  
> +struct rdt_parse_data {
> +	struct rdtgroup		*rdtgrp;
> +	char			*buf;
> +};

This is a copy of rdt_cbm_parse_data. Sigh.

The right thing to do here is

    1) rename struct rdt_cbm_parse_data to struct rdt_parse_data

    2) Move it to a header file

    3) Change the argument of parse_ctrlval from void * to struct
       rdt_parse_data *

Everything else is just proliferating the initial underlying problem of
having a void pointer in those callbacks for no reason at all.

Thanks,

	tglx
