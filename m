Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD290C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F6C20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KTQY3vRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F6C20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeJWRXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:23:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46301 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbeJWRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:23:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so323587pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=fylEEco5pjLtGsGjHcHhLfPg0yEgdiOJYTFObVPB6QM=;
        b=KTQY3vRDe4rFZu9V/AkUQuRLelYh7eb6/RRPAvYzYHef+F9yk/gdxtyNP0lT0ceqtU
         PmdlfcOdxqHshVKYkZ3qYyYDAbkvn8s/0YjVVc/N21FNDL/CRmjSo7TgpkntizZZMWZV
         gHdcfRbOGv5C/kisYK3h2YO1bjpswlL0uolWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=fylEEco5pjLtGsGjHcHhLfPg0yEgdiOJYTFObVPB6QM=;
        b=EBQMqhzcVt1Ke/HSIEkkfOWE5kA7MdTc8gOURXZ0V3bsdS0UgYwI1Y5cT7cxb7gnu0
         +Y+lMZehJjzhfheB5ba9uBU0vzAMEPfZ1GNVouBuuNLWNkkm7aAmTkbTQmTFT7mp2rAA
         wcQJ+eSrQdJSsvkVICAaxSjGCxol2zC2RYoTeEtnHh9O60k3CtL2NzAwDTPfbc8avFnZ
         k42RVc0fYwPkmwzGG0gFlXjnVVHNE+RAu9qF68GYlRE/hM3dhmyKnGOP4BWdt+npH7pK
         QIWKoky9hrAcbg/up5QrOWxJvkEvuYv8tIRr7+mLgZyXftd8TD3Zowv0lzcAeSZ4p6/Q
         WAsw==
X-Gm-Message-State: ABuFfoiJbCzI/dhGLUIowzEh7SU5R1CELN3YiMJa+MJ18emqk/nigdn0
        bXg1RYhHUFbBr9NKnK+6Yr/ZGw==
X-Google-Smtp-Source: ACcGV62+UsC8WoGkgJ6MWfPKvN7KCa5v7VIByd3DieIF1U3sdgUZix4vBX2Q9e1zBghDNWg2NL9tFQ==
X-Received: by 2002:a65:655a:: with SMTP id a26-v6mr45757369pgw.389.1540285239970;
        Tue, 23 Oct 2018 02:00:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 145-v6sm4125549pfw.17.2018.10.23.02.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 02:00:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Brown <broonie@kernel.org>, Ryan Case <ryandcase@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181023010707.153647-1-ryandcase@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20181023010707.153647-1-ryandcase@chromium.org>
Message-ID: <154028523769.53599.11047318773748957636@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1] spi: spi-qcom-qspi: Fix remaining driver nits
Date:   Tue, 23 Oct 2018 02:00:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Case (2018-10-22 18:07:07)
> Address remaining comments from original driver patch series
> =

> * Move RD_FIFO_CFG to be ordered corretly
> * Expand spinlock comment
> =

> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

