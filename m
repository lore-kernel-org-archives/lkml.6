Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DA8ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2723207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m500nsSC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W0YHYWge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2723207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeJYBdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:33:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeJYBdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:33:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2E4BD60C64; Wed, 24 Oct 2018 17:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540400671;
        bh=OvRVgb7YkaOg6/LwRpY2RAq54ZIKv7ScWEXYHWlJIU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m500nsSC+hivtM/Zkc7PnXRl0ePE9Yo9dPHa8h1spkx10JpL0jUCPRbB5ilwb5y/o
         Laggf96ObLvrAJs3bJtfGSm3DrK7+fexoZDXm1/EukNTb4dClDsSmd96fKC/K97WSc
         jMWo2mYS9h3l32e0StOYYcvUTa3h1hKFaC/DKFKw=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89F5160C1B;
        Wed, 24 Oct 2018 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540400670;
        bh=OvRVgb7YkaOg6/LwRpY2RAq54ZIKv7ScWEXYHWlJIU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W0YHYWge0vL0WFXKyW22fSIEg55+UGvA7KgoTsPTEX22YiQCAjecsClpCS2ccMHEq
         Q75BwlWSeQQq/syrnArRGgItxe8HtLJRFKSBz2fwR7/8Cyhek7aL+MwOQe/g673356
         yQSGxJ102dROwAY4cibglm5dURbsTOAdTrHfwtBw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89F5160C1B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 24 Oct 2018 11:04:29 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org,
        mka@chromium.org
Subject: Re: [PATCH RESEND] drivers: qcom: rpmh: avoid sending sleep/wake
 sets immediately
Message-ID: <20181024170429.GE17444@codeaurora.org>
References: <1540315748-29158-1-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1540315748-29158-1-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23 2018 at 11:29 -0600, Raju P.L.S.S.S.N wrote:
>Fix the redundant call being made to send the sleep and wake requests
>immediately to the controller.
>
>As per the patch[1], the sleep and wake request votes are cached in rpmh
>controller and sent during rpmh_flush(). These requests needs to be sent
>only during entry of deeper system low power modes or suspend.
>
>[1]https://patchwork.kernel.org/patch/10477533/
>
nit: [1] https://
>Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>Reviewed-by: Lina Iyer <ilina@codeaurora.org>
>---
> drivers/soc/qcom/rpmh.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>index e6e98d4..877fe78 100644
>--- a/drivers/soc/qcom/rpmh.c
>+++ b/drivers/soc/qcom/rpmh.c
>@@ -228,9 +228,8 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
> 		WARN_ON(irqs_disabled());
> 		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
> 	} else {
>-		ret = rpmh_rsc_write_ctrl_data(ctrlr_to_drv(ctrlr),
>-				&rpm_msg->msg);
> 		/* Clean up our call by spoofing tx_done */
>+		ret = 0;
> 		rpmh_tx_done(&rpm_msg->msg, ret);
> 	}
>
>--
>QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>of the Code Aurora Forum, hosted by The Linux Foundation.
>
