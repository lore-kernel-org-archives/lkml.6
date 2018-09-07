Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6511FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B527206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Opb8rBTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B527206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbeIGMkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:40:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33417 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbeIGMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:40:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so6644099pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iV83B8R4RN0S46KhJwI/DPsWmsVjF3gQZbNOLfrDO2o=;
        b=Opb8rBToQcMZtyPYTVhVnP0kWL6jOjIeziL6TJJFv1WBRD57nZtKirw3Gv+BigdMUA
         IfnfHFH2jGHiprpQONf+LFBgWyM0iAdDGxdcgKTFHBWR1yJofCRZVngza0NB4IdIuVsN
         YatTiRLRgRL3dzahQVtG+E4EKQTPVuN5XgPMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iV83B8R4RN0S46KhJwI/DPsWmsVjF3gQZbNOLfrDO2o=;
        b=IwtKhY+kmP0EjiBvhNn/8VhOxSmyvkD/It54fUfME6SsSACyGYb9ItJ3FrjGAZT4YO
         35EbHMFtmTHOiAqFPTS7Ckaom18qgB//xPnaO64OG86g7Jo/67edD3x39U8q5pAo8/vm
         5/ZyvLUZUP1W7AAozkAxRx911JN44I/Rvhr/viI1XNbUBDNcTLqFE9YgUxCa/qwMJVFh
         82XE/yKNOtX0PRs/hjkeWEoFKCt0whO4yfehW8Ub6XjsHYy5DiGxF9W72YN79jaMerGO
         1D7nH9p/ic/3Kfb/fcUST7DKmPY6TYJbjTnoCGt6C/lSSKHIKEj+e3UNxE5ckHQlp1i1
         Y5bA==
X-Gm-Message-State: APzg51CQ7B8KsvdH7NGo3vVprae7JatfcuqlviOv+7EGBPxi+eQar3Pe
        nMrffQG8+4isHmgEikejf7Y94w==
X-Google-Smtp-Source: ANB0VdZ7w/sDOgYgYrqbJwijOoX5johxlrWvhDHbfMyxIOLJzpa5P+M+GD0CUDm/69cD2d43Hic2KA==
X-Received: by 2002:a62:ed5:: with SMTP id 82-v6mr7109449pfo.198.1536307224906;
        Fri, 07 Sep 2018 01:00:24 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id o10-v6sm7788864pgp.70.2018.09.07.01.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 01:00:24 -0700 (PDT)
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
Subject: [PATCH v14 07/16] arm64: add image head flag definitions
Date:   Fri,  7 Sep 2018 17:00:31 +0900
Message-Id: <20180907080040.4967-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907080040.4967-1-takahiro.akashi@linaro.org>
References: <20180907080040.4967-1-takahiro.akashi@linaro.org>
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
2.18.0

