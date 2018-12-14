Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60509C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA2420892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpNm40GJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA2420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeLNEmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:42:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36204 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeLNEmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 23:42:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so2212102pfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 20:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xmB9+EdxZMOL0QapvQAJVb2Nc83UeB5GuMqXc76N6Xo=;
        b=QpNm40GJwcnVdDdHqRHFlnKVkHZS2o9WPGHin0jIOVNrchc1CcwzVdSA73U40dsjEX
         URTaYKHNxwj/8UJSqXdDXUhn4v+GCVD9ms+kZVnqBVf+1/+VHWEd0HqD9DLB33EXmuu6
         +quC4MYIls515YYqRrv3jKCjkzG+cHFppnrgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xmB9+EdxZMOL0QapvQAJVb2Nc83UeB5GuMqXc76N6Xo=;
        b=N4qQH93fFc9BRe2unm43/dOEkFPKaPBZD3XrxDAvm96vJq+ha8/99yybjlsh9S0Cfx
         wn5WA+mK2jnIuAmvxfxo7v0QoToxM+EfSBwpLx9t6FtlNMP03poDM6jEbN6g1TW3DwUB
         +MaIhLS2355OCMnYaIFCqrregGxQ/r1yMAHdIqE12gkJ7Tv6YcOKsWi+rTzwZao7BchI
         +yTnaxt/F3oPJh9C9YNQJJpVMBBbfHUGA5iJI5VVpGV7IRAoBDgWynMVldmqp3n1E9AW
         KVjK2geiXa/X5WkNVatJIaxu/Z6jfdtyH8QGAwvo91V79/1c+N9pFkvmdC62ttzANSvu
         sGjg==
X-Gm-Message-State: AA+aEWYIsGWTqPpUuUEFU4q/U87qJnX992IS9U7ILPW0d2hMaR8aLRm/
        3l3+BOYF34Vk1WFGvnQd0ucNZw==
X-Google-Smtp-Source: AFSGD/XGhLvwe5krrUM1pWH84no7CVWOxOqCMv4AOr9Jx+a3gThHbp3E2aNk15d/Bnj18cljzhGpRg==
X-Received: by 2002:a63:a064:: with SMTP id u36mr1443468pgn.145.1544762538037;
        Thu, 13 Dec 2018 20:42:18 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id p77sm5695789pfi.85.2018.12.13.20.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 20:42:17 -0800 (PST)
Date:   Fri, 14 Dec 2018 10:12:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v13 0/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
Message-ID: <20181214044213.kae2yhogbrgomyu6@vireshk-i7>
References: <1544760624-12874-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544760624-12874-1-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-12-18, 09:40, Taniya Das wrote:
>  [v13]
>    * Update Documentation binding to #freq-domain-cells in description.
>    * Replace devm_ioremap_resource() to use devm_ioremap() API.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
