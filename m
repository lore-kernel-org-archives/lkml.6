Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B118AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E8A20818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfBEQlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:41:37 -0500
Received: from muru.com ([72.249.23.125]:37726 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729743AbfBEQlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:41:36 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2A4CE809C;
        Tue,  5 Feb 2019 16:41:44 +0000 (UTC)
Date:   Tue, 5 Feb 2019 08:41:32 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     s-anna@ti.com, ohad@wizery.com, bjorn.andersson@linaro.org,
        david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com,
        nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com,
        woods.technical@gmail.com, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Message-ID: <20190205164132.GT5720@atomide.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <20190204163312.GI5720@atomide.com>
 <5C5959DB.2090608@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C5959DB.2090608@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190205 09:40]:
> On 04/02/19 18:33, Tony Lindgren wrote:
> > 
> > 	shrdram2: memory@10000 {
> > 		device_type = "memory";
> > 		reg = <0x10000 0x3000>;
> > 	};
> 
> Shared RAM is not so straight forward. Both PRU firmwares and both application drivers
> might need to read/write here. The area split is decided by firmware design and there
> is no hardware protection to prevent from stomping on each others toes.
> 
> We need a carveout based memory allocator at least I think that can do a
> allocate(base_offset, size); into shared RAM.
> 
> This could be used by pru_rproc driver at firmware load time and by application drivers
> at initialization time.
> 
> Thoughts?

That sounds sane to me :)

> > If the ti,pruss-gp-mux-sel and ti,pru-interrupt-map are
> > firmware configuration options, maybe leave them out of
> > the dts completely and make the app-node optional.
> 
> Yes the app-node is optional. I will mention it.
> 
> No, ti,pruss-gp-mux-sel and ti,pru-interrupt-map are not firmware options.
> But these settings are application/firmware specific.
> 
> ti,pru-interrupt-map specifies the configuration to be used for the INTC interrupt
> controller.

OK. So just to see if we have a standard solution available already..
It sounds a bit similar to what we're doing with omap-wakeupgen.c
and stacked interrupts? I wonder if something similar might help
here?

> ti,pruss-gp-mux-sel is used to configure this register.
> "Table 30-20. PRUSS_GPCFG0" in http://www.tij.co.jp/jp/lit/ug/spruhz7h/spruhz7h.pdf
> "29:26 PR1_PRU0_GP_MUX_SEL"
> 
> It configures how the pins from the PRUSS module are routed internally
> to the various modules.
> 
> see "30.2.1 PRU-ICSS I/O Interface"
> and "Table 30-1. PRU-ICSS1 I/O Signals"

Well these are external signals for PRUSS processor (although not
necessarily external signals for the SoC). So why not handle them
with a standard pinctlr binding with #pinctrl-cells?

Sure it may not even be the Linux pinctrl framework running on the
main SoC handling these pins, but after all you're describing
hardware for a processor. Maybe Linus W has some comments on this?

Regards,

Tony
