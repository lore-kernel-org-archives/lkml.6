Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5645C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 13:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9013A2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 13:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9013A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=credativ.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbeHSRDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 13:03:12 -0400
Received: from gauss.credativ.com ([93.94.130.89]:32952 "EHLO
        gauss.credativ.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeHSRDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 13:03:12 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Aug 2018 13:03:11 EDT
Received: from gauss.credativ.com (localhost [127.0.0.1])
        by gauss.credativ.com (Postfix) with ESMTP id 8047C1E1CDA;
        Sun, 19 Aug 2018 15:51:37 +0200 (CEST)
Received: from localhost.localdomain (x59cc99f1.dyn.telefonica.de [89.204.153.241])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sdi@gauss.credativ.com)
        by gauss.credativ.com (Postfix) with ESMTPSA id 022B71E1CD2;
        Sun, 19 Aug 2018 15:51:36 +0200 (CEST)
From:   Sedat Dilek <sedat.dilek@credativ.de>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sedat Dilek <sedat.dilek@credativ.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler warning
Date:   Sun, 19 Aug 2018 15:51:35 +0200
Message-Id: <20180819135135.8801-1-sedat.dilek@credativ.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be dropped with commit 771c035372a036f83353eef46dbb829780330234
("deprecate the '__deprecated' attribute warnings entirely and for good")
now in upstream.

Please, use the kbuild infrastruture to disable compiler warnings.
This should be...

CFLAGS_i2c-core-base.o := $(call cc-disable-warning, deprecated-declarations)

This has the advantage to check if other compilers like GCC support this.

NOTE: My compiler is a prerelease of LLVM/Clang version 7.

[1] https://clang.llvm.org/docs/DiagnosticsReference.html#wdeprecated-declarations

CC: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sedat Dilek <sedat.dilek@credativ.de>
---
[ v2: Fix typo s/no-deprecated-declarations/deprecated-declarations. -dileks ]
 drivers/i2c/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 72c94c60fdd1..bed6ba63c983 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -18,4 +18,3 @@ obj-$(CONFIG_I2C_STUB)		+= i2c-stub.o
 obj-$(CONFIG_I2C_SLAVE_EEPROM)	+= i2c-slave-eeprom.o
 
 ccflags-$(CONFIG_I2C_DEBUG_CORE) := -DDEBUG
-CFLAGS_i2c-core-base.o := -Wno-deprecated-declarations
-- 
2.18.0

