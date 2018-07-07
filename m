Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2E7C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC0721EFA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f21jR63v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC0721EFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeGGLXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:23:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39132 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753730AbeGGLXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:23:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id w14-v6so10453417eds.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 04:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qxjkAPVbAd44TS9MFd+K+fZ//MRtkNL9GP70v4fmXg4=;
        b=f21jR63vvJsHF0EDsjfdbQDy72qwZK1ywqASB0ZND1WpnZN6pYAut7DP8eUq5GTQRW
         ad5llzSnIkL4dbaFCd/tt4bFiq7fLuz9ePsoeJHJAFCK4roZslDMsmFTtJuuj70c5u7+
         Wy0TuiozJyhscTYfkrzY0yFUKVOkxXdTuV/NZ03El4g5mYe8ANBkK6Q52R8nRjEZa7FP
         wVVnTakKG8n20FFICBn93VyFXdGnqDDJYnHsmNeXErRz3iJ5Sa5DGzhLGbdOVWiKa5Xx
         iNoyJYxFqUrii6Mlz0K3vyvchUQEpZIOfCetq0AwqHHyFwilVaT4M7Mns6Vjah07upw1
         4fOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qxjkAPVbAd44TS9MFd+K+fZ//MRtkNL9GP70v4fmXg4=;
        b=aQpal/JOppyXpUC79y99Fdwt9v9pYiF2mLmDiEhMMr0pJK7EXJ9n7mY8Hf0kLtgyr0
         jh7qNhbD8DMakZ8YSRN3jZYYYHUojwsJbRSWDOyw5HtXeBd7Eo1EghfSk2C6uu84oeoN
         g7HArn+io+UiBs2OKRGE8BFY7RU9E/LOFWcHrFgHDch4KTg1RSj0Q20tyjELjKKZkRAf
         YGhzzUDcsxIYZPKKINDZ3wNG+cQwYc17JExAcJOno9gV9OBqd/lDVIB0hF+0MIgTGQFi
         G634sYmK9lfibPMQU6rso6QWohveRrfEWlgS4D4KGWwZQT+qWX01AEKXrED1KD7jozJf
         Ht0g==
X-Gm-Message-State: APt69E2bLVMDwD7ycpfj1BukHetBQpWx6vi+bmCoU9oadJzKY7kXGtLD
        SFEuQJnY5fcrGxqWEecfuF+7dYg+pMw=
X-Google-Smtp-Source: AAOMgpdr5LJN8G+OQSQtQ4vGuFZGgCXQA9Po+G6PEXPCbBeEaStQzQyoykinkAwFRRaqy+7FaP8S7g==
X-Received: by 2002:aa7:c0c9:: with SMTP id j9-v6mr14801136edp.135.1530962583469;
        Sat, 07 Jul 2018 04:23:03 -0700 (PDT)
Received: from arch.localdomain (x590e632c.dyn.telefonica.de. [89.14.99.44])
        by smtp.gmail.com with ESMTPSA id k2-v6sm7809757edl.30.2018.07.07.04.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 04:23:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: replace while with shorter for loop
Date:   Sat,  7 Jul 2018 13:22:50 +0200
Message-Id: <20180707112250.17287-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify rtw_get_rateset_len() by replacing the while loop
with a shorter for loop. Also replace tabs with spaces in
the definition line.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index e47927b9c3b8..711ebb0ad640 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -200,17 +200,13 @@ void rtw_set_supported_rate(u8 *SupportedRates, uint mode)
 	}
 }
 
-uint	rtw_get_rateset_len(u8	*rateset)
+uint rtw_get_rateset_len(u8 *rateset)
 {
-	uint i = 0;
+	uint i;
 
-	while (1) {
-		if ((rateset[i]) == 0)
-			break;
-		if (i > 12)
+	for (i = 0; i < 13; i++)
+		if (rateset[i] == 0)
 			break;
-		i++;
-	}
 	return i;
 }
 
-- 
2.18.0

