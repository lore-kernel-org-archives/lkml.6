Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F069C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1311C2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzelvWj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfAGHPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:15:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42129 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfAGHO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:14:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so21392888pfr.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 23:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HvH8ILeKjFjiNuSx4wKutk9HjvXjEHz1PVJLUIYz0+M=;
        b=QzelvWj+6ACYaw8uwWTGQ27jwGuoHwT9J+lzrtg/cZamfEoM1+wEEr6ZGAKbdzH7eI
         q5ZU/HOCd4thO936ypBmOhuCN37wjxKoEq4oHg2n4mzL+D9hGLErHVDHnWrFf2XHYX6+
         wSm9xRot2ASkOMZzVROL7jk8EtxsslC2BVLGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HvH8ILeKjFjiNuSx4wKutk9HjvXjEHz1PVJLUIYz0+M=;
        b=neeogxSDzUJyLt6P1uERd6oAYl9eR5AuiOtDwlHvsUN/6pW3/1FX6SJzPlp+4tc2HE
         nnI2yH5HXSyU9KEekjFWbQvZZPqYWCWHEZoyLHX+J+p2+bfPw3DoYFNB2SkFf7OE/4E7
         WZZrrpRcRY5r+YVng00iaKZ1ripACZ+rZyaqlSBO+HXtFfTCy1a59oQNYPqbNQe2Nmef
         RpzX4tKgSfkMxA/ZA9OVxigAW5u4GtKmzsirqytSrQT97HEw5GFaBK10rBqyQ/5QVgDU
         SZedeoSA98y2IOmSF6vzHLpR7/knNJDlP634S2A2T2RhRAvYSeyuOp1UmXKRAlER8QVK
         sZnw==
X-Gm-Message-State: AA+aEWZLthEzrdmUo5S34ZiCl2EJa5gw8lx6muQQ2tsZ2C+Pk3+4ZaCx
        O3iXWR8xyqYI35vCRtTxbub1cA==
X-Google-Smtp-Source: AFSGD/V6fzfmV2thi8vODnyxkHc8iP56gMV3DQ9G/y11O7dWk/434t/UbDY73Y9TzS6gZTLv7Sdo2w==
X-Received: by 2002:a62:c21c:: with SMTP id l28mr61392699pfg.74.1546845298811;
        Sun, 06 Jan 2019 23:14:58 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v72sm40194631pfd.163.2019.01.06.23.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Jan 2019 23:14:57 -0800 (PST)
Date:   Sun, 6 Jan 2019 23:13:59 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rohit Kumar <rohitkr@codeaurora.org>
Cc:     ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org
Subject: Re: [PATCH 2/2] remoteproc: q6v5_adsp: Remove voting for lpass_aon
 clock
Message-ID: <20190107071359.GK31596@builder>
References: <1543562950-23997-1-git-send-email-rohitkr@codeaurora.org>
 <1543562950-23997-3-git-send-email-rohitkr@codeaurora.org>
 <f6f9b4a2-6205-0ba5-9a3a-b34bd814d303@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6f9b4a2-6205-0ba5-9a3a-b34bd814d303@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Jan 20:36 PST 2019, Rohit Kumar wrote:

> Hello Bjorn,
> 
> Can you please review this patch series too.
> 
> LPASS_AON clock support is already removed from lpass clock driver.
> 

Applied the two patches.

Thanks,
Bjorn

> 
> Thanks,
> 
> Rohit
> 
> On 11/30/2018 12:59 PM, Rohit kumar wrote:
> > Lpass_aon clock is on by default. Remove it from lpass
> > clock list to avoid voting for it.
> > 
> > Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> > ---
> >   drivers/remoteproc/qcom_q6v5_adsp.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> > index 79374d1..4829173 100644
> > --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> > +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> > @@ -48,7 +48,7 @@
> >   /* list of clocks required by ADSP PIL */
> >   static const char * const adsp_clk_id[] = {
> > -	"sway_cbcr", "lpass_aon", "lpass_ahbs_aon_cbcr", "lpass_ahbm_aon_cbcr",
> > +	"sway_cbcr", "lpass_ahbs_aon_cbcr", "lpass_ahbm_aon_cbcr",
> >   	"qdsp6ss_xo", "qdsp6ss_sleep", "qdsp6ss_core",
> >   };
> 
> -- 
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the Linux Foundation.
> 
