Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E443C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403342085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SzYU6CEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388010AbfAaQF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:05:56 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39874 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733167AbfAaQF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:05:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so1664756pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XKp0vivshSp48I8VQHLEgDAdkTdo/PVsXk1wLGxyYs0=;
        b=SzYU6CEeobPbF9unEtUxlsDgIzWq+rQNb/iYJKrGDbqk1sVuvbpy/HZO5vre/8Qwyc
         fJI4VyKBnFGmOn6D5E89bFUay9PyXqnn5rt5FvSRv6qbHR83gxdPNCpTyn879bpoQdYQ
         Q547f0uR1waLE/+Uf5QRXqW1MmO0Hukhs33BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XKp0vivshSp48I8VQHLEgDAdkTdo/PVsXk1wLGxyYs0=;
        b=j7uH1H++BANCe3ckxm/vwSyjI1d2QQb2Rg23/pcK50gykuAAhq8iwBhozbgtyH2lTl
         r4TJwWcVAVjwBlt3JQPB/VICA8kDJ29nIAQahMdGGDeKmVWDKeSJ0btAewcllKzmv3sZ
         CgxH1QKfZjjg7vGH82H2eHDrDVVUapsz+P2cNeAsvEFYVQPp7FRX7ewIqP2cft/rIGiT
         p3/ijUlDV6ahNouCF0fnG5dslJhK57JdIju0IIP6qMqk+GQzT2VkjJ1crj5awJ4nlwPp
         iFthXcC4G9xoIuc3CGF7mvV/oKqI1U+W2FowrhXijyKtxIZMLbjksr7P+LPb/HCUDkvk
         qIuQ==
X-Gm-Message-State: AJcUukciFzDt42M+LJ96cTlyFiHOBQ7iV70wfuT0EcbftLoFAk86LR3M
        3+hjjEaFM9KJnoiDg8LV7IBLbg==
X-Google-Smtp-Source: ALg8bN7UVAL7icmbxqORM5x4KsmAGXvR5uUv5jiazl/JqvjMooZpjEqBfy+exgIarbdYozwUl0LTpw==
X-Received: by 2002:a62:44d8:: with SMTP id m85mr35803562pfi.164.1548950754547;
        Thu, 31 Jan 2019 08:05:54 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b2sm10144732pfm.3.2019.01.31.08.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 08:05:53 -0800 (PST)
Date:   Thu, 31 Jan 2019 08:05:51 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        rohitkr@codeaurora.org
Subject: Re: [PATCH] qcom: apr: Make apr callbacks in non-atomic context
Message-ID: <20190131160551.GD2387@tuxbook-pro>
References: <20181115184904.27223-1-srinivas.kandagatla@linaro.org>
 <20190131011649.GA27190@builder>
 <7555094b-350b-b4c6-47c6-507f7ce99dc5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7555094b-350b-b4c6-47c6-507f7ce99dc5@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31 Jan 02:44 PST 2019, Srinivas Kandagatla wrote:

> 
> 
> On 31/01/2019 01:16, Bjorn Andersson wrote:
> > On Thu 15 Nov 10:49 PST 2018, Srinivas Kandagatla wrote:
> > 
> > > APR communication with DSP is not atomic in nature.
> > > Its request-response type. Trying to pretend that these are atomic
> > > and invoking apr client callbacks directly under atomic/irq context has
> > > endless issues with soundcard. It makes more sense to convert these
> > > to nonatomic calls. This also coverts all the dais to be nonatomic.
> > > 
> > Hi Srinivas,
> > 
> > Sorry for not looking at this before.
> > 
> NP, thanks for the review!
> 
> > Are you sure that you're meeting the latency requirements of low-latency
> > audio with this change?
> 
> Low and Ultra Low Latency audio is not supported in the exiting upstream
> qdsp drivers.
> 

Sure, but we want the design to allow for that still, either in future
upstream or by additional downstream code.

> Also it depends on definition of "latency", is the latency referring to
> "filling the data" or "latency between DSP command and response".
> 

I'm referring to the latency between the message from the DSP until we
give it a new buffer.

> For former case as long as we have more samples in our ring buffer there
> should be no latency in filling the data.
> For later case it should not really matter as long as former case is taken
> care off.
> 
> Low latency audio involves smaller sample sizes and no or minimal
> preprocessing in DSP so am guessing that we should be okay with responses in
> workqueue as long as we have good size ring buffer.
> 

Relying on more buffered data will increase the latency of the audio,
preventing you from doing really low-latency things.

Regards,
Bjorn
