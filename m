Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 884FDC07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4ED20660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WK/UUfe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4ED20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934233AbeFKSTr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:19:47 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34747 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933493AbeFKSTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:19:45 -0400
Received: by mail-pf0-f194.google.com with SMTP id a63-v6so10674763pfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FoqW5kbSQry1ZnHepDpW0njGWC1OzjUWOfc/81TfeoQ=;
        b=WK/UUfe5baloKX9dn+zKH4Tabs3ICKmaVja5SB1EiXqL+LPnU9XOKGPB/Ht1kXz+/Y
         APpSPah+IKlzSxOMTlvirD+/GbQKbq/7tUewxD+4w41/y+B+BUBfL45706KMutV+lekJ
         5FgZj+lV648SGWg7XJpn7uYgMoDs8fMVpZqQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FoqW5kbSQry1ZnHepDpW0njGWC1OzjUWOfc/81TfeoQ=;
        b=iAeQIG2d9nEYUPoyRR0W4NITKX33aOupQseKJD5dywEKVkPVByAK4K0akPUziMFmOx
         qGC8C6fzyRawIlcPH65jBORYcqCa4ZCRAj9J9xkFMb62yBiKFjkvC6qFW133A5AkUw6u
         KwF1Ym8GiCUILMFte2COO7bKODDMf2ZaeGpCRycXQEbvKGI1uzeomQ23zZtsM5WBcTKT
         oANktue2ZpT32qAWH45/RGp6EscJ1Q/ob0nBIvVk6DKGbp8EHW00lkWdiFofRZG6Ia9f
         WRE/6BpE1gDRchmxW7jaJz4tUPgKd2SrJ7tT7Rdp7GNpnDUSjjYmjQ6C5ola2agM0JlY
         popQ==
X-Gm-Message-State: APt69E0kyIU21ud8P4+xZvzlI7r75f5LI/5kPDdeMhCd/0DWRTEMvVwl
        C5i6DyoKQQ5o/kAoUC99GMHG2w==
X-Google-Smtp-Source: ADUXVKJFDLqlQr5upph3MZIYJ0EIEJ9b82ibF3X6vm2MvuB4Al4NeGkuC8n7I4NzEcgATc6YjfIiGQ==
X-Received: by 2002:a62:211a:: with SMTP id h26-v6mr250263pfh.133.1528741184923;
        Mon, 11 Jun 2018 11:19:44 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id q82-v6sm81502560pfg.170.2018.06.11.11.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 11:19:43 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] ath10k: use crash_dump enum instead of magic numbers
Date:   Mon, 11 Jun 2018 11:19:35 -0700
Message-Id: <20180611181935.155032-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments are telling you what the enum could tell you instead.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 4cf54a7ef09a..eae46a04f503 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -41,10 +41,8 @@ static bool uart_print;
 static bool skip_otp;
 static bool rawmode;
 
-/* Enable ATH10K_FW_CRASH_DUMP_REGISTERS and ATH10K_FW_CRASH_DUMP_CE_DATA
- * by default.
- */
-unsigned long ath10k_coredump_mask = 0x3;
+unsigned long ath10k_coredump_mask = BIT(ATH10K_FW_CRASH_DUMP_REGISTERS) |
+				     BIT(ATH10K_FW_CRASH_DUMP_CE_DATA);
 
 /* FIXME: most of these should be readonly */
 module_param_named(debug_mask, ath10k_debug_mask, uint, 0644);
-- 
2.18.0.rc1.242.g61856ae69a-goog

