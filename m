Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE10C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FD62083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnRSApHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FD62083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbeGKJoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:44:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40032 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbeGKJoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:44:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6-v6so17452709wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sA0x4vnqsHOfjf2tc9OZ1sVTXlxbVufq2Bf9Pecho2U=;
        b=GnRSApHQiDH25jpATv9Hy+YfcdUmFoLZmSkR5RQxzvJvMbWjA3RmDby27bcyBy1RUz
         Oof0Qm/nHboGrcB+Ntm1+mzwKeIshCj+rPnL9jEvINjnPA+sH0QEo1S6uiAkA9XFMFBZ
         6nsv0PbzDLsyqQlxlXhS4hl4MgNW/7ekODA5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sA0x4vnqsHOfjf2tc9OZ1sVTXlxbVufq2Bf9Pecho2U=;
        b=ftiLps/lxaR6ImrAPPFCsJGGTTWW5CLd+99sXPOHqLJItRZDDxF3IVPFWoP4tybcT+
         MQ8DzEJOSFVKMUs9WHzKZsJNF413gEwO9vEHUjO0sRkUcIbE5SABgJipqiHfmdLXvr81
         ky+K1tLbkSbGBPFPPxO/wKKrkpFscvV5vMduE/1dOuGmuXz3Fga9MmZQRpdtS5LSTsp1
         aldlb01EfzYzpSoZB1OHq3IZT2AWHMKF3pa04ywGMYas6Wr1RR5/ZAvu5qRbjlMx4Sqh
         Dw9cJECJnFBJ2F5A1uc/m01XrVe06XZnYbGxTb4zfCoTc4LjL2PkKJmkN9E2QMDVVnF6
         zS6Q==
X-Gm-Message-State: APt69E2ZKPo/1oBGeLdkqcwiVmKv9NBhbdn9n2Mq1aaXBqiSua1vy7w/
        pCX9oE+xgKKK0lHoJtJQUvIbWw==
X-Google-Smtp-Source: AAOMgpfWpYM/UDe4zIiuaPF96A1RKWOrfYEO33v44bEnxfa8LFkJG8OvgUO5QP2Eyntd723r8wwxJw==
X-Received: by 2002:adf:b3d4:: with SMTP id x20-v6mr21143810wrd.272.1531302054562;
        Wed, 11 Jul 2018 02:40:54 -0700 (PDT)
Received: from localhost.localdomain (33.153.69.91.rev.sfr.net. [91.69.153.33])
        by smtp.gmail.com with ESMTPSA id t124-v6sm1641311wmt.29.2018.07.11.02.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 02:40:53 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] efi: cper: avoid using get_seconds()
Date:   Wed, 11 Jul 2018 11:40:36 +0200
Message-Id: <20180711094040.12506-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
References: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

get_seconds() is deprecated because of the 32-bit time overflow
in y2038/y2106 on 32-bit architectures. The way it is used in
cper_next_record_id() causes an overflow in 2106 when unsigned UTC
seconds overflow, even on 64-bit architectures.

This starts using ktime_get_real_seconds() to give us more than 32 bits
of timestamp on all architectures, and then changes the algorithm to use
39 bits for the timestamp after the y2038 wrap date, plus an always-1
bit at the top. This gives us another 127 epochs of 136 years, with
strictly monotonically increasing sequence numbers across boots.

This is almost certainly overkill, but seems better than just extending
the deadline from 2038 to 2106.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/cper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 3bf0dca378a6..b73fc4cab083 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -48,8 +48,21 @@ u64 cper_next_record_id(void)
 {
 	static atomic64_t seq;
 
-	if (!atomic64_read(&seq))
-		atomic64_set(&seq, ((u64)get_seconds()) << 32);
+	if (!atomic64_read(&seq)) {
+		time64_t time = ktime_get_real_seconds();
+
+		/*
+		 * This code is unlikely to still be needed in year 2106,
+		 * but just in case, let's use a few more bits for timestamps
+		 * after y2038 to be sure they keep increasing monotonically
+		 * for the next few hundred years...
+		 */
+		if (time < 0x80000000)
+			atomic64_set(&seq, (ktime_get_real_seconds()) << 32);
+		else
+			atomic64_set(&seq, 0x8000000000000000ull |
+					   ktime_get_real_seconds() << 24);
+	}
 
 	return atomic64_inc_return(&seq);
 }
-- 
2.17.1

