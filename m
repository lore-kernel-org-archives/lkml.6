Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4257C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8120F240CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdfIxRvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8120F240CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbeGEVhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:37:00 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33592 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbeGEVg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:36:57 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so6516121pfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/1ZxHgiAk3xRN0ETasLw0aApS2qjZ6KJn/p3wIzUCVQ=;
        b=hdfIxRvgDkflgwbHWt1FNZZejRdjXeG/oNZKQpbcjg7lczFpdhRlWOiow94AU2/CeD
         Q8pkuiAsObOW3If6fr7vQJ2h8+P3+DnkFcNPV4+oIufpPS679Ge6S3fElJ0i/v4mX4oH
         reaDCQ2co3O7iGy24rFtp0lAZegZyXHQvSpSuDRa1Z4gBLuzXdGDBApvvegBcXS6UyQm
         LgF8ubMn21cH7mcklar69lkRXZAodTuJuO8GNgyOArecEviiYTHz0AxIV57i6HTfCr1U
         ssJBZeLhrMfkt2WzlQh+y4ay16RMxGPTIi5cHasjtKgmcB/eSwKkFbaOClyxFO3iXp1J
         rsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/1ZxHgiAk3xRN0ETasLw0aApS2qjZ6KJn/p3wIzUCVQ=;
        b=hk1Pv0lpLTa0wqdTzYehtgcp0uQWRakE2STXk/nOmysJKNd1ciqsnbVdJLRSR0GTd2
         UB+nVK+EP1OpcWPnhp2llE7KH/y9btFz4JwftcVgYBvtVC2kQyaws9hU7lZg+wDLmekh
         OVoo42ymvkz6+liZyVuSbeY/CwUIgy4X7gFO1qDXo41A4FqnQ0h6RhwqPyp8dMOOaou9
         AMmHiyP8V/oF0EBjeLpxZ5bS1wtMnzmOksmAknDhTPWMGD1qKfp3hbYxAsozq7I4Cbjh
         +N3pxrHnO1HMSoPX8a0xDVJJoUdv5jbOM2j4xOplOyUwuHZbfYjAQ9HksYu7KaptRgRG
         6MqQ==
X-Gm-Message-State: APt69E0ciX90Bth/zjcPkkUpqIDF0lwMGHrI80/moew55Vrxi3m2kPy5
        yat0wLPJu0sJPEPF2tCNTu8=
X-Google-Smtp-Source: AAOMgpdKBuvVQ3Rb/4mvfRwSSiLkPXixk6nFP14X5SqrSFhPMvviLZbLr7Ei0LQtffxyBTRGId223g==
X-Received: by 2002:a63:ab4c:: with SMTP id k12-v6mr1180764pgp.386.1530826616705;
        Thu, 05 Jul 2018 14:36:56 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id v89-v6sm20438290pfd.64.2018.07.05.14.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 14:36:56 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, davem@davemloft.net
Subject: [PATCH v2 2/7] sparc: Make thread_info.h available directly
Date:   Thu,  5 Jul 2018 14:35:59 -0700
Message-Id: <20180705213604.18883-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705213604.18883-1-deepa.kernel@gmail.com>
References: <20180705213604.18883-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/compat.h was including this indirectly for
asm/compat.h dependencies.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: davem@davemloft.net
Acked-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/compat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 4eb51d2dae98..1b991cfcdd76 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -5,6 +5,8 @@
  * Architecture specific compatibility types
  */
 #include <linux/types.h>
+#include <linux/thread_info.h>
+#include <asm/thread_info.h>
 
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"sparc\0\0"
-- 
2.17.1

