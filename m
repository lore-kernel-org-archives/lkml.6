Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88784C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CCA20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CCA20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJCNdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:33:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33127 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbeJCNdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:33:41 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7avX-0007sU-0F; Wed, 03 Oct 2018 08:46:31 +0200
Date:   Wed, 3 Oct 2018 08:46:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     fenghua.yu@intel.com, tony.luck@intel.com, jithu.joseph@intel.com,
        gavin.hindman@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/intel_rdt: Introduce utility to obtain CDP
 peer
In-Reply-To: <6e8c2eddf0cb2521fe7018357a0fa6f8dba7a882.1537987801.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1810030843180.1435@nanos.tec.linutronix.de>
References: <cover.1537987801.git.reinette.chatre@intel.com> <6e8c2eddf0cb2521fe7018357a0fa6f8dba7a882.1537987801.git.reinette.chatre@intel.com>
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
> + * Return: 0 if a CDP peer was found, <0 on error or if no CDP peer exists.
> + *         If a CDP peer was found, @r_cdp will point to the peer RDT resource
> + *         and @d_cdp will point to the peer RDT domain.
> + */
> +static int __attribute__((unused)) rdt_cdp_peer_get(struct rdt_resource *r,
> +						    struct rdt_domain *d,
> +						    struct rdt_resource **r_cdp,
> +						    struct rdt_domain **d_cdp)
> +{
> +	struct rdt_resource *_r_cdp = NULL;
> +	struct rdt_domain *_d_cdp = NULL;
> +	int ret = 0;
> +
> +	switch (r->rid) {
> +	case RDT_RESOURCE_L3DATA:
> +		_r_cdp = &rdt_resources_all[RDT_RESOURCE_L3CODE];
> +		break;
> +	case RDT_RESOURCE_L3CODE:
> +		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L3DATA];
> +		break;
> +	case RDT_RESOURCE_L2DATA:
> +		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2CODE];
> +		break;
> +	case RDT_RESOURCE_L2CODE:
> +		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2DATA];
> +		break;
> +	default:
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	/*
> +	 * When a new CPU comes online and CDP is enabled then the new
> +	 * RDT domains (if any) associated with both CDP RDT resources
> +	 * are added in the same CPU online routine while the
> +	 * rdtgroup_mutex is held. It should thus not happen for one
> +	 * RDT domain to exist and be associated with its RDT CDP
> +	 * resource but there is no RDT domain associated with the
> +	 * peer RDT CDP resource. Hence the WARN.
> +	 */
> +	_d_cdp = rdt_find_domain(_r_cdp, d->id, NULL);
> +	if (WARN_ON(!_d_cdp)) {
> +		_r_cdp = NULL;
> +		ret = -ENOENT;

While this should never happen, the return value is ambiguous. I'd rather
use EINVAL or such and propagate it further down at the call site.

Thanks,

	tglx


