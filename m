Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8922DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D41C2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n0NWQRdo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UXPxVYau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfAVTZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:25:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33696 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfAVTZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:25:08 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1BBF76079C; Tue, 22 Jan 2019 19:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548185107;
        bh=weH1LBeM0HR4xKmCH4RU0JCB8/rPv6ax05CD85bpzvc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n0NWQRdon9c4gWP8k1Ebk8ahasIujugupwvhfTvY1Mdvl6Yty//m+LCKzRngzKvpL
         M8I3jvclpnMe+e3T/RssNAoa+X4cyk5c1M1QYV6OL4H6XeJCNaRKiUNhY+67xDpP3N
         VTAK16ZGOXkCEWgdaJ+p0PseFZDIi4lgxiyoRQak=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8856B6024C;
        Tue, 22 Jan 2019 19:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548185106;
        bh=weH1LBeM0HR4xKmCH4RU0JCB8/rPv6ax05CD85bpzvc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UXPxVYau5Rt6lcMEqF+Y+GxyAzV/Gak4FWom5OmBg6BrVlGIspCeiyQNDUOrP9bTN
         uHHM9liSwHV5nlr9pAkFnsgqR3O9y3pT0Q6b76UelUU5VasK6BBlvWaV0tLKJKajnl
         jF7iI0aiDfdhvBgC+CK2R8JIGQZdApeMP3j0PLng=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8856B6024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] regulator: qcom-smd: Batch up requests for disabled
 regulators
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20190122190147.26735-1-bjorn.andersson@linaro.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <fee88300-dbda-344a-81e3-4d81b6ba2234@codeaurora.org>
Date:   Tue, 22 Jan 2019 12:25:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122190147.26735-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

This seems intresting, but I'm not sure I fully understand it yet.

On 1/22/2019 12:01 PM, Bjorn Andersson wrote:
> In some scenarios the early stages of the boot chain has configured
> regulators to be in a required state, but the later stages has skipped
> to inform the RPM about it's requirements.
So if I understand this correctly, the boot chain turned on and 
configured the regulator, but didn't give the RPM its vote, so the RPM 
doesn't know anything and just assumes the default state - 
off/unconfigured.  Right?

If we are in Linux, is that boot chain "vote" valid anymore?
> 
> But as the SMD RPM regulators are being initialized voltage change
> requests will be issued to align the voltage with the valid ranges. The
> RPM aggregates all parameters for the specific regulator, the voltage
> will be adjusted and the "enabled" state will be "off" - and the
> regulator is turned off.

So, this would happen when Linux is processing the constraints from DT 
for example, but is still initing the devices, so there are no consumers 
and thus the device is not enabled, but the voltage configuration is 
sent to the RPM to ensure the constraints are met?

> 
> This patch addresses this problem by caching the requested enable state,
> voltage and load and send the parameters in a batch, depending on the
> enable state - effectively delaying the voltage request for disabled
> regulators.

I'm curious, would any sort of additional latency be expected because 
the RPM has delayed work to the enable "stage"?

While I suspect there are benefits to this change regardless, it seems 
like what you are describing above should be addressed by 
"regulator-boot-on" in the DT.  Why is that not a valid solution for 
this scenario?

> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   drivers/regulator/qcom_smd-regulator.c | 104 ++++++++++++++++---------
>   1 file changed, 69 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> index f5bca77d67c1..dfdc67da5cec 100644
> --- a/drivers/regulator/qcom_smd-regulator.c
> +++ b/drivers/regulator/qcom_smd-regulator.c
> @@ -31,6 +31,11 @@ struct qcom_rpm_reg {
>   
>   	int is_enabled;
>   	int uV;
> +	u32 load;
> +
> +	unsigned int enabled_updated:1;
> +	unsigned int uv_updated:1;
> +	unsigned int load_updated:1;
>   };
>   
>   struct rpm_regulator_req {
> @@ -43,30 +48,59 @@ struct rpm_regulator_req {
>   #define RPM_KEY_UV	0x00007675 /* "uv" */
>   #define RPM_KEY_MA	0x0000616d /* "ma" */
>   
> -static int rpm_reg_write_active(struct qcom_rpm_reg *vreg,
> -				struct rpm_regulator_req *req,
> -				size_t size)
> +static int rpm_reg_write_active(struct qcom_rpm_reg *vreg)
>   {
> -	return qcom_rpm_smd_write(vreg->rpm,
> -				  QCOM_SMD_RPM_ACTIVE_STATE,
> -				  vreg->type,
> -				  vreg->id,
> -				  req, size);
> +	struct rpm_regulator_req req[3];
> +	int reqlen = 0;
> +	int ret;
> +
> +	if (vreg->enabled_updated) {
> +		req[reqlen].key = cpu_to_le32(RPM_KEY_SWEN);
> +		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
> +		req[reqlen].value = cpu_to_le32(vreg->is_enabled);
> +		reqlen++;
> +	}
> +
> +	if (vreg->uv_updated && vreg->is_enabled) {
> +		req[reqlen].key = cpu_to_le32(RPM_KEY_UV);
> +		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
> +		req[reqlen].value = cpu_to_le32(vreg->uV);
> +		reqlen++;
> +	}
> +
> +	if (vreg->load_updated && vreg->is_enabled) {
> +		req[reqlen].key = cpu_to_le32(RPM_KEY_MA);
> +		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
> +		req[reqlen].value = cpu_to_le32(vreg->load / 1000);
> +		reqlen++;
> +	}
> +
> +	if (!reqlen)
> +		return 0;
> +
> +	ret = qcom_rpm_smd_write(vreg->rpm, QCOM_SMD_RPM_ACTIVE_STATE,
> +				 vreg->type, vreg->id,
> +				 req, sizeof(req[0]) * reqlen);
> +	if (!ret) {
> +		vreg->enabled_updated = 0;
> +		vreg->uv_updated = 0;
> +		vreg->load_updated = 0;
> +	}
> +
> +	return ret;
>   }
>   
>   static int rpm_reg_enable(struct regulator_dev *rdev)
>   {
>   	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
> -	struct rpm_regulator_req req;
>   	int ret;
>   
> -	req.key = cpu_to_le32(RPM_KEY_SWEN);
> -	req.nbytes = cpu_to_le32(sizeof(u32));
> -	req.value = cpu_to_le32(1);
> +	vreg->is_enabled = 1;
> +	vreg->enabled_updated = 1;
>   
> -	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
> -	if (!ret)
> -		vreg->is_enabled = 1;
> +	ret = rpm_reg_write_active(vreg);
> +	if (ret)
> +		vreg->is_enabled = 0;
>   
>   	return ret;
>   }
> @@ -81,16 +115,14 @@ static int rpm_reg_is_enabled(struct regulator_dev *rdev)
>   static int rpm_reg_disable(struct regulator_dev *rdev)
>   {
>   	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
> -	struct rpm_regulator_req req;
>   	int ret;
>   
> -	req.key = cpu_to_le32(RPM_KEY_SWEN);
> -	req.nbytes = cpu_to_le32(sizeof(u32));
> -	req.value = 0;
> +	vreg->is_enabled = 0;
> +	vreg->enabled_updated = 1;
>   
> -	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
> -	if (!ret)
> -		vreg->is_enabled = 0;
> +	ret = rpm_reg_write_active(vreg);
> +	if (ret)
> +		vreg->is_enabled = 1;
>   
>   	return ret;
>   }
> @@ -108,16 +140,15 @@ static int rpm_reg_set_voltage(struct regulator_dev *rdev,
>   			       unsigned *selector)
>   {
>   	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
> -	struct rpm_regulator_req req;
> -	int ret = 0;
> +	int ret;
> +	int old_uV = vreg->uV;
>   
> -	req.key = cpu_to_le32(RPM_KEY_UV);
> -	req.nbytes = cpu_to_le32(sizeof(u32));
> -	req.value = cpu_to_le32(min_uV);
> +	vreg->uV = min_uV;
> +	vreg->uv_updated = 1;
>   
> -	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
> -	if (!ret)
> -		vreg->uV = min_uV;
> +	ret = rpm_reg_write_active(vreg);
> +	if (ret)
> +		vreg->uV = old_uV;
>   
>   	return ret;
>   }
> @@ -125,13 +156,16 @@ static int rpm_reg_set_voltage(struct regulator_dev *rdev,
>   static int rpm_reg_set_load(struct regulator_dev *rdev, int load_uA)
>   {
>   	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
> -	struct rpm_regulator_req req;
> +	u32 old_load = vreg->load;
> +	int ret;
>   
> -	req.key = cpu_to_le32(RPM_KEY_MA);
> -	req.nbytes = cpu_to_le32(sizeof(u32));
> -	req.value = cpu_to_le32(load_uA / 1000);
> +	vreg->load = load_uA;
> +	vreg->load_updated = 1;
> +	ret = rpm_reg_write_active(vreg);
> +	if (ret)
> +		vreg->load = old_load;
>   
> -	return rpm_reg_write_active(vreg, &req, sizeof(req));
> +	return ret;
>   }
>   
>   static const struct regulator_ops rpm_smps_ldo_ops = {
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
