Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCB2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE5F223CB
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE5F223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389206AbeKPQ7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:59:05 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58303 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeKPQ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:59:05 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gNXuv-0004Qm-Bx; Fri, 16 Nov 2018 07:47:49 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gNXuu-00030N-El; Fri, 16 Nov 2018 07:47:48 +0100
Date:   Fri, 16 Nov 2018 07:47:48 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        Weijie Gao <weijie.gao@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>
Subject: Re: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
Message-ID: <20181116064748.6c7shn3am4wejrnj@pengutronix.de>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
 <20181114124752.GI2620@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181114124752.GI2620@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 01:47:52PM +0100, Thierry Reding wrote:
> On Tue, Nov 13, 2018 at 10:08:22AM +0800, Ryder Lee wrote:
> > The flag 'has_clks' and related checks are superfluous as the CCF
> > subsystem does this for you.
> 
> Both of these mechanisms aren't equivalent. While CCF can deal with
> optional clocks, what the has_clks flag actually means is that the
> device doesn't need a clock (or doesn't have a clock input) on the
> devices where it is cleared.
> 
> So I'd actually be in favor of keeping the has_clks property because it
> serves as an additional sanity check. For example if you run this driver
> on an SoC that "has clocks" but if you don't list them in DT, then after
> this patch the driver will happily continue without clocks, even though
> it may break completely without those clocks. I've seen SoCs respond to
> disabled clocks for a hardware block in different ways, in many cases an
> access to any of the registers will completely hang the CPU. In other
> cases it may just crash in some other way or give you some sort of
> machine exception. None of those are good, and make the tiny bit of
> additional code required to support the has_clks flag very attractive.
> 
> But that's just my opinion. If you prefer to throw away that safety
> barrier, be my guest. But if you do, please move this functionality into
> the clock framework first and then make the driver use it.

The usual policy is: If the things specified in the dt are
wrong or incomplete, it's ok to fail however you like. So from a
correctness POV I think the change is fine.

I don't know about the mips details that John pointed out in a followup
to this mail though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
