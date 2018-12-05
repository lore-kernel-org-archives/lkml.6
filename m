Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9F8C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FB320851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZsfnPMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FB320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeLEHPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:15:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbeLEHPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:15:51 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61D0A206B7;
        Wed,  5 Dec 2018 07:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543994149;
        bh=QA2f4A6WaubtcLivsxrypjR7/T1YXiEXXTZDJwOlun0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=VZsfnPMJwL4ZldvpMVkT3ooBr17j75HxVOr+fTtPljxBhmppTfwr2qlAST8zaydSu
         BJh7CWfpWX4TftwiPIWBOzDUVz9a66RL0A6uSLi/SMtRxbmxe2zEtmakRk2Zy3QDjo
         zFB/CtDzOsUhqpSMY9U4VzMnLxFp9bhzKzH8UN/4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alex Elder <elder@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <edeebce5-24a2-b844-6bff-781017949e2d@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, tdas@codeaurora.org
References: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
 <1543895413-1553-2-git-send-email-daidavid1@codeaurora.org>
 <154395145491.88331.1174781210192403998@swboyd.mtv.corp.google.com>
 <8dafe631-4b16-94cd-392e-84728f2bb382@linaro.org>
 <154396284056.88331.12279283832884556349@swboyd.mtv.corp.google.com>
 <edeebce5-24a2-b844-6bff-781017949e2d@codeaurora.org>
Message-ID: <154399414865.88331.2447825064224349951@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC PATCH] clk: qcom: clk-rpmh: Add IPA clock support
Date:   Tue, 04 Dec 2018 23:15:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Dai (2018-12-04 17:14:10)
> =

> On 12/4/2018 2:34 PM, Stephen Boyd wrote:
> > Quoting Alex Elder (2018-12-04 13:41:47)
> >> On 12/4/18 1:24 PM, Stephen Boyd wrote:
> >>> Quoting David Dai (2018-12-03 19:50:13)
> >>>> Add IPA clock support by extending the current clk rpmh driver to su=
pport
> >>>> clocks that are managed by a different type of RPMh resource known as
> >>>> Bus Clock Manager(BCM).
> >>> Yes, but why? Does the IPA driver need to set clk rates and that some=
how
> >>> doesn't work as a bandwidth request?
> >> The IPA core clock is a *clock*, not a bus.  Representing it as if
> >> it were a bus, abusing the interconnect interface--pretending a bandwi=
dth
> >> request is really a clock rate request--is kind of kludgy.  I think Bj=
orn
> >> and David (and maybe Georgi? I don't know) decided a long time ago that
> >> exposing this as a clock is the right way to do it.  I agree with that.
> >>
> > But then we translate that clock rate into a bandwidth request to the
> > BCM hardware? Seems really weird because it's doing the opposite of what
> > you say is abusive. What does the IPA driver plan to do with this clk?
> > Calculate a frequency by knowing that it really boils down to some
> > bandwidth that then gets converted back into some clock frequency? Do we
> > have the user somewhere that can be pointed to?
> The clock rate is translated into a unitless threshold value sent as =

> part of the rpmh msg
> that BCM takes to select a performance. In this case, the unit =

> conversion is based on
> the unit value read from the aux data which is in Khz. I understand that =

> this wasn't
> explicitly mentioned anywhere and I'll improve on that next patch. =


How is this different from bus bandwidth requests? In those cases the
bandwidth is calculated in bits per second or something like that, and
written to the hardware so it can convert that bandwidth into kHz and
set a bus clk frequency in the clock controller? So in the IPA case
we've skipped the bps to kHz conversion step and gone straight to the
clk frequency setting part? Is a BCM able to aggregate units of
bandwidth or kHz depending on how it's configured and this BCM is
configured for kHz?

> Here's a link to
> the IPA driver implementation: https://lkml.org/lkml/2018/11/7/220

Thanks for the link. It looks like the IPA driver hard codes a rate of
75 MHz.

