Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7D3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2C921104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHNXTKrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2C921104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeKUVq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:46:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35290 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbeKUVqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:46:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id v1-v6so5093869plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 03:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YZBuOxpj38mn+YM/mSI7MokUl//bWowKjwc5o8VwSVQ=;
        b=DHNXTKrtwFRnARBdJmkcwY9qYZa+5jnp8W2BrZ92y31kbW8xtdNTWqGZIN052ADS7L
         xf2zM1CMoIoCuvPMHo23F3BRbfmzhMRtiWDfIh162sNp0qkdS/9KwZK9GWN95904WNV5
         vaI47X0W84k/MO5ymDSO0ZDGtQU/CAxe2s2oL/XM/zADFxf72bvw0nGJGr6PtTujZmqM
         +rTKEBYKXKvJZlS8+W9/CJQsuw3PrpZfx2zqunER9hmTU/m/yFMSJM4gCqysAYy3xJEg
         Z2a1U6xf89PznwSKEnoGe8ypF0tOBShOsHqNF1sScYHzHf/RhntAjKNsh/yGyRF7R0z4
         HjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YZBuOxpj38mn+YM/mSI7MokUl//bWowKjwc5o8VwSVQ=;
        b=E6su7L3YHIfjj5+XE1+LoNrfIPtCMSrugD3QAbAyEQ0knqdipAR5kZ5yJmRN6ltuco
         3tcflw1Vkpgvo13TNKu+fad2UdLF02ZsAHf+RGoMIyr5n9eZFnPzLVTwOLMiq9gbafQl
         jz9sR/1akF8qM6gqKN043XznR0T4x8Wocpjr3XCD3Qah6WIvz4g816LmoKemsstUNGVB
         EEYAqRKBSNVAjzLlZpnl+/9LIQC3MOyM5kvgRB3s50nO0w9Rc0TqAmX3kKtzR8gvb2IH
         7nJOukX25tLFSoubgnGQFDlvpdDweFfyxIVWAcaHQUqYJWuclglaSIVZbNpA6et5AUCQ
         lcQQ==
X-Gm-Message-State: AA+aEWZ53VLrCECDhUP4PbXn3BWhO2god7PMMXMK4xOTdOSkda1h9RaB
        d9Fa+aPVYmlUKRiw5neTxgs=
X-Google-Smtp-Source: AFSGD/Vox3NIUYXVCrmdoTKCnfKBxvgwio4VaYF/QKer8EFCI7TrNKg2JuVAMv1yV3Kh3qQ6T8UGcA==
X-Received: by 2002:a17:902:d905:: with SMTP id c5mr6198212plz.43.1542798777060;
        Wed, 21 Nov 2018 03:12:57 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id 7sm40878654pfm.8.2018.11.21.03.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 03:12:56 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] arch/x86/kernel/process.c: avoid unnecessary NULL check in get_wchan
Date:   Wed, 21 Nov 2018 19:12:14 +0800
Message-Id: <1542798734-12532-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the task p is always guaranteed to be non-NULL.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 arch/x86/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c93fcfd..3c3ee89 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -730,7 +730,7 @@ unsigned long get_wchan(struct task_struct *p)
 	unsigned long start, bottom, top, sp, fp, ip, ret = 0;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (p == current || p->state == TASK_RUNNING)
 		return 0;
 
 	if (!try_get_task_stack(p))
-- 
1.8.3.1

