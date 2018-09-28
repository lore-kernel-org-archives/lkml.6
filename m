Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB81C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A456B2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sr+o5pxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A456B2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbeI1NKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:10:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32980 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1NKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:10:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so3749854pge.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PN5LeK8svtoziSd5ZB0HR3YbxUdhrZV+lLkgGkSy5ww=;
        b=Sr+o5pxeVXKOqw06DTNMIn4lVoKNr0kR4J9mRDFNopsLcBVTUokarh6DZcfsqDq0QC
         OFUT3k1jL133SZm3xC4fX3bXuVzu2TXeJOiVSRDTXzLuLjuV+vhNHNBPSMoCQPUanvUr
         P7wYBet1ILkC9dYZAI7aZV24GEykbffCAJv4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PN5LeK8svtoziSd5ZB0HR3YbxUdhrZV+lLkgGkSy5ww=;
        b=BLjC/Hyui3REFugWfju7yziW7VS8319uvRgUPdZNVUa35k1o0jThRMnZKgxvwTc93W
         qqNkhEsTlerNElNNu5BTMxsil/X0OW2VF3UDscf+hVpJUCcfV9HANiYOCcE6vDT8g7Yd
         0JkTlYTNhNfjp3bux8dk7wtjkX2FkF2TBVEaAphtJnMzqVDAjgv+QOYOgGRFHTUsXqmp
         dTJgmfwoBAQNz1Jl5MkI0ADr959G4aypgPndQKgOtZZkTgGH7ntfrccLKNM47JHVwEff
         RA51V38By/zi+n81/jeq6NvDZdcGPQyxbZpZEgvyn1dJWeXiKRPWySn7pErap2jqTlAo
         ouTA==
X-Gm-Message-State: ABuFfojQ1Z8VS77OyNpQbCTN62Of6oMCwo06xps6ll/j9nhT0XLnjPGk
        rDlVDWkOjts4V9I9vlJpKjxoVQ==
X-Google-Smtp-Source: ACcGV62nBgWpFV+8q6H/25pGLwVOjlY7bVf20Tyu6xMawVDn02uriiocxqf19Yz2RVwaSmGyeQIiPQ==
X-Received: by 2002:a17:902:c01:: with SMTP id 1-v6mr14301101pls.122.1538117307811;
        Thu, 27 Sep 2018 23:48:27 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id 3-v6sm6995090pfq.10.2018.09.27.23.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:48:26 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v15 07/16] arm64: add image head flag definitions
Date:   Fri, 28 Sep 2018 15:48:32 +0900
Message-Id: <20180928064841.14117-8-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those image head's flags will be used later by kexec_file loader.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: James Morse <james.morse@arm.com>
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
2.19.0

