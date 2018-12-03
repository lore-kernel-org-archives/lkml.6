Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1C3C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D6A208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px80hsID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D6A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeLCRwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:52:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeLCRwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:52:40 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED6F220848;
        Mon,  3 Dec 2018 17:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543859556;
        bh=+gjCBg6qCkIqS/5+hzcmL0FLKRJl2ioFwUBH6WbHMSY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Px80hsIDCole+ek1tecEd1/5Ty32EPG7XAUkkRRSqLNWn3H7Hz0qltVWfGIMCVfpB
         fYSmh52/zBVf2AcQfQ7pgKw3RzFz+deggsLxrXxcZ2je0k174lC0q9FuMn0IMiwpQd
         l2T5VTktzi/93rBbtz4FWNgA31zk3bIhMfZSK6YA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <bf2c5a96-6a29-e89b-4b16-8aaab516a7b5@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543851298-32320-1-git-send-email-jhugo@codeaurora.org>
 <20181203155538.GQ2225@minitux>
 <711fb66a-a408-08e2-c0c2-6addf1510937@codeaurora.org>
 <154385654317.88331.9077579060059188717@swboyd.mtv.corp.google.com>
 <bf2c5a96-6a29-e89b-4b16-8aaab516a7b5@codeaurora.org>
Message-ID: <154385955525.88331.5713343841692637945@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: Fix MSM8998 resets
Date:   Mon, 03 Dec 2018 09:52:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2018-12-03 09:19:20)
> On 12/3/2018 10:02 AM, Stephen Boyd wrote:
> > Quoting Jeffrey Hugo (2018-12-03 08:08:46)
> >> On 12/3/2018 8:55 AM, Bjorn Andersson wrote:
> >>> On Mon 03 Dec 07:34 PST 2018, Jeffrey Hugo wrote:
> >>>
> >>>> The offsets for the defined BCR reset registers does not match the h=
ardware
> >>>> documentation.  Update the values to match the hardware documentatio=
n.
> >>>>
> >>>
> >>> Sorry for not spotting this before.
> >>>
> >>>> Fixes: b5f5f525c547 (clk: qcom: Add MSM8998 Global Clock Control (GC=
C) driver)
> >>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> >>>> ---
> >>>>    drivers/clk/qcom/gcc-msm8998.c | 38 +++++++++++++++++++----------=
---------
> >>>>    1 file changed, 19 insertions(+), 19 deletions(-)
> >>>>
> >>>> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-m=
sm8998.c
> >>>> index 9f0ae40..01cc555 100644
> >>>> --- a/drivers/clk/qcom/gcc-msm8998.c
> >>>> +++ b/drivers/clk/qcom/gcc-msm8998.c
> >>>> @@ -2742,25 +2742,25 @@ enum {
> >>>>    };
> >>>>    =

> >>>>    static const struct qcom_reset_map gcc_msm8998_resets[] =3D {
> >>>> -    [GCC_BLSP1_QUP1_BCR] =3D { 0x102400 },
> >>>> -    [GCC_BLSP1_QUP2_BCR] =3D { 0x110592 },
> >>>> -    [GCC_BLSP1_QUP3_BCR] =3D { 0x118784 },
> >>>> -    [GCC_BLSP1_QUP4_BCR] =3D { 0x126976 },
> >>>> -    [GCC_BLSP1_QUP5_BCR] =3D { 0x135168 },
> >>>> -    [GCC_BLSP1_QUP6_BCR] =3D { 0x143360 },
> >>>> -    [GCC_BLSP2_QUP1_BCR] =3D { 0x155648 },
> >>>> -    [GCC_BLSP2_QUP2_BCR] =3D { 0x163840 },
> >>>> -    [GCC_BLSP2_QUP3_BCR] =3D { 0x172032 },
> >>>> -    [GCC_BLSP2_QUP4_BCR] =3D { 0x180224 },
> >>>> -    [GCC_BLSP2_QUP5_BCR] =3D { 0x188416 },
> >>>> -    [GCC_BLSP2_QUP6_BCR] =3D { 0x196608 },
> >>>> -    [GCC_PCIE_0_BCR] =3D { 0x438272 },
> >>>> -    [GCC_PDM_BCR] =3D { 0x208896 },
> >>>> -    [GCC_SDCC2_BCR] =3D { 0x81920 },
> >>>> -    [GCC_SDCC4_BCR] =3D { 0x90112 },
> >>>> -    [GCC_TSIF_BCR] =3D { 0x221184 },
> >>>> -    [GCC_UFS_BCR] =3D { 0x479232 },
> >>>> -    [GCC_USB_30_BCR] =3D { 0x61440 },
> >>>> +    [GCC_BLSP1_QUP1_BCR] =3D { 0x19000 },
> >>>> +    [GCC_BLSP1_QUP2_BCR] =3D { 0x1b000 },
> >>>> +    [GCC_BLSP1_QUP3_BCR] =3D { 0x1d000 },
> >>>> +    [GCC_BLSP1_QUP4_BCR] =3D { 0x1f000 },
> >>>> +    [GCC_BLSP1_QUP5_BCR] =3D { 0x21000 },
> >>>> +    [GCC_BLSP1_QUP6_BCR] =3D { 0x23000 },
> >>>> +    [GCC_BLSP2_QUP1_BCR] =3D { 0x26000 },
> >>>> +    [GCC_BLSP2_QUP2_BCR] =3D { 0x28000 },
> >>>> +    [GCC_BLSP2_QUP3_BCR] =3D { 0x2a000 },
> >>>> +    [GCC_BLSP2_QUP4_BCR] =3D { 0x2c000 },
> >>>> +    [GCC_BLSP2_QUP5_BCR] =3D { 0x2e000 },
> >>>> +    [GCC_BLSP2_QUP6_BCR] =3D { 0x30000 },
> >>>> +    [GCC_PCIE_0_BCR] =3D { 0x6c01c },
> >>>
> >>> I find GCC_PCIE_0_BCR at 0x6b000 and then GCC_PCIE_0_PHY_BCR at 0x6c0=
1c.
> >>
> >> Doh.  Thanks for the double check.  GCC_PCIE_0_PHY_BCR is not defined =
in
> >> include/dt-bindings/clock/qcom,gcc-msm8998.h so I plan to leave it out
> >> until later.
> >>
> >> Expect a v2 shortly.
> > =

> > Will you add GCC_PCIE0_PHY_BCR shortly so we don't have to add it later
> > on when it becomes critical?
> > =

> =

> My plan was to let it sit until it becomes necessary.  I'm working on =

> USB and found that GCC_QUSB2PHY_PRIM_BCR, GCC_USB3_PHY_BCR, and =

> GCC_USB3PHY_PHY_BCR are also missing, so I suspect there are others.
> =

> Would you prefer I send a follow up that adds the PCIE phy and the USB =

> resets?

Yes please send a followup patch to add all the possible defines and
implementations that you can find. It makes future cross-tree merges
simpler.

