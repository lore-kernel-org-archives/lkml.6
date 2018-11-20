Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15268C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC704208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HU6qKGTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC704208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeKTTpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:45:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33191 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeKTTpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:45:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so5488pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 01:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aMeyIyaguMhD5iGlEmNOaT3eb3ZgThhc+yd1X2UTIwc=;
        b=HU6qKGTafwfuCYwxrrf3WkEk8Z/NRCzKvl2P9STWNb5AxWcDrRLPjIgk5ZxhJh96W/
         Wr2d+wkGpxBTsusTSMPpcXX9rqC5l19B7HmSjK/eBASe/OmFUpl5MUL2nGSUomX9nTKW
         KP3GTDWeMJtqgsCJpnH1yheS/u4pX7AuLDCEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aMeyIyaguMhD5iGlEmNOaT3eb3ZgThhc+yd1X2UTIwc=;
        b=HWqbGM3F7xFZHYCJlFGodI+kopS0xamUxbtXa+oP5voGCgfZkd2821n+Puk9aemMMd
         M5I/ewy7Ee9E7Um6siqdz7aqsdO5nCcCgQPlSTErsLWk2Qq9i8JoLG9lSVxoDaLx1aZ7
         poMjvBH0q7JFtUY9jjKyn9fez+Vpx8y3eGPeEsdhHQzqPe+vQkPLjBZd4c+8Jo7C3myj
         D6mvUHkQjo2sOqVU5WSvrTS6/Xqy7Hlky6uPMnJkrLpK7HhSFJc2hy+pZiiwoXYdEGaE
         buo7VoVzWPAEigmzgNE3c70TL8rDTxxxPGvr62kurJjT7Yhoyd3PCvj2of7fIqU/QYI7
         AkWw==
X-Gm-Message-State: AA+aEWZiyTx1cMu70iXJYYKMpiMyH48UjjEMirAoJva6+xhmEgYDiNNX
        auJypKIjbE7C6ajM6chZtCFIcw==
X-Google-Smtp-Source: AFSGD/V1UDihNou9XMWZFmeFEhLzJNFwEOTn+CtzQ+xtw287UNekMHHQ8Xf9iHfuZXFaQi2++p96QA==
X-Received: by 2002:a63:170c:: with SMTP id x12mr1158879pgl.364.1542705414076;
        Tue, 20 Nov 2018 01:16:54 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id n22sm56857707pfh.166.2018.11.20.01.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 01:16:53 -0800 (PST)
Date:   Tue, 20 Nov 2018 14:46:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Michal.Vokac@ysoft.com, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org,
        l.majewski@majess.pl,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>,
        vincent.guittot@gmail.com
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Message-ID: <20181120091651.cqqqi3tr43q3jnp3@vireshk-i7>
References: <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <CACRpkdZAew3bUea=iR4t-a7SVSMf=-CTeWfeU215uT_jQ-o81A@mail.gmail.com>
 <20181119083230.re3dtq4alnrojbnd@pengutronix.de>
 <CACRpkdYeSTZSvK9URE5ZvwnGTXVCZad=ptCmUBrbDyozoJnfSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYeSTZSvK9URE5ZvwnGTXVCZad=ptCmUBrbDyozoJnfSQ@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-18, 09:35, Linus Walleij wrote:
> The whole issue with splash screens and different hardware
> turned over to Linux in running state is a bit imperfect I would
> say, I think Viresh was working on boot constraints to get
> handover of different systems components into some kind
> of shape but maybe that stopped short because of the
> complexities involved.

It got stuck mostly due to lack of use-cases where that can be useful.
All I could find until now is LCD and earlycon stuff.

Though things may change soon after the interconnect subsystem gets
merged, as we will have bootloader requirements for each and every
device in that case which the boot loader enables and passes on to
kernel.

-- 
viresh
