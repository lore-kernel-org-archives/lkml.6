Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7CCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F36520855
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g5aRG1fE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F36520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeKJJp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:45:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43181 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeKJJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:45:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id n10-v6so1504980pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 16:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=hy61I6bNOSvgGHwG1tOvJ/t+XVq58jSa5hwn4m3BR20=;
        b=g5aRG1fEHkxuVO+uF78IRaKCO5op9tKxcaDOYtxRUf6D/0Jj6DiISEkeI4gOloz2sx
         DxFzfsekUKO3C+egE34bYR/l1bDlRwJk2rQbXPjKNxCzgwXgONQfBB6Il1rfzq+tVhKv
         A+huxjsfL2TEmv5g7/3pfqE1pe4lHr5Cb3yS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=hy61I6bNOSvgGHwG1tOvJ/t+XVq58jSa5hwn4m3BR20=;
        b=rqtHgrysRPmsjUlwDevUDpUFnbaGbuQDwtZxqze6+NfPNQcD4FS4omc4dq7t+OVQxI
         zRoJ/joBtZqGfaTYm0rIFx3kAE9R1qbO5ujQDoPmYzLpjaUVALRjAmnp/foq/IUESi9d
         fGE73NelkVVh/BeEqu8V1uovfuuOp9YkazurUQ3bpJhPgTcAe9tYKYlYWL15+10zZcvq
         YPFnbjs2acpOfnZw9Vrn/GshJ9bKrhBntZVkeDdz6v3urg/6SoJJAxyxZX1ufBtlZUsN
         XSSyvWcZ+Bwj4v33k5fEJ+gfl6mCZ2wNKKSLDTynkH9IZW5bHItywxdvTpa7oLQSbm8/
         z1Hg==
X-Gm-Message-State: AGRZ1gJyhuK2vOPIfIjrRKZh1Qui1PKFuafs5oKhs76L1hZxPZ6tk793
        lkZed4Ejx+wQPPWfZFaMd0UeIA==
X-Google-Smtp-Source: AJdET5cU0cBfKx23wU3qvfy19kOv6CvVGZHhn4y+flhSkyS+TheM3Sj335QSuriB1ZrFy72+ml64lQ==
X-Received: by 2002:a63:e915:: with SMTP id i21mr9080089pgh.409.1541808183233;
        Fri, 09 Nov 2018 16:03:03 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id l2-v6sm6745460pgp.20.2018.11.09.16.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 16:03:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181109235212.111169-1-evgreen@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
References: <20181109235212.111169-1-evgreen@chromium.org>
Message-ID: <154180818197.88331.4465955446689131055@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add gpio-ranges to TLMM node
Date:   Fri, 09 Nov 2018 16:03:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2018-11-09 15:52:12)
> Add the gpio-ranges property to the TLMM node so that GPIO hogs work.
> =

> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

