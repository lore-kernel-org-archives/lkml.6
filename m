Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07A7C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EBA217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eF4vKclh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfAVULy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:11:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47061 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfAVULx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:11:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so11531692pgp.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 12:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dUl/6E6j1ECKDBmAnpiUzwx3jDmolb1yccaxXR8VIR8=;
        b=eF4vKclh3LVspS2k9w0nKLkUDvCmLeaUDXYKvc790t+GAt44URK0MhyPcrnecRGBhA
         qjTeTiI+78PjV/8Ly5PO98hTmxlbM/Z8QUCPbVx2gqb35/wPbAtXKRYi2s/XtNguwHtL
         6fayh7xL75EZLW0mbtUrOtgleOzRWQHL2BJe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dUl/6E6j1ECKDBmAnpiUzwx3jDmolb1yccaxXR8VIR8=;
        b=NRWrWx5EASv3v8LXR1SwSinTmb9ZDzZqlfmsrle3Wx6HSY2DSYxxWfWSKt9gg81P84
         vCkmCFGiPeyo3r6KLCCCPKVP/+MSwRcDwkcuaHAiQL8UBNtTXoINjfXLUI8NdEVSFvgJ
         6Tld1qfk9MrYuleuqjjyLE8H5+lX44gaEOACgyGmGZM4D03vCpXlAmb+zSJ5+gQWSkD6
         oKcaoJ/xRapONvsX648gC7Nbc9fd7zbyHtmjycT7hX969B8oRMRLZDHqdDd9HMZ/43hz
         swRlr81XEQqL5KUNulXB+H9zbr7EtrFJLlZojB3QvQYPpFrf4g8INkZiUmeaFCgbVTiY
         tScA==
X-Gm-Message-State: AJcUukcnkrMllvkPd2xNRpyVYzBNc3KIr0wS/dE8kE/Gwa6B4yhMt6Lx
        0BXwkQxsBXuHrH0NWF8xnMsZMg==
X-Google-Smtp-Source: ALg8bN43e9q8nL5O34ee9OjB7WjmGAStH7boDpUVuU+LgIWdNWQBdyHxfrYIzihrahYJ7mdT76ysRA==
X-Received: by 2002:a65:40c5:: with SMTP id u5mr32469742pgp.46.1548187911303;
        Tue, 22 Jan 2019 12:11:51 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z191sm21186934pgd.74.2019.01.22.12.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 12:11:50 -0800 (PST)
Date:   Tue, 22 Jan 2019 12:11:48 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-smd: Batch up requests for disabled
 regulators
Message-ID: <20190122201148.GD31919@minitux>
References: <20190122190147.26735-1-bjorn.andersson@linaro.org>
 <fee88300-dbda-344a-81e3-4d81b6ba2234@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee88300-dbda-344a-81e3-4d81b6ba2234@codeaurora.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Jan 11:25 PST 2019, Jeffrey Hugo wrote:

> Hi Bjorn,
> 
> This seems intresting, but I'm not sure I fully understand it yet.
> 
> On 1/22/2019 12:01 PM, Bjorn Andersson wrote:
> > In some scenarios the early stages of the boot chain has configured
> > regulators to be in a required state, but the later stages has skipped
> > to inform the RPM about it's requirements.
> So if I understand this correctly, the boot chain turned on and configured
> the regulator, but didn't give the RPM its vote, so the RPM doesn't know
> anything and just assumes the default state - off/unconfigured.  Right?
> 

In our particular case we see that if ABL decides not to enter fastboot
it will not request the RPM to power the USB block. But the particular
regulator is part of the power-on sequence of the PMIC, so it's on.

So there's no votes in the RPM to have this on, but it is on and
disabling it causes the system to reboot.

> If we are in Linux, is that boot chain "vote" valid anymore?

I've never seen this code, but I assume it treats votes from "unsecure
apps" the same. The problem here is that there's no votes, from anyone,
to keep this regulator enabled.

