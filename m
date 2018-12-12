Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B87C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5CB20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 04:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6d3A0bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5CB20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeLLErJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 23:47:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42167 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeLLErJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 23:47:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so7726649pga.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 20:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G91H4j0lY0PH4g+lksAHoXtvYfWCxP6EW2hfRI/3F64=;
        b=C6d3A0boDIG8YEQ6kApbZoc4cn/+uNovGU271xomISPv1NgQzWgKsT46GXZgc/9CK2
         /UySF4E+nhVb14At/2N5Qnzs5dT/gY4rEiunJjaN3Zp+T5Ad75QZZTxbTabQr4j3Iujy
         5I9rwRLxd/PTQQOSU41GXOPA8eV66b+T/PIZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G91H4j0lY0PH4g+lksAHoXtvYfWCxP6EW2hfRI/3F64=;
        b=IXikZFbKy57ryUfZ1v4i3YN8MreAM/HzZRkgkhybT+ImvGkJ/8X0/FCGu5h7WC4vCL
         KcU/Q6MSdMjK2JrwTI2rm/woHGhpcdsxewI3VPMPMdndzAjJJbrzcCcWoOdECmtnc42/
         3y18a/WSHbJv/2id2b87uJCy8JVz8JRbyPABXQ4H8SPNRncTSIaPMpAT1JrSShO//6X7
         Krpcp/8zrssavHWB61AjTCnivvRyZ2ygduJbWyFEqtOC84NJTljVGAKJ7Z/EIykL3XaO
         eNUJw/W01THAJejaN7wvbid2X3CpjgkY/YUTXygNewXwTelMGbqviJlV5VV9S/NPZSAz
         A2dg==
X-Gm-Message-State: AA+aEWYTV3UUBtf8DrTFydmfs1k/Be0IWcDZS4bjTmjyuhZUTkAcsHWj
        MwouMoQ11CgeTHtljUGjF4Z9AA==
X-Google-Smtp-Source: AFSGD/WfSnbYiLMndXmvRoXmDjDe1ScmY3TFB+4cGDK6Pt27A54emgHxP4ahAgRsbR8DxHZwm/eySA==
X-Received: by 2002:a63:588:: with SMTP id 130mr16834407pgf.273.1544590028226;
        Tue, 11 Dec 2018 20:47:08 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id x7sm18517567pga.68.2018.12.11.20.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 20:47:06 -0800 (PST)
Date:   Wed, 12 Dec 2018 10:17:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Message-ID: <20181212044702.jp2r3mviq4ffal42@vireshk-i7>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
 <154396249199.88331.1800559141437859959@swboyd.mtv.corp.google.com>
 <154396472692.88331.13742924031474269133@swboyd.mtv.corp.google.com>
 <49139ae4-4373-9e70-02ad-80f7bbc4494c@codeaurora.org>
 <20181205061600.7zglbpkgbktn27am@vireshk-i7>
 <82b168d1-79bc-f454-8e19-4f7630a34069@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82b168d1-79bc-f454-8e19-4f7630a34069@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-12-18, 19:05, Taniya Das wrote:
> The design here assumes that there would not be any per-cpu/per-cluster
> based SW requirement for the HW during frequency transitions, which again
> makes me think that we would require to re-introduce these structures again
> in case we have such requirements in near future.

Firstly, even in such cases we can go ahead with the design we proposed. And I
am not at all concerned about some hardware which we don't have right now. We
will see what to do when such hardware comes, maybe reintroduce the structures,
but that doesn't matter right now.

> Also I think leaving the structures also helps us debug any boot up issues
> looking at the ram contents of the per-(cpu/cluster) structures with the
> contents from the firmware.

I don't see how debugging would be hard without those structures in place.

> Hope these above helps us to go ahead with the current SW design.

Sorry, but I don't see any satisfactory reason on why you shouldn't make the
suggested changes. We are trying to make your (and any other developer who will
work on that driver) life simple by simplifying the code. Nothing beyond that :)

-- 
viresh
