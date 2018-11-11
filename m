Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E0BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BC720869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BC720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbeKLGas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:30:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49392 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729850AbeKLFsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:03 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0000l7-Bo; Sun, 11 Nov 2018 19:58:34 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001Nd-TZ; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "=?UTF-8?q?Pawe=C5=82=20Chmiel?=" <pawel.mikolaj.chmiel@gmail.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Tomasz Figa" <tomasz.figa@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.483612167@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 020/366] pinctrl: samsung: Correct EINTG banks order
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>

commit 5cf9a338db94cfd570aa2607bef1b30996f188e3 upstream.

All banks with GPIO interrupts should be at beginning of bank array and
without any other types of banks between them.  This order is expected
by exynos_eint_gpio_irq, when doing interrupt group to bank translation.
Otherwise, kernel NULL pointer dereference would happen when trying to
handle interrupt, due to wrong bank being looked up.  Observed on
s5pv210, when trying to handle gpj0 interrupt, where kernel was mapping
it to gpi bank.

Fixes: 023e06dfa688 ("pinctrl: exynos: add exynos5410 SoC specific data")
Fixes: 608a26a7bc04 ("pinctrl: Add s5pv210 support to pinctrl-exynos)
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
[bwh: Backported to 3.16:
 - Drop change to exynos5410_pin_banks0
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -679,12 +679,12 @@ static struct samsung_pin_bank s5pv210_p
 	EXYNOS_PIN_BANK_EINTG(7, 0x1c0, "gpg1", 0x38),
 	EXYNOS_PIN_BANK_EINTG(7, 0x1e0, "gpg2", 0x3c),
 	EXYNOS_PIN_BANK_EINTG(7, 0x200, "gpg3", 0x40),
-	EXYNOS_PIN_BANK_EINTN(7, 0x220, "gpi"),
 	EXYNOS_PIN_BANK_EINTG(8, 0x240, "gpj0", 0x44),
 	EXYNOS_PIN_BANK_EINTG(6, 0x260, "gpj1", 0x48),
 	EXYNOS_PIN_BANK_EINTG(8, 0x280, "gpj2", 0x4c),
 	EXYNOS_PIN_BANK_EINTG(8, 0x2a0, "gpj3", 0x50),
 	EXYNOS_PIN_BANK_EINTG(5, 0x2c0, "gpj4", 0x54),
+	EXYNOS_PIN_BANK_EINTN(7, 0x220, "gpi"),
 	EXYNOS_PIN_BANK_EINTN(8, 0x2e0, "mp01"),
 	EXYNOS_PIN_BANK_EINTN(4, 0x300, "mp02"),
 	EXYNOS_PIN_BANK_EINTN(8, 0x320, "mp03"),

