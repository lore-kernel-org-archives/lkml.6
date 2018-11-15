Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C241CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAB8208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0wQq7DB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAB8208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeKPF3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:29:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33974 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeKPF3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:29:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so9177704pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dqSOkVng3lktMkDtP7wdxQ3mPWCG0rE5nTxELDTfKco=;
        b=V0wQq7DBfDTdPD9OjMH91zAXdzIxBVfPRdc5bNGfTNU+aDJSGgk/QExePaWqv3tmS4
         2XE3iRhQYKECcFYBfNOZrluQkLbD56MOt4n7blG+k6cLvrQD8JEsAPu3Ev4LEWm4ISdO
         jUgz/ewsTHxWU0hfLNRBqzBbN7+MPZBtwk3tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dqSOkVng3lktMkDtP7wdxQ3mPWCG0rE5nTxELDTfKco=;
        b=JNEsSZg2CspVVK8rj0bsaKDOE3IZfyoUdQwwa5o8l5tpUmF4K0l07gG1SXFLKgWGv2
         8qwqYQVR1KoVWPawXusn5keEgPf/8khN2/YyE1lX8Pg1zpWyClJS4C9YY50wRox40rdt
         ZPzIsyDFVaoOSPZSA2q31N3JE1T7gi77Ypb1nmcOyNs5saHFUR1evLZWdQz7z/YtDu6Z
         dkjtriORxwpm6IY+5NHbdiYNDI6u+b5iFdrlxLQjDd+DQDYYI2aNs7cOoByVKjgYp0zX
         ay3vqx6qG4d/b2CsL/+PWFvYmuzkbSfY9A3I82MJgIMWCUgjLIs9jgNChD88jfF0lUDa
         HgFg==
X-Gm-Message-State: AGRZ1gLcN4pqrvJHMDGU4uNp9Ul44GtTk31cKcdW+M9r2i3s+9jiFB26
        mFPeOmxdYsOnDgNv8/d4OMXN3A==
X-Google-Smtp-Source: AJdET5cOxAxALzFcwLvpewtHIxkeP3AELOnoHz3434oYo1CvsRBo6jwFhWLLyc2er7o5K7JAR5nJgQ==
X-Received: by 2002:a62:2cca:: with SMTP id s193-v6mr7632504pfs.10.1542309611030;
        Thu, 15 Nov 2018 11:20:11 -0800 (PST)
Received: from localhost ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id r8sm28405902pgr.48.2018.11.15.11.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:20:10 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:20:09 -0800
From:   Andy Gross <andy.gross@linaro.org>
To:     Vinod Koul <vinod.koul@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v6 0/2] arm64: dts: add prng-ee nodes
Message-ID: <20181115192009.GB17484@hector>
References: <20181001062151.27607-1-vkoul@kernel.org>
 <20181115034518.GG3060@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115034518.GG3060@vkoul-mobl>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 09:15:18AM +0530, Vinod Koul wrote:
> On 01-10-18, 11:51, Vinod Koul wrote:
> > This adds prng-ee nodes for msm8996 and sdm845
> 
> Ping Andy, would appreciate if you can pick these up.

Done.  I did have to massage the location in dts for both of these patches to
keep the address order correct.

Andy
