Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E5EC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2832098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb/SAAa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2832098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJSE15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725735AbeJSE14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:27:56 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61C932098A;
        Thu, 18 Oct 2018 20:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539894315;
        bh=xD9/OKztBpup7K3Sv7G2qaI36/DmGd3KCJP4VqHdJLU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Nb/SAAa2yHFLAv0ahcKBH7lXb9mGEYMuTrIReS75Nd0cQmxpOwbyrc+f2eMGJEJrJ
         nghFyDIxxPYd6nHeAXagT/gVqnPxpQXRMWsl9HIRRWGqA+rU/5qL466V53LTjp/oSf
         N7vwqMmZ1oso2NtGwIZc3ZnsXo+gYxYrDPoLnJQc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        atull@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAPybu_2MyMyM9PXANowPkZ2LjnCUarNJmyHR+-bAowPNxVUThw@mail.gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        frowand.list@gmail.com
References: <1467735814-23518-1-git-send-email-ricardo.ribalda@gmail.com>
 <1467735814-23518-11-git-send-email-ricardo.ribalda@gmail.com>
 <CANk1AXRvJQtcmAysrkfAGurGUGVHSq55=8PZARGYsEZNv2zt0g@mail.gmail.com>
 <CAPybu_2MyMyM9PXANowPkZ2LjnCUarNJmyHR+-bAowPNxVUThw@mail.gmail.com>
Message-ID: <153989431481.53599.12103308080212712307@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 8/8] clk: fixed-rate: Convert into a module platform driver
Date:   Thu, 18 Oct 2018 13:25:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ricardo Ribalda Delgado (2018-10-18 13:02:01)
> Hi Alan
> =

> =

> On Thu, Oct 18, 2018 at 9:21 PM Alan Tull <atull@kernel.org> wrote:
> >
> > On Tue, Jul 5, 2016 at 11:45 AM Ricardo Ribalda Delgado
> > <ricardo.ribalda@gmail.com> wrote:
> >
> > I've stumbled across a of_node_get/put imbalance that happens when the
> > fixed rate clock is added and deleted using device tree.  The cause is
> > that this driver calls of_clk_add_provider() when probed, but doesn't
> > call of_clk_del_provider() when removed.
> >
> > It looks like a lot of clock drivers share that issue:
> >
> > $ cd drivers/clk/
> > $ git grep -l of_clk_add_provider * | xargs grep -L of_clk_del_provider=
 | wc -l
> > 131
> >
> > It should be a one line fix, but for many files.
> >
> > I'm not a clock subsystem expert, so please let me know whether I'm
> > missing something here.
> =

> Not an expert either, but I believe that the affected drivers are much
> less. We have to consider only the drivers that can be removed
> =

> git grep -l  of_clk_add_provider  | xargs grep -l platform_driver |
> xargs grep -l  remove | xargs grep -L of_clk_del_provider
> drivers/clk/clk-fixed-factor.c
> drivers/clk/clk-fixed-rate.c
> drivers/clk/davinci/psc.c
> drivers/clk/ti/adpll.c
> drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
> =

> =

> Also there is something else that I do not undersand:
> of_clk_add_hw_provider() is the same as of_clk_add_provider() ?

The difference is the hw provider API deals with struct clk_hw and the
other API deals with struct clk pointers. The preference is to use the
clk_hw based APIs.

