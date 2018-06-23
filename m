Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10614C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEED824ABC
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxlURdmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEED824ABC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934771AbeFWCVT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:21:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39751 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934528AbeFWCVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:21:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id r11-v6so3990598pfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 19:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N6l5ADvfSARlBrFBLh9//Q8Y5HUEl/bDth4c/brQGkk=;
        b=WxlURdmDbAsopckzPs87JfrpO7YFHsw+qidS6gzFHAF8brPet5F1uzoQQJiEotUoCv
         DYJni3FAh3r4za3XeLOeDQTtUi1TZ7nU14JjW1mZk9959O6lBg8dN8jlc10GBcLYCJts
         lNgW9L2z95O5KO2wF+miWm97uNUn8cVfC1URE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N6l5ADvfSARlBrFBLh9//Q8Y5HUEl/bDth4c/brQGkk=;
        b=Wr1EAqeyZkVpyl3lnoCpgwzrBpxIjyOkr6GZSWPH4DgFsONtSjDu/I57yOMms4GpyP
         R18o118RvJtkqCTDRbH08Azt78GkPCHoncni1g/4NnPKgvEo7aqXwBobL9c1prF1I67+
         xS60md77wSZSD5BQsZ6YgIW941+6a4XFnYs92T6GrogTDtcNZEizapxMedNLCg71xOP6
         63/kAh+q+VembjdkaY8vjPeHC6R2OhKw3sEh3+c3gG10fMs5HqGYIePXs1HLilPo2Lg3
         djMvClfEibzbkQvPWPG4AsbADmUK4tHWo8sY04bv2zR7W9Q8Mv0k6poevllrE18+DMtt
         2nAw==
X-Gm-Message-State: APt69E3u8+oN+/z1PW2Aj47fLFd/q521RNgMUTjzxdbaHvYkkYI6IPBF
        9fZNu3c7lypMGcVIInCv6fV2qg==
X-Google-Smtp-Source: ADUXVKJ1V2XQzWKskz/YDEm8bb9Xn6Z0Xo5ofbNPfvTCrThKco+gZSj6uXmegiP43FW6dgcmvdS9QA==
X-Received: by 2002:a65:468e:: with SMTP id h14-v6mr3245878pgr.89.1529720474766;
        Fri, 22 Jun 2018 19:21:14 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id a8-v6sm17553197pfe.72.2018.06.22.19.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 19:21:14 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v10 05/14] arm64: add image head flag definitions
Date:   Sat, 23 Jun 2018 11:20:49 +0900
Message-Id: <20180623022058.10935-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180623022058.10935-1-takahiro.akashi@linaro.org>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those image head's flags will be used later by kexec_file loader.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/boot.h | 15 +++++++++++++++
 arch/arm64/kernel/head.S      |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
index 355e552a9175..0bab7eed3012 100644
--- a/arch/arm64/include/asm/boot.h
+++ b/arch/arm64/include/asm/boot.h
@@ -5,6 +5,21 @@
 
 #include <asm/sizes.h>
 
+#define ARM64_MAGIC		"ARM\x64"
+
+#define HEAD_FLAG_BE_SHIFT		0
+#define HEAD_FLAG_PAGE_SIZE_SHIFT	1
+#define HEAD_FLAG_BE_MASK		0x1
+#define HEAD_FLAG_PAGE_SIZE_MASK	0x3
+
+#define HEAD_FLAG_BE			1
+#define HEAD_FLAG_PAGE_SIZE_4K		1
+#define HEAD_FLAG_PAGE_SIZE_16K		2
+#define HEAD_FLAG_PAGE_SIZE_64K		3
+
+#define head_flag_field(flags, field) \
+		(((flags) >> field##_SHIFT) & field##_MASK)
+
 /*
  * arm64 requires the DTB to be 8 byte aligned and
  * not exceed 2MB in size.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b0853069702f..8cbac6232ed1 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -91,7 +91,7 @@ _head:
 	.quad	0				// reserved
 	.quad	0				// reserved
 	.quad	0				// reserved
-	.ascii	"ARM\x64"			// Magic number
+	.ascii	ARM64_MAGIC			// Magic number
 #ifdef CONFIG_EFI
 	.long	pe_header - _head		// Offset to the PE header.
 
-- 
2.17.0

