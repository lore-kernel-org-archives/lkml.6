Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D001C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EC5208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8xzNrmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EC5208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbeJATQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:16:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43348 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbeJATQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:16:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id p24-v6so615788pff.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nwOrqS42C2b7bMiiI2+G94+DumTNk9ZeUe61Ww87Pqk=;
        b=N8xzNrmI9xf6MPkdmnaKmr40Wxs+cLBXQa8qBcSj3iJ1nhhddl1RnzBqaDR77YDxVL
         z4LuaFEczTl42jr4jB5OhqyGh0w8lrQEnkJqQM+kyKFDiHxUVsDl0U7bnzDjC4Jsg80p
         nGOysTMCeaoYY5xyaT8GlXBlOxgzy2t6djMe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nwOrqS42C2b7bMiiI2+G94+DumTNk9ZeUe61Ww87Pqk=;
        b=bYwyogyxNgfzMe44jD8ENjY+xtUwhzY+Bdm/13w2EJy5+q0qwsf8yQKGB5LOXi+XJa
         aU5gUcV8tvPiWV8CU9soGcj9/umLaMmiAhh8spKG1DAfoENGSgqCAlpQy4FS3Dc57XQ/
         NlnmBPKNVBcCAFl7tV6dfzanHkKnSfDZiFP17ZK8/o6Nc+TBX9B/nm6MiQhHCB3+AB/o
         IsnQ5cB6rvlKNSj1pt0Ziq4XOTuVOZH1poGdq4D2NBNrOHAGD2k2Bv1NdrHyJ/gzRSvZ
         AtvBdL5tL1QuB0iMVbvXmbRk5jihtfzVvTajAGXptiwzwudfBJ8sh4xVfolYA481Em6m
         d/Rw==
X-Gm-Message-State: ABuFfoguess0fJcgQowyUQyExR90HRJJb0S0QhwaUrZgj55cnduGUxvJ
        5tiIQrN0bGxmUKAfaO2pkFHI8g==
X-Google-Smtp-Source: ACcGV63mxpXyFHt3r+78fiN401uj50Zbk/xg0tyfVDDXro+DfVMvRzdgTwfPGoG35OeocsoPOk81TQ==
X-Received: by 2002:a17:902:b612:: with SMTP id b18-v6mr11666237pls.92.1538397545578;
        Mon, 01 Oct 2018 05:39:05 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.59.231])
        by smtp.gmail.com with ESMTPSA id o12-v6sm21329345pfh.20.2018.10.01.05.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 05:39:05 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 5/5] m68k: add __IGNORE* entries in asm/unistd.h
Date:   Mon,  1 Oct 2018 18:07:57 +0530
Message-Id: <1538397477-4003-6-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org>
References: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __IGNORE* entries for seccomp, pkey_mprotect, pkey_
alloc, pkey_free, io_pgetevents and rseq in the file
asm/unistd.h as it is correct to keep __IGNORE* entry in
non uapi header asm/unistd.h while uapi/asm/unistd.h must
hold information only useful for user space applications.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/m68k/include/asm/unistd.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 5072e94..cc5f640 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -31,4 +31,11 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 
+#define __IGNORE_seccomp
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+#define __IGNORE_io_pgetevents
+#define __IGNORE_rseq
+
 #endif /* _ASM_M68K_UNISTD_H_ */
-- 
1.9.1

