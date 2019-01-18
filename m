Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1BEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9745D20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B5is7oZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfARK6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:58:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37032 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfARK6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:58:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so4058984wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KEDamF1G6iG0yJARiV0f8WcLBjigYpz1ziosX686/wc=;
        b=B5is7oZMBWOvsBwStWjLCig5yDrvlpDdrOQaVttA4OM8lJLR8PUJgLQJuSn3uOAbM+
         zfoXjGMTFKVFLsSR/uyYRuHpLI6LaXCt0F2x2foHcdKCMAKbVas/ppLo3H1u0lyBb8lB
         5+hBoZaZERPR79NwjidOakjyX/n+JWU0dD5xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KEDamF1G6iG0yJARiV0f8WcLBjigYpz1ziosX686/wc=;
        b=rnpWctY/BjGZyzEXs03ICSvHOLeZrKBuZunzJMcyfYm4Q4KgMFhnsS5Qqk/6kEJih1
         rF1CynTwLoa5it+JCBVXsPQB9qw+KsrCpZeWr5O4vNhsiOvOAGwmmtjSSfLsUsc0PBYU
         qpoQVUCc8jTGHPDeOnqHQKxJkyPPlXyLQ8rHyKKb8/ebr1ofT41J23+C2fevPIgBs2Fa
         Si7qNeJowXZqGirz/fXRJxKObDae49eLzIzotPNESjGHoUc8nVCl35MHoKZ/8qcpTKC5
         Jfsmk58TYaAz0xMdfQrELhI2+oGjCm5okyENqX3wqD7lRIeATZ3TgysCq+m0khZ6L/x5
         8i8w==
X-Gm-Message-State: AJcUukcfCe9oLrdoWz+iw3rGD75oRETfod8NtwNvhTNorsPfgyYMk8od
        9DcV71GsYicOBbQax7fg4RT1BDTNympNvA==
X-Google-Smtp-Source: ALg8bN7qCWn/ViMIVnXJ1q67toJGgsTW8ewMP7OlvOby9t/lrnuCQtV3qoXuPoluDUv707tzxfr6vg==
X-Received: by 2002:a1c:a104:: with SMTP id k4mr14994971wme.54.1547809092789;
        Fri, 18 Jan 2019 02:58:12 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-20-152.w90-86.abo.wanadoo.fr. [90.86.223.152])
        by smtp.gmail.com with ESMTPSA id y13sm65345467wrn.73.2019.01.18.02.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 02:58:12 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     keescook@chromium.org
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kugan Vivekanandarajah <kugan.vivekanandarajah@linaro.org>
Subject: [PATCH 1/2] gcc-plugins: arm_ssp_per_task_plugin: sign extend the SP mask
Date:   Fri, 18 Jan 2019 11:58:06 +0100
Message-Id: <20190118105807.26425-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
References: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM per-task stack protector GCC plugin hits an assert in
the compiler in some case, due to the fact the the SP mask
expression is not sign-extended as it should be. So fix that.

Suggested-by: Kugan Vivekanandarajah <kugan.vivekanandarajah@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
index de70b8470971..a65fbefb8501 100644
--- a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
+++ b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
@@ -13,7 +13,7 @@ static unsigned int arm_pertask_ssp_rtl_execute(void)
 	for (insn = get_insns(); insn; insn = NEXT_INSN(insn)) {
 		const char *sym;
 		rtx body;
-		rtx masked_sp;
+		rtx mask, masked_sp;
 
 		/*
 		 * Find a SET insn involving a SYMBOL_REF to __stack_chk_guard
@@ -33,12 +33,13 @@ static unsigned int arm_pertask_ssp_rtl_execute(void)
 		 * produces the address of the copy of the stack canary value
 		 * stored in struct thread_info
 		 */
+		mask = GEN_INT(sext_hwi(sp_mask, GET_MODE_PRECISION(Pmode)));
 		masked_sp = gen_reg_rtx(Pmode);
 
 		emit_insn_before(gen_rtx_SET(masked_sp,
 					     gen_rtx_AND(Pmode,
 							 stack_pointer_rtx,
-							 GEN_INT(sp_mask))),
+							 mask)),
 				 insn);
 
 		SET_SRC(body) = gen_rtx_PLUS(Pmode, masked_sp,
-- 
2.20.1

