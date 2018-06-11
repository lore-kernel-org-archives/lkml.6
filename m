Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0842FC004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12522086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W5GDzYyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12522086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934308AbeFKVK3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:10:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34188 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754202AbeFKVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:10:06 -0400
Received: by mail-pf0-f193.google.com with SMTP id a63-v6so10893698pfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h1pXq7NPNRuYXuOgas51mxihg+FMjGWfvyKPiwhEFQU=;
        b=W5GDzYyXC0Naj/gD2Dlm1lMCYFcDX/A1aou+fqOAr8QRkQi+8IHUssMFCNjEp5rUKk
         6BdMojwUTogeUr91VO3lkuBs/mq3Q/GsfK5/ghbwjW/Fe728UMdSkolhkcCMM6P+MMUZ
         +4VeYrsFD4A5FFfY6fTS+h6bZXU75PKAedRJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h1pXq7NPNRuYXuOgas51mxihg+FMjGWfvyKPiwhEFQU=;
        b=RqljIZa6/P1rAi8qKZFwzydj+6++drzVs2KrVSKAsp6bDXDa8IhBnNDh8+EN61v2m2
         nLR9LHoXWio0cjhXsFrcVuuYFNqKvzfFaFxkxRHW0eoPhHaBTZFRACsnkfXI/+CXmWba
         aMzvfONHhCXfZpw+xCDMihymKeBH94QoejC20ODcrtfy7XNSjWBAszbf1LZwLX08t17y
         2+w/wodArBkKbasa0esalfBjlY5Qay2wLXSFFa5f2imUPMaZj8bJTKZmRR41VLIQ7VH5
         UllrDYNuQ7DJIC7QrO8PkfUCmQDp8mbn2vu3+mpigTZZ3W2x2ODmCuhLmGmYGRrS18W8
         TQKw==
X-Gm-Message-State: APt69E25AGIYfmt34ez0lL/Twl1H35ohS9M5YB5cknVjO1dMm6nejGiR
        glLVpgJbV7//KP/cLPwEmGWMIEZumcQ=
X-Google-Smtp-Source: ADUXVKLGpoF9oG6FeFwaOTJHAOw/10/bNyawy+cbaB4XOhkI0ne0QQShfCaqhzOF1q0hHhb/pykLZQ==
X-Received: by 2002:a62:d117:: with SMTP id z23-v6mr749967pfg.99.1528751405251;
        Mon, 11 Jun 2018 14:10:05 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id c4-v6sm49116184pfe.53.2018.06.11.14.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 14:10:04 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 4/4] ath10k: snoc: sort include files
Date:   Mon, 11 Jun 2018 14:09:46 -0700
Message-Id: <20180611210946.241341-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180611210946.241341-1-briannorris@chromium.org>
References: <20180611210946.241341-1-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort these alphabetically, with local includes in a separate section.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 61967c2966e6..c88677e0a21c 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -14,18 +14,19 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
-#include <linux/module.h>
+#include <linux/clk.h>
 #include <linux/kernel.h>
-#include "debug.h"
-#include "hif.h"
-#include "htc.h"
-#include "ce.h"
-#include "snoc.h"
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
-#include <linux/clk.h>
+
+#include "ce.h"
+#include "debug.h"
+#include "hif.h"
+#include "htc.h"
+#include "snoc.h"
 
 #define ATH10K_SNOC_RX_POST_RETRY_MS 50
 #define CE_POLL_PIPE 4
-- 
2.18.0.rc1.242.g61856ae69a-goog

