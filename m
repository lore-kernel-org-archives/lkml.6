Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQHMBaJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C1A8601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754031AbeFFQPm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:15:42 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37171 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932748AbeFFQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:15:28 -0400
X-Google-Smtp-Source: ADUXVKIgf7eY6dgoXB9onDpCmjDzLllQLLKMQl5pzfzWZSn0dMtA9eHNlGBWhMW6VyIEieo40ayCgA==
Date: Wed, 6 Jun 2018 09:17:33 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: Vinod <vkoul@kernel.org>, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        sibis@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: Introduce Hexagon V5 based WCSS driver
Message-ID: <20180606161733.GE510@tuxbook-pro>
References: <1528177361-8883-1-git-send-email-sricharan@codeaurora.org>
 <20180605061919.GQ16230@vkoul-mobl>
 <3a4c102b-7228-153a-c588-b1bf00291fa8@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a4c102b-7228-153a-c588-b1bf00291fa8@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Jun 05:56 PDT 2018, Sricharan R wrote:

> Hi Vinod,
> 
> On 6/5/2018 11:49 AM, Vinod wrote:
> > On 05-06-18, 11:12, Sricharan R wrote:
> > 
> >> +config QCOM_Q6V5_WCSS
> >> +	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
> >> +	depends on OF && ARCH_QCOM
> >> +	depends on QCOM_SMEM
> >> +	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
> >> +	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
> > 
> > Is there a reason why it depends on RPMSG_QCOM_GLINK_SMEM=n? What would
> > happen if distro wants both this and RPMSG_QCOM_GLINK_SMEM
> > 

It says that QCOM_Q6V5_WCSS either must have a compatible state (i.e.
builtin vs builtin, module vs builtin, but not builtin vs module) or
that it's disabled, in which case we will hit the stub functions in
qcom_glink.h.

I.e. this prevents QCOM_Q6V5_WCSS to be compiled builtin when
RPMSG_QCOM_GLINK_SMEM is module, as this would give us both stubs and
the module.

>   RPMSG_QCOM_GLINK_SMEM=n should be for the COMPILE_TEST. Probably that
>   means that it should be corrected here and for ADSP, Q6V5_PIL as well.
>   Bjorn, is that correct ?, should it be, below ?
>  

There are platforms with SMD, those with GLINK-SMEM and those with both.
For the two first we want it to be possible only compile the specific
transport being used and the other being stubbed.

As Sricharan's particular platform uses GLINK for communicating with the
WCSS it's perfectly fine to run this particular driver with
RPMSG_QCOM_SMD=n RPMSG_QCOM_GLINK_SMEM=y/m


As such I would recommend that you drop COMPILE_TEST from above.

Regards,
Bjorn
