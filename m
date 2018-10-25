Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7FCC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD5920838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xg4+ai/B";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GA+n/5AO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD5920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeJYOw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:52:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbeJYOw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:52:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0353E60CEB; Thu, 25 Oct 2018 06:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540448470;
        bh=NAwuXVUwY/moMDaPo3NML9jkJ887vKts1Qb13yqe/tA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xg4+ai/BUuMRbgZBCv15sTx0U9D820yo4+kt/6hr8uyhTdm5xb9NMJJ03pYMiB8/6
         4y0kFOObiovT+PUANXjy2KWeDqRNwjIupMV8eI8jsbStA4FXrs2Y6+zMYI3GwKum+d
         3CHrNHkvTYGL/0wpPV/jHkqIXZs4JJBPmL/bedGI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C614760C1B;
        Thu, 25 Oct 2018 06:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540448463;
        bh=NAwuXVUwY/moMDaPo3NML9jkJ887vKts1Qb13yqe/tA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GA+n/5AOTuFm6fZVrn720OCjc1gIU0QYBCXSLtN1qD1BwzUJqJsRF6rhjYQzFnC2h
         BmH3EQNxD2M3uN20zMICilbaqXs5nNhX6ZtkDFMOIP4ntSehsSotOaT7A320Js9CLV
         Nmg5sopQZRdoAUFbBgY/KrRpUrPMGBGRtkYKlAwk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Oct 2018 11:51:03 +0530
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] phy: qcom-qusb2: Use HSTX_TRIM fused value as is
In-Reply-To: <719bbfbe-808e-4757-a8ad-dab7cf348ea7@codeaurora.org>
References: <20181016072209.1011-1-mgautam@codeaurora.org>
 <719bbfbe-808e-4757-a8ad-dab7cf348ea7@codeaurora.org>
Message-ID: <540a85c0d122e2cf5aa8645877b9fea6@codeaurora.org>
X-Sender: vivek.gautam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-25 11:46, Vivek Gautam wrote:
> Hi Manu,
> 
> On 10/16/2018 12:52 PM, Manu Gautam wrote:
> 
>> Fix HSTX_TRIM tuning logic which instead of using fused value
>> as HSTX_TRIM, incorrectly performs bitwise OR operation with
>> existing default value.
>> 
>> Fixes: ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on
>> Qcom chips")
>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> ---
>> drivers/phy/qualcomm/phy-qcom-qusb2.c | 19 ++++++++++---------
>> 1 file changed, 10 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c
>> b/drivers/phy/qualcomm/phy-qcom-qusb2.c
>> index e70e425f26f5..9d6c88064158 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
>> @@ -402,10 +402,10 @@ static void qusb2_phy_set_tune2_param(struct
>> qusb2_phy *qphy)
>> 
>> /*
>> * Read efuse register having TUNE2/1 parameter's high nibble.
>> -     * If efuse register shows value as 0x0, or if we fail to find
>> -     * a valid efuse register settings, then use default value
>> -     * as 0xB for high nibble that we have already set while
>> -     * configuring phy.
>> +     * If efuse register shows value as 0x0 (indicating value is
>> not
>> +     * fused), or if we fail to find a valid efuse register
>> setting,
>> +     * then use default value for high nibble that we have already
>> +     * set while configuring the phy.
>> */
>> val = nvmem_cell_read(qphy->cell, NULL);
>> if (IS_ERR(val) || !val[0]) {
>> @@ -415,12 +415,13 @@ static void qusb2_phy_set_tune2_param(struct
>> qusb2_phy *qphy)
>> 
>> /* Fused TUNE1/2 value is the higher nibble only */
>> if (cfg->update_tune1_with_efuse)
>> -        qusb2_setbits(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE1],
>> -                  val[0] << 0x4);
>> +        qusb2_write_mask(qphy->base,
>> cfg->regs[QUSB2PHY_PORT_TUNE1],
>> +                 val[0] << HSTX_TRIM_SHIFT,
>> +                 HSTX_TRIM_MASK);
>> else
>> -        qusb2_setbits(qphy->base, cfg->regs[QUSB2PHY_PORT_TUNE2],
>> -                  val[0] << 0x4);
>> -
>> +        qusb2_write_mask(qphy->base,
>> cfg->regs[QUSB2PHY_PORT_TUNE2],
>> +                 val[0] << HSTX_TRIM_SHIFT,
>> +                 HSTX_TRIM_MASK);
>> }
>> 
>> static int qusb2_phy_set_mode(struct phy *phy, enum phy_mode mode)
> 
> Thanks for the patch.
> Acked-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> 

My bad. Didn't notice the HTML mode. Resending, so that it reaches to 
lists as well.

Thanks
Vivek

> Regards
> Vivek
