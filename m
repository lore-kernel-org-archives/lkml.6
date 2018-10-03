Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A754DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7582420652
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7582420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeJCNtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:49:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33149 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeJCNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:49:47 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7bAy-00080a-FZ; Wed, 03 Oct 2018 09:02:28 +0200
Date:   Wed, 3 Oct 2018 09:02:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     fenghua.yu@intel.com, tony.luck@intel.com, jithu.joseph@intel.com,
        gavin.hindman@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/intel_rdt: CBM overlap should also check for
 overlap with CDP peer
In-Reply-To: <262e12b66c238517c4766190dd493d937825f563.1537987801.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1810030848580.1435@nanos.tec.linutronix.de>
References: <cover.1537987801.git.reinette.chatre@intel.com> <262e12b66c238517c4766190dd493d937825f563.1537987801.git.reinette.chatre@intel.com>
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

On Wed, 26 Sep 2018, Reinette Chatre wrote:
>  /**
> - * rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
> + * _rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
>   * @r: Resource to which domain instance @d belongs.
>   * @d: The domain instance for which @closid is being tested.
>   * @cbm: Capacity bitmask being tested.
> @@ -1049,8 +1048,8 @@ static int __attribute__((unused)) rdt_cdp_peer_get(struct rdt_resource *r,
>   *
>   * Return: false if CBM does not overlap, true if it does.
>   */
> -bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
> -			   u32 _cbm, int closid, bool exclusive)
> +static bool _rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
> +				   u32 _cbm, int closid, bool exclusive)

Existing issue. The documentation uses @cbm, but the argument is _cbm.

Also please make this __rdtgroup_cbm_overlaps(). Double underscores are
standing more out.

>  {
>  	unsigned long *cbm = (unsigned long *)&_cbm;
>  	unsigned long *ctrl_b;
> @@ -1087,6 +1086,44 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
>  	return false;
>  }
>  
> +/**
> + * rdtgroup_cbm_overlaps - Does CBM overlap with other use of hardware
> + * @r: Resource to which domain instance @d belongs.
> + * @d: The domain instance for which @closid is being tested.
> + * @cbm: Capacity bitmask being tested.
> + * @closid: Intended closid for @cbm.
> + * @exclusive: Only check if overlaps with exclusive resource groups
> + *
> + * Resources that can be allocated using a CBM can use the CBM to control
> + * the overlap of these allocations. rdtgroup_cmb_overlaps() is the test
> + * for overlap. Overlap test is not limited to the specific resource for
> + * which the CBM is intended though - when dealing with CDP resources that
> + * share the underlying hardware the overlap check should be performed on
> + * the CDP resource sharing the hardware also.
> + *
> + * Refer to description of _rdtgroup_cbm_overlaps() for the details of the
> + * overlap test.
> + *
> + * Return: true if CBM overlap detected, false if there is no overlap
> + */
> +bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
> +			   u32 _cbm, int closid, bool exclusive)

Ditto. And here is no reason for using _cbm.

> +{
> +	struct rdt_resource *r_cdp;
> +	struct rdt_domain *d_cdp;
> +	bool ret;
> +
> +	ret = _rdtgroup_cbm_overlaps(r, d, _cbm, closid, exclusive);
> +	if (ret)
> +		return ret;

  	if (__rdtgroup_cbm_overlaps(r, d, _cbm, closid, exclusive))
		return true;

> +
> +	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp) == 0)
> +		return _rdtgroup_cbm_overlaps(r_cdp, d_cdp, _cbm,
> +					      closid, exclusive);

	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp) < 0)
		return false;

	return __rdtgroup_cbm_overlaps(r_cpd, d_cdp, _cbm, closid, exclusive);

Makes the whole thing more obvious.

Thanks,

	tglx

