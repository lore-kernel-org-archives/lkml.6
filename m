Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E2BC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B5F2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kCWzTkOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B5F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbeLCWh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:37:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42858 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeLCWh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:37:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so7101239pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=5zknM25FWMPjY4b/sv1I1qz4amjm2RxfjqcY7nK7rkA=;
        b=kCWzTkOiFMGev8jLLooqKoNEhlCk7CLX62Epk5Q3rbwbLphsvqVQPMK5laMgZ0aiCG
         oAUElzrq0/tgjv0Z9HCQx9VBQpiXD58cINLTUoD5gUpklN6838hCwBhj0n/G38WiAtvV
         1xWxnM/sj8Vzqi4/SwywoRbSJeJJpaCYbAG2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=5zknM25FWMPjY4b/sv1I1qz4amjm2RxfjqcY7nK7rkA=;
        b=TkZ3mEIoNMQCGtLAwIU/lhjnXieHoV5TvkrTiwRPLACK+2myyIkhK3GV+7S8/pxzRi
         FFR8ofOEr+IdQXVfhbVfMCeq27YMkDyRrh5Ub98Nqb7i8/dedYG7s2jE3LZBeOoxwBjK
         RLYjdww0yCknxUGamDghIbuMzRRpTAU+dzrhB3SArOg1Iui/dvr4cuYOt5vzeOLa2nzI
         5WaoXn3Hj+RPv3MBfohvijw3dGm1kg0uMu0uSR164GQvXH+zUmBKWg2m5ZB0MXUJ1pqt
         8970yd8XuOxzS51Lzxx8DO5MqS/HIPePUK772LOK93hTEcKcNvyt8mPmrtyGkI3TPoCV
         I6Ww==
X-Gm-Message-State: AA+aEWZnHrEsdRX4zLrkTcnQu5Us5xGiw7nHs3h3KElHU2k1hoDYy4RK
        yCvBTq53BDLHIXHF7nY/laRLsQ==
X-Google-Smtp-Source: AFSGD/UQBF2KBLrQLj5SKREXFpP7R5BQv+xr1AFsqME8U02Kqhare0/cZ7LPyXdfRm8VNW1oGwg6Dw==
X-Received: by 2002:a63:b34f:: with SMTP id x15mr14973620pgt.243.1543876646112;
        Mon, 03 Dec 2018 14:37:26 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id y71sm24720661pfi.123.2018.12.03.14.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 14:37:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181129221357.67417-2-evgreen@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20181129221357.67417-1-evgreen@chromium.org>
 <20181129221357.67417-2-evgreen@chromium.org>
Message-ID: <154387664448.88331.2728522404504674597@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 1/4] dt-bindings: phy-qcom-qmp: Move #clock-cells to child
Date:   Mon, 03 Dec 2018 14:37:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2018-11-29 14:13:54)
> The phy-qcom-qmp bindings specified #clock-cells as 1. This was never used
> because of_clk_add_provider() was never called, so there was no way anybo=
dy
> could reference these clocks from DT. Furthermore, even if they could be
> accessed, the bindings never specified what should go in that additional
> cell.
> =

> Fix these incomplete and broken bindings. Move the #clock-cells into the
> child node, since that is the actual clock provider, and not all
> instances of qcom-qmp-phy are clock providers. Also set #clock-cells to
> zero, since there's nothing to pass to it.
> =

> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

