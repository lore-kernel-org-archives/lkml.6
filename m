Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA32ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A95E20863
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P8HFN9nZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A95E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeGUTtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:49:53 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:42119 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbeGUTtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:49:52 -0400
Received: by mail-yw0-f195.google.com with SMTP id y203-v6so5507011ywd.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y+prbugxWB3Vcv8RmuavVL6v8V3pOtTv5Vq6p45Z+hk=;
        b=P8HFN9nZuc5mDoFctrl3tfqTjYpvWT4LkuswhbgfDJSibbC57jRwKGOfPUecckGQ6P
         6WeghhIeI4+cgpscKzgmg+0hnt14M+GbxDYSwHh0xSsf28JTnxBFN/lhRF08WXG+R22Z
         BL8oFZ2Ym5nIjxfynqvPrxTQ5ccAYr+gRvhBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y+prbugxWB3Vcv8RmuavVL6v8V3pOtTv5Vq6p45Z+hk=;
        b=ov0MQ3i+AcEXa44vSTX+4Y4aaDqOyz1d2ILr5+zsv2m9RfSwx/EWEBvCJbPyBSY+N6
         s3ZwJYLFnBYnalWqHijMCK+ihg/3EAFDmf3j+gfWim+7y3HU8hkYUlNCbMjESbh1twJK
         a5YJIet/yRlE/oHcG0YsbZFDkutwqPf6L2Cv9wOUnA//4CsEp8syOc67hp6a0an0W7i0
         Av/d0PdUS47I1vfNHFpoRXs9MVetFVKTQjpP2mUqQV+XMXNwfIhPyhtluGvxe7t3fx3t
         ILz0iA09pTo/jYS6ugW5+gOZ+LO5pUm0yNPvNGIPARgD4atqYGzbrFPuBzkZfesK/Y8k
         Fdrg==
X-Gm-Message-State: AOUpUlE8X+3R7FriY28tVNlnIcOQCcOh30QpZAxPYpdPEJa57O8C9GyY
        yzgSn7Uwv+CA8bg1w262iyKOWA==
X-Google-Smtp-Source: AAOMgpdsBMlJOJte1SbTZ1u2YiQjdDY0OYaY9ZHydSvXw74IBGVeoE44VM8yvJZG5J0ZMQgYTIHtvA==
X-Received: by 2002:a81:4c8c:: with SMTP id z134-v6mr3544804ywa.395.1532199369238;
        Sat, 21 Jul 2018 11:56:09 -0700 (PDT)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net. [107.207.74.175])
        by smtp.gmail.com with ESMTPSA id d11-v6sm2267912ywd.1.2018.07.21.11.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 11:56:08 -0700 (PDT)
Date:   Sat, 21 Jul 2018 13:56:04 -0500
From:   Andy Gross <andy.gross@linaro.org>
To:     Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, arm@kernel.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/15] arm: dts: qcom: Add missing OPP properties for CPUs
Message-ID: <20180721185604.GI7404@hector.attlocal.net>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <9f9cc23d1fd17503c9056d62f7757fb9c412d1f9.1527244201.git.viresh.kumar@linaro.org>
 <CAHLCerN1Oxz3t53gxvK83A8jQswsPitgm_NjQ4CWB8V02R_LnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerN1Oxz3t53gxvK83A8jQswsPitgm_NjQ4CWB8V02R_LnQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 03:52:26PM +0530, Amit Kucheria wrote:
> On Fri, May 25, 2018 at 4:02 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > The OPP properties, like "operating-points", should either be present
> > for all the CPUs of a cluster or none. If these are present only for a
> > subset of CPUs of a cluster then things will start falling apart as soon
> > as the CPUs are brought online in a different order. For example, this
> > will happen because the operating system looks for such properties in
> > the CPU node it is trying to bring up, so that it can create an OPP
> > table.
> >
> > Add such missing properties.
> >
> > Fix other missing property (clock latency) as well to make it all
> > work.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> FWIW,
> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

Picking this up for 4.19.  thanks.

Andy
