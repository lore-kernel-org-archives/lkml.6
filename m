Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B471C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA4C2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyBfxHnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA4C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJHM1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 08:27:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41874 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeJHM1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 08:27:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id q17-v6so9497973plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 22:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVc4Im/tlNb/+Q87+YSUnQ6E1heQGbWRIcznReQrtGM=;
        b=KyBfxHnFkcRqSuq3BEX40+PmIgpZ/JjKXlH83WSrXXlI2/lbIil6yptjcfZGHxPk4X
         Bcuk7uco7PexeEHh4bY9PGDq4DlvwL/Cp7wfsd1dD31dmvPsppH8i1r+foQYmlaWc0mP
         WtcnfAFlgDDZpLJWFCsgMTGZEb6iDPuUJGpZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVc4Im/tlNb/+Q87+YSUnQ6E1heQGbWRIcznReQrtGM=;
        b=EFjIeIsBp8oBkaGl+yN8fAC5XmkJ7dqDfkhyrKX7VRWw+hS6e2VGMfdPgeKq35GT6p
         DvJpETs13FqIc8D8mX1Os5G5Jlw0vLM1aLn9+rfcgTYOvmQRUGMNl8A54UBUe2JSX55Y
         dh9M5G/ABkhoz3SxzHwB2KhpU6+fUWKte2msDEt6Ct9VYyo0nWhroduYvlkjvFJM/HFL
         ZSd2Jp7vD0H91dPx9VjtIyjYFTITNfC8v970b3evmWfwGO4XG5KQLW3jVuEiZxegqt4u
         rkQeJat4vm8xtvOAISu/o+QTA3+/MH8rBj42udJdsRaxwJG/1Qor/KSVLErNitnyZ+Zh
         swJg==
X-Gm-Message-State: ABuFfohg05HHp9pmLyfAxuV8eFEbvLnK9P9S6LRXakM3j8fLCAS5pkOP
        n4pr/u8gRaf/Lh500XVmSvLuug==
X-Google-Smtp-Source: ACcGV63HwWee89JOu/tQMZC0DT1DTgLKCbbcBV+UNp9noWbIJ+pOv3yc/u8rU+hSghWQZVSi4zsbSw==
X-Received: by 2002:a17:902:7002:: with SMTP id y2-v6mr23242483plk.125.1538975843597;
        Sun, 07 Oct 2018 22:17:23 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id j19-v6sm1875919pfi.137.2018.10.07.22.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Oct 2018 22:17:23 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 1/6] parisc: move __IGNORE* entries to non uapi header
Date:   Mon,  8 Oct 2018 10:46:36 +0530
Message-Id: <1538975801-13735-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the __IGNORE* entries are resides in the uapi header
file move to non uapi header asm/unistd.h. Basically it
is not used by any user space applications.

It is correct to keep __IGNORE* entry in non uapi header
asm/unistd.h while uapi/asm/unistd.h must hold information
only useful for user space applications.

One of the patch in this patch series will generate uapi
headers that should present in the uapi header file. And
some of the information which directly used by the user
space application also need to be present in uapi file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/asm/unistd.h      | 6 ++++++
 arch/parisc/include/uapi/asm/unistd.h | 7 -------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 3d507d0..93fd9f6 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -8,6 +8,12 @@
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
 
+#define __IGNORE_select                /* newselect */
+#define __IGNORE_fadvise64             /* fadvise64_64 */
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

