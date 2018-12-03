Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C97C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AB32087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AB32087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeLCPjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:39:22 -0500
Received: from muru.com ([72.249.23.125]:56134 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbeLCPjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:39:22 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E041880BF;
        Mon,  3 Dec 2018 15:39:19 +0000 (UTC)
Date:   Mon, 3 Dec 2018 07:39:10 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Tero Kristo <t-kristo@ti.com>,
        Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        letux-kernel@openphoenux.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        mturquette@baylibre.com, paul@pwsan.com
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
Message-ID: <20181203153910.GA6707@atomide.com>
References: <20181110203115.13335-1-andreas@kemnade.info>
 <20181110203115.13335-3-andreas@kemnade.info>
 <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
 <20181130071534.0a6cd455@kemnade.info>
 <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
 <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
 <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
 <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
 <20181130153729.GG53235@atomide.com>
 <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Boyd <sboyd@kernel.org> [181130 23:52]:
> Quoting Tony Lindgren (2018-11-30 07:37:29)
> > Hi,
> > 
> > * Tero Kristo <t-kristo@ti.com> [181130 09:21]:
> > > On 30/11/2018 09:57, Stephen Boyd wrote:
> > > > No that is not preferred. Can the omap2_clk_deny_idle() function be
> > > > integrated closer into the clk framework in some way that allows it to
> > > > be part of the clk_ops structure? And then have that take a clk_hw
> > > > structure instead of a struct clk? I haven't looked at this in any
> > > > detail whatsoever so I may be way off right now.
> > > 
> > > It could be added under the main clk_ops struct, however this would
> > > introduce two new func pointers to it which are not used by anything else
> > > but OMAP. Are you aware of any other platforms requiring similar feature?
> > 
> > From consumer usage point of view, I'm still wondering about
> > the relationship of clk_deny_idle() and clkdm_deny_idle().
> > 
> > It seems that we need to allow reset control drivers call
> > clk_deny_idle() for the duration of reset. And it seems the
> > clk_deny_idle() should propagate to also up to the related
> > clock domain driver to do clkdm_deny_idle().
> > 
> > So maybe clk_deny_idle() is could just be something like:
> > 
> > dev = clk_get_device(clk);
> > ...
> > error = pm_runtime_get(dev);
> > ...
> > pm_runtime_put(dev);
> > ...
> > 
> > And that way it would just propagate to the parent clock
> > domain driver and the clock framework does not need to know
> > about clockdomains. A clockdomain could be just a genpd
> > domain.
> > 
> > Or do you guys have better ideas?
> > 
> 
> Wouldn't the device link in clk framework patches do this for you if we
> had the RUNTIME_PM flag passed in. If this is about keeping the clock
> controller active when a consumer device is using it then I think it may
> work.

The consumer device stays active just fine with PM runtime
calls. So yes, the problem is keeping a clock controller forced
active for the period of consumer device reset. Other than
that typically autoidle can be just kept enabled.

Below is a clarified suggested example usage if we wanted to
use PM runtime on a clock controller device from a consumer
device reset driver:

error = pm_runtime_get_dev()
...
cdev = clk_get_device(clk);
...
error = pm_runtime_get(cdev);
...
/* Do the consumer device reset here */
...
pm_runtime_put(cdev);
pm_runtime_put(dev);

Regards,

Tony
