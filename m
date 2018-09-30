Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FC3C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8A4206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="hgkiqheL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8A4206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeJAE5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 00:57:21 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:41054 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeJAE5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 00:57:21 -0400
Received: from trochilidae.lan (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D63595C0604;
        Mon,  1 Oct 2018 00:22:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1538346156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=iVT8b+pH1h/jXid4EIHi06MY3S9FUosXnXzwteaVkpM=;
        b=hgkiqheLZNN5ybkOOlu+ujYfyWesTv2fNFgbeg9SxJFa1VOGpmmpMeRQ/Y2pigHCcYCmRR
        bd7Y+nkqkOWSat1VkxByWmveimeF+NqHITIU5JMulg1chUsiMG8Erl91o9ECcse7ezfKdI
        45WRaYkibGR88Qg2fVRdFrg1zC1JfJM=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ARM: disable ARMv6 for Clang older than 8.0
Date:   Mon,  1 Oct 2018 00:22:30 +0200
Message-Id: <20180930222230.24167-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel passes the ArmV6K architecture to the compiler when
using the multi platform selection and enabling ARMv6. Clang
older than version 8.0 emit assembly with an non-existing CPU,
which then makes the assembler fail. Prevent the user from
selecting ARMv6 when using Clang before 8.0.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Link: https://github.com/ClangBuiltLinux/linux/issues/55
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a5b04c..8da160757381 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -671,6 +671,7 @@ config ARCH_MULTI_V4_V5
 
 config ARCH_MULTI_V6
 	bool "ARMv6 based platforms (ARM11)"
+	depends on !CC_IS_CLANG || CLANG_VERSION>=80000
 	select ARCH_MULTI_V6_V7
 	select CPU_V6K
 
-- 
2.19.0

