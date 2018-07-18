Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C89AECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C2520652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WRNWSjGy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dxo8cpd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C2520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbeGRRrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:47:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54388 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbeGRRrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:47:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0658F607C6; Wed, 18 Jul 2018 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531933723;
        bh=6FHwTyJqww16tdrWqS6R0l6JBVVAzAv/Xdp5NiGDEmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRNWSjGyY5SqaRpCnsHAD7GQJPFeNrgglB3xCOoFzcmB3UgxfgEy6effoueK2QM1b
         9u0UZJ67R3UbTy85r59gaTBNG8qAaJRmZlHIMXA08ZyJIkamoZuRtEvbTZNOm6fMBP
         sQaVP2a8sLnbBBzBFgQdh30MOkR+w/ipufmY8cK4=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A033602B3;
        Wed, 18 Jul 2018 17:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531933722;
        bh=6FHwTyJqww16tdrWqS6R0l6JBVVAzAv/Xdp5NiGDEmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxo8cpd5sEKrk/wJWnB5ZGiyvNS4FgJI3YUS53tmtXvAN2VQwxdeSZ4VKNQbUMvft
         xhv5kPlmC9vkBdK/x4MCQukoSjkCOi11iWmuXoIx0xUcqh6JoOJSY/+r7cn/idPWwy
         IYE+lCdrBpKeAIfw3qsvG4g/RNw8zlA4vOJjQynE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A033602B3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 18 Jul 2018 11:08:41 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Raju P L S S S N <rplsssn@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH] drivers: qcom: rpmh: fix unwanted error check for
 get_tcs_of_type()
Message-ID: <20180718170841.GB10905@codeaurora.org>
References: <1531489546-21577-1-git-send-email-rplsssn@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531489546-21577-1-git-send-email-rplsssn@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13 2018 at 07:46 -0600, Raju P L S S S N wrote:
>From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
>
>The patch fixes the bug reported by Dan Carpenter.
>It removes the unnecessary err check for ‘tcs’ reported by
>static checker warning:
>
>drivers/soc/qcom/rpmh-rsc.c:111 tcs_invalidate()
>warn: 'tcs' isn't an ERR_PTR
>See also:
>drivers/soc/qcom/rpmh-rsc.c:178 get_tcs_for_msg() warn: 'tcs' isn't
>an ERR_PTR
>drivers/soc/qcom/rpmh-rsc.c:180 get_tcs_for_msg() warn: 'tcs' isn't
>an ERR_PTR
>
>https://www.spinics.net/lists/linux-soc/msg04624.html
>
>Fixes: 48dbb0f02d34 ("drivers: qcom: rpmh-rsc: allow invalidation
>of sleep/wake TCS")
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>

>---
> drivers/soc/qcom/rpmh-rsc.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>index 098feb9..fefda0f 100644
>--- a/drivers/soc/qcom/rpmh-rsc.c
>+++ b/drivers/soc/qcom/rpmh-rsc.c
>@@ -107,8 +107,6 @@ static int tcs_invalidate(struct rsc_drv *drv, int type)
> 	struct tcs_group *tcs;
>
> 	tcs = get_tcs_of_type(drv, type);
>-	if (IS_ERR(tcs))
>-		return PTR_ERR(tcs);
>
> 	spin_lock(&tcs->lock);
> 	if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
>@@ -174,9 +172,9 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
> 	 * TCSes before making an active state request.
> 	 */
> 	tcs = get_tcs_of_type(drv, type);
>-	if (msg->state == RPMH_ACTIVE_ONLY_STATE && IS_ERR(tcs)) {
>+	if (msg->state == RPMH_ACTIVE_ONLY_STATE && !tcs->num_tcs) {
> 		tcs = get_tcs_of_type(drv, WAKE_TCS);
>-		if (!IS_ERR(tcs)) {
>+		if (tcs->num_tcs) {
> 			ret = rpmh_rsc_invalidate(drv);
> 			if (ret)
> 				return ERR_PTR(ret);
>--
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
>
