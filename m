Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCB7C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3169D21F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="llNnlCsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3169D21F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeHIU0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:26:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40430 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeHIU0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:26:20 -0400
Received: by mail-lf1-f65.google.com with SMTP id y200-v6so4733594lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGDOQR0HuHQd+TGE/hMSAAnB3N/WHLB2yfh1lRyhf9Y=;
        b=llNnlCsfIWxhkuDXEaDH9JZ+rTXAYiYHSfMvdyzNIt1ruGTnnriGV/JgUka4BSEc2k
         7T13yWk2gslL4JnG82Ue1ZRNaJ3g7184RgDCTe8bGIumgs5Aefn2bwCiiLiXj+4PIjA/
         nluuvxFzxqconwY2o/54E1jZ/GmxrLeHLG6D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGDOQR0HuHQd+TGE/hMSAAnB3N/WHLB2yfh1lRyhf9Y=;
        b=riqN1f3zHIaFa1pRw6AxHT5sfgicITFMbh6aITdR7/PaPBNvCEB/yQjteUF0RvLY4d
         D88d9G6xa4HB+CopbbegPlhlcOlKdKrw/ZygV8iCMHHKpVi+/eOflbF0qb3nHbMhai8l
         y8CwfecG3qi03vU6vMy0blaAe82139pOhc2sCpUUJU9brIte2RfeDswGGGipW6XWYF9W
         b6hgQp1MRK+lvd2toQ1al1OJYnvGrMw/ztu8g7IXDkJZIYcbcNMKmpGQ5P3/bPz40xhi
         LgFiKJ1foM7JG8gfk9VRb89daqe49CVX1arbt65N0VGGTfetvvkfja6/7PAJGcIZuoXH
         TDiQ==
X-Gm-Message-State: AOUpUlF4z4KKQHZ5aQOHerJU0Ky7eksWfj7sn6VmPQo6M4o1HxFJZLaU
        8ZCR9UUGzoOOeLDB9fiC4kDRhR2BK84=
X-Google-Smtp-Source: AA+uWPyRS/6Q6Egd0wDTRmSBU24HnDVohhqzEHSF2nURuSuJ8tG+0Td6kXGmsLcI5L53Hj6HL6i6og==
X-Received: by 2002:ac2:4117:: with SMTP id b23-v6mr2353912lfi.84.1533837620713;
        Thu, 09 Aug 2018 11:00:20 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id g12-v6sm1256507ljf.5.2018.08.09.11.00.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:00:19 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id v9-v6so5173089ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 11:00:19 -0700 (PDT)
X-Received: by 2002:a2e:1207:: with SMTP id t7-v6mr2312348lje.129.1533837619020;
 Thu, 09 Aug 2018 11:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180731100914.19856-1-cang@codeaurora.org> <20180731100914.19856-4-cang@codeaurora.org>
 <CAE=gft6cdE+oMYf779VGrQHfYQ5Xb1v+Qr6cAznTtAovehCOxw@mail.gmail.com> <c5ccbdac-8816-2a64-eb29-23e506b5cf7c@codeaurora.org>
In-Reply-To: <c5ccbdac-8816-2a64-eb29-23e506b5cf7c@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 9 Aug 2018 10:59:42 -0700
X-Gmail-Original-Message-ID: <CAE=gft6pFN91Y317-9S-3+DMgt6rMeGU_8ynrziGN=WaNVu5_Q@mail.gmail.com>
Message-ID: <CAE=gft6pFN91Y317-9S-3+DMgt6rMeGU_8ynrziGN=WaNVu5_Q@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] phy: Add QMP phy based UFS phy support for sdm845
To:     vivek.gautam@codeaurora.org
Cc:     cang@codeaurora.org, subhashj@codeaurora.org,
        asutoshd@codeaurora.org, Manu Gautam <mgautam@codeaurora.org>,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 10:26 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Hi Evan,
>
>
> On 8/9/2018 3:25 AM, Evan Green wrote:
> > On Tue, Jul 31, 2018 at 3:09 AM Can Guo <cang@codeaurora.org> wrote:
> >> Add UFS PHY support to make SDM845 UFS work with common PHY framework.
> >>
> >> Signed-off-by: Can Guo <cang@codeaurora.org>
> >> ---
> >>   drivers/phy/qualcomm/phy-qcom-qmp.c | 172 +++++++++++++++++++++++++++++++++++-
> >>   drivers/phy/qualcomm/phy-qcom-qmp.h |  15 ++++
> >>   2 files changed, 186 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> >> index 9be9754..de7ff18 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> > ...
> >>   static void qcom_qmp_phy_configure(void __iomem *base,
> >>                                     const unsigned int *regs,
> >>                                     const struct qmp_phy_init_tbl tbl[],
> >> @@ -1131,6 +1249,14 @@ static int qcom_qmp_phy_init(struct phy *phy)
> >>          qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
> >>
> >>          /*
> >> +        * UFS PHY requires the deassert of software reset before serdes start.
> >> +        * For UFS PHYs that do not have software reset control bits, defer
> >> +        * starting serdes until the power on callback.
> >> +        */
> > I'm relatively thick when it comes to PHYs, but I'm a little confused.
> > The sequence of code right below this (not shown) looks like it is
> > deasserting reset before starting serdes, seemingly doing what the
> > comment wants. I guess the problem is the lack of SW reset? So then
> > you defer serdes start until UFS does... something. Can you explain
> > how deferring to after UFS HC init actually helps? Is it the UFS HC
> > that releases reset on the PHY?
>
> As you can see in [1], the ufs first asserts the sw_reset, then phy
> initialization is done.
> This phy_init() is just programming the phy registers. Now as per the H/W
> programming doc, we can't start the phy until we de-assert the sw_reset.
> So the sequence as per the programming doc should be:
>
> assert SW_reset --> program phy serdes/tx/rx/pcs registers --> deassert
> SW_reset --> start serdes --> test PCS status
>
> That's the reason that serdes_start has been moved to phy_power_on(), as
> that seemed
> a more cleaner way of handling the above sequence.
> UFS HC init doesn't help more than this in terms of phy initialization.

Ok that makes sense. Thank you for the explanation.

>
> >
> > I was hoping the next patch would help, but I'm still confused. It
> > looks like you've added a call to phy_power_on in
> > ufs_qcom_setup_clocks, but there's also one still in
> > ufs_qcom_power_up_sequence. What does the original phy_power_on in
> > ufs_qcom_power_up_sequence do now? It seems like that one would do the
> > power on too early, and then your new added call in
> > ufs_qcom_setup_clocks would do nothing.
>
> I think [patch 4/5] of this series handles this. We skip the
> phy_power_on until
> we do phy_init.
> phy_power_on/off() in setup_clocks() is also used for suspend/resume case
> and that's the reason you see couple of phy_power_on(). Patch 4/5 should
> handle
> this now.

Ok got it. I was confused about the ordering. setup_clocks is actually
called first (via __ufshcd_setup_clocks > ufshcd_hba_init >
ufshcd_init), which is why you need the boolean to defer this power on
until later.

Reviewed-by: Evan Green <evgreen@chromium.org>
