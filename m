Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94889C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62395214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfAHPil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:38:41 -0500
Received: from muru.com ([72.249.23.125]:60692 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728403AbfAHPil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:38:41 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D2E648080;
        Tue,  8 Jan 2019 15:38:46 +0000 (UTC)
Date:   Tue, 8 Jan 2019 07:38:37 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     JeffyChen <jeffy.chen@rock-chips.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] mfd: syscon: Fix syscon name for device tree
Message-ID: <20190108153837.GK5544@atomide.com>
References: <20190108000558.54914-1-tony@atomide.com>
 <20190108001543.GJ5544@atomide.com>
 <5C34162B.200@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C34162B.200@rock-chips.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* JeffyChen <jeffy.chen@rock-chips.com> [190108 03:17]:
> Hi Tony,
> 
> On 01/08/2019 08:15 AM, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [190108 00:06]:
> > > I'm now seeing the following error on omap5 during boot:
> > > 
> > > (NULL device *): Failed to create dummy-scm_conf@0 debugfs directory
> This log means failed to init regmap debugfs with device(NULL) and
> name("scm_conf@0"), which likely to be called from of_syscon_register() with
> np fullname("scm_conf@0").
> 
> So my guess would be there're more than one syscon dts nodes named
> "scm_conf@0".

Yup.

> For omap5 and scm_conf@0, should be these 2:
> https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/omap5.dtsi#L167
> 				scm_conf: scm_conf@0 {
> 					compatible = "syscon";
> 
> https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/omap5.dtsi#L313
> 				scm_wkup_pad_conf: scm_conf@0 {
> 					compatible = "syscon", "simple-bus";

Yes those are the one.

> Maybe try to rename one of them(for example, rename the second one to
> "scm_wkup_pad_conf@0").

Well the thing is that any valid node name should work here
just like it does for devices. In this case the syscon
instances are on separate inteconnect instances. So it seems
that we should do something similar to what we already do in
of_device_make_bus_id().

BTW, I was trying to patch the wrong function :) The right
function to fix is of_syscon_register() for the dts case.

Regards,

Tony

