Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B50C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFEA218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AsouC6bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfAXMQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:16:43 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:52693 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfAXMQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:16:40 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x0OCGKiQ017405;
        Thu, 24 Jan 2019 21:16:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x0OCGKiQ017405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548332181;
        bh=fcs9Tf30L7diisTe9kSWtVGAq5PPlPjnIbgxyaZumog=;
        h=From:To:Cc:Subject:Date:From;
        b=AsouC6bX8PZhWYLH2/zFKqf/wOxFQC5Yin/AUDaw046ZUkZzoGO9xErnj+KwSjWYM
         3Rfu7Z6tA8NS2CWR2KeoQbFd/TgGPovv0JiLqH9K3+C6RNGSm/W/IgZY8QSBd6aLUy
         OHv2D3yBjjNkSmzmxvpBlUrGh9+V1usIPFji016mdwGeWkkmYA3EwJRcLMzNpBE/3M
         FWITbVt+SRH58X32xxKbEb6JsDmjR9yJXPPmn5GkdRgwe90q8iOLGhT9JLFR/s7L38
         u0AfpJ1/RPEFLnXXoApe8DqBLu+TC8ZJ0TymJFrSxzINYqaYd4D/SEH5s648cQCVLu
         2JMb+sRlpz07w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI / DPTF: remove header search path to the parent directory
Date:   Thu, 24 Jan 2019 21:16:03 +0900
Message-Id: <1548332163-17869-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is too much to add extra header search path for all files in
drivers/acpi/dptf/.

Fix up one C file, and remove the header search path.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

My main motivation is to get rid of crappy header search path manipulation
from Kbuild core.

Before that, I want to clean up as many useless paths as possible.

The full work of this is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git build-test


 drivers/acpi/dptf/Makefile          | 2 --
 drivers/acpi/dptf/int340x_thermal.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/dptf/Makefile b/drivers/acpi/dptf/Makefile
index 06ea880..e6032e4 100644
--- a/drivers/acpi/dptf/Makefile
+++ b/drivers/acpi/dptf/Makefile
@@ -1,4 +1,2 @@
 obj-$(CONFIG_ACPI)             += int340x_thermal.o
 obj-$(CONFIG_DPTF_POWER)	+= dptf_power.o
-
-ccflags-y += -Idrivers/acpi
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 8636409..0aa7c2e 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -12,7 +12,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 
-#include "internal.h"
+#include "../internal.h"
 
 #define INT3401_DEVICE 0X01
 static const struct acpi_device_id int340x_thermal_device_ids[] = {
-- 
2.7.4

