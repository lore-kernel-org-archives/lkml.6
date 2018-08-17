Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1F5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E06121878
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E06121878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeHQSMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:12:48 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35833 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeHQSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:12:47 -0400
Received: by mail-io0-f194.google.com with SMTP id w11-v6so7178653iob.2;
        Fri, 17 Aug 2018 08:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QsN1P37kMRVUuTKff+S8sglejH6PFBfE3rNp1p/knB0=;
        b=nhnQeyFKAXGd1zi9NYK+GRove9UboF5/MJ9a8QBlKYsKrKmEqs4tTVe+QEQ/GTQ20B
         Q8S45xNNih3duRfy9OFB+uonC13Bqq6eq6a1OQeyhOxNpTAssyDFJXEeN8rk+5IFUqw/
         7scDVIEXhiIcaIk8ry8GhNExOPgsvaCfOC8egHzVW00s/IcagpcQvNJq1tfxF+6SnrUq
         eOPNg/lyIAl+B2ig+qc4b9TJYY65J+l9RqMy6SBLZ5JFkVB4pNY2FCoEBkMpvGDFX+vO
         CfAyBMJ9pnBAdqKFK2U+dqsKJecT+1RIdTrsUJVHr1panMQhcHcBB3R1+l8/xw05eHyl
         xTsw==
X-Gm-Message-State: AOUpUlGtGi0KI89UpDTIfYROzCFd4CdwWOJ1n3Jd4OrAnzQDVj5/BTmN
        V6tBPH12wDJC4PkatbSXQcgzUUs=
X-Google-Smtp-Source: AA+uWPxjRVqcrL39XcoclN72UslsHGtHauQluAgBapuQ2xIzH08WZaHXJ63rnzKyktBR3hKgvzyDfg==
X-Received: by 2002:a6b:de09:: with SMTP id v9-v6mr29806186iog.10.1534518543698;
        Fri, 17 Aug 2018 08:09:03 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id f12-v6sm909872iog.32.2018.08.17.08.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 08:09:02 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:09:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, sboyd@codeaurora.org,
        linux@armlinux.org.uk, thierry.escande@linaro.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        niklas.cassel@linaro.org, sricharan@codeaurora.org
Subject: Re: [PATCH v12 13/14] cpufreq: qcom: Re-organise kryo cpufreq to use
 it for other nvmem based qcom socs
Message-ID: <20180817150902.GA19164@rob-hp-laptop>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
 <1534248753-2440-14-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534248753-2440-14-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Tue, 14 Aug 2018 17:42:32 +0530, Sricharan R wrote:
> The kryo cpufreq driver reads the nvmem cell and uses that data to
> populate the opps. There are other qcom cpufreq socs like krait which
> does similar thing. Except for the interpretation of the read data,
> rest of the driver is same for both the cases. So pull the common things
> out for reuse.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
>  .../{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt}   |   6 +-
>  drivers/cpufreq/Kconfig.arm                        |   4 +-
>  drivers/cpufreq/Makefile                           |   2 +-
>  .../{qcom-cpufreq-kryo.c => qcom-cpufreq-nvmem.c}  | 124 ++++++++++++---------
>  4 files changed, 80 insertions(+), 56 deletions(-)
>  rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (99%)
>  rename drivers/cpufreq/{qcom-cpufreq-kryo.c => qcom-cpufreq-nvmem.c} (65%)
> 

DT bindings (including binding headers) should be a separate patch. See
Documentation/devicetree/bindings/submitting-patches.txt.
