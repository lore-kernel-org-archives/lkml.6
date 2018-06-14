Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C3A20C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A86208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPR6eIC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A86208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755198AbeFNLMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:12:30 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41506 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755139AbeFNLM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:12:27 -0400
Received: by mail-lf0-f66.google.com with SMTP id d24-v6so8781640lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BuRAUWq7O2zLXqV2NWRnZ70tza/xOBEVCO/2+vpJ/MI=;
        b=XPR6eIC2oEZhc2glDjsioCqgO6fZnsUyC6c+lAv4q6OSjVAusQBkhkpL7tESr42Voz
         6W0WnusKjbi5YguXEyRU92GuTA82B4AZ8ZHu2F93K94pDDH0Of3Ga9OqeCN8UikeE8r8
         LHmdTxWUdbBJmpBaen5cF0pVEGm2FSgrMbfMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuRAUWq7O2zLXqV2NWRnZ70tza/xOBEVCO/2+vpJ/MI=;
        b=r5N72NMPrgGTxpj7zFLuvz0FvDQG0ayXhMhcSSvrue9oyT8WrpHvDWJrLxGmxN3sS6
         OV5JgxMNLRT/4HWqAxR5kdMt39Iunwlshb8LybsXk+K3JrGoGKf9LVlkBkD3aponJeTS
         hWEnbHhA01Q+IBMy3THQJJ37tMARoDMk4UtrbvsE9APS/M5fn61KAQ2XHZsTPXB7Dg7b
         Uyioq9afdagrZ0vzXenZPxvQHRyASWuxXZm5xhSiYpE16L0zeFsAW4MXSCugvmec+SZK
         UIBpez7HTuXcqyxGLUsPhtC2Qx6tT8Fz4uzbGW/lWBUXdta+uakSChlCP7mROIK0PjQA
         pRCQ==
X-Gm-Message-State: APt69E384F5ROQLG1XHf3CcCo0JgX8jE1K3MjJlncWUHIQNiuAWNEw9G
        cJpESoYdd70vvQCXGWrTUz+cFQ==
X-Google-Smtp-Source: ADUXVKJUHb40nO345Mupz962zDiN36s5Tmbop/ShETMkI8IKr62ZYgDBS7QSBRpjfSpOJMFCI3nAPQ==
X-Received: by 2002:a2e:594d:: with SMTP id n74-v6mr1554380ljb.128.1528974746553;
        Thu, 14 Jun 2018 04:12:26 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id j103-v6sm1029550lfi.58.2018.06.14.04.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 04:12:25 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     andy.gross@linaro.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] rpmsg: smd: Add missing include of sizes.h
Date:   Thu, 14 Jun 2018 13:11:32 +0200
Message-Id: <20180614111138.8923-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614111138.8923-1-niklas.cassel@linaro.org>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing include of sizes.h.

drivers/rpmsg/qcom_smd.c: In function ‘qcom_smd_channel_open’:
drivers/rpmsg/qcom_smd.c:809:36: error: ‘SZ_4K’ undeclared (first use in this function)
  bb_size = min(channel->fifo_size, SZ_4K);
                                    ^~~~~

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/rpmsg/qcom_smd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 6437bbeebc91..8695cb041c31 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/sched.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/wait.h>
-- 
2.17.1

