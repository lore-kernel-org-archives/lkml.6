Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373A1C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F406E2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FR8dIy/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F406E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeJPQJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:09:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41487 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJPQJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:09:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id q17-v6so10637436plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 01:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zJeX9M/3WLf7vGzEgsrr2EwGJJddbgH/0Jo3NzAEVkc=;
        b=FR8dIy/Qmurw7MTf6m8nU9O7QMNlI9a9oHeV13rsi/wauahqAhLyzqc47iO4VU6WQN
         RE/8lbfSnYQKCBdPwBGD3ETpRs+1CFLCDlWGlKKPqIKsQHFYW5hpRb8PlqV13Vrti5n/
         0Vl8DrlfZ707oa8UVw/zcedPSJjVBDW/VEzbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zJeX9M/3WLf7vGzEgsrr2EwGJJddbgH/0Jo3NzAEVkc=;
        b=T6W9774gQRnK/NNXI1uK7dhZIkJsJvKB2rZKOIKEdy6HuWoh/31fUICfwbxP+rxBak
         TTIA+JN3782ANHfo4bdwMENrrRirxEvJ1AOSIDnz+ceb9zyU6Ls05B5ltQXADrjAi+Xv
         ++Tcu2CZ1rANmOfDy3hfWH06CjzZVDj3bhIzIHhUxHqekXRsMeG3FKqlUgCDTYwn0S+q
         zY9FG4/bGJ34Z/q0JgtaeN+8XGw4aXCJPKUFEOET790sN2AehSMlMkJE8VHYKlX6Un5j
         ce9WLMzYcm4bJUF1Z3+N5KGTBpB7A1hP+fupIxy2Uy3yI3piSFoeKbblVCegmEFicOBq
         jlxA==
X-Gm-Message-State: ABuFfojGp0odVvJsmn2vcmNoZY7FRoVrs69ecCVkjwMuR6uIGd5B1SN6
        r/otiVkpzs9rJI0lnsvIYIPnUw==
X-Google-Smtp-Source: ACcGV612kssoHq7+rKZVH4a0tb4Hw6gJYXdScOiXaYkfM6tvnQx+Xj3eVqIKbVkcNeTwDKoPX0JvHQ==
X-Received: by 2002:a17:902:bc49:: with SMTP id t9-v6mr20624403plz.210.1539678029651;
        Tue, 16 Oct 2018 01:20:29 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e131-v6sm20807868pfc.52.2018.10.16.01.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 01:20:28 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] mmc: sdhci: use goto rather than return directly
Date:   Tue, 16 Oct 2018 16:19:42 +0800
Message-Id: <1539677982-13762-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver should clean resources requested in the function before
unnormal return.

CC: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Fixes: bd9b902798ab ("mmc: sdhci: Implement an SDHCI-specific bounce buffer")
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1b3fbd9..f6b57e1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3991,7 +3991,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 		/* This may alter mmc->*_blk_* parameters */
 		ret = sdhci_allocate_bounce_buffer(host);
 		if (ret)
-			return ret;
+			goto unreg;
 	}
 
 	return 0;
-- 
2.7.4

