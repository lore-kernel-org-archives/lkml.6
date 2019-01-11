Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03668C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E3621841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KRWLRY0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389245AbfAKRXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:23:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36115 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388794AbfAKRWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:22:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so3117884wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xBD70HL2qWO03paRwQIDmAlJlPVaPEi3eVQDU8YVxoo=;
        b=KRWLRY0F0rlnDv+yevaEtVPd9HPVrX+LTdoU6A+ijvu7ZMOPU4qM7ax6P/rvDVMsGs
         23AY5Oh/ZZrxMP9xaUabObPNgCxtJlkBfMzFeYZuZGnFmEMgEqd+Ulj3BppJ6QiXl4OH
         kXrRre/lBt9z/FJYMTecJf/o2+VpnV4B1mAkZVnMhKLhVmUClQ70Z5Qw+VlW1lxzZ/yP
         c0LX4YhDgojAKNy8JPPer8EbpOXz3LnrCGJoI9eA5MR6z5uJGzj4UG/8OI1ahP1Wdo38
         Li5O6vdrBaG8A/wPmcqtjscRh/iddp3UxmSfWFMhgIKoLZU3aTrjhs4Es0RMXB38I+4+
         SrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xBD70HL2qWO03paRwQIDmAlJlPVaPEi3eVQDU8YVxoo=;
        b=j1zUH74b6iYWcioSqElkLYTso4BwRqPfdTnRXoyxJUCawpMCqt7lliBtQKbY7TQEzS
         NUcY2pn7IUYtnJVWiLd3QDQRV/APXBj6EqoAnIJqPWbVPfm5KmcwLjcwRY08xHR4EsDT
         12Be4YQX06sRuiVhUIj4sXC1tyU7rENSBzzJAFbA0HlfXIDKgWZULoJZuyaA+DlOjEur
         sosxq1F/8Izb7EH+2SIwJKIuSU1fy+PaE7HOIOU/hDVF3HDc8AkAVKeHm7gzSAy7Meua
         vpFkidn1xqn6T77XiGJzg+/jR5hC4Quz2nO17ue3uIE42Q0SPJ1bzwh8WdfJEtW7TfhV
         0HcA==
X-Gm-Message-State: AJcUukfQkyq9G//lPAhpLXpcebDPixa3iWNtjTXZeUuXcRsVw0ZDvTsP
        5cDk05mNXdmXPBL6Y5u/0d/v4A==
X-Google-Smtp-Source: ALg8bN45wANz3c7rgmiuLR9X1ICgjFWDGdCeblsSLFC0KdscQ3VOCvOjBhNQluWu800clWt35Ce+DA==
X-Received: by 2002:a1c:7616:: with SMTP id r22mr3084741wmc.35.1547227318742;
        Fri, 11 Jan 2019 09:21:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:21:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 07/17] ARM: davinci: dm365: WARN() if clk_get() fails
Date:   Fri, 11 Jan 2019 18:21:24 +0100
Message-Id: <20190111172134.30147-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the timer code checks if the clock pointer passed to it is
good (!IS_ERR(clk)). The new clocksource driver expects the clock to
be functional and doesn't perform any checks so emit a warning if
clk_get() fails.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm365.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 01fb2b0c82de..842b7e706ba1 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -786,6 +786,7 @@ void __init dm365_init_time(void)
 	dm365_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
 	davinci_timer_init(clk);
 }
-- 
2.19.1

