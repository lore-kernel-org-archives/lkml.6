Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B141ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196F420850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ry+FER4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196F420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbeGRGo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:44:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33746 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeGRGo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:44:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id b17-v6so1695587pfi.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 23:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YbPU0MCZ80y+82Mxb9ofSrYqFEA+hlTaSeGHuhvsHCw=;
        b=Ry+FER4j5mH1l0ojU/aZxdvbj4+QoirSxsQD9xg+697F1xy88kTvmbs6ecE82OANvL
         LSHgYCN7FTo+Wk8SXhOMFwmiXgG8W0ppiyZ7DwpSOe/zlWw8D/uqWCFEVZ2XXCJMu6oS
         eEvODDDOZS4e80Mhq5AUVGQzbQCAnAKIk0Q4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YbPU0MCZ80y+82Mxb9ofSrYqFEA+hlTaSeGHuhvsHCw=;
        b=dhFs4BIfyRAkCbYhH1XKGdEzjCHIANTdn4KsE1RNR3hLPRmJSbAQ/qCTCkB9a/UpqG
         yCeTm0ce4lcWozBfYLXsPFpZzljwSuKjRWrBzYgsu/EcAZUN+d6kwcF7FcdWTi4qRT9J
         793o1iwwfYmKu1RAZJ+teBTi1CAmIZu15jsVKGd+uc4o1+OAIdRYOcnuT/z5CpeqDUIA
         a21Z0zYl49VS7rDgfEP6HzncToSD3lrXMShOwM9uOPAjfhhCEplKtuis3g4WdXgoA8i1
         DbKojioADubTcdhaRf2ApDogTEk8c8bH8shbW3XaoKw/Y1j4tBlkPvEuVTUPtKalrq7j
         kF2Q==
X-Gm-Message-State: AOUpUlEw9DfNZHyhMVhHUE9ni9m27I9c5YEWubsk4yFqkS6hqbW+wCMj
        AOTSTZA+FAgTMI491ipNHXnzXQ==
X-Google-Smtp-Source: AAOMgpdbckrQ/Iu98D65+zDcEkGTFW6n10DgOD3yEVfMzmHnnu56TlcNJ+EV3VhsGpEBGoCDbHt+EQ==
X-Received: by 2002:a62:1314:: with SMTP id b20-v6mr3861942pfj.230.1531894094785;
        Tue, 17 Jul 2018 23:08:14 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id m15-v6sm8691612pfj.171.2018.07.17.23.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 23:08:13 -0700 (PDT)
Date:   Wed, 18 Jul 2018 11:38:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     arm@kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] arm: dts: qcom: Add missing OPP properties for CPUs
Message-ID: <20180718060812.vgmb33zws5nbwjd6@vireshk-i7>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <9f9cc23d1fd17503c9056d62f7757fb9c412d1f9.1527244201.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f9cc23d1fd17503c9056d62f7757fb9c412d1f9.1527244201.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-18, 16:02, Viresh Kumar wrote:
> The OPP properties, like "operating-points", should either be present
> for all the CPUs of a cluster or none. If these are present only for a
> subset of CPUs of a cluster then things will start falling apart as soon
> as the CPUs are brought online in a different order. For example, this
> will happen because the operating system looks for such properties in
> the CPU node it is trying to bring up, so that it can create an OPP
> table.
> 
> Add such missing properties.
> 
> Fix other missing property (clock latency) as well to make it all
> work.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Qcom maintainers, can you please apply this one ?

-- 
viresh
