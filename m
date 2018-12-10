Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8481C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D58620672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQMOZoVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D58620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeLJQwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:52:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55237 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeLJQws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:52:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so4268713wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/tF6/1it/JYRnKL2oCTIrRuf0Werr1FUed1K6IZQ/dU=;
        b=IQMOZoVS0iG0kUMg+/db+R6R+G/XLyWsrox0OjbZR6tYXjaZ7Z8fmJhEotxrxe5Lis
         h2hC/ccFgllisqOHqfIdaW9sZbuXNdL+z41VixDqBKpB/TGMmuMMOfTAuAwZfNpl6gV1
         704xY8pt5KO0KQSdoFaRN54QKYhwQAK7bPNyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/tF6/1it/JYRnKL2oCTIrRuf0Werr1FUed1K6IZQ/dU=;
        b=NDd5auQOhu+K8VOUS5oIkMNZqZ9GrfAx+U9K/n2YoWbaULFt3pQKOa3pWbgeepqBw3
         57A1JzdmMhvstJp7Hap4MgUQeweSHISQ5lCAABDES1JtOHNiGdQGxG6zVtLLPWt9A5xl
         6NnpEoyJ5Q+9kqhE0cjNBool0qgsli6hqd36rRw2tKP+XAa0qwFv+IVwFUVOwuCI4maD
         3hPJI+iFSeNA7p3iSryirBXTKPZnY6kyokmTLjywFPb6TGC9H8k/TMA3crydOzO2h9GA
         wSnmgtEVmozRAFPt2Eu53Gi4xtAxl5nVgE8/ENXLcrgnqnea/vlhajx5dlIxfuh0E3ps
         CmtQ==
X-Gm-Message-State: AA+aEWYHayDodRO61q6xzdd/7tryUhkAgmkUYP0m55TetBFnYGBfJPRb
        RFjU68wqI19rWh+KrCNXiHGHAA==
X-Google-Smtp-Source: AFSGD/XUKg5l3QE2PN7HEX8DdJlmo6N6JoRrrZMQuwy1z8F2kGdNzuTqhByTs45zxN323S5JjuXbHQ==
X-Received: by 2002:a1c:1286:: with SMTP id 128mr11949834wms.70.1544460767078;
        Mon, 10 Dec 2018 08:52:47 -0800 (PST)
Received: from localhost.localdomain (73.59.88.92.rev.sfr.net. [92.88.59.73])
        by smtp.gmail.com with ESMTPSA id c77sm12877833wmh.12.2018.12.10.08.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:52:46 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Subject: [PATCH 1/5] clocksource/drivers/riscv: Change name riscv_timer to timer-riscv
Date:   Mon, 10 Dec 2018 17:52:38 +0100
Message-Id: <20181210165243.5625-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to unify the names in this directory, let's rename the driver to be
prefixed with timer-*

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Makefile                         | 2 +-
 drivers/clocksource/{riscv_timer.c => timer-riscv.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{riscv_timer.c => timer-riscv.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index dd9138104568..ddf697b29df9 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -78,6 +78,6 @@ obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
-obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
+obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/timer-riscv.c
similarity index 100%
rename from drivers/clocksource/riscv_timer.c
rename to drivers/clocksource/timer-riscv.c
-- 
2.17.1

