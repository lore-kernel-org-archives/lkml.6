Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A99FC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E4520866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cq1H+3ro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E4520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeJPOxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:53:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42435 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeJPOxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:53:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id c8-v6so10518840plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 00:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KU6DXIIYUjCMDre4JgDcgc8e7hiA/7vLtU/zXJn/n5E=;
        b=cq1H+3rog/MGkmoVEHo1HyK+notT9Hrc9j6PhcK11KQ+aG6SB0VadnNb5h1R+YTVfv
         5ttIYFuslE6Y8RhThcJpJTH+QAeayrxrTZVuYo76fupdGBnw6S26NrzW+m4cdt79eI1X
         N5SUCZLR0PYSBLgUQX1slJDwQ8TQkzuuDkvW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KU6DXIIYUjCMDre4JgDcgc8e7hiA/7vLtU/zXJn/n5E=;
        b=sS1qvzW6xYVduCQtCS/Q6i/vs1+8kO5o5rdv9VQLoqw1LHCDPptSWFbMfuOqrDOE0C
         FScFVxs9xHEcBlxGGMgDEsDAevnmf/4uF1/dBIM1BRzwrP2Qwk1YqrwSLqLUqd+gn4Id
         +q806dO2mVW2akRqRjlrWFl0yBlQMyTM0N0HGJEuZmPy5yWPNWXxC6uQhBf84CrpEjyz
         A+/fQWX9Qap2CmhWrLQti03XWh9X9T0lE/6EIYUQYywagQGba/dPZxpg/bsDqF9oaiu3
         4QOZBGU/M7VEOdvup4Ja9J6x5zlRBjkbCh8w+tJfBmz9QN286nkVBpopcxC/HgS0q7Jn
         KUIA==
X-Gm-Message-State: ABuFfohxJv1uNVXSoeey+vDNf1qXZp8TH3PvhtChIbJrl/fsOpMox0Gj
        o6qV+8axaj6IWlKNlTsLvm7J6w==
X-Google-Smtp-Source: ACcGV60nSlXphrDivYOmfhjjUrI0lSkdHpPrLXmPYnoMx3ivz0juLRfO5C+38BrHgnvB0r+l3Y2rtA==
X-Received: by 2002:a17:902:a606:: with SMTP id u6-v6mr19537091plq.69.1539673452493;
        Tue, 16 Oct 2018 00:04:12 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id u21-v6sm21775107pfa.176.2018.10.16.00.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 00:04:12 -0700 (PDT)
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
Subject: [PATCH v5 1/5] parisc: move __IGNORE* entries to non uapi header
Date:   Tue, 16 Oct 2018 12:33:34 +0530
Message-Id: <1539673418-7279-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539673418-7279-1-git-send-email-firoz.khan@linaro.org>
References: <1539673418-7279-1-git-send-email-firoz.khan@linaro.org>
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

