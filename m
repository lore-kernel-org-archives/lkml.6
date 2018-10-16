Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFA5C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A6221471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OTlT7VJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A6221471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJQFkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:40:01 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42004 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQFkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:40:00 -0400
Received: by mail-yb1-f193.google.com with SMTP id p74-v6so9524580ybc.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BQJKia//hru3n+/JYCjGhW0IPokv27OxI/Ee3R6hFTw=;
        b=OTlT7VJbxMeTjmWhKlkq2MKKLNmSNHaYu33vG1vykjBOYX9kgJy2C8nuBsuU5Bl2Xi
         N/YgGgCjsVDCohVUSvu27M56IWPHQgodRxsTB7bq8wPUpGXzlo86dp4L3o33MuX/Ueg6
         ulxEQz1w7pY+Flx/IfOEzSDjxmq+HaObvkqFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BQJKia//hru3n+/JYCjGhW0IPokv27OxI/Ee3R6hFTw=;
        b=dRH7WarDyFmt8s2h99xp1+zlXCTmVBsrF6h2c54qsl9bVsfjYlUfyZ1svyMW2pulAK
         Gb0RuJL/fWYi5R+6wnrK67gFgnGgSCpiGQeJB+jjCY+PlTSmSwAMcPWZvGqborbs2wMc
         tudxNKREuSmqDot88FqZYOsYgB1JFg3Bb/cya0vVjYxVzUrcLtRMm8dFCp7FYrqs+QIV
         8p5RjHuTcmvRqFNxchPa5K6eBaC4klbJTzZtRkFWFmKJBW+FwXtK/JyLtKuYs49SvKuX
         ieOTJT98631pFfIsq/V25iyVFutdfoHXMgC/RiF/gdu9iuPahn/JDiB1E/DtpC+rizfb
         5HUQ==
X-Gm-Message-State: ABuFfohyuNmaR1lhtKrQy5fxR5xuZTeWlD5YH+0BLjg7CdGgXFX9fwKU
        TcqwAAJnZDRey+HxnNyOeJv7YZiCLL1/s27D
X-Google-Smtp-Source: ACcGV63K0uXfKI1/RhsLF0L7r+UaNWZdOu8jtVF5sG+kwa+kceSV44F4R30Nxqu6HJ0ocIBWLrvbMA==
X-Received: by 2002:a25:b007:: with SMTP id q7-v6mr12286215ybf.344.1539726458583;
        Tue, 16 Oct 2018 14:47:38 -0700 (PDT)
Received: from alago.cortijodelrio.net (CableLink-187-161-144-121.PCs.InterCable.net. [187.161.144.121])
        by smtp.googlemail.com with ESMTPSA id b71-v6sm4040122ywa.48.2018.10.16.14.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 14:47:37 -0700 (PDT)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org (open list:GPIO MOCKUP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests: gpio: Find libmount with pkg-config if available
Date:   Tue, 16 Oct 2018 16:46:59 -0500
Message-Id: <20181016214659.22362-1-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If pkg-config is available, use it to define the CFLAGS and
LDLIBS needed for libmount; else, use the current hard-coded
paths and options.

Using pkg-config is very helpful for cross-compilation
environments, and is sometimes readily available on developer
boxes to ensure we get the right compiler/linker options for
the given package.

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/gpio/Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 46648427d537..f22b22aef7bf 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -1,7 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/
-LDLIBS += -lmount -I/usr/include/libmount
+MOUNT_CFLAGS := $(shell pkg-config --cflags mount 2>/dev/null)
+MOUNT_LDLIBS := $(shell pkg-config --libs mount 2>/dev/null)
+ifeq ($(MOUNT_LDLIBS),)
+MOUNT_LDLIBS := -lmount -I/usr/include/libmount
+endif
+
+CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ $(MOUNT_CFLAGS)
+LDLIBS += $(MOUNT_LDLIBS)
 
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
-- 
2.17.1

