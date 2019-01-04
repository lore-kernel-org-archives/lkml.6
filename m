Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5202C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6D920665
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi72I7wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfADIqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:46:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44451 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfADIqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:46:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so17975618pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 00:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7kBuW9syjoQefDFmReZn+9HPOW1bgwXYJmYeXsBQgXw=;
        b=Oi72I7waeLj1XxOpGcH7libtx8g+7AdRvi5fTTYmbPYUJsxagnfcRarwhwIyPHpfpH
         jAShnxWLnSNdjFVw6PfsjWwSwo79dRufiULxAZ3Po0wPZ8oq0gvM5FdAzuNRyM/bl8tH
         CQ9JuVTgDRT4P9GEsfBG6wPsGGjqpppbLyU7kKBW97sRVCKn3ITCUrZJJnCDeXGnR9Jx
         wtglyMYv5c8DBOPE+LmLqUp0hphbMX019rE82D+1NwIqNLAtvriCuq+3fkvN4pOONz9S
         kHVFozjY3BuPEjWKstCpM1T0IiLveoUiPaS0l810ZFY5BR32E4AjN87z7gaJOeRSMEOV
         bOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7kBuW9syjoQefDFmReZn+9HPOW1bgwXYJmYeXsBQgXw=;
        b=roaOYseuAFDOEbFuwz/HiNdbeFv+qvX9+rCDVTEVBCMJhLtDSiPgXJcPEj03iHOAkd
         axRNFCoYMsCjxuNo0UBVrEzj0I9N2vHknfsVX5myiySKbHKov1BAShgHfGmld9HoUkUE
         LcLQojhVckjlp0Z7EjJKU05rWp+eXs5FAsoaeJRJRGiuyEMg65KQ99civ3T0GH352prv
         yY1hk6KI1/gt05MCsumhs3124P0i2Y/U60wZqxRHBrbFV61hYuydx0oSkanBJmjSYc0L
         1b5PypdlTxm6of/kFFXUYdhU/nzxHtWcuizHRwyS+Ek6H0+Epa2w+ecpOLlLb+BJWxmZ
         dAsA==
X-Gm-Message-State: AJcUukfLAJqH6uh7q6W2ogpgm8MPIVb67acNbYRAFje+UpEbYqp1eGYV
        vc1pYqlMgwF6Nv2sB3ZGbg==
X-Google-Smtp-Source: ALg8bN5c5EMlWuJ4VfZDcJYjEfL4502OPsgnyknrM2tnsK0962AVxLl3mjOE6J/IJ5Znb/7cQrDoDg==
X-Received: by 2002:a63:658:: with SMTP id 85mr885016pgg.373.1546591601640;
        Fri, 04 Jan 2019 00:46:41 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 184sm81190859pfe.106.2019.01.04.00.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 00:46:40 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/trap: remove useless declaration
Date:   Fri,  4 Jan 2019 16:46:19 +0800
Message-Id: <1546591579-23502-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no early_trap_pf_init() implementation, hence removing this
useless declaration

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org

---
 arch/x86/include/asm/processor.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 071b2a6..88a7365 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -742,7 +742,6 @@ enum idle_boot_override {IDLE_NO_OVERRIDE=0, IDLE_HALT, IDLE_NOMWAIT,
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
-void early_trap_pf_init(void);
 
 /* Defined in head.S */
 extern struct desc_ptr		early_gdt_descr;
-- 
2.7.4