> > 
> > But as the SMD RPM regulators are being initialized voltage change
> > requests will be issued to align the voltage with the valid ranges. The
> > RPM aggregates all parameters for the specific regulator, the voltage
> > will be adjusted and the "enabled" state will be "off" - and the
> > regulator is turned off.
> 
> So, this would happen when Linux is processing the constraints from DT for
> example, but is still initing the devices, so there are no consumers and
> thus the device is not enabled, but the voltage configuration is sent to the
> RPM to ensure the constraints are met?
> 

Correct.

> > 
> > This patch addresses this problem by caching the requested enable state,
> > voltage and load and send the parameters in a batch, depending on the
> > enable state - effectively delaying the voltage request for disabled
> > regulators.
> 
> I'm curious, would any sort of additional latency be expected because the
> RPM has delayed work to the enable "stage"?
> 

Afaict the PMIC itself is enabled/disabled by setting the voltage, so
there should be no negative latency difference in postponing the voltage
change until enable time. There's quite likely a positive gain though,
by removing the extra round trip over SMD.

> While I suspect there are benefits to this change regardless, it seems like
> what you are describing above should be addressed by "regulator-boot-on" in
> the DT.  Why is that not a valid solution for this scenario?
> 

Because set_machine_constraints() first calls
machine_constraints_voltage() then _regulator_do_enable() (if boot_on is
set). So without this patch the RPM will disable the regulator in the
beginning of the function and not reach the end of it.

Regards,
Bjorn

> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >   drivers/regulator/qcom_smd-regulator.c | 104 ++++++++++++++++---------
> >   1 file changed, 69 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> > index f5bca77d67c1..dfdc67da5cec 100644
> > --- a/drivers/regulator/qcom_smd-regulator.c
> > +++ b/drivers/regulator/qcom_smd-regulator.c
> > @@ -31,6 +31,11 @@ struct qcom_rpm_reg {
> >   	int is_enabled;
> >   	int uV;
> > +	u32 load;
> > +
> > +	unsigned int enabled_updated:1;
> > +	unsigned int uv_updated:1;
> > +	unsigned int load_updated:1;
> >   };
> >   struct rpm_regulator_req {
> > @@ -43,30 +48,59 @@ struct rpm_regulator_req {
> >   #define RPM_KEY_UV	0x00007675 /* "uv" */
> >   #define RPM_KEY_MA	0x0000616d /* "ma" */
> > -static int rpm_reg_write_active(struct qcom_rpm_reg *vreg,
> > -				struct rpm_regulator_req *req,
> > -				size_t size)
> > +static int rpm_reg_write_active(struct qcom_rpm_reg *vreg)
> >   {
> > -	return qcom_rpm_smd_write(vreg->rpm,
> > -				  QCOM_SMD_RPM_ACTIVE_STATE,
> > -				  vreg->type,
> > -				  vreg->id,
> > -				  req, size);
> > +	struct rpm_regulator_req req[3];
> > +	int reqlen = 0;
> > +	int ret;
> > +
> > +	if (vreg->enabled_updated) {
> > +		req[reqlen].key = cpu_to_le32(RPM_KEY_SWEN);
> > +		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
> > +		req[reqlen].value = cpu_to_le32(vreg->is_enabled);
> > +		reqlen++;
> > +	}
> > +
> > +	if (vreg->uv_updated && vreg->is_enabled) {
> > +		req[reqlen].key = cpu_to_le32(RPM_KEY_UV);
> > +		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
> > +		req[reqlen].value = cpu_to_le32(vreg->uV);
> > +		reqlen++;
> > +	}
> > +
> > +	if (vreg->load_updated && vreg->is_enabled) {
> > +		req[reqlen].key = cpu_to_le32(RPM_KEY_MA);
> > +		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
> > +		req[reqlen].value = cpu_to_le32(vreg->load / 1000);
> > +		reqlen++;
> > +	}
> > +
> > +	if (!reqlen)
> > +		return 0;
> > +
> > +	ret = qcom_rpm_smd_write(vreg->rpm, QCOM_SMD_RPM_ACTIVE_STATE,
> > +				 vreg->type, vreg->id,
> > +				 req, sizeof(req[0]) * reqlen);
> > +	if (!ret) {
> > +		vreg->enabled_updated = 0;
> > +		vreg->uv_updated = 0;
> > +		vreg->load_updated = 0;
> > +	}
> > +
> > +	return ret;
> >   }
> >   static int rpm_reg_enable(struct regulator_dev *rdev)
> >   {
> >   	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
> > -	struct rpm_regulator_req req;
> >   	int ret;
> > -	req.key = cpu_to_le32(RPM_KEY_SWEN);
> > -	req.nbytes = cpu_to_le32(sizeof(u32));
> > -	req.value = cpu_to_le32(1);
> > +	vreg->is_enabled = 1;
> > +	vreg->enabled_updated = 1;
> > -	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
> > -	if (!ret)
> > -		vreg->is_enabled = 1;
> > +	ret = rpm_reg_write_active(vreg);
> > +	if (ret)
> > +		vreg->is_enabled = 0;
> >   	return ret;
> >   }
> > @@ -81,16 +115,14 @@ static int rpm_reg_is_enabled(struct regulator_dev *rdev)
> >   static int rpm_reg_disable(struct regulator_dev *rdev)
> >   {
> >   	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
> > -	struct rpm_regulator_req req;
> >   	int ret;
> > -	req.key = cpu_to_le32(RPM_KEY_SWEN);
> > -	req.nbytes = cpu_to_le32(sizeof(u32));
> > -	req.value = 0;
> > +	vreg->is_enabled = 0;
> > +	vreg->enabled_updated = 1;
> > -	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
> > -	if (!ret)
> > -		vreg->is_enabled = 0;
> > +	ret = rpm_reg_write_active(vreg);
> > +	if (ret)
> > +		vreg->is_enabled = 1;
> >   	return ret;
> >   }
> > @@ -108,16 +140,15 @@ static int rpm_reg_set_voltage(struct regulator_dev *rdev,
> >   			       unsigned *selector)
> >   {
> >   	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
> > -	struct rpm_regulator_req req;
> > -	int ret = 0;
> > +	int ret;
> > +	int old_uV = vreg->uV;
> > -	req.key = cpu_to_le32(RPM_KEY_UV);
> > -	req.nbytes = cpu_to_le32(sizeof(u32));
> > -	req.value = cpu_to_le32(min_uV);
> > +	vreg->uV = min_uV;
> > +	vreg->uv_updated = 1;
> > -	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
> > -	if (!ret)
> > -		vreg->uV = min_uV;
> > +	ret = rpm_reg_write_active(vreg);
> > +	if (ret)
> > +		vreg->uV = old_uV;
> >   	return ret;
> >   }
> > @@ -125,13 +156,16 @@ static int rpm_reg_set_voltage(struct regulator_dev *rdev,
> >   static int rpm_reg_set_load(struct regulator_dev *rdev, int load_uA)
> >   {
> >   	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
> > -	struct rpm_regulator_req req;
> > +	u32 old_load = vreg->load;
> > +	int ret;
> > -	req.key = cpu_to_le32(RPM_KEY_MA);
> > -	req.nbytes = cpu_to_le32(sizeof(u32));
> > -	req.value = cpu_to_le32(load_uA / 1000);
> > +	vreg->load = load_uA;
> > +	vreg->load_updated = 1;
> > +	ret = rpm_reg_write_active(vreg);
> > +	if (ret)
> > +		vreg->load = old_load;
> > -	return rpm_reg_write_active(vreg, &req, sizeof(req));
> > +	return ret;
> >   }
> >   static const struct regulator_ops rpm_smps_ldo_ops = {
> > 
> 
> 
> -- 
> Jeffrey Hugo
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies,
> Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
