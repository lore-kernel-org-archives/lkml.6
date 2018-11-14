Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27E5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A715F2250E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TZil/uQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A715F2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbeKNP2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 10:28:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33063 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbeKNP2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 10:28:42 -0500
Received: by mail-pl1-f194.google.com with SMTP id w22-v6so7213020plk.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 21:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=goExF1GBzjheC5xy4kMD7sglfgZ7pi4rKx0Y1n5HIek=;
        b=TZil/uQ5QxHCLAGGRLxHRiNCl5kwNPUF+bIr03M1Bn8I/Vpe+kLlkHKYO76ptTxB0j
         O+RshFPIXcK6cXYg9OUoOo+6PSCjQiwVvlabBJEOLBatSpghwHC8ezOr0LRKEhmNbtSv
         x22SZxMi0NT4EbExiLHJJMfexzEIXlIf0x+ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=goExF1GBzjheC5xy4kMD7sglfgZ7pi4rKx0Y1n5HIek=;
        b=HnnAouVs/4mU1ATQGN/FixrFSRNr8llL8mktaD8A914tEeIfXPFHZ2JfkNIptvLUmO
         Z69ztlqB3tM74I5C2jTdLPIVvgWNJ58E80vlkuw2lckT8H2WGzSenJmWWXjr7yGRGaXQ
         ZrcIRXnjSrOBLVWwvsbuSyS/z2Bk3wLV3WF9EX+5U4hyD1e1WSPLLe06tQAqXkGMv/qB
         VsFWiMSmkGpNtczIIGa5TbykLuNOZz6eKsaI4cSLJsvjx7zpjKmMsHteyUXd3DNvID0r
         f26AHgSPIoV43CEMHiKAiL0fZKI3yXxj0MMvGOeDILDySpTEBnDN/0OcBGsd79wQ0H/7
         KvNA==
X-Gm-Message-State: AGRZ1gL1h0SBAH8lDCWDZFiTCCpoNk8WFtS9IIqYwiOi/J/UcChOTtkL
        3w8jMTjJzyDrDL6YorSOGNBKQiuINJM=
X-Google-Smtp-Source: AJdET5erRq9iZ1sdmTeIwoF25R+/q7S5Q20rPmeNkSElFJHiNlD87Z5HogIpFr3CmTRP0TU9+pK8CA==
X-Received: by 2002:a17:902:ab81:: with SMTP id f1-v6mr506058plr.103.1542173223180;
        Tue, 13 Nov 2018 21:27:03 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 34sm36331746pgp.90.2018.11.13.21.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 21:27:02 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 1/4] sparc: move __IGNORE* entries to non uapi header
Date:   Wed, 14 Nov 2018 10:56:28 +0530
Message-Id: <1542173191-24981-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the __IGNORE* entries are resides in the uapi header
file move to non uapi header asm/unistd.h as it is not
used by any user space applications.

It is correct to keep __IGNORE* entry in non uapi header
asm/unistd.h while uapi/asm/unistd.h must hold information
only useful for user space applications.

One of the patch in this patch series will generate uapi
header file. The information which directly used by the
user space application must be present in uapi file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sparc/include/asm/unistd.h      | 16 ++++++++++++++++
 arch/sparc/include/uapi/asm/unistd.h | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 00f87db..73d2454 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -46,4 +46,20 @@
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
 
+#ifdef __32bit_syscall_numbers__
+/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
+ * it never had the plain ones and there is no value to adding those
+ * old versions into the syscall table.
+ */
+#define __IGNORE_setresuid
+#define __IGNORE_getresuid
+#define __IGNORE_setresgid
+#define __IGNORE_getresgid
+#endif
+
+/* Sparc doesn't have protection keys. */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #endif /* _SPARC_UNISTD_H */
diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index 45b4bf1..d37a136 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -434,20 +434,4 @@
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
 
-#ifdef __32bit_syscall_numbers__
-/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
- * it never had the plain ones and there is no value to adding those
- * old versions into the syscall table.
- */
-#define __IGNORE_setresuid
-#define __IGNORE_getresuid
-#define __IGNORE_setresgid
-#define __IGNORE_getresgid
-#endif
-
-/* Sparc doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #endif /* _UAPI_SPARC_UNISTD_H */
-- 
1.9.1

