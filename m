Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cAShD9nvGFs/CgAAmS7hNA
	; Thu, 07 Jun 2018 08:43:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC218608BF; Thu,  7 Jun 2018 08:43:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBYMSzGs"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 64BD9602FC;
	Thu,  7 Jun 2018 08:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64BD9602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932747AbeFGIn4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753325AbeFGInx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:43:53 -0400
Received: from localhost (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AF3920874;
        Thu,  7 Jun 2018 08:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528361032;
        bh=hhXggZSPIex5OVyje2bgD2/buuhR4/3e/H/xnhmFMcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBYMSzGsq1D/RHoG1e7t9KgJUD0ts/jP6F32If15ScBiDcratuknuN3VsVqOf/1k1
         n8l49Wb9K30yy71dWdxoCfKf2m50J/Y2Y3sIN7na7iOTISSCsnly47q98EmdqL47cV
         3Utd2WBHly3h9Vg0IGzBbpAbQSTOMQsEPmidxj+I=
Date: Thu, 7 Jun 2018 14:13:48 +0530
From: Vinod <vkoul@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Sricharan R <sricharan@codeaurora.org>, ohad@wizery.com,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        sibis@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: Introduce Hexagon V5 based WCSS driver
Message-ID: <20180607084348.GG16230@vkoul-mobl>
References: <1528177361-8883-1-git-send-email-sricharan@codeaurora.org>
 <20180605061919.GQ16230@vkoul-mobl>
 <3a4c102b-7228-153a-c588-b1bf00291fa8@codeaurora.org>
 <20180606161733.GE510@tuxbook-pro>
 <20180607041134.GF16230@vkoul-mobl>
 <20180607042443.GK510@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607042443.GK510@tuxbook-pro>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-06-18, 21:24, Bjorn Andersson wrote:
> On Wed 06 Jun 21:11 PDT 2018, Vinod wrote:
> 
> > So, wouldn't Kconfig syntax something like where we say:
> >         M if RPMSG_QCOM_GLINK_SMEM=m
> >         bool if RPMSG_QCOM_GLINK_SMEM=y
> > 
> 
> If we ignore SMD for a while we have the following combinations:
> 
> glink/wcss
> y     y - valid
> y     m - valid
> y     n - valid
> m     y - link failure (invalid)
> m     m - valid
> m     n - valid
> n     y - valid (platform uses wcss, but not glink)
> n     m - valid (-----"-----)
> n     n - valid
> 
> So to distill this we have the two valid cases:
> module/no if RPMSG_QCOM_GLINK_SMEM=m
> yes/module/no if RPMSG_QCOM_GLINK_SMEM=y
> 
> and the way you express that in Kconfig is the somewhat awkward
> 
>   depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n

Understood now :) Yes it is awkward..

Btw we seem to have issue with link fail here when glink is m and wcss
is y. Why don't we see link fail for glink being n? Yes I understand that
platform uses wcss but am curious how that works out :)

Thanks
-- 
~Vinod
