Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8ACECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2512086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Euf02FmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2512086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeJTCjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:39:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41916 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeJTCjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:39:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23-v6so16108483pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hCLPGpZ744OWUlwVBqLzAUFi89kvnnrXopdGAHnOhz4=;
        b=Euf02FmDGuVLSGHxdlE21wOaYPuWmUpgJ9A2VFz85b36shGFH+dXSwLlGQ+g14mCiR
         2ZnPoqhhwLgSrP9DVuDSzYOUlIZeRr1JbD5wQK1FLm3NV+oplevSG1qa80uo2Iw+8otH
         bSaiJi+bvY0n/s+w0E4bxH2Ac38/2w3otob8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hCLPGpZ744OWUlwVBqLzAUFi89kvnnrXopdGAHnOhz4=;
        b=ZoB+zKD7rOVyIFqV+hvV0XAJdMdazhg35Zt5/mFWQLmc1VHhd3/nN6tBXv+eNmOXp1
         /6s4jh7cm7Zv5NzBmt1fhwXuaWsxafP+igOsHg9fpiW/VftiBjBaJ09wbrdR549ZVj+f
         HWnIvwXLyPCqz8znvkoovYL1vNM12TC/Ec1asEFwXtLMf/OoKUdDf/zZWU+o7Y5rwDQ5
         98znTLcaaLu764U+6UCny391fjecoflnv4w5hG6p2r/NdDQRyHpYRLeOAYAT6iny9xly
         UDbJssQW3CCsO7aBbPrcnxH/WiGhbTUu76B5jMrV+nBfJMR+FYqPoMbvFbZWtjYex1/3
         dX5A==
X-Gm-Message-State: ABuFfohco4LWAn13Sm8RAqE6gLUe0si1dB7SbCE8h/fS37OoOM3pA3EN
        +YcLbCurCxp62Lyle54049pMSA==
X-Google-Smtp-Source: ACcGV60Cu5aMR5lU1jrY7T9eOogtmxA2gsGj162wjx3XUpjR6L1Zk1+NAjqaFw1FvFsYB6ZvnNGseQ==
X-Received: by 2002:a62:d046:: with SMTP id p67-v6mr36879282pfg.147.1539973926808;
        Fri, 19 Oct 2018 11:32:06 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x186-v6sm23706316pfb.125.2018.10.19.11.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 11:32:06 -0700 (PDT)
Date:   Fri, 19 Oct 2018 11:35:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, kyan@codeaurora.org
Subject: Re: [PATCH v5 0/5] Add coredump support for Q6v5 Modem remoteproc
Message-ID: <20181019183514.GU12063@builder>
References: <20181017135527.30592-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017135527.30592-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17 Oct 06:55 PDT 2018, Sibi Sankar wrote:

> This patch series add coredump support for modem on SDM845, MSM8996
> and MSM8916 SoCs. Modem requires the mba to be loaded before a
> coredump can be performed and this is achieved using a custom per
> segment dump function.
> 
> V5:
>   Add software bypass to avoid high MX current in mpss_load error path.
>   Remove the proxy votes of clk/regs only after the active/reset clks/regs.
>   Reclaim MBA memory after mpss_load failure in mba_reclaim func.
>   Revert to dump_fn to as done with v3 with a mask based approach.
> 
> V4:
>   Addressed Bjorn's comments.
> 
> V3:
>   [bjorn]:replace prepare/unprepare ops with a more generalised per segment
>   dump function
> 
> V2:
>   Introduce prepare/unprepare ops for rproc coredump
> 

Applied

Regards,
Bjorn

> Sibi Sankar (5):
>   remoteproc: Introduce custom dump function for each remoteproc segment
>   remoteproc: Add mechanism for custom dump function assignment
>   remoteproc: qcom: q6v5-mss: Refactor mba load/unload sequence
>   remoteproc: qcom: q6v5-mss: Add custom dump function for modem
>   remoteproc: qcom: q6v5-mss: Register segments/dumpfn for coredump
> 
>  drivers/remoteproc/qcom_q6v5_mss.c   | 379 +++++++++++++++++----------
>  drivers/remoteproc/remoteproc_core.c |  55 +++-
>  include/linux/remoteproc.h           |  11 +
>  3 files changed, 303 insertions(+), 142 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
