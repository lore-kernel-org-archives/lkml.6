Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721972087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzn2fYfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfBYIAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:00:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41328 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfBYIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:00:11 -0500
Received: by mail-pl1-f194.google.com with SMTP id y5so4115013plk.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 00:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zGDEPItGaPdD8yt6wjb5Oz3a3s/XKB16QwOPJuthCCI=;
        b=rzn2fYfWKXx7eZ6xjEhCWY2G2VDBnptjory0a+4uAVKmaMZgQUKLCMzylINj/5D1J9
         ITCQV32V2PS3JGwxPeze+Rdc7JW33aw15GLWpqz6jIccx/evvBNvpbhOzw417hB/77QC
         YCGwCO2CZNeF62XLcl5QsuoOSLC+XX9WkoMxo6uTJhVef47HM3ClMz+0cYwqtmeyZRNW
         f+z9iAS3bKu+pKCrUpN2fw8BVZBcZn5G9K49lcmTppVGnoDQXzhkeoPHcxaYI+HN50qv
         TmeSSWxkUVCPC/ay0YYfyli8roV9iaLhunBUp/zOQjcsP6ysJIeZso3+WVHGcj/ckybh
         3P1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zGDEPItGaPdD8yt6wjb5Oz3a3s/XKB16QwOPJuthCCI=;
        b=MVtJZdrLxLK2EMuhQQMrHQzQqMlP/XEUTTOFH1JE1zp7Luh52KXjbKndadWQ5R1vot
         93W6WReK1B8xz8NJS9dDK1AuXn265km2Q56bGlV8gNa2/t/9aMjFXU+LvEr8hyzpQIfX
         yKX3Kp/TvOXtpKSLhfwvzo/ztXIWRkxWNuYwmSFFpJh+cJVFhRztZtuLiIHIA9JcyIWu
         yK6Nsx/UeFVSg/xqa4iWUd5jX7l4Ps8n2exu0U5hh8c9TAT+ERGLxncRwxHqZmfri6U/
         a3Ch3i2v5pzC/IsGI+Y4uYrYCYJxilfEgjlajsfDJe5hIbCmAU+z5ZFX93zG8eTn9dpG
         X63w==
X-Gm-Message-State: AHQUAuZIvWyFxoBBF29bfcFGDP2GVIvxFWS7yMO3P7H7e6agNO9BrkPQ
        fRLuQ7/xX9g9QKvOAKMKdg==
X-Google-Smtp-Source: AHgI3IbhnVFCQHOvKdTMDrRzZYgb5y4SzmqahcqkmNpgU7MH8Q+R9cGJfEVI+JUzmCMP9riboY8UXA==
X-Received: by 2002:a17:902:be15:: with SMTP id r21mr18514808pls.143.1551081611097;
        Mon, 25 Feb 2019 00:00:11 -0800 (PST)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w10sm11772456pge.8.2019.02.25.00.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 00:00:10 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/boot/KASLR: skip the specified crashkernel reserved region
Date:   Mon, 25 Feb 2019 15:59:56 +0800
Message-Id: <1551081596-2856-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crashkernel=x@y option may fail to reserve the required memory region if
KASLR puts kernel into the region. To avoid this uncertainty, making KASLR
skip the required region.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/boot/compressed/kaslr.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 9ed9709..728bc4b 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -109,6 +109,7 @@ enum mem_avoid_index {
 	MEM_AVOID_BOOTPARAMS,
 	MEM_AVOID_MEMMAP_BEGIN,
 	MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
+	MEM_AVOID_CRASHKERNEL,
 	MEM_AVOID_MAX,
 };
 
@@ -240,6 +241,27 @@ static void parse_gb_huge_pages(char *param, char *val)
 	}
 }
 
+/* parse crashkernel=x@y option */
+static int mem_avoid_crashkernel_simple(char *option)
+{
+	char *cur = option;
+	unsigned long long crash_size, crash_base;
+
+	crash_size = memparse(option, &cur);
+	if (option == cur)
+		return -EINVAL;
+
+	if (*cur == '@') {
+		option = cur + 1;
+		crash_base = memparse(option, &cur);
+		if (option == cur)
+			return -EINVAL;
+		mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
+		mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
+	}
+
+	return 0;
+}
 
 static void handle_mem_options(void)
 {
@@ -250,7 +272,7 @@ static void handle_mem_options(void)
 	u64 mem_size;
 
 	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
-		!strstr(args, "hugepages"))
+		!strstr(args, "hugepages") && !strstr(args, "crashkernel="))
 		return;
 
 	tmp_cmdline = malloc(len + 1);
@@ -286,6 +308,8 @@ static void handle_mem_options(void)
 				goto out;
 
 			mem_limit = mem_size;
+		} else if (strstr(param, "crashkernel")) {
+			mem_avoid_crashkernel_simple(val);
 		}
 	}
 
-- 
2.7.4

