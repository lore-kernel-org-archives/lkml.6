Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EBFECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684FF20866
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684FF20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbeJQRzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:55:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59847 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQRzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:55:17 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gCicS-0004xG-97; Wed, 17 Oct 2018 12:00:00 +0200
Date:   Wed, 17 Oct 2018 11:59:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <andi@firstfloor.org>
cc:     peterz@infradead.org, x86@kernel.org, eranian@google.com,
        kan.liang@intel.com, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 1/2] x86/cpufeature: Add facility to match microcode
 revisions
In-Reply-To: <20181010162608.23899-1-andi@firstfloor.org>
Message-ID: <alpine.DEB.2.21.1810171151010.6000@nanos.tec.linutronix.de>
References: <20181010162608.23899-1-andi@firstfloor.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018, Andi Kleen wrote:
> +/*
> + * Match specific microcodes
> + *
> + * vendor/family/model/stepping must be all set.
> + * min_ucode is optional and can be 0.

Stale comment

> + */
> +
> +struct x86_ucode_id {
> +	u8 vendor;
> +	u8 family;
> +	u16 model;
> +	u16 stepping;

Still using u16 for no reason. And please make the members aligned in a
tabular fashion.

> +	u32 min_ucode;
> +};
> +
> +const struct x86_ucode_id *x86_match_ucode(const struct x86_ucode_id *match)

What's the point of returning the struct pointer? Shouldn't it be enough to
make it return bool? Also the function name really should reflect that this
checks whether the minimal required microcode revision is active.

> +{
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
> +	const struct x86_ucode_id *m;
> +
> +	for (m = match; m->vendor | m->family | m->model; m++) {

VENDOR_INTEL = 0, so this check is obscure to begin with. Either you chose
a explicit condition to put at the end of the table, e.g. vendor = U8_MAX
or you hand in the array size to the function.

> +		if (c->x86_vendor != m->vendor)
> +			continue;
> +		if (c->x86 != m->family)
> +			continue;
> +		if (c->x86_model != m->model)
> +			continue;
> +		if (c->x86_stepping != m->stepping)
> +			continue;
> +		if (c->microcode < m->min_ucode)
> +			continue;

Why would you continue here? If vendor, family, model, stepping match, then
there is no point to continue, really. Assuming that the return type is bool:

      	    	return c->microcode >= m->min_ucode;

is sufficient.

Thanks,

	tglx
