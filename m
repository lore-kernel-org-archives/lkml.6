Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A439C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3990220863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd0c0fMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3990220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933326AbeGIPGK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932994AbeGIPGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:06:07 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF3D208A2;
        Mon,  9 Jul 2018 15:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531148766;
        bh=p5dKY2BpCtaX5cMv5r/3x5jzFXmjZkcsQaewStNujwM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=bd0c0fMo0Ds/z03MhGaUEfRB5j5XCRTzLxfK1B2nC72fK8Ghp0TKh6aLcSc2RJUyB
         I2Yt18+ZJZujeznng00riXLjk3djPKdnpjlDP8f5d2hVPBEpPal8JtWd6eFWuUtG1b
         KhF9g5EBozV4lzr6/QQ+b9iHR9N6FPaZfbbAE8nQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <288770be-a763-b287-f62a-72ab7616efdb@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1529763567-13131-1-git-send-email-tdas@codeaurora.org>
 <1529763567-13131-4-git-send-email-tdas@codeaurora.org>
 <153109408562.143105.15954380130353645468@swboyd.mtv.corp.google.com>
 <10f87216-caa2-d523-e134-6cf3acd268a7@codeaurora.org>
 <153111701079.143105.13387458941681113476@swboyd.mtv.corp.google.com>
 <436cc6a3-7406-c695-7879-3b9d042262cc@codeaurora.org>
 <153112184177.143105.15452587215679149679@swboyd.mtv.corp.google.com>
 <288770be-a763-b287-f62a-72ab7616efdb@codeaurora.org>
Message-ID: <153114876561.143105.465317097490450694@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/3] clk: qcom: Add display clock controller driver for SDM845
Date:   Mon, 09 Jul 2018 08:06:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-07-09 02:34:07)
> =

> =

> On 7/9/2018 1:07 PM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-07-09 00:07:21)
> >>
> >>
> >> On 7/9/2018 11:46 AM, Stephen Boyd wrote:
> >>>>
> >>>>    > Why is the nocache flag needed? Applies to all clks in this fil=
e.
> >>>>    >
> >>>>
> >>>> This flag is required for all RCGs whose PLLs are controlled outside=
 the
> >>>> clock controller. The display code would require the recalculated ra=
te
> >>>> always.
> >>>
> >>> Right. Why is the PLL controlled outside of the clock controller? The
> >>> rate should propagate upward to the PLL from here, so who's going
> >>> outside of that?
> >>>
> >> The DSI0/1 PLL are not part of the display clock controller, but in the
> >> display subsystem which are managed by the DRM drivers. When DRM drive=
rs
> >> query for the rate clock driver should always return the non cached ra=
tes.
> > =

> > Why? Is the DSI PLL changing rate all the time, randomly, without going
> > through the clk APIs to do so?
> >
> =

> Hmm, I am afraid I do not have an answer for this, but this was the =

> requirement to always return the non cached rates from the clock driver.
> =


Ok. Who knows about this requirement? Can we add someone from the
display driver to understand more?

