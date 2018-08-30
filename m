Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A73C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07CD20645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEpJo2qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07CD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeH3KQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:16:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46732 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeH3KQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:16:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so3418095pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 23:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=meqNCHnf8M6zrGD6lZy7LEVDxappggWsVLfJRIHaIRY=;
        b=HEpJo2qhqSv8+l0kcLonBLlGOWwQnQa3+YjaajPMKuclifIa+aJsdAPHOfgrcwM8k9
         Jx0RS14WMI5YD0fzcvUA0Fg6A50MCfiPT0Bj0Y/cUgBjxKaLQ3MLnqyJs8Dn8wLPEP2O
         /R2uM28OHELD7roQzF8gWgS5efin3MAEmOpfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=meqNCHnf8M6zrGD6lZy7LEVDxappggWsVLfJRIHaIRY=;
        b=DQhMf346XcLBodxBhEEFQt3IeieWd3oz2C9O2E9OqLZxkskMAfvMcPO2CyQ8jGZNG6
         FxFY91DFu53nKjOBunwFCYcF0hC8DuAstQggNyhYiLVkpU7bmH2WL8edObppDvcwUVzM
         YxDbhOuWqQ1OOA3zFXHv3Q5PoImg8BAJsVIwNRKd7FaRFiaSZ2nGZ1hWiBjFzXKz2GuE
         KJjOsIMOWtZOlgLF/Rc0ON9aSOyu2unYU4SmjTgkn2Q5h+JBVFjjKnuE5cjOuPP+BBO5
         Y+T3Jye3/9UaGbEFaNRPTdfdlLipV3dhsI+q6LKY46UgT8tTMw7jEwCuQUIVA/9QWlzC
         PXSQ==
X-Gm-Message-State: APzg51A4NOOVwcGHoibPxFtQCmsJItvcZnwBgo0PPgD2ew77vD4uDthl
        prVAJUBt2aFwye767z/+5iVFNw==
X-Google-Smtp-Source: ANB0VdaEkH85LUpbPrWuImZBJ2+RE5seDQ1dqYI80jRFXUrsUoisBb5McMg6/+UZhZBpQtHiNozzvw==
X-Received: by 2002:a62:cac5:: with SMTP id y66-v6mr9014109pfk.187.1535609767721;
        Wed, 29 Aug 2018 23:16:07 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n80-v6sm9422541pfb.95.2018.08.29.23.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 23:16:06 -0700 (PDT)
Date:   Wed, 29 Aug 2018 23:16:04 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Can Guo <cang@codeaurora.org>
Cc:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 0/5] Support for Qualcomm UFS QMP PHY on SDM845
Message-ID: <20180830061604.GM2523@minitux>
References: <20180731100914.19856-1-cang@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731100914.19856-1-cang@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31 Jul 03:09 PDT 2018, Can Guo wrote:

> This patch series adds support for UFS QMP PHY on SDM845 and the
> compatible string for it. This patch series depends on the current
> proposed QMP V3 USB3 UNI PHY support for sdm845 driver [1], on
> the DT bindings for the QMP V3 USB3 PHYs based dirver [2], and also
> rebased on updated pipe_clk initialization sequence [3]. This series
> can only be merged once the dependent patches do.
> [1] http://lists-archives.com/linux-kernel/29071659-dt-bindings-phy-qcom-qmp-update-bindings-for-sdm845.html
> [2] http://lists-archives.com/linux-kernel/29071660-phy-qcom-qmp-add-qmp-v3-usb3-uni-phy-support-for-sdm845.html
> [3] https://patchwork.kernel.org/patch/10376551/
> 

Hi Can,

We still have the issue that the older non-QMP phy driver takes a direct
call to ufs_qcom_phy_set_tx_lane_enable(), which means that pointing
UFSHCD to this phy implementation results in a kernel panic.

I do however think this series is good in itself and would like to see
it merged. As any fix for this problem would be done on top of the
patches in this series.

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
