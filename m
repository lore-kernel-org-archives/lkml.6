Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B11C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDA820827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="NN8NV2xN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDA820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeKJIyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:54:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34047 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbeKJIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:54:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so2980964ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bpti9kZw/T7PG4L2L6dJ8g02XfdGZhflFXVDEygz3qU=;
        b=NN8NV2xNO5kVUTMLSiI/V5tl3hQ1bgMvAtSpQd1oGPYrZCxYpZ3P/Sde6G/FUGvAL9
         W4TbRbth8ZGPYkyd0DwH4VrsuZBy9pnImRNsLEedUDea/6Hx8aKn8hzXfIMCfOrQ46YQ
         +v7IjySxhLfRDpaPipfoyAJqy5+RcNcSx7x4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bpti9kZw/T7PG4L2L6dJ8g02XfdGZhflFXVDEygz3qU=;
        b=T0U/x6G2TL9l/cyahcBMvFYITy5832fRcYgPOhOLjw8F4zWMhHyCoQ/612Hy7g4CeD
         Fcg6CUcjyoFayNrmLeCEoCfKFpr3UyGjZloU+E79J5ENsq51joOLmAdZV/KNAWXzbkRM
         oSAvchW+5Z7e9ZqlGSZvBV0FoFxZuFTAlSDnD1Af2qP6jSoEAvopbV17BEof+BE08HHr
         X66OfdR2GVrUWEqn7m4T1hBsSFMEcT9m+oJ/URjZiGV+jpg2lxvLB28C+hUcD1D3zQFi
         gYCQ+dD/hiH+3KAcF1DWuS4ILJFEAxEbASdus4s8U+7NrDkgRWht06LKneEeLFzFL22f
         3dLQ==
X-Gm-Message-State: AGRZ1gKVVik1TC5enZp0ie4WHNV+xG31heTZww0nagLVCZmnWNtScYll
        m9jMGgFky2gy/hg9l2vBkW3e6cpv6/stbg==
X-Google-Smtp-Source: AJdET5fVDvw7R1hY2+eWpBYmPa55rf61VA7Vgz3Lq68JYec59MoJfSJidLPrxCv23XCc/l+gqMddSw==
X-Received: by 2002:a2e:2e1a:: with SMTP id u26-v6mr3283700lju.8.1541805085747;
        Fri, 09 Nov 2018 15:11:25 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:25 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v3 21/23] jump_label: move JUMP_TYPE_* constants to new asm-generic file
Date:   Sat, 10 Nov 2018 00:10:19 +0100
Message-Id: <20181109231021.11658-22-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
 <20181109231021.11658-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to need to refer to the JUMP_TYPE_FALSE and JUMP_TYPE_TRUE
constants from asm code. In order to do that, move them to an
asm-generic header and define them using the UL() helper macro.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/asm-generic/jump_label.h | 11 +++++++++++
 include/linux/jump_label.h       |  6 +-----
 2 files changed, 12 insertions(+), 5 deletions(-)
 create mode 100644 include/asm-generic/jump_label.h

diff --git a/include/asm-generic/jump_label.h b/include/asm-generic/jump_label.h
new file mode 100644
index 000000000000..ff72c4c68ce3
--- /dev/null
+++ b/include/asm-generic/jump_label.h
@@ -0,0 +1,11 @@
+#ifndef __ASM_GENERIC_JUMP_LABEL_H
+#define __ASM_GENERIC_JUMP_LABEL_H
+
+#include <linux/const.h>
+
+#define JUMP_TYPE_FALSE		UL(0)
+#define JUMP_TYPE_TRUE		UL(1)
+#define JUMP_TYPE_LINKED	UL(2)
+#define JUMP_TYPE_MASK		UL(3)
+
+#endif /* __ASM_GENERIC_JUMP_LABEL_H */
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 5df6a621e464..989fa8c328fd 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -119,6 +119,7 @@ struct static_key {
 
 #ifdef HAVE_JUMP_LABEL
 #include <asm/jump_label.h>
+#include <asm-generic/jump_label.h>
 
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
@@ -194,11 +195,6 @@ struct module;
 
 #ifdef HAVE_JUMP_LABEL
 
-#define JUMP_TYPE_FALSE		0UL
-#define JUMP_TYPE_TRUE		1UL
-#define JUMP_TYPE_LINKED	2UL
-#define JUMP_TYPE_MASK		3UL
-
 static __always_inline bool static_key_false(struct static_key *key)
 {
 	return arch_static_branch(key, false);
-- 
2.19.1.6.gbde171bbf5

