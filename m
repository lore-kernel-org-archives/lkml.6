Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99776C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AE720838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e77N50tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AE720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbeLFEUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:20:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39726 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbeLFEUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 23:20:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so10026692pgl.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 20:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UobFFfiPAS1biiiYmE/OBn8y+WiYbYOfLhA6baxH0i4=;
        b=e77N50tkDJDmdGCF6zEYtmfWYhk/uNw/EBhGE50b/nEGGbBEN6fdQ/PHLXcI7m7UrU
         Drza3PScWqdXhhMWKtf3Pji/nIpxlnY05oNq1OqhWrVgAeP/rP0cCQzJyH3kWteSWirZ
         He3/J2twtT7oCh/Y3cWuaQVkEcPBDqXTP7F0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UobFFfiPAS1biiiYmE/OBn8y+WiYbYOfLhA6baxH0i4=;
        b=kDmV9pcT7+zzVCY6nmYnTpBScHsCUvNp11+Fldz22US4IjsY+rTwOQIIjS82XF13ge
         ZAZORlPtZFcLPeK2xSZ8g06Qj4BYjdhB3vhXlysV2IZbm6/VEpzrXLTYCWvxkGasRsbj
         Eta73z5hH0rMT7qnmMO7oTqxLwie/2KCHH5P5TxV3LxIBLuB78FAac/NALJZn2pcchqi
         1giI964tVcOTtGdPWTEOME/N0cpVHdYqzVsVFuKengtkY3uej1lywFI1Lk/EA3vZ8ezx
         5QyvGtVgWjYXQetxPJmkVOt2RCXDN5bf54yf/5AWKfl+f9MyjFzW4b8j5o9joQE50EZN
         SCyA==
X-Gm-Message-State: AA+aEWZ8kBeWQhLp5Obbn25W2WdR4TY0PiBRqGCBIw2/a4+m8oxTJL1b
        l1LGqXS6GW18Xjl1xe1FAR4PQw==
X-Google-Smtp-Source: AFSGD/Wmc+gFmE0xvYIZzIwrkwi95Bx2PEJN8ImJ1cGtDlhzonS9jG1QWVP7ywUZh9FiDCgkImu0kQ==
X-Received: by 2002:a62:1f53:: with SMTP id f80mr26967882pff.92.1544070029555;
        Wed, 05 Dec 2018 20:20:29 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id x3sm36178266pgk.18.2018.12.05.20.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 20:20:28 -0800 (PST)
Date:   Thu, 6 Dec 2018 09:50:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: nforce2: Remove meaningless return
Message-ID: <20181206042025.njiw3rzmgmzb6ki4@vireshk-i7>
References: <20181205155751.15945-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205155751.15945-1-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-12-18, 10:57, Yangtao Li wrote:
> Delete a line of meaningless return and some useless blank lines. In a function
> whose return type is void, returning on the last line is not required.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Changes in v2:
> -revert modify of MODULE_
> -delete some blank lines
> ---
>  drivers/cpufreq/cpufreq-nforce2.c | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
