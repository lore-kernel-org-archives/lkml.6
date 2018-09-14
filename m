Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AADBC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1387F20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ReRJhFlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1387F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeINNkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:40:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33206 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbeINNkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:40:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so3976975pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MZaHj8J1zXAeXdwHoWi62dASpANMGH5B+ollkuVTPh0=;
        b=ReRJhFlIE1rwNnRZhQTD256roF5vNFa0NoCjDeupyccqAHtW/xTlwy/deOZeKBnNpm
         cHN+u3uLhOdIC2PqRY4aswuk1u3o0WTg7+n60B2ujePxtWyvcoAjAEKBkTZ6dE1B+gcY
         q0gg4Y1AaODXRPg4rpkXKKlr8dgAQnnBKijRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MZaHj8J1zXAeXdwHoWi62dASpANMGH5B+ollkuVTPh0=;
        b=a6I8pimtjH95j68sEAKnC6Pq3G/nlxyrlZKjkutkus3oR9IBtvEWbETjjB9Lp2MsM5
         ZDvk1hahf+cZ0P4vYK+KI6SQNWHBQPZhNCmM683WkhSPVtgmv1gm+zU+YuOdjoIphA2A
         ed2gxokWxGj2VDBE9XQ4BFLfQY5l6XLtmnDUsvp5nMn2We0L61DAfvJQgT4FzGGJ6DLX
         vtjt7G1PnD6yvVtMF2J1WmYwSRF+qc5OxepJNHOHS0v/Y1EReRGePBfguc+xR84UduQH
         CAF2qjhnKXNteohAFOkgaMsQs/mAJ5+n1P1j5Ye46PFA3GefmuFQC2sNL0dQBo7bbNmx
         pC1A==
X-Gm-Message-State: APzg51DYmR/7lAF7kXJcAPbSx583cw/8IiFyaJTur17cYreOUNG5/zph
        6WQkCZVCNl4ypGrsixAJuXKm/g==
X-Google-Smtp-Source: ANB0VdbYVQ4W0GG2SOkOP6lXPmKwjkET7v+QF0Jf2XeT1XXD0j2U6mmkUodMdO/fkd/yrdI9oXSPMA==
X-Received: by 2002:a63:e841:: with SMTP id a1-v6mr10537822pgk.126.1536913643788;
        Fri, 14 Sep 2018 01:27:23 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.60.83])
        by smtp.gmail.com with ESMTPSA id q80-v6sm8919855pfd.15.2018.09.14.01.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 01:27:23 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Thibaut Varene <T-Bone@parisc-linux.org>,
        linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/4] parisc: Move __IGNORE* entries to non uapi header
Date:   Fri, 14 Sep 2018 13:56:40 +0530
Message-Id: <1536913603-4584-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536913603-4584-1-git-send-email-firoz.khan@linaro.org>
References: <1536913603-4584-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the  __IGNORE* entries are resides in the uapi header
file and it is not used by any user space applications.

One of the patch in this patch series will generate the
uapi header file and system call table file. So if we move
all the __IGNORE* entries to non uapi header, it will simplify
the uapi header and system call table file generation script.

It is correct to keep __IGNORE* entry in non uapi header
asm/unistd.h while uapi/asm/unistd.h must hold information
only useful for user space applications.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/asm/unistd.h      | 6 ++++++
 arch/parisc/include/uapi/asm/unistd.h | 7 -------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 3d507d0..fc71edf 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -165,6 +165,12 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 
+#define __IGNORE_select		/* newselect */
+#define __IGNORE_fadvise64	/* fadvise64_64 */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #endif /* __ASSEMBLY__ */
 
 #undef STR
diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index dc77c5a..bb52e12 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -368,13 +368,6 @@
 
 #define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
 
-
-#define __IGNORE_select		/* newselect */
-#define __IGNORE_fadvise64	/* fadvise64_64 */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #define LINUX_GATEWAY_ADDR      0x100
 
 #endif /* _UAPI_ASM_PARISC_UNISTD_H_ */
-- 
1.9.1

