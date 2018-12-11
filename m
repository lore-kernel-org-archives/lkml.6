Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450C8C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B98320851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFXver8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B98320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeLKU2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:28:18 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33404 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKU2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:28:18 -0500
Received: by mail-yb1-f195.google.com with SMTP id f125so7292210ybc.0;
        Tue, 11 Dec 2018 12:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9pg+Er4J0Oi1AGkskDng4P2kVR6Lyc0oMT3zgFqDETI=;
        b=qFXver8iCBR7xQvaVb0mTKM3hggNdEo7sogJes2KB/iuUTiAHe3FnEJJKaPSho5Ju2
         dengnXvVhaanwmrnucLvZH9JXZ01BqI466NkBUfp+9r/W1yFtyICQrAHL2nw8Y4LlaWI
         vMxMofCCeudVYbKtDZkj9+ZufYAsVn9Oitfv54ssR0Kz7VW0kFCUeGUgwxUqzFT3DBzo
         oX8yTJ4+aK7/7HHlNO9fW57caKea7IN9t/SDt4QIc/v/PdNnCOigtFMj/yV60ll+RPMh
         2OTTw4w11e23eF/PzCUhO2xZiFgpCQjjeMTm76N2RO41m8XnOAs1yKVqeKbMSl5Mjj+Y
         wPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9pg+Er4J0Oi1AGkskDng4P2kVR6Lyc0oMT3zgFqDETI=;
        b=aQ0/6/Wne3iMvfOsSF/c06F9oR69R7YN55/SfomAXYDvTHJ82PKOj9uGuhWQlVK0wS
         nDLqMOpp32KkK3S0OxE4wMSxO+omEB2Y8gnbzr/5WF9pSLzL65MWqCiJLTJGGrMkFQCh
         YCptujferBj1DTWBHZRTtCQmo0sS22YL0FOU2yOJo0TDzUE4UJUNTySkKerMTPr/suc7
         n/1j4Zd/aLsEg0qHXIgI0FuMDONcgYe5xJCn82MDfr8GXKx/HHXjc8XIV53GK1KWgodp
         ssDUifGw89r95Cyh3Ah2cW9eComugdPLB/+lQuNP4aHyiFATARYy2OjokxoPAc5Zwd26
         BbtA==
X-Gm-Message-State: AA+aEWZAsLsqfoXQF9tw1U0CW+gxfMNJ220coGvWnHbEjfh1BUgQD46t
        SHmlLzqdfuhr+tn+dxwTcdE=
X-Google-Smtp-Source: AFSGD/UDyMbzUPfAOWhLerGAhrv5Mj6vdRf/Vu4+3ctkeneiqWiApn33q1D00tpJImz/N6v6BVLQpQ==
X-Received: by 2002:a25:e86:: with SMTP id 128-v6mr17532720ybo.184.1544560097117;
        Tue, 11 Dec 2018 12:28:17 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id l35sm5415078ywh.48.2018.12.11.12.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 12:28:16 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v2 3/8] arch: sparc: Override struct __kernel_old_timeval
Date:   Tue, 11 Dec 2018 12:25:15 -0800
Message-Id: <20181211202520.16799-4-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211202520.16799-1-deepa.kernel@gmail.com>
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct __kernel_old_timeval is supposed to have the same
layout as struct timeval. But, it was inadvarently missed
that __kernel_suseconds has a different definition for
sparc64.
Provide an asm-specific override that fixes it.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/uapi/asm/posix_types.h | 10 ++++++++++
 include/uapi/linux/time.h                 |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/sparc/include/uapi/asm/posix_types.h b/arch/sparc/include/uapi/asm/posix_types.h
index fec499d6efb7..f139e0048628 100644
--- a/arch/sparc/include/uapi/asm/posix_types.h
+++ b/arch/sparc/include/uapi/asm/posix_types.h
@@ -19,6 +19,16 @@ typedef unsigned short         __kernel_old_gid_t;
 typedef int		       __kernel_suseconds_t;
 #define __kernel_suseconds_t __kernel_suseconds_t
 
+typedef long		__kernel_long_t;
+typedef unsigned long	__kernel_ulong_t;
+#define __kernel_long_t __kernel_long_t
+
+struct __kernel_old_timeval {
+	__kernel_long_t tv_sec;
+	__kernel_suseconds_t tv_usec;
+};
+#define __kernel_old_timeval __kernel_old_timeval
+
 #else
 /* sparc 32 bit */
 
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 6b56a2208be7..04d5587f30d3 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -63,10 +63,12 @@ struct __kernel_itimerspec {
  * here, this is probably because it is not y2038 safe and needs to
  * be changed to use another interface.
  */
+#ifndef __kernel_old_timeval
 struct __kernel_old_timeval {
 	__kernel_long_t tv_sec;
 	__kernel_long_t tv_usec;
 };
+#endif
 
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
-- 
2.17.1

