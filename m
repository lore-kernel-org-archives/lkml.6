Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE460C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49D12087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49D12087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJEAQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:16:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52752 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbeJEAQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:16:50 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FNaiVBmuGJUH; Thu,  4 Oct 2018 19:22:36 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92A5B1EC032D;
        Thu,  4 Oct 2018 19:22:36 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: [PATCH] SMT: State SMT is disabled even with nosmt and without "=force"
Date:   Thu,  4 Oct 2018 19:22:27 +0200
Message-Id: <20181004172227.10094-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec057f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

When booting with "nosmt=force" a message is issued into dmesg to
confirm that SMT has been force-disabled but such a message is not
issued when only "nosmt" is on the kernel command line.

Fix that.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 668c8553e171..3c7f3b4c453c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -383,6 +383,7 @@ void __init cpu_smt_disable(bool force)
 		pr_info("SMT: Force disabled\n");
 		cpu_smt_control = CPU_SMT_FORCE_DISABLED;
 	} else {
+		pr_info("SMT: disabled\n");
 		cpu_smt_control = CPU_SMT_DISABLED;
 	}
 }
-- 
2.19.0.271.gfe8321ec057f

