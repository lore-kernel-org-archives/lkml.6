Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B719FC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0092075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsTij8O5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0092075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeJLRQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:16:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41560 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeJLRQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:16:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so5919449pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVc4Im/tlNb/+Q87+YSUnQ6E1heQGbWRIcznReQrtGM=;
        b=jsTij8O5YnLoI7FpArSnzHoCFW4SBVzcFrAUDNh+4a5gaAXcU0dcCiwyI5bK3KoFsx
         TkNxgTnvML3kJW6vW1xbn+c83oUtFkJmPRBqY6KD/m8McvoUfEqTYNbw6vp8XrcyRKOa
         OiYJYHE41od+I52BhbYfNfyZdE/x51bwV/XTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVc4Im/tlNb/+Q87+YSUnQ6E1heQGbWRIcznReQrtGM=;
        b=t/yPPmfBkzYAZIH9hBsiuGLxJGJfn4W+Dv8+qY7BeyTFi/tPo5Yp3kJeNbRdw4coyL
         Q0HmfJvHVgJL1plKVTSslrIgEtXx/Xa5/jPjaXNwB/ASiNlFR8m2alvVF6uAyPG0kGCN
         +MI1nWEd7yQrIfy5iG2tz5uxhws29aG+mnlbS29nHIWd02wnkLuNSIbTQ/cY5h/B700p
         1KHLtW09pjo+l11PC2WbIeIRt0Dn+MBW9ZAu1IClAZs3bd7nsWy8P1CuKvb+BOIKxxfh
         ko87dJ9Z+b5+xW8ROh8m1if+YarJe8ba+hCrxAxWdIeTAipPwdUbdXgY45edD/SRbLfQ
         Q9dg==
X-Gm-Message-State: ABuFfoio/tEU666Bm5LDcCFO6e1B10zW1xT5l7kK1kYuCY6OWkwcAcN/
        qCCWzdmKGdjRfGgVBfXNcFMFWg==
X-Google-Smtp-Source: ACcGV62B4T1FEIRQYXcHRLKWiV3hveh8vy3otpBaLtK0N+Q3TD1OuHV+d+aI/tDZmyazha6SQD4qmA==
X-Received: by 2002:a63:6883:: with SMTP id d125-v6mr4849471pgc.451.1539337487290;
        Fri, 12 Oct 2018 02:44:47 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.108.175])
        by smtp.gmail.com with ESMTPSA id j19-v6sm1254191pfi.137.2018.10.12.02.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 02:44:46 -0700 (PDT)
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
Subject: [PATCH v4 1/6] parisc: move __IGNORE* entries to non uapi header
Date:   Fri, 12 Oct 2018 15:13:57 +0530
Message-Id: <1539337442-3676-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
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

