Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733BDECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBE520850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rtZUmx8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBE520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbeGRLd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:33:26 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:44331 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730911AbeGRLd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:33:26 -0400
Received: by mail-pg1-f174.google.com with SMTP id r1-v6so1830906pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aL8b40oj8iE845mB0Z+u7Il6/plUelhIjCMY3k6mMAI=;
        b=rtZUmx8lm/j5aOjM6ZTlFQ3K93Is8fymcrfswnILFkOftakQYc3bE4Z3+2V+bLtwaF
         q8PblsSLO8r25bcv6lG9YnqyO809aj+W7VRy4YSTAz/Wkq3hK/oVp0lKd3YfkJj++XQo
         w4hD6b2/eTYlInf7rq3IvQ9Oy6OgPWm5iaxe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aL8b40oj8iE845mB0Z+u7Il6/plUelhIjCMY3k6mMAI=;
        b=GE9r4KuCBOKMWQZyTnRjz54UfHzCW31ssOsZDNjc6X5nIgBbgxYfWgqMWBkYssUbvH
         IPoZ4LU01uuAAfNcigyYcP0sKjBa4ufLv7L1WeTdGp+Eg0ycQPQZ5zj6hMgl5Vd+EeMv
         opbeShHQYFP19GB55Kq3niNORPTo5K5njD4+NXRVdFPraQK1vuOGk/Q9PoPkaPtR3lN1
         5MRqubr+GI9jnw6r5iYyhMohHmZbF55w2lxdrlI/8RGocdBnnhyxhwl346rZiWKXRHJu
         OEBHvyTCR54qyfHsweAUDtj7E6LWCQ0S8a6LAe+b9oqGCbAokGp01oi5KO3Imhuc0Rw0
         taSw==
X-Gm-Message-State: AOUpUlHU44GgjH1W0csallH/ZN8BrONx2FJRSDCYbvtV5HAzQSZ0zLGD
        fDFRxmPr38wy2acxV7MGu9JsPQ==
X-Google-Smtp-Source: AAOMgpc30n0pTpS44iTl+wbdOJhSoyQjWevfH81uNXx+uqRd4oMBOPa1WHMJevppKogGDUU7Aq1wgA==
X-Received: by 2002:a62:d544:: with SMTP id d65-v6mr4645011pfg.107.1531911366228;
        Wed, 18 Jul 2018 03:56:06 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:56:05 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 09/18] arm64: defconfig: Enable CONFIG_DRM_SUN4I
Date:   Wed, 18 Jul 2018 16:24:49 +0530
Message-Id: <20180718105458.22304-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DRM Support for Allwinner Display Engine, built as a module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3, v2:
- none

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c192a42c2ba3..7c362b0ea27c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -425,6 +425,7 @@ CONFIG_DRM_EXYNOS_DSI=y
 CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_EXYNOS_MIC=y
 CONFIG_DRM_ROCKCHIP=m
+CONFIG_DRM_SUN4I=m
 CONFIG_ROCKCHIP_ANALOGIX_DP=y
 CONFIG_ROCKCHIP_CDN_DP=y
 CONFIG_ROCKCHIP_DW_HDMI=y
-- 
2.17.1

