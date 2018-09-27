Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78026C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C152156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F+HwayzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C152156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeI0Lis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:38:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40682 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeI0Lir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:38:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id s5-v6so1001172pfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 22:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=ALUZcYVat+XCFIdJZ9HrpSTFmHRyEcSsOm9EQUYpI7U=;
        b=F+HwayzVcGjUUSvWZwRKZLoIfn50r4EGTSuT61Uz6/ihsRlpx9yYYp7spqsM6uNJOM
         gF9gSaSEJgnR9UkTP0rftMH4WdJa0YKxBeNdjUY8XUQerPZcqqY3X2btlgVbbZ0K3J+L
         BKIVdYAKCsoPBCSWtDUYe+ZHDQWuB4qTnD55g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=ALUZcYVat+XCFIdJZ9HrpSTFmHRyEcSsOm9EQUYpI7U=;
        b=ZfFLqZsJg59FqgL6sGwd9r0cRZ9hdZY6o6L2YXs82EFG+zUUGBq32Ep4q2icleF8tH
         uEWY8au+eEo8Qo2DTyG4QL1kfgIHmeNP4U8uACyAi1bSy3vG1wqQ/ZeVzywLZiuEjUj0
         KiutqH3f7XFDxLfgUqzueoKKM3ZdNOGMyrhbsUaK/JHO0ns1O//fKkCQ0ykRA882SHq3
         QUMynTdtBtKPr2MPdptx8ENL7MKzZiE/HiEkfpdPaUVtf2p7Y8WJqKKlw7CJ6H/3BjEP
         ynbCVrKVJ2YDfU1E1Fp1UirnIKeTjLdewoovuLQEkJwTR24fr83twFYAopCYE7PmOHzt
         mTjQ==
X-Gm-Message-State: ABuFfoiPmOA9AI2NHKmNEdBqmmvDq8Q8pLUK1nuBuBjUTiiWFojsMHk/
        p1tf0REbr6++WHshifPngoWeTA==
X-Google-Smtp-Source: ACcGV60ujlDI5bgUIbfykXaoeIoA570FbbEYuLxb15uJBS0J1eyEhs3/io4rT2HDhTPhy7aTXItRfw==
X-Received: by 2002:a63:f711:: with SMTP id x17-v6mr8451321pgh.322.1538025742326;
        Wed, 26 Sep 2018 22:22:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id m27-v6sm1226930pff.187.2018.09.26.22.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 22:22:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mark Brown <broonie@kernel.org>, Ryan Case <ryandcase@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180926205204.184898-1-ryandcase@chromium.org>
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
References: <20180926205204.184898-1-ryandcase@chromium.org>
Message-ID: <153802574048.119890.3343861516349497753@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date:   Wed, 26 Sep 2018 22:22:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Case (2018-09-26 13:52:03)
> From: Girish Mahadevan <girishm@codeaurora.org>
> =

> Bindings for Qualcomm Quad SPI used on SoCs such as sdm845.
> =

> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

