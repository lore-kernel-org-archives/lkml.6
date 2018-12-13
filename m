Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16823C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEF920870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKfot2pG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEF920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbeLMM3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:29:48 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43492 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeLMM3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:29:46 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so1403075lff.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 04:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ArxlYqjZXbaDBdScGzXO++eUTVCwBAIV+Cl7LJu9VDE=;
        b=MKfot2pGlN410QrVXJpGEsr+x9HX6otGF9AtSbejCHDdfXbg/voDC5xROuIjoK12kY
         ZkseMUUyXN/4a3Mfql0lXn8Fi19URuzGS2VAM5CE5WuftFvmtwV5we5k2XFP3xQRO5OB
         EfoPRwjLW6PVTviNMC9JQAJ5U6W1rpMD7ztEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ArxlYqjZXbaDBdScGzXO++eUTVCwBAIV+Cl7LJu9VDE=;
        b=iNe2I+YWwjJ1aFFgxCeJHCwPxqYooHnr6kcQ1iMkwP8sHOSpsS2Ob5DKlBDShJJsz/
         /MZjiRc6rwlEwg24tUOCUu+l5mL/30ZWr/frAJdQQvpcNnSIOcN9XWIxHkhBEO/X5lP+
         xsX1WTZgjcf/RwzlRsk4KCe+7BJXuAll0NIdoKpvDFkGmE2+nlidoZHSKgjrSV8XOGvv
         XsSrhavjOaLlS0CSFmqnPhpg4znJ/PnZcE2G0gq2I9UcZiN9uY1x7WbSCwm1NKZmKGk6
         Et1raeGMwcDWTZcysu3VUmmAQYlt4OBFWzMbpyp9FQuAT9Jh20RLgHnbHwIvps4G3UkS
         iFCg==
X-Gm-Message-State: AA+aEWZNM0aUlteMauWl6pnCE+qn5Ld+Gw58Tqf55egrEGfYMDFC9HTn
        nehSu2PtwHvAqVSGCdopsRYXoBCl7CpBaA==
X-Google-Smtp-Source: AFSGD/X5Q+UAMKFMOW+jcPgFwCroM8AqNNN1oKmPi/fTOHnIDfIk70H19NaHCvvWvT56odbbUc1bBw==
X-Received: by 2002:a19:f204:: with SMTP id q4mr14990233lfh.133.1544704184327;
        Thu, 13 Dec 2018 04:29:44 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id q20sm325551lfj.20.2018.12.13.04.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 04:29:43 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        mingo@redhat.com, rostedt@goodmis.org, akpm@linux-foundation.org,
        broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [RFC PATCH 1/3] config: provide a fragment to enable gdb for qemu
Date:   Thu, 13 Dec 2018 13:29:08 +0100
Message-Id: <20181213122910.24193-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213122910.24193-1-anders.roxell@linaro.org>
References: <20181213122910.24193-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a fragment to make it easier to know what options is needed to
build a kernel to get the that you can debug in qemu.

First you need to start qemu with flags '-s -S' and then connect with
gdb like below:
$ gdb \
 ./obj-dir/vmlinux -iex 'add-auto-load-safe-path \
 ./obj-dir' -ex 'target remote localhost:1234'

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 kernel/configs/qemu-gdb.config | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 kernel/configs/qemu-gdb.config

diff --git a/kernel/configs/qemu-gdb.config b/kernel/configs/qemu-gdb.config
new file mode 100644
index 000000000000..30465905ff93
--- /dev/null
+++ b/kernel/configs/qemu-gdb.config
@@ -0,0 +1,7 @@
+# Enable debug info for gdb
+# CONFIG_COMPILE_TEST is not set
+CONFIG_DEBUG_INFO=y
+CONFIG_GDB_SCRIPTS=y
+
+# Easier to debug
+# CONFIG_RANDOMIZE_BASE is not set
-- 
2.19.2

