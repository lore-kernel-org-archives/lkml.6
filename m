Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030411AbeEXOKt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:10:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50040 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967947AbeEXOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:10:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D041601E8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: <ilialin@codeaurora.org>
To: "'Sudeep Holla'" <sudeep.holla@arm.com>
Cc: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vireshk@kernel.org>, <nm@ti.com>,
        <sboyd@kernel.org>, <robh@kernel.org>, <mark.rutland@arm.com>,
        <rjw@rjwysocki.net>
References: <1527152242-31281-1-git-send-email-ilialin@codeaurora.org> <1527152242-31281-2-git-send-email-ilialin@codeaurora.org> <860be68b-cac0-9efc-b3c7-cc75b391a4c3@arm.com> <000501d3f35f$96794910$c36bdb30$@codeaurora.org> <b4e221af-57f7-fd11-942d-6bc6f6b55a73@arm.com>
In-Reply-To: <b4e221af-57f7-fd11-942d-6bc6f6b55a73@arm.com>
Subject: RE: [PATCH v12 1/2] cpufreq: Add Kryo CPU scaling driver
Date: Thu, 24 May 2018 17:10:32 +0300
Message-ID: <000701d3f368$fd31e410$f795ac30$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGZT1zPRN1vy0pjuCXFwimP3N8iDQLFSuT5Ahbt958CVipr1gDt4VB6pHMwwbA=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4OEAsK8032582

Thank you for the explanation. However, could you suggest, which condition should I check then? Device tree?

> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Thursday, May 24, 2018 17:01
> To: ilialin@codeaurora.org; vireshk@kernel.org; nm@ti.com;
> sboyd@kernel.org; robh@kernel.org; mark.rutland@arm.com;
> rjw@rjwysocki.net
> Cc: Sudeep Holla <sudeep.holla@arm.com>; linux-pm@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v12 1/2] cpufreq: Add Kryo CPU scaling driver
> 
> 
> 
> On 24/05/18 14:03, ilialin@codeaurora.org wrote:
> >
> >
> 
> [...]
> 
> >>> +
> >>> +	ret = PTR_ERR_OR_ZERO(platform_device_register_simple(
> >>> +		"qcom-cpufreq-kryo", -1, NULL, 0));
> >>
> >>
> >> You simply can't do this unconditionally here. This will blow up on
> >> platforms where this driver is not supposed to work. The probe will
> >> be called on non- QCOM or non-Kryo QCOM platforms and I reckon it
> >> will crash trying to execute something in qcom_smem_get.
> >
> > What do you mean by 'unconditionally'?
> 
> Why should you even add/register a device "qcom-cpufreq-kryo" on other
> platforms. Drivers can get registered, but only devices that are present or
> required by the platform need to be registered.
> 
> > The driver depends on the smem and nvmem drivers, which depend on
> ARCH_QCOM:
> >  +	depends on QCOM_QFPROM
> >  +	depends on QCOM_SMEM
> >
> 
> Sure, but we have something called single image for all ARM64 platforms.
> May be QCOM still used to tweeking config to build binary for your particular
> mobile platform but the distro kernel need single binary to work on all
> platforms. We have moved far away from platform specific builds long back
> now IIRC.
> 
> > And if SMEM read in the probe returns something other than Kryo, it will
> exit.
> >
> 
> Check what this driver does ?
> 
> 	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY,
> MSM_ID_SMEM, &len);
> 	msm_id++;
> 	switch ((enum _msm_id)*msm_id)
> 
> I think it *will and should* crash here ? You need to check the return value
> for sure. But since qcom_smem_get return -EPROBE_DEFER, we keep
> retrying even on non QCOM platforms which is something I would like to
> avoid.
> 
> Therefore that's not the main concern. Why do I have to see "qcom-cpufreq-
> kryo" device registered on my non QCOM platform ?
> 
> --
> Regards,
> Sudeep
