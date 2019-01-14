Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1BBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F693206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547484428;
	bh=D2MNF+Kq2lSmR31nGOTN9/JLfwQzExxBYfVq8a9D794=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=wWKZi2rJVqYiaC6EIwWGHr1shuTZ9CHHm8ZD+1rOSl3err5peVvL9mlVQZskhF5N5
	 q2mhK4f7+/Gm7wyYEWUzzL9P/35yJbBf50UkB3YFcuRg12OMn4FVrjoUsFbXyO7b8x
	 3SShw8xMBs132qFyUSX3R/iTLPlrl+I7/1AqgOPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfANQrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:47:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfANQrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:47:04 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 883A0206B7;
        Mon, 14 Jan 2019 16:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547484423;
        bh=D2MNF+Kq2lSmR31nGOTN9/JLfwQzExxBYfVq8a9D794=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=w99w+y1CWUP2LYdA5FqWVqsYD32L4wFxdkkksBw+GkI34d9i4U+u8H5xIbWSjVRoq
         BV19sKtHhoNlUAiZTsFsgUwBVFh60Fm1ot1SseZWvhGSz6RoscR6ZmpJlZl4TKHVGG
         YUs56IUvbO4sBX1VtzIA43P8L8dvZuMIYlCuZ+IY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] clk: qcom: clk-rpmh: Add IPA clock support
User-Agent: alot/0.8
In-Reply-To: <11f948dc-3045-762f-b6bf-63c32d51772a@codeaurora.org>
References: <1544754904-18951-1-git-send-email-daidavid1@codeaurora.org> <154706211110.15366.8008755843113316822@swboyd.mtv.corp.google.com> <11f948dc-3045-762f-b6bf-63c32d51772a@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, tdas@codeaurora.org, elder@linaro.org
To:     David Dai <daidavid1@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <154748442276.169631.994019688641603420@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 14 Jan 2019 08:47:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Dai (2019-01-11 16:56:14)
>=20
> On 1/9/2019 11:28 AM, Stephen Boyd wrote:
> > Quoting David Dai (2018-12-13 18:35:04)
> >> +
> >> +#define BCM_TCS_CMD(valid, vote)                               \
> >> +       (BCM_TCS_CMD_COMMIT_MASK |                              \
> >> +       ((valid) << BCM_TCS_CMD_VALID_SHIFT) |                  \
> >> +       ((cpu_to_le32(vote) &                                   \
> > Why?
> Sorry, could you clarify this question? If you're referring to the=20
> cpu_to_le32, shouldn't we be explicit about converting endianness even=20
> if it might be redundant for this particular qcom platform?

Is only the vote part of the message in little endian format and the
rest is native CPU endianess? It's very odd to see that jammed in the
middle of a bit packing statement like that. Typically the whole u32
would be in one or the other endianness. Also, sparse right complains
about this macro and it's usage, so something is wrong.

I think one other problem is that rpmh API doesn't really talk about
endianness here and that's busted. So if you want to fix endianness
issues that needs to be fixed first.

> >> @@ -29,6 +54,7 @@
> >>    * @aggr_state:                rpmh clock aggregated state
> >>    * @last_sent_aggr_state: rpmh clock last aggr state sent to RPMh
> >>    * @valid_state_mask:  mask to determine the state of the rpmh clock
> >> + * @aux_data:          data specific to the bcm rpmh resource
> > But there isn't aux_data. Is this supposed to be unit? And what is unit
> > going to be? 1000?
> Supposed to be unit, the value is on the order of Khz.

Ok, hopefully the kernel-doc comes out easy to understand.

> >> @@ -217,6 +340,7 @@ static unsigned long clk_rpmh_recalc_rate(struct c=
lk_hw *hw,
> >>   DEFINE_CLK_RPMH_VRM(sdm845, rf_clk1, rf_clk1_ao, "rfclka1", 1);
> >>   DEFINE_CLK_RPMH_VRM(sdm845, rf_clk2, rf_clk2_ao, "rfclka2", 1);
> >>   DEFINE_CLK_RPMH_VRM(sdm845, rf_clk3, rf_clk3_ao, "rfclka3", 1);
> >> +DEFINE_CLK_RPMH_BCM(sdm845, ipa, "IP0");
> > It's really IP0?! What was wrong with IPA?
> Yeah... convention seems to be 2 letters and then a number for most BCM=20
> resources.

OK.

