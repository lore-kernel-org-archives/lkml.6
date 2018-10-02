Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857D3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3076E208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bw84vKsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3076E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeJBOCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:02:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36871 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeJBOCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:02:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id az3-v6so331020plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=3iWfKK11EXdx40BLXc84u1PmKHb/02aUkSQa1evr1kA=;
        b=Bw84vKsL3tX27UGC7s413oJxE3zx8ozyyu7mTqFIjS2MYf60FsVLKixO7GSZLnprZy
         +LttYcpbitPeAof61SMXJrgXzHAfT0iD9akTGK7GCWG410m7iZAlSZTebb1nS9an4Mdp
         3tIk76THN7b5vV26B3pHwHHXjWXhaVWRAsdeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=3iWfKK11EXdx40BLXc84u1PmKHb/02aUkSQa1evr1kA=;
        b=lfoGBT40aH3rPpyO2eaNmG1CbsYuGsLpYBw7xbUuUNErXhFjulOz7sLZogqWOlSBoE
         2Iy0B77dFHhEHkZ1a9Ftxug3DvgvKY3qjquZ57rpRe5X2FzVn5NhK6FokE4+V6D0hG6E
         7kTUq8229hzw/Ybhzh2jNN/5JzZxEdTskaX2lYQFxolCakpcU9GCKaMUJVDwHMPCdefO
         jAO132hF1ZS8pI57twiUZrrToKgLW0oHk6VAlCXgfp5J66HO1mvrTG1Q71gvodybZr78
         uZX0RQb9lW699HMwUv+OMiMcyuIXQbDG2LalDM9BPB/NJeho6Eq9EZPy1HvfnFbLHZDP
         CIYQ==
X-Gm-Message-State: ABuFfogf/rWErYYo65QqNwCnRE8Cu4CQmGc/4Rx/AFNhtJJjZKAnzLzq
        FX9jU3Y8nLWoCSGM/uPMFJeaxg==
X-Google-Smtp-Source: ACcGV624p8k1HVdbIUgbgyNg26jfk9WAvf0dDRtDJvOFDWr59xCXJELwbU8t9FVAlgsta6rOOWC2Kw==
X-Received: by 2002:a63:df06:: with SMTP id u6-v6mr8378953pgg.202.1538464850056;
        Tue, 02 Oct 2018 00:20:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id y86-v6sm24964486pfk.84.2018.10.02.00.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 00:20:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Brown <broonie@kernel.org>, Ryan Case <ryandcase@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181002013142.209751-1-ryandcase@chromium.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Ryan Case <ryandcase@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20181002013142.209751-1-ryandcase@chromium.org>
Message-ID: <153846484865.119890.9647250280891039183@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date:   Tue, 02 Oct 2018 00:20:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Case (2018-10-01 18:31:41)
> From: Girish Mahadevan <girishm@codeaurora.org>
> =

> Bindings for Qualcomm Quad SPI used on SoCs such as sdm845.
> =

> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

