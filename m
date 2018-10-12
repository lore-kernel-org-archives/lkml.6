Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34851C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCECD20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWS1RJjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCECD20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJLLJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 07:09:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42400 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeJLLJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 07:09:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id i4-v6so5146039pgq.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 20:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VpjNeQKHTnltOQHRbPEIXs8j04MXHt8bRqmOw0HdQIw=;
        b=WWS1RJjWz87fXvMdz07TVuvrL7+xdsZNdPvbLHhgMSPqKgj/KK0ChVtbC4BN8vHCWL
         bh1WUHmep7CgEQaejOitnVYOo6u+eEbMS82W3kMrSQuv5uMghMxlA3G1g0fGRNYJD4Mi
         Eh+CM5E8m0vJiWbyXh3NKs7evR0/FTEUwTbnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VpjNeQKHTnltOQHRbPEIXs8j04MXHt8bRqmOw0HdQIw=;
        b=scJx+RH4JMYpLNNuZS6l12sN2lMkSyro1RSxXP/LJxwnIU0KhoUKxoDtWPtaHyQd7G
         EL3My0qbF8G6ZKaCzZS4HcauGr8ZahTV7q7C/0bXJIW5moN6o1dad9/jVsWA/MzfWqJ8
         h8PpC51ouLAmmlnwDDkU0wt+gBFBImDkJGhJHHQbDq+CKpB92MpEXciY9FrRO5s0tLzu
         2I1ipPNGGatz4nIA1UGI3mIhKqPuCbU4bS424w+zd7cU8wR3dIYy0Hc55WmIhCMwtl7C
         P6gvxKobVeA+NYlXujMg8O1TuYhnQnm9ykgfPy6dG3DqSVPxLDicHaVYhcqynxgIO7v4
         ILgg==
X-Gm-Message-State: ABuFfohApY8ntZehx4jid0rv6tNNCoBDCiRRrdBdFY13xoWMD/AFfJ1g
        hZ3gGuIn2XAoM0Guwbvc2n7zm1VBTg==
X-Google-Smtp-Source: ACcGV62kn7p/AI/DQ3fUs3FyCtzIMU8e+9HOEnJSQJ0ZFdSoTg+C299lkBp9+voNG/pV0pAnaKi2Sg==
X-Received: by 2002:a62:3942:: with SMTP id g63-v6mr4466851pfa.170.1539315546780;
        Thu, 11 Oct 2018 20:39:06 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:902:ab1e:5434:2d24:93e3:3797])
        by smtp.gmail.com with ESMTPSA id s23-v6sm34885306pgg.67.2018.10.11.20.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 20:39:06 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:08:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        xuwei5@hisilicon.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/4] Add clock support for Hi3670 SoC
Message-ID: <20181012033857.GA5438@Mani-XPS-13-9360>
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 11:00:59PM -0700, Manivannan Sadhasivam wrote:
> This patchset adds clock support for Hi3670 SoC from HiSilicon utilizing
> the HiSi common clock code. While adding clock support, let's remove the
> fixed clock for UART and source SoC clock on HiKey970 board.
> 
> This patchset has been verified on HiKey970 board.
>

Hi,

Any update on this series?

Thanks,
Mani

> Thanks,
> Mani
> 
> Manivannan Sadhasivam (4):
>   dt-bindings: clk: hisilicon: Add bindings for Hi3670 clk
>   arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
>   arm64: dts: hisilicon: Source SoC clock for UART6
>   clk: hisilicon: Add clock driver for Hi3670 SoC
> 
>  .../bindings/clock/hi3670-clock.txt           |   43 +
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |   48 +-
>  drivers/clk/hisilicon/Kconfig                 |    7 +
>  drivers/clk/hisilicon/Makefile                |    1 +
>  drivers/clk/hisilicon/clk-hi3670.c            | 1016 +++++++++++++++++
>  include/dt-bindings/clock/hi3670-clock.h      |  348 ++++++
>  6 files changed, 1458 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/hi3670-clock.txt
>  create mode 100644 drivers/clk/hisilicon/clk-hi3670.c
>  create mode 100644 include/dt-bindings/clock/hi3670-clock.h
> 
> -- 
> 2.17.1
> 
