Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F508C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F6520827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3g8wWpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F6520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbeKEPwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:52:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbeKEPwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:52:42 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C9AC20827;
        Mon,  5 Nov 2018 06:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541399676;
        bh=p7+cN13OraCfdQrQUt7TparT2ome498FdSCc0ue+C9Y=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=J3g8wWpWmLcn85b60bVCMqJtlKBEDddTo/TgW2sBjqWCwcMg2sRn5W30pePw62b5B
         GiYYz0BtbnjkOvUUI7tXJewFdm77vVWmEasQ7GWuwsaga6rm6T+bb4goRHh99TEKmP
         CfpKyrnso8q57C8q/uAF3kH5f6NmoC4uE0z8LQZo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1534141987-29601-2-git-send-email-anischal@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>
References: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
 <1534141987-29601-2-git-send-email-anischal@codeaurora.org>
Message-ID: <154139967580.88331.12189885863422622526@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/4] clk: qcom: gdsc: Add support to enable/disable the clocks
 with GDSC
Date:   Sun, 04 Nov 2018 22:34:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-08-12 23:33:04)
> For some of the GDSCs, there is a requirement to enable/disable the
> few clocks before turning on/off the gdsc power domain. Add support
> for the same by specifying a list of clk_hw pointers per gdsc and
> enable/disable them along with power domain on/off callbacks.
> =

> Signed-off-by: Amit Nischal <anischal@codeaurora.org>

In v1 of this patch series I asked for much more information in this
commit text. Please add it here. I won't apply this patch until the
justification is put into this commit text.

> ---
>  drivers/clk/qcom/gdsc.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/gdsc.h |  5 +++++
>  2 files changed, 49 insertions(+)
> =

> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index a077133..b6adca1 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -12,6 +12,8 @@
>   */
>  =

>  #include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>

This makes me unhappy. It's almost always a problem when we see clk.h
and clk-provider.h included in the same file, so if gdsc has to call clk
APIs to operate correctly, then we should do that by having the gdsc
code get clks properly instead of directly reaching into the clk_hw
structure to get a clk pointer. This means we should have the gdsc code
ask the clk framework to convert a clk_hw pointer into a clk pointer
because of how so intimately connected the gdsc is to clks on this SoC.
But given all that, I'm still trying to understand why we need to do
this within the gdsc code.

Adding these clk calls to the gdsc seems like we're attaching at the
wrong abstraction level. Especially if the reason we do it is to make it
easier for the GPU driver to handle dependencies. I hope that's not the
case. Either way, it would make more sense to me if we made genpds for
the clks and genpds for the gdscs and then associated the clk genpds
with the gdsc genpds so that when a gdsc is enabled the clk domain that
it depends on is enabled first. Then we have a generic solution for
connecting clks to gdscs that doesn't require us to add more logic to
the gdsc driver and avoids having clk providers do clk consumer things.
Instead, it's all handled outside of this driver by specifying a domain
dependency. It may turn out that such a solution would still need a way
to make clk domains in the clk driver, and it will probably need to do
that by converting clk_hw structures into clk pointers, but it would be
good to do that anyway.

So in summary, I believe we should end up at a point where we have clk
domains and power domains (gdscs) all supported with genpds, and then we
can connect them together however they're connected by linking the
genpds to each other. Device drivers wouldn't really need to care how
they're connected, as long as those genpds are attached to their device
then the driver would be able to enable/disable them through runtime PM.
But I can see how this may be hard to do for this patch series, so in
the spirit of progress and getting things done, it would be OK with me
if the gdsc code called some new clk API to convert a clk_hw pointer
into a clk pointer and then did the same enable/disable things it's
doing in this patch. This whole patch would need to be completely
untangled and ripped out later when we have clk domains but at least we
could get something working now while we work on making clk domains and
plumbing them into genpds and runtime PM.

