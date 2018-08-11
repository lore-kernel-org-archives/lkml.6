Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B0BC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4360223A6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 09:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="PkTxWjU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4360223A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeHKM0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 08:26:18 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49616 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbeHKM0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 08:26:18 -0400
Received: from trochilidae.toradex.int (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 91FAC5C0487;
        Sat, 11 Aug 2018 11:52:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533981156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=kFAHeYhN1rRh+fKT4TJKu7jbX2C74qlkpx5L3b2bubw=;
        b=PkTxWjU5G6GRfATh3vy+t/mOVSB6L71CZjtVuF7U7rvYoq5ccma5/H3Uc809FTglA3DfIW
        YZ+jF6sKmeQuCyALlBTlGwTM6mA3qLU4mPbrGBwG+tZwK5cmoQuE+P0EvVDLp+ufmtnDTb
        juI3A5i43uzoPB9H7lnZGzfcbwUuHX8=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     arnd@arndb.de, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ARM: require GCC for FRAME_POINTER
Date:   Sat, 11 Aug 2018 11:52:35 +0200
Message-Id: <20180811095235.1938-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To produce a meaningful backtrace with FRAME_POINTER enabled the
kernel needs a specific function prologue:
    mov    ip, sp
    stmfd    sp!, {fp, ip, lr, pc}
    sub    fp, ip, #4

To get to the required prologue gcc uses apcs and no-sched-prolog.
This compiler options are not available on clang, and clang is not
able to generate the required prologue. Make the FRAME_POINTER
config symbol dependent on GCC.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 693f84392f1b..cb65cf67dfa2 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -54,7 +54,7 @@ config DEBUG_WX
 # n, but then RMK will have to kill you ;).
 config FRAME_POINTER
 	bool
-	depends on !THUMB2_KERNEL
+	depends on !THUMB2_KERNEL && CC_IS_GCC
 	default y if !ARM_UNWIND || FUNCTION_GRAPH_TRACER
 	help
 	  If you say N here, the resulting kernel will be slightly smaller and
-- 
2.18.0

