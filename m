Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C487AECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE09208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9xDQiIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE09208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbeGQCkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36828 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731605AbeGQCkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id m19-v6so8265045pgv.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hdae6EY6LQdzfjses/l36WTPDA81Ak7jv9qrpdYLRI=;
        b=b9xDQiIhoFNzA93UgJXaKNVbJDIMGW++fVDEbDb7qg24AlrrAsp+rIf38kRA7MCrOM
         i6BmuZmSMuF1jltFpkkOAYY9Km8/iLhizaEsp5jSuBpCpjJW0V0/Zg6VkAeTE5O6bhye
         rnynCGCY5KRc71uHqTH/AafzHUFuzdCcpEfL6IvKkB0TkbCLV228YFK572lgi1GB/Upb
         tqwufcRyllkozvw9T6n5isoOiFyTjjWysMEjIgKK3qrLfcYl1EBDPJga3GBFcFRIv0Gy
         kUdLFkbBrKPADzekM+eb0rjoS4jzPtkUSpe4P4wsYCa0h2a2FMfFFhqYs3MaoTPHmIQY
         7z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/hdae6EY6LQdzfjses/l36WTPDA81Ak7jv9qrpdYLRI=;
        b=exU4aMdxUIioxgSSDWiNx8OC5zdHDjfR5Qn5gBmA3CHKp+lrefnTAKZX2AHPgs6nbX
         mf1wIEoSUe5FL8Kl/ynWDZY2Q8NDHisS0Oz/OL9PSY1JwuOVHgio3/inTCyqymQNIYRX
         751gt7aoRW3BBjtWx1Q8HwU/RkLWCLHdDYIA1HyavV0lKpZA3q4U12eWb8EgBRtANfdu
         h8r5jmShNA75/2AdAjXSAtfAgrL/2vb24WDS6GHCm11dPQ9rWkOT60JQJ/1GTsOd83rM
         fe5JmduvlIXVxsxLid4aLOTdcSmyqY7m7xTi4XQ1CZjVtsTWjnfczD1MOx67nrRGVef3
         bFBw==
X-Gm-Message-State: AOUpUlHpPSDuDmZAnH2hBV5CfYipwcIinUpiMoeuTnVE4If4sfCXnqF4
        Epi9vyUmf7CnGLbIg/z8g3c=
X-Google-Smtp-Source: AAOMgpeBvATm0K+OfBZqGYD9CT7mMYvNaT7ptsb3hEGth++T4Ai2P+5VWe9h8QC2oVP5uRuaTU+gCw==
X-Received: by 2002:a63:c252:: with SMTP id l18-v6mr17575504pgg.76.1531793401482;
        Mon, 16 Jul 2018 19:10:01 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:00 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 12/32] staging: gasket: gasket_wait_with_reschedule return when condition hit
Date:   Mon, 16 Jul 2018 19:09:06 -0700
Message-Id: <20180717020926.176408-13-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Return right away instead of break out of while and then return.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 442543573f6e9..85116cc46f311 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -2097,7 +2097,7 @@ int gasket_wait_with_reschedule(
 	while (retries < max_retries) {
 		tmp = gasket_dev_read_64(gasket_dev, bar, offset);
 		if ((tmp & mask) == val)
-			break;
+			return 0;
 		msleep(delay_ms);
 		retries++;
 	}
-- 
2.18.0.203.gfac676dfb9-goog

