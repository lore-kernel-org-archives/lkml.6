Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCE7C04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666CE214DE
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8xRq3bI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666CE214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeKUOro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:47:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43921 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbeKUOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:47:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so3503024plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 20:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qKx2DGfS1C19jw7NY3t4lVOTAQM2/ra3r7ahK7MpGHs=;
        b=S8xRq3bIwvFh+q51xM+mEQ0+/8UD8797f5LcQc9wQknYLBr8VA1tfmeV82z4cgykj0
         00vK0arCUCO6hRhIAKy1TaMyESdyeBY/d6CSsNRG5of22lKdhUG6QT92aNIdVdzxysB4
         3VftsWe6PLMlIcjZ8G/4BwE2U8P3Vfe7E5C2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qKx2DGfS1C19jw7NY3t4lVOTAQM2/ra3r7ahK7MpGHs=;
        b=cTi+sQt2i0WtN9mDdpkqRSkf0c1Z300Waf2RELhSzbS0w6XblWeXjIJPk8UKFgUqB+
         fObyKGx9gOz9828PwZwK5WAQnyhGH9CgGYhk0Qls8jJ7XTYx+LFPDj4Utj5yH0ccvmuw
         LKVYkzrpiqGH1olVLa/gUpnZD4Xr/eLdTT9xVM0B9LhzwLUVRjCmLjIo4JxrpJxWF+8W
         lpP8kKr8hPAhF1HVL9cNqhV2JiKjp8h4IOZrhv0HqtWz+v0lwyRRNrfyBW8UrG4rMMkx
         Drs9jUdKdLxc8CXaLa6lZW0LxAMMj+ZBiY2pp7nut7VTXvg7iMNjEgYk9YfGUMObTRbW
         566A==
X-Gm-Message-State: AGRZ1gIYZ8JNZ5VA6krlk5uBEXwKNplKhfHBnly2Akh6jRA77At/synd
        u9wEi9b2rW84RYM3eQSDcyv6ig==
X-Google-Smtp-Source: AJdET5ddLclCeat1blKGPm4KpoNMiXmY5c993EK/mlk9aG7vmpK4cNSDb+Y+knlWamnjRfcI6tLgjw==
X-Received: by 2002:a62:7796:: with SMTP id s144mr5145861pfc.26.1542773702000;
        Tue, 20 Nov 2018 20:15:02 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id v124-v6sm10818712pfb.182.2018.11.20.20.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 20:15:01 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v8 1/6] parisc: move __IGNORE* entries to non uapi header
Date:   Wed, 21 Nov 2018 09:44:25 +0530
Message-Id: <1542773670-25460-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542773670-25460-1-git-send-email-firoz.khan@linaro.org>
References: <1542773670-25460-1-git-send-email-firoz.khan@linaro.org>
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
Acked-by: Helge Deller <deller@gmx.de>
---
 arch/parisc/include/asm/unistd.h      | 6 ++++++
 arch/parisc/include/uapi/asm/unistd.h | 7 -------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index bc37a49..fd1013f 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -8,6 +8,12 @@
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
 
+#define __IGNORE_select			/* newselect */
+#define __IGNORE_fadvise64		/* fadvise64_64 */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #ifndef ASM_LINE_SEP
 # define ASM_LINE_SEP ;
 #endif
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

