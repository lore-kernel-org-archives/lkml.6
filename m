Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF4FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D58620652
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D58620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeJDCdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:33:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34627 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbeJDCdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:33:42 -0400
Received: from tmo-108-185.customers.d1-online.com ([80.187.108.185] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7n3h-00047x-2w; Wed, 03 Oct 2018 21:43:45 +0200
Date:   Wed, 3 Oct 2018 21:43:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     fenghua.yu@intel.com, tony.luck@intel.com, jithu.joseph@intel.com,
        gavin.hindman@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/intel_rdt: CBM overlap should also check for
 overlap with CDP peer
In-Reply-To: <6fc60e52-8f93-6135-78c0-254676c0c375@intel.com>
Message-ID: <alpine.DEB.2.21.1810032138290.27796@nanos.tec.linutronix.de>
References: <cover.1537987801.git.reinette.chatre@intel.com> <262e12b66c238517c4766190dd493d937825f563.1537987801.git.reinette.chatre@intel.com> <alpine.DEB.2.21.1810030848580.1435@nanos.tec.linutronix.de> <6fc60e52-8f93-6135-78c0-254676c0c375@intel.com>
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

Reinette,

On Wed, 3 Oct 2018, Reinette Chatre wrote:
> On 10/3/2018 12:02 AM, Thomas Gleixner wrote:
> >> +{
> >> +	struct rdt_resource *r_cdp;
> >> +	struct rdt_domain *d_cdp;
> >> +	bool ret;
> >> +
> >> +	ret = _rdtgroup_cbm_overlaps(r, d, _cbm, closid, exclusive);
> >> +	if (ret)
> >> +		return ret;
> > 
> >   	if (__rdtgroup_cbm_overlaps(r, d, _cbm, closid, exclusive))
> > 		return true;
> > 
> >> +
> >> +	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp) == 0)
> >> +		return _rdtgroup_cbm_overlaps(r_cdp, d_cdp, _cbm,
> >> +					      closid, exclusive);
> > 
> > 	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp) < 0)
> > 		return false;
> > 
> > 	return __rdtgroup_cbm_overlaps(r_cpd, d_cdp, _cbm, closid, exclusive);
> > 
> > Makes the whole thing more obvious.
> 
> I think a different change is needed to support the request from your
> review of the first patch to propagate that unthinkable error where only
> one of the CDP peers could have an rdt_domain associated with it.
> 
> In the above that error in question from rdt_cdp_peer_get() will be lost.
> 
> I could do the following in support of propagating that error (note that
> in support of the code below __rdtgroup_cbm_overlaps() also changes to
> return int instead of bool):
> 
> int rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
>                           u32 cbm, int closid, bool exclusive)
> {
>         struct rdt_resource *r_cdp;
>         struct rdt_domain *d_cdp;
>         int ret;
> 
>         if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, exclusive))
>                 return 1;
> 
>         ret = rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
>         if (ret == -ENOENT) {
>                 return 0;
>         } else if (ret == -EINVAL) {
>                 rdt_last_cmd_puts("Error finding CDP peer\n");
>                 return ret;
>         } else {
>                 return  __rdtgroup_cbm_overlaps(r_cdp, d_cdp, cbm,
>                                                 closid, exclusive);
>         }
> 
>         return -EINVAL;
> }
> 
> With the above change in rdtgroup_cbm_overlaps() the call sites then
> change to for example:
> 
>         ret = rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, true);
>         if (ret < 0) {
>                 /* last_cmd_status already populated with error */
>                 return -EINVAL;
>         } else if (ret == 1) {
>                 rdt_last_cmd_puts("overlaps with exclusive group\n");
>                 return -EINVAL;
>         }
>         /* fall through when no overlap detected */
> 
> Would this be acceptable?

We really have to think about that whether it's worth it. Looking at the
resulting code I doubt it. Then I'd rather prefer the warnon and the
simpler code. But either way works for me.

Thanks,

	tglx
