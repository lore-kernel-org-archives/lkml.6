Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A9CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D8825F41
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AGAW8UGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D8825F41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934339AbeFYRZ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:25:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52042 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755425AbeFYRZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:25:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id w137-v6so4851420wmw.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Hflegabax1XbCkMY3MBzsujUtn+vVogJfgk/UTTE9ic=;
        b=AGAW8UGHrhKeaH33dlo/d0JYAguf9z1AU0YsRROK59syXte7Oi88wF+3TUQZpablNO
         AX+oDxsLhMkReNHBD7Qtw+9HQTR6J2pi0B8QDrqACzI4ujNLpRLzfTYUPRTfm934J53F
         t9aIB7GtbA8eQlshAY/8pDJeA8EH7egZTYqAixKiAtfdNF9mNf0oSzE2EgNf2REC7RRn
         pt3mpldofnUyvQGxqShrmVK9arkONRSczhWRSauSyT2Jgg75GgfSw0RgWcdtJG/KDAiH
         d7dGC60r5UBSswrsW34bfftVK5PLsOmY3it1VoYWyiRdG69rp4YAhXwfU/v/sI6wnVt/
         1qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hflegabax1XbCkMY3MBzsujUtn+vVogJfgk/UTTE9ic=;
        b=VBLS65rRd20Bxw4egmKgaEDg8V60LFLb08/3Xdx7Xs7bSdCEMm8yovo0LXfsrkT5wO
         n5NYLrfGRGFTrgaBPuUQOOvAtcJMdZ8l6w8FKGZfwZOIXSpNqyRR9QDxQapkTXW576sD
         F/9iz4PaA6hoXdm+M7A24vmpNnG9WnF4Kw7DIL+SlPN7CLSjVk1W3NRscYXZeOVzqxPM
         s/KkZHcpFbONCUqLDH29aPikBpOHCrVy1WtcH1tlrB5l01Mx+Gjav8zitx41LqvPZ6mx
         H7/Lz+/6NcQaxvCk/TKg8FC6nKbmyaYd5PUkWkj6FKaZHe4++mjhl44HIykbhoWDhaQ8
         7fOg==
X-Gm-Message-State: APt69E0gd/x5oR9LOzbWXsXZ+33Jmc88AoEI1rd54pIWjHYYuifvxOqQ
        upbFoiEkOj0M3TPolSXJzc2Iiw==
X-Google-Smtp-Source: AAOMgpeHvPPFanICDmRC+pyADdJ2y+lexTkqW9BOL/Er1SJoorxruvBXtoHJRo1LDiDWk5mWs5RDsg==
X-Received: by 2002:a1c:9015:: with SMTP id s21-v6mr1706845wmd.20.1529947553660;
        Mon, 25 Jun 2018 10:25:53 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-1-7080-22.w90-116.abo.wanadoo.fr. [90.116.249.22])
        by smtp.gmail.com with ESMTPSA id z14-v6sm7345972wma.11.2018.06.25.10.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 10:25:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH] clk: davinci: fix a typo (which leads to build failures)
Date:   Mon, 25 Jun 2018 19:25:50 +0200
Message-Id: <20180625172550.17379-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This should have been DM365, not DM356.

Fixes: 4eff0bebf4ed5 ("clk: davinci: Fix link errors when not all SoCs are enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/davinci/psc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
index 6a42529d31a9..cc5614567a70 100644
--- a/drivers/clk/davinci/psc.h
+++ b/drivers/clk/davinci/psc.h
@@ -107,7 +107,7 @@ extern const struct davinci_psc_init_data of_da850_psc1_init_data;
 #ifdef CONFIG_ARCH_DAVINCI_DM355
 extern const struct davinci_psc_init_data dm355_psc_init_data;
 #endif
-#ifdef CONFIG_ARCH_DAVINCI_DM356
+#ifdef CONFIG_ARCH_DAVINCI_DM365
 extern const struct davinci_psc_init_data dm365_psc_init_data;
 #endif
 #ifdef CONFIG_ARCH_DAVINCI_DM644x
-- 
2.17.1

