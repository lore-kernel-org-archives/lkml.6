Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F68EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B1E20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbfAIKvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:51:47 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:15719 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729607AbfAIKvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:51:45 -0500
Received: from g4t3428.houston.hpe.com (g4t3428.houston.hpe.com [15.241.140.76])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 3F2051177;
        Wed,  9 Jan 2019 10:46:03 +0000 (UTC)
Received: from sarge.linuxathome.me (unknown [16.214.81.200])
        by g4t3428.houston.hpe.com (Postfix) with ESMTP id A500C55;
        Wed,  9 Jan 2019 10:46:03 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>
Subject: [PATCH 2/3] x86/platform/UV: kill uv_bios_call_reentrant() as it has no callers
Date:   Wed,  9 Jan 2019 10:45:40 +0000
Message-Id: <20190109104541.25733-3-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109104541.25733-1-hedi.berriche@hpe.com>
References: <20190109104541.25733-1-hedi.berriche@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uv_bios_call_reentrant() has no callers nor is it exported, kill it.

Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
Reviewed-by: Russ Anderson <rja@hpe.com>
Reviewed-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/bios.h |  1 -
 arch/x86/platform/uv/bios_uv.c | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index e652a7cc6186..4eee646544b2 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -140,7 +140,6 @@ enum uv_memprotect {
  */
 extern s64 uv_bios_call(enum uv_bios_cmd, u64, u64, u64, u64, u64);
 extern s64 uv_bios_call_irqsave(enum uv_bios_cmd, u64, u64, u64, u64, u64);
-extern s64 uv_bios_call_reentrant(enum uv_bios_cmd, u64, u64, u64, u64, u64);
 
 extern s64 uv_bios_get_sn_info(int, int *, long *, long *, long *, long *);
 extern s64 uv_bios_freq_base(u64, u64 *);
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 4a6a5a26c582..cd05af157763 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -66,18 +66,6 @@ s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 	return ret;
 }
 
-s64 uv_bios_call_reentrant(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
-					u64 a4, u64 a5)
-{
-	s64 ret;
-
-	preempt_disable();
-	ret = uv_bios_call(which, a1, a2, a3, a4, a5);
-	preempt_enable();
-
-	return ret;
-}
-
 
 long sn_partition_id;
 EXPORT_SYMBOL_GPL(sn_partition_id);
-- 
2.20.0

