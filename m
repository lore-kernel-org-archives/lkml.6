Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D035EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A093620823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AlrM1972"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfARK6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:58:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43180 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfARK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:58:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so14459722wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4PBOByBDyORJotrQHfAdkrD3rgX1OelOnufeKqsU2dQ=;
        b=AlrM1972m+0wXMXOuZvU17EhloZ3TgU+0dIl+cd6pVPtOCjjKqwzIbZ3qrSe2qlVEW
         Hw9ggdG4YeVmAHafc5+n+akYNC0sXtYESZj6frJhFweaIHa/bj8H8YM6vI5nxTZSygcM
         9vR54EMAC2oeYRxIsG4Cmg43eJLzQ9buONYUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4PBOByBDyORJotrQHfAdkrD3rgX1OelOnufeKqsU2dQ=;
        b=KbhJ7u4myIq6Qt89y5Ubm+mWpaq4nAC8tXXAz1bMEhYxC7eFh/5ZfC1zxSEE96bp7p
         WNpYlx5HOWLjrxplYbGGqSC0atQgD/FLuQ/4La9OI+S77tyUqieRu6G2RamIhhYCV0mx
         qHQLxAOu7OFcaa1lIIsaL5PJC/o8DgmmZGexOLOkP57RxD5riWi3nf/vSP1GOq2T4zZE
         ril9FTrSsINsT2hdiBLA/1KcqRYkVP7cZaZi2lJk7FKBpadqtiO8J+MHo1qRwiWWzVWU
         xIdPLBwsIbd9VVc9rsdYjEuMVW0KINtlt8KjDeMVfSxocC3xcdHpegzcCtCE89h6dujQ
         L5Iw==
X-Gm-Message-State: AJcUukcWa4h+oWP/4QgCSaAiH11r0RiuKm0Uq7uL5huX2tyKWzyUwHd7
        2BmCnw9jAmxWjli5Ir/XxNDeSA==
X-Google-Smtp-Source: ALg8bN6XNctV/3mjt9tXUIVh909CcvPA7/B0iHznoaW1oLjZTDN2yXXDqL2opy2cpSGYg4eMK78sIQ==
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr17072968wrp.59.1547809094054;
        Fri, 18 Jan 2019 02:58:14 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-20-152.w90-86.abo.wanadoo.fr. [90.86.223.152])
        by smtp.gmail.com with ESMTPSA id y13sm65345467wrn.73.2019.01.18.02.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 02:58:13 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     keescook@chromium.org
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 2/2] gcc-plugins: arm_ssp_per_task_plugin: fix for GCC 9+
Date:   Fri, 18 Jan 2019 11:58:07 +0100
Message-Id: <20190118105807.26425-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
References: <20190118105807.26425-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 9 reworks the way the references to the stack canary are
emitted, to prevent the value from being spilled to the stack
before the final comparison in the epilogue, defeating the
purpose, given that the spill slot is under control of the
attacker that we are protecting ourselves from.

Since our canary value address is obtained without accessing
memory (as opposed to pre-v7 code that will obtain it from a
literal pool), it is unlikely (although not guaranteed) that
the compiler will spill the canary value in the same way, so
let's just disable this improvement when building with GCC9+.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
index a65fbefb8501..89c47f57d1ce 100644
--- a/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
+++ b/scripts/gcc-plugins/arm_ssp_per_task_plugin.c
@@ -53,6 +53,19 @@ static unsigned int arm_pertask_ssp_rtl_execute(void)
 #define NO_GATE
 #include "gcc-generate-rtl-pass.h"
 
+#if BUILDING_GCC_VERSION >= 9000
+static bool no(void)
+{
+	return false;
+}
+
+static void arm_pertask_ssp_start_unit(void *gcc_data, void *user_data)
+{
+	targetm.have_stack_protect_combined_set = no;
+	targetm.have_stack_protect_combined_test = no;
+}
+#endif
+
 __visible int plugin_init(struct plugin_name_args *plugin_info,
 			  struct plugin_gcc_version *version)
 {
@@ -100,5 +113,10 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
 	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
 			  NULL, &arm_pertask_ssp_rtl_pass_info);
 
+#if BUILDING_GCC_VERSION >= 9000
+	register_callback(plugin_info->base_name, PLUGIN_START_UNIT,
+			  arm_pertask_ssp_start_unit, NULL);
+#endif
+
 	return 0;
 }
-- 
2.20.1

