Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E753C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A4C215A5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vittXXwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A4C215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeHCAhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbeHCAhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:37:45 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4382F215A5;
        Thu,  2 Aug 2018 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533249870;
        bh=PzGaF0YFoImv8SQE7Xc6qpS0qjlTx5HAoPX/TTNWi0M=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=vittXXwAQg6yrsACLbSr+I1lUPAB1B3D/g+VKYbryukdpr+EZZa+Lxniz4GqWVuaH
         ZYGJhA4ddZ8S+9AR9g3YFEn2GxWb9RIixNH3ZOiI5Ca57KAnWWsr0f+kCWdvQuZO8E
         WCS17jXDwlFinvvd6qJiMU7ojER0ux52RU2qHqNw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <07e0321116993d27d6585bd1a186328d@codeaurora.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk-owner@vger.kernel.org
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
 <1528285308-25477-3-git-send-email-anischal@codeaurora.org>
 <153111693472.143105.11303543263643845656@swboyd.mtv.corp.google.com>
 <1e6d9fc284c3c118203728867f504ec6@codeaurora.org>
 <153250192252.48062.9210075387954345932@swboyd.mtv.corp.google.com>
 <07e0321116993d27d6585bd1a186328d@codeaurora.org>
Message-ID: <153324986956.10763.5124619734269160725@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/4] clk: qcom: Add clk_rcg2_gfx3d_ops for SDM845
Date:   Thu, 02 Aug 2018 15:44:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-07-30 04:28:56)
> On 2018-07-25 12:28, Stephen Boyd wrote:
> > =

> > Ok. Sounds good! Is the rate range call really needed? It can't be
> > determined in the PLL code with some table or avoided by making sure =

> > GPU
> > uses OPP table with only approved frequencies?
> > =

> =

> Currently fabia PLL code does not have any table to check this and =

> intention
> was to avoid relying on the client to call set_rate with only approved
> frequencies so we have added the set_rate_range() call in the GPUCC =

> driver
> in order to set the rate range.
> =


But GPU will use OPP so it doesn't seem like it really buys us anything
here. And it really doesn't matter when the clk driver implementation
doesn't use the min/max to clamp the values of the round_rate() call. Is
that being done here? I need to double check. I would be more convinced
if the implementation was looking at min/max to constrain the rate
requested.

