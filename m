Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E425FECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E3720693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P03e8j9s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i4HwUuE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E3720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbeGSI5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:57:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56144 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbeGSI5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:57:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 04744606DB; Thu, 19 Jul 2018 08:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531988155;
        bh=beMoysEWEUSgySWS06Rek18MqxV0XEQlQWB3HMRsvbU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P03e8j9sRU1Oc3dqTGohTxJM8ZIg4xyVN86hb9QP6wRkg29hOSQhbM5eenGwfJvA1
         qIrdQK42zyyo//miA/aNgrTZYgOZMTBPwNcxm7Hlrm3AgDeNtySFXtf++ApG1S5Xo2
         XRUd98C9ZiitG7Ikb01oi3zvEct/QgAJ/eq3OjGs=
Received: from [10.206.16.36] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED1216071B;
        Thu, 19 Jul 2018 08:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531988150;
        bh=beMoysEWEUSgySWS06Rek18MqxV0XEQlQWB3HMRsvbU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i4HwUuE3ajmHy2DXosc5MlC66K3zoMmXN4bLgsEIWKxm7WYwaIXvWyNIgVrvsKzYn
         VDd9DtXi4N+fAxU0Dju1e2fegYcnngVvAKOW5XKXU6GaTBEQXQGt+bIQnHlAU6C263
         hvzAk9+XR9HYHQwkKhYoVT+oRsMZa5z3lVXB+orM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED1216071B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH 1/7] drivers: qcom: rpmh-rsc: fix the loop index check in
 get_req_from_tcs
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org
References: <1531984382-11780-1-git-send-email-rplsssn@codeaurora.org>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <c39d3a97-9aa8-8487-0030-9db76fc50cd2@codeaurora.org>
Date:   Thu, 19 Jul 2018 13:45:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531984382-11780-1-git-send-email-rplsssn@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is an independent patch and not part of patch set. There was some 
issue while sending the patch using git send-email. Please ignore 1/7 in 
the mail subject. Sorry for multiple mails.

Thanks,
Raju.

On 7/19/2018 12:43 PM, Raju P L S S S N wrote:
> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
> 
> get_req_from_tcs introduced in patch[1] returns tcs_request from
> tcs_group. The size of tcs (of type - tcs_group) array in rsc_drv is
> TCS_TYPE_NR. So the loop index needs to be iterated up to TCS_TYPE_NR only.
> 
> [1] https://patchwork.kernel.org/patch/10477547/
> 
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
>   drivers/soc/qcom/rpmh-rsc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index fefda0f..33fe9f9 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -190,7 +190,7 @@ static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
>   	struct tcs_group *tcs;
>   	int i;
>   
> -	for (i = 0; i < drv->num_tcs; i++) {
> +	for (i = 0; i < TCS_TYPE_NR; i++) {
>   		tcs = &drv->tcs[i];
>   		if (tcs->mask & BIT(tcs_id))
>   			return tcs->req[tcs_id - tcs->offset];
> 
