Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635FBC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC9721470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRhvvDPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC9721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeJMBJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeJMBJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:09:19 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD07E21470;
        Fri, 12 Oct 2018 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539365744;
        bh=Rgt1QL6cPUerUj+FNhXWL/Yz8dn6bcl8zgyM915Sbnw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ZRhvvDPnAvqj0e+JSfSGZT6Hyxc/vr+XnqjED0B9lf7jZpUvA9nUqXM04O5SBl21W
         HfvPGgJVbQvUBcZMxyvuoTnVUhcaopPy0asSWGknSe4ZQY4bUNdzBdibQXsOQ6DK5d
         umF1vqLfG7UojurDT2PbLabSiEiauJgfhtWkVQCw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <7d4012b9-e71d-f114-b228-7198f07ea767@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1538654546-31204-1-git-send-email-tdas@codeaurora.org>
 <1538654546-31204-2-git-send-email-tdas@codeaurora.org>
 <153896666821.119890.13143150697797456341@swboyd.mtv.corp.google.com>
 <ba0d7d92-5ad9-2dcf-c5a5-21332df193f0@codeaurora.org>
 <153911832719.119890.11984877060665330428@swboyd.mtv.corp.google.com>
 <7d4012b9-e71d-f114-b228-7198f07ea767@codeaurora.org>
Message-ID: <153936574404.5275.10513827793530511886@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6] clk: qcom: Add lpass clock controller driver for SDM845
Date:   Fri, 12 Oct 2018 10:35:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-10-09 23:12:27)
> =

> =

> On 10/10/2018 2:22 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-10-09 10:26:38)
> >> Hello Stephen,
> >>
> >> On 10/8/2018 8:14 AM, Stephen Boyd wrote:
> >>> Quoting Taniya Das (2018-10-04 05:02:26)
> >>>> Add support for the lpass clock controller found on SDM845 based dev=
ices.
> >>>> This would allow lpass peripheral loader drivers to control the cloc=
ks to
> >>>> bring the subsystem out of reset.
> >>>> LPASS clocks present on the global clock controller would be registe=
red
> >>>> with the clock framework based on the device tree flag. Also do not =
gate
> >>>> these clocks if they are left unused.
> >>>
> >>> Why not gate them? This statement states what the code is doing, not =
why
> >>> it's doing it which is the more crucial information that should be
> >>> described in the commit text. Also, please add a comment about it to =
the
> >>> code next to the flag.
> >>>
> >>> I am concerned that it doesn't make any sense though, so probably it
> >>> shouldn't be marked as CLK_IGNORE_UNUSED and it's papering over some
> >>> other larger bug that needs to be fixed.
> >>>
> >>
> >> It does not have any bug, it is just that to access these lpass
> >> registers we would need the GCC lpass registers to be enabled. I would
> >> update the same in the commit text.
> >>
> >> During clock late_init these clocks should not be accessed to check the
> >> clock status as they would result in unclocked access. The client would
> >> request these clocks in the correct order and it would not have any is=
sue.
> >>
> > =

> > That seems like the bug right there. If the LPASS registers can't be
> > accessed unless the clks in GCC are enabled then this driver needs to
> > turn the clks on before reading/writing registers. Marking the clks as
> > ignore unused is skipping around the real problem.
> > =

> =

> If the driver requests for the clocks they would maintain the order. But =

> if the clock late init call is invoked before the driver requests, there =

> is no way I could manage this dependency, that is the only reason to =

> mark them unused.
> =


Which driver are we talking about here? The lpass clk driver? Presumably
the lpass clk driver would request the GCC clks and turn them on in
probe and then register any lpass clks. If the lpass clk driver probes
bfeore late init, then the gcc clks will be enabled and everything
works, and if the lpass clk driver probes after late init then the clks
that can't be touched without gcc clks enabled won't be registered, and
then they won't be touched. What goes wrong?


