Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35E5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D8A206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sbt1QaHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D8A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeLDQq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:46:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36726 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:46:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so7632449pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=JWEeeh7ktMDf9DW6dKh8hv3Rz/O6CjCtl7hkELGzH9Y=;
        b=Sbt1QaHzPMSFYMr8J2xcjDZe5vvtUOTxLVBxXz6nmIMZ84e5ghicGN6R95ilYmE7zz
         vl1JU8zcwnZPrIZXZKWIw6W+PwSpJ6qfnuFpazWJFiNNmxcEPpjJuAPMonZ8ieM30tDX
         7h+IITG21dXo17lW1zSU/F9FQF3Ir0pfIWcqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=JWEeeh7ktMDf9DW6dKh8hv3Rz/O6CjCtl7hkELGzH9Y=;
        b=XfiyPS/7qnYoe/KfhY98Oeyy8qpLB9UgXdPdTfqDnSkp97qvQH5DRB5gl98kB0jMpH
         6CKWhzHaiCS8z5Yv66polCpG44KnNMdBJmIiBwAK/AeFfbSx5bNkjidDnWyDdmbmILP1
         Ve4j8HN6xOAbBIornC1RFNSodRjU6+Txe2+CJIGHqdjhu6beTHSqsM7jRxA5zTjriIPw
         4j4+TclZFg+5Dvrahuuqo1pjDNf3fmJZTftjPkZrPu2aRx5wEv2370jMjjtzJ6CJGwdy
         7xpMbVTlUDavEhCX0R93aPbKxiVgfK6J+oVpjRg6C418YYy3njlrHMP44nUG30MjdBLR
         KAYQ==
X-Gm-Message-State: AA+aEWZITQw28M0X+0zLW7tsg2G5ZZHsHdbG3I6JRnZw/LdZHKUPW5gH
        KJMm6ZYBi8lRpGkgU8n4+slqVw==
X-Google-Smtp-Source: AFSGD/UdsEX4aHCGHnmaCec6T/tAoJHaHkP5qOGf4XYia6xAAU5KUUBgcH/65sl29jCjasBPJxM72Q==
X-Received: by 2002:a63:235f:: with SMTP id u31mr17203687pgm.122.1543941986665;
        Tue, 04 Dec 2018 08:46:26 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 78sm23001958pft.184.2018.12.04.08.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:46:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181201005254.139908-7-mka@chromium.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
References: <20181201005254.139908-1-mka@chromium.org>
 <20181201005254.139908-7-mka@chromium.org>
Message-ID: <154394198550.88331.230677771077664270@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 6/8] arm64: dts: qcom: msm8916: Set 'xo_board' as ref clock of
 the DSI PHY
Date:   Tue, 04 Dec 2018 08:46:25 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-11-30 16:52:52)
> Add 'xo_board' as ref clock for the DSI PHYs, it was previously
> hardcoded in the PLL 'driver' for the 28nm PHY.
> =

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

