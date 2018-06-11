Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E7B40C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E641208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HYeFB3Pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E641208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934134AbeFKRT1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:19:27 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41660 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752768AbeFKRTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:19:25 -0400
Received: by mail-pg0-f68.google.com with SMTP id l65-v6so10064632pgl.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=al+E3Fcg1KTeuC7yAFZApdyfzPaGAeIg1uzoVeFiNdQ=;
        b=HYeFB3PeJxYW9lRAqLAmeNm3wGySQMExjLiN/TBj/u/2L1KDtCnf1jjfjRqf14Tuhi
         lcJAMTqzNapHF1s+bhICPJBSIn3RLiVISUqWbgQkKw/UMuL9kB7fw98AdJWn4s8UJITa
         znk0iCjV9Dhf7CTeZUV3ubvINXrH7zSuMzW+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=al+E3Fcg1KTeuC7yAFZApdyfzPaGAeIg1uzoVeFiNdQ=;
        b=ZwExSPl9URM2uz08/q9PUAx3xLX6XMyDUB/2tvVCQMjmkPUQA1rPUU5ycROBIheDPx
         mloK18se0yG6RGbNMG3HhtdQgOSBc1qbwK3oKxElwvsVuvrkskCo6zO98XzNNCBMyCXX
         SN8pHbLlq6HTA8FA8/VylSMMikDLYwiXeCS+TFM87ileVEABOpQ3Bmh0fueabn30sCyZ
         eBK4/fAWNBT33QuBjgC0a8SirV7tFAbJqBWAj4OxehSU/WH/9Zh5JpwazcBqclNgPxhw
         ZcTCyjhK18vTCpfPA7kitTAH7ljMCOF4kgGSV2VTGLQB0o4NZIVoUkkG2nCcUFCYmBm8
         gSJg==
X-Gm-Message-State: APt69E3WnYjxprBMDInmH9P73WVmmG0yLXqAvAJo4tukGHp41pR/5Bb8
        m7yKe6bU7qqlR9FRxLpTJ0HRLg==
X-Google-Smtp-Source: ADUXVKKM+0JPlNqk3e/sSn4tDSBT1IHVTDoq6qygYggkhf91vJ7k5UxkKDCWjirLuWI9nDJG/UBOpQ==
X-Received: by 2002:a62:1013:: with SMTP id y19-v6mr85339pfi.166.1528737564546;
        Mon, 11 Jun 2018 10:19:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id t17-v6sm57734545pfj.75.2018.06.11.10.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 10:19:23 -0700 (PDT)
Date:   Mon, 11 Jun 2018 10:19:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     David Collins <collinsd@codeaurora.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        sboyd@kernel.org, dianders@chromium.org
Subject: Re: [PATCH v7 2/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180611171922.GG88063@google.com>
References: <cover.1528498807.git.collinsd@codeaurora.org>
 <36e91ad9edeeee2adfe7a4d92675a1d6950f5002.1528498807.git.collinsd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36e91ad9edeeee2adfe7a4d92675a1d6950f5002.1528498807.git.collinsd@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 04:44:15PM -0700, David Collins wrote:
> Add the QCOM RPMh regulator driver to manage PMIC regulators
> which are controlled via RPMh on some Qualcomm Technologies, Inc.
> SoCs.  RPMh is a hardware block which contains several
> accelerators which are used to manage various hardware resources
> that are shared between the processors of the SoC.  The final
> hardware state of a regulator is determined within RPMh by
> performing max aggregation of the requests made by all of the
> processors.
> 
> Add support for PMIC regulator control via the voltage regulator
> manager (VRM) and oscillator buffer (XOB) RPMh accelerators.
> VRM supports manipulation of enable state, voltage, and mode.
> XOB supports manipulation of enable state.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>  drivers/regulator/Kconfig               |   9 +
>  drivers/regulator/Makefile              |   1 +
>  drivers/regulator/qcom-rpmh-regulator.c | 753 ++++++++++++++++++++++++++++++++
>  3 files changed, 763 insertions(+)
>  create mode 100644 drivers/regulator/qcom-rpmh-regulator.c

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
