Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9879BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615892086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615892086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeLKJtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:49:17 -0500
Received: from foss.arm.com ([217.140.101.70]:42742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKJtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:49:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A292615AD;
        Tue, 11 Dec 2018 01:49:16 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D28C3F614;
        Tue, 11 Dec 2018 01:49:15 -0800 (PST)
Date:   Tue, 11 Dec 2018 09:49:10 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PM / OPP: Always expose one supply in debugfs
Message-ID: <20181211094908.2dzmmzu6aq6cs4yn@queper01-lin>
References: <20181210113247.11412-1-quentin.perret@arm.com>
 <20181210115410.clyrxhp5plptrf5n@queper01-lin>
 <20181211092549.2ydogec7bnlfokwy@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211092549.2ydogec7bnlfokwy@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 Dec 2018 at 14:55:49 (+0530), Viresh Kumar wrote:
> On 10-12-18, 11:54, Quentin Perret wrote:
> > On Monday 10 Dec 2018 at 11:32:47 (+0000), Quentin Perret wrote:
> > > On some platforms, the opp_table->regulator_count field is kept at zero
> > > even though opp->supplies is always allocated. However, the loop used to
> > > display the supplies in the debugfs doesn't deal correctly with this,
> > > which results in the supplies not being displayed in debugfs on those
> > > platforms.
> > > 
> > > Fix this by making sure to always display at least once supply in
> > > debugfs.
> > > 
> > > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > > 
> > > ---
> > > 
> > > This has been observed on Juno r2 which uses SCPI and Hikey960 which
> > > uses DT. I am not particularly familiar with that part of the code, so
> > > I'm not sure if this is even remotely correct (hence the RFC tag).
> > > 
> > > I first thought setting opp_table->regulator_count to 1 would be the
> > > right fix but that causes other issues. This fix seems to work OK on
> > > Juno and Hikey960, at least.
> > > 
> > > Feedback is welcome :-)
> > 
> > Hmm, so I just figured what I'm doing here is basically reverting:
> > 
> >     1fae788ed640 ("PM / OPP: Don't create debugfs "supply-0" directory unnecessarily")
> > 
> > Should I send a proper revert instead of this patch ? It _is_ handy to
> > read voltage numbers when available.
> 
> First of all I am really happy that someone apart from me is using this debug
> interface :)

:-)

My current use case is to compute the 'dynamic-power-coefficient' thing
for IPA. With P=CV^2f, I can measure P and get f easily, but V is a bit
trickier (as of now at least). PM_OPP has the information I need, so it'd
be handy to expose it somewhere.

> At least that patch was correct and if we have to fix something, it should be
> fixed somewhere else.

Understood.

> I tried to reproduce the issue on hikey and straight away understood why it is
> behaving that way. There is no "cpu-supply" property defined for the CPUs.

Ah, right. The opp-microvolt binding is specified however, so I guess we
could expose that too ...

> I looked at juno driver and couldn't see any references to voltage there. Are
> you trying to add that support ?

So, on Juno we do get voltage numbers from firmware, and those get
registered properly in PM_OPP, exactly like for Hikey960. So it's
probably the same problem in both cases.

FWIW, this is what I get on juno with my 'fix' applied:

  $ cat /sys/kernel/debug/opp/cpu0/*/supply-0/u_volt_target
  820000
  850000
  900000
  950000
  1000000

> Anyway, this should still be fixed irrespective of the "cpu-supply" property.
> The other fix you mentioned about setting opp_table->regulator_count to 1 is
> actually the right thing to do but the fix may require changes at multiple
> places. I can help writing a patch for that if you want, else I am open to you
> giving it a shot :)

You'll definitely know the code better than me so if you have a patch in
mind, please don't hesitate. I'll be happy to test it on my two boards
here :-)

Thanks,
Quentin
