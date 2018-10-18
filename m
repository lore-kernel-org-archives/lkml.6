Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8150C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B04208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtV6QE5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B04208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJRODp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:03:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33138 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbeJRODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:03:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id 78-v6so11987515pfq.0;
        Wed, 17 Oct 2018 23:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzs3SsfUC0eVNi4WA7ljTQtLs6lW/O5XBKVHzpCLf1Q=;
        b=BtV6QE5oDSQpKc+5CN9Bh036ZNf6PKe1rA887OUVAibtzqQLvwFT5OJ4Fi6DGHGeZl
         J0Y48gsdw1ezyMAqISdpnyW9Uxm/zDJk5evz19nRrVZ7NgOl2XXzbeM6ZePmfgUuEusz
         YudrB05HI3DRxarSnTkUu8sgSAfpAzAAnob/I1i5bd69txqcQScKT8uMMtzwud2xhnd1
         a+YV31EN7DkYSp350OvJU7Xj9AJIhFQ2TKyM49lkFwNMPvuM9ZSIzuObZSEKCR9WRDtH
         z4KjYuC/gL3BfCGODztRUAwk0GoUa7bsSlcO/oeoFDfPyq+zjJe+IAyUX/WP8nsflAyy
         sC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzs3SsfUC0eVNi4WA7ljTQtLs6lW/O5XBKVHzpCLf1Q=;
        b=nkofe0RCQ938/2RhlGSauyTR7yXGvRX3vimDnWJGjU+ZsM3tl8WJN+3QvadjymAHYm
         vz8SawxivhSMzq5BnA33DL9yYSHS5Zs3grWAxxLA+0cTesFYzLD3F1HPbhMN1d9vAuU4
         3ekyP5NVLuKQoDOMedO/ERkSzNuYceDV4YLhC4+O005ZS8OfqZby/MPB2wCRvWQ9jt1U
         5SgIY/0P17rxKWVQtun7T3BgfECWA4+shLrhiJbriFMHbG6y+Mfmo7LB8hMoRySMdz89
         Ctb7rxe/AWNvCYLoLXndXdYRi/nq1Ff6iqLqQOweFEskQKuqS70f9apCVJD3DVvo0Y43
         jZsA==
X-Gm-Message-State: ABuFfohVeY3V5dBKGJNSsW6Eej7RCABOScOwcK+THow3KMdkLxsf/2p8
        ZCQ9ijQreHFFPLC5zM6OQG4=
X-Google-Smtp-Source: ACcGV61GFVHBmmBWV46ypzp+OVmcvHyt4HhfaATJdC70jEX07OYechMF5sNBog6/aSUQbMATEzDS4Q==
X-Received: by 2002:a62:6383:: with SMTP id x125-v6mr29118735pfb.13.1539842663868;
        Wed, 17 Oct 2018 23:04:23 -0700 (PDT)
Received: from anarsoul-thinkpad.localnet (216-71-193-140.dyn.novuscom.net. [216.71.193.140])
        by smtp.gmail.com with ESMTPSA id i5-v6sm19436086pgs.10.2018.10.17.23.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 23:04:22 -0700 (PDT)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Oskari Lemmela <oskari@lemmela.net>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 0/7] AXP8x3 AC and battery power supply support
Date:   Wed, 17 Oct 2018 23:04:21 -0700
Message-ID: <7922695.scgUESgI9A@anarsoul-thinkpad>
In-Reply-To: <20181013080848.29894-1-oskari@lemmela.net>
References: <20181013080848.29894-1-oskari@lemmela.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, October 13, 2018 1:08:41 AM PDT Oskari Lemmela wrote:
> AXP813 AC power supply support with input current and
> voltage limiting support.
> 
> AXP803 AC and battery power supply support.
> 
> Changes in v4:
> * Change order of axp20x-gpio in axp20x.c
> * Fix indentation and spaces to tabs in axp20x.c
> 
> Changes in v3:
> * Reorder ac_power_supply DT node
> * Rename axp20x_ac_power_set_property function
> * Split mfd commit
> 
> Changes in v2:
> * Reuse axp813 compatibles for axp803
> * Refactor axp20x_ac_power.c

Patches 1-3, 5-7:

Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>

> Oskari Lemmela (7):
>   dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
>   ARM: dts: axp81x: add AC power supply subnode
>   arm64: dts: allwinner: axp803: add AC and battery power supplies
>   arm64: dts: allwinner: a64: sopine: enable power supplies
>   power: supply: add AC power supply driver for AXP813
>   mfd: axp20x: Add AC power supply cell for AXP813
>   mfd: axp20x: Add supported cells for AXP803
> 
>  .../bindings/power/supply/axp20x_ac_power.txt |  3 +
>  arch/arm/boot/dts/axp81x.dtsi                 |  5 +
>  arch/arm64/boot/dts/allwinner/axp803.dtsi     | 31 +++++++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts |  8 ++
>  drivers/mfd/axp20x.c                          | 20 ++++
>  drivers/power/supply/axp20x_ac_power.c        | 92 +++++++++++++++++++
>  include/linux/mfd/axp20x.h                    |  1 +
>  7 files changed, 160 insertions(+)




