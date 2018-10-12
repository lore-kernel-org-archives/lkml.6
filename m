Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A32AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2099E213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 05:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X0VMkdwn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DSYHCvvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2099E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeJLN2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:28:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33016 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeJLN2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:28:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5803160C60; Fri, 12 Oct 2018 05:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539323851;
        bh=IDdUDH5mhO07VUL6h/96nk7cgEfI4vl01Y6eKFX/ZiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X0VMkdwnnE5dmTAeuAOgpwY7Hqe4Yjz0zmsFkuJyfEuoshGrZUVw6G9ZeAhLLgtrt
         XJv5mYPFGpyNwJcp+gKeyyjfumfyUkjtDfq/gwcid8iJ/PaDv5VjwP+LqfcTWtTnms
         EeMEK/CYYXu7G2PgxgB+xtqPq/7AJOshbJQ0mXII=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 781D36072E;
        Fri, 12 Oct 2018 05:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539323850;
        bh=IDdUDH5mhO07VUL6h/96nk7cgEfI4vl01Y6eKFX/ZiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DSYHCvvOhr4LYb2Kr2c2Ms/E5O/oSI0OypfD6NNQELvQWHOFZ3hgpaRKX0FsPbE0/
         0RwEuhELgM3WBOZ9w4MzZ3lD37amGmI4NlIZwKjj2fZGxk8g0RXi+pTd/W+N+OqoSs
         NN4WWjDFpoEsnxB/ZLB8ckcVCoNowK/4wd9Cz3Lw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 12 Oct 2018 11:27:30 +0530
From:   mgautam@codeaurora.org
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] phy: qcom-qusb2: Fix HSTX_TRIM tuning with fused value
 for SDM845
In-Reply-To: <CAD=FV=UgFBzUzjqakJp2OCoKVcbEksrv-QrQ5-303ZqTCfv=hw@mail.gmail.com>
References: <20181005090920.26108-1-mgautam@codeaurora.org>
 <CAD=FV=UgFBzUzjqakJp2OCoKVcbEksrv-QrQ5-303ZqTCfv=hw@mail.gmail.com>
Message-ID: <4f1adeecf61643fcba4202be1c520561@codeaurora.org>
X-Sender: mgautam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-10-11 04:06, Doug Anderson wrote:
> Hi,
> 
> On Fri, Oct 5, 2018 at 2:09 AM Manu Gautam <mgautam@codeaurora.org> 
> wrote:
>> 
>> Tune1 register on sdm845 is used to update HSTX_TRIM with fused
>> setting. Enable same by specifying update_tune1_with_efuse flag
>> for sdm845, otherwise driver ends up programming tune2 register.
>> While at it, also fix HSTX_TRIM tuning logic which instead of
>> using fused value as HSTX_TRIM, incorrectly performs bitwise OR
>> operation with existing default value.
>> 
>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> It's a little weird that the old code wasn't causing more problems.
> Any idea why?  On SDM845 it looks like the old code was clobbering the
> "fstx slew rate control" bits.

Thanks for reviewing it.
I am assuming changing 'fstx slew rc' didn't have major impact other 
than
some interoperability or electrical compliance issues.

> 
> In any case, this looks like it fixes several commits:
> 
> 1. The bitwise OR vs. setting the bits w/ mask fixes the original
> driver at commit ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2
> PHY on Qcom chips").  It'll be slightly annoying to backport past
> commit c71dabf27c3a ("phy: qcom-qusb2: Add support for different
> register layouts") but you should still tag "Fixes" with the original
> commit in case anyone wants to do it.
> 
> 2. On sdm845 it was updating the wrong register (tune2 instead of
> tune1).  This fixes commit ef17f6e212ca ("phy: qcom-qusb2: Add QUSB2
> PHYs support for sdm845").
> 
> ...because of the above I'd suggest splitting this into two commits:
> one that fixes the qusb2_write_mask() and one that fixes sdm845.  Then
> add the "Fixes:" tag.  This will really help in the backports to
> linux-stable.

Sure, will split in two.

> 
> 
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c 
>> b/drivers/phy/qualcomm/phy-qcom-qusb2.c
>> index e70e425f26f5..defeb0b7cfa0 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
>> @@ -231,6 +231,7 @@ static const struct qusb2_phy_cfg sdm845_phy_cfg = 
>> {
>>         .mask_core_ready = CORE_READY_STATUS,
>>         .has_pll_override = true,
>>         .autoresume_en    = BIT(0),
>> +       .update_tune1_with_efuse = true,
>>  };
>> 
>>  static const char * const qusb2_phy_vreg_names[] = {
>> @@ -415,12 +416,13 @@ static void qusb2_phy_set_tune2_param(struct 
>> qusb2_phy *qphy)
>> 
>>         /* Fused TUNE1/2 value is the higher nibble only */
>>         if (cfg->update_tune1_with_efuse)
>> -               qusb2_setbits(qphy->base, 
>> cfg->regs[QUSB2PHY_PORT_TUNE1],
>> -                             val[0] << 0x4);
>> +               qusb2_write_mask(qphy->base, 
>> cfg->regs[QUSB2PHY_PORT_TUNE1],
>> +                                val[0] << HSTX_TRIM_SHIFT,
>> +                                HSTX_TRIM_MASK);
>>         else
>> -               qusb2_setbits(qphy->base, 
>> cfg->regs[QUSB2PHY_PORT_TUNE2],
>> -                             val[0] << 0x4);
>> -
>> +               qusb2_write_mask(qphy->base, 
>> cfg->regs[QUSB2PHY_PORT_TUNE2],
>> +                                val[0] << HSTX_TRIM_SHIFT,
>> +                                HSTX_TRIM_MASK);
> 
> In general your patch seems like something we should take.  ...but it
> made me look a bit more at the code and I think your patch will tickle
> another bug that we probably need to fix first.
> 
> Specifically there are two ways to set HSTX_TRIM.  One is in
> qusb2_phy_set_tune2_param() and the other is in
> qusb2_phy_override_phy_params().  At the moment we first call
> qusb2_phy_override_phy_params() and then we call
> qusb2_phy_set_tune2_param().  That means that (now that we've fixed
> qusb2_phy_set_tune2_param()) we'll _always_ set the tuning based on
> qusb2_phy_set_tune2_param() assuming that the nvmem is specified (and
> non-zero).  ...and it's specified in sdm845.dtsi so that means that on
> SDM845 it's _always_ specified.
> 
> Said another way: the 'qcom,hstx-trim-value' in sdm845-mtp.dts is
> totally useless because it will always be overridden by the fuse which
> is specified in sdm845.dtsi.
> 
> I have no idea how the fused value vs. the device tree value are
> supposed to interact, but that doesn't seem right.  ...or is the fused
> value really supposed to override and it'll be 0 if it's not supposed
> to?

Fused value is supposed to always override. If value is not fused for 
some
parts (which I believe is case with some early samples), then driver 
will
read it is '0' from nvmem and should use hstx-trim value passed from DT.

-Manu
