Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84435C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C572208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlvCNKhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C572208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933100AbeGJJ3J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:29:09 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39901 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754434AbeGJJ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:29:06 -0400
Received: by mail-lf0-f68.google.com with SMTP id a134-v6so17685533lfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 02:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S2u/8m1WWVYxU7l5MWR/hWCWcMYCMg9cs/nkAYIzLmQ=;
        b=RlvCNKhIz+Cy8+UB3NGP0Aqg/VtxVeHWIFIvL66AUvlQmevgdKpCUYx+/JYpMyGLr+
         uer50gqA3L+I12puLOKaWLUr2H05rR/0EkadClYRueLUo2yPRE6inMBYlAS95jrT6hKV
         bHqTFN0AAGc6ioU+M8Awj5sLUv+1RBU2RCWG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S2u/8m1WWVYxU7l5MWR/hWCWcMYCMg9cs/nkAYIzLmQ=;
        b=HwC1QaXkoaLVHrGHsR7z7FI5N+X6qW2sse8d7em5OR8eCv+ipDg0dq1Wdbs2uYFFcE
         I6lnlie57DK+5d1fIGhYg8bkGtFfxMHzb+vRJiN+i7eiCSfTxC7PoTXq7cUVCPG+Z0vD
         BUtIycl9PdIm7QJ7I6oMmFM66HrI7QPu1CXbq7Jia0lLCkYhv0hgC0PF4M5heg98ygl5
         zrlOg6Y9LWSLzd5mFfG4P7h/0bvUsPS7tl5DFqwleujngc6q4yzHF49Miw0czLYlS9Xf
         Q7Dxvi0Z9eDrw+uWt5GDFrttUtwJFZEpaDb+QuJxVE4PmK1rgO335zBbn6Nf1TUZ1t13
         bFUQ==
X-Gm-Message-State: APt69E2KFQvYFD4sjbO/mopcXbGMnH1623WFkedKhvpMW0c0wYX9ri/w
        64RgUQmJ07ap7pcNQ6OuF8Jq0Q==
X-Google-Smtp-Source: AAOMgpf010kSimR57zrgx+wR6QQo1c46zdH7k/pw41/+lRiG9eFXj+6qG26WzI6d4PesWmslqPnwpw==
X-Received: by 2002:a19:5a56:: with SMTP id o83-v6mr2144991lfb.50.1531214943926;
        Tue, 10 Jul 2018 02:29:03 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id b9-v6sm2471911ljd.62.2018.07.10.02.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 02:29:03 -0700 (PDT)
Date:   Tue, 10 Jul 2018 11:29:00 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Ilia Lin <ilialin@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ilia.lin@gmail.com
Subject: Re: [PATCH v11 2/2] dt: qcom: Add qcom-cpufreq-kryo driver
 configuration
Message-ID: <20180710092900.GA26718@centauri.lan>
References: <1527081091-13389-1-git-send-email-ilialin@codeaurora.org>
 <1527081091-13389-3-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527081091-13389-3-git-send-email-ilialin@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 04:11:31PM +0300, Ilia Lin wrote:
> 1. Add NVMEM node for the speedbin
> 2. Add definitions for all possible MSM8996 CPU OPPs.
> The qcom-cpufreq-kryo driver will select the appropriate subset.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dts |   2 +-
>  arch/arm64/boot/dts/qcom/msm8996.dtsi       | 281 ++++++++++++++++++++++++++--
>  2 files changed, 270 insertions(+), 13 deletions(-)
> 

Hello Ilia, Viresh


I tried this patch series (together with you cpu clock driver).

The first problem is that the driver fails to create debugfs entries.

The second problem appears to be that it runs on unlisted frequency.
Is this simply because of missing entries in the opp table?

[    4.538513] cpu cpu1: opp_list_debug_create_link: Failed to create link
[    4.538567] cpu cpu1: _add_opp_dev: Failed to register opp debugfs (-12)
[    4.544514] cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 614400 KHz
[    4.551441] cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed to: 652800 KHz
[    4.563219] cpu cpu3: opp_list_debug_create_link: Failed to create link
[    4.566937] cpu cpu3: _add_opp_dev: Failed to register opp debugfs (-12)
[    4.573489] cpufreq: cpufreq_online: CPU2: Running at unlisted freq: 19200 KHz
[    4.580368] cpufreq: cpufreq_online: CPU2: Unlisted initial frequency changed to: 307200 KHz


Kind regards,
Niklas
