Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83F4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99E821720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XqbHLj8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeLZCfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:35:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34346 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeLZCfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 21:35:48 -0500
Received: by mail-qk1-f196.google.com with SMTP id q8so8779555qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 18:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZAyA9hDr8hvY+9HSu7R6Bzw/IIvnIFJa35s/uXJU8S8=;
        b=XqbHLj8c4XiNOsouTV+lemdmqMtPsUbYqr8nEffNEBbwKVq6X+Wvr/qOnN7JNufqPv
         lVOgNTO/PBXn+Nw3BFMD4YPeTksHMaHGhSPscXFfIzzgCwoxW+9i5ZhW2Fb0L3az4isD
         HpxSygZ/skq/0LhL0E7dkjLvG6mgVPAgasKTM1xWtz9l6pl/jOZZzyO1MobUg/ttW0ci
         72FyzSg9hexKlyypukwBDm0CkYC25qDck2AJnujOGP/xJ8HPEbC+aO6UtEeEnXFPMd9W
         bGF+SpEEas9xoQdp5A4/6jfVawtIb76rOD38vQchmaMt5a3Z5WLmYocHxQQWFfNKCNl3
         fIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZAyA9hDr8hvY+9HSu7R6Bzw/IIvnIFJa35s/uXJU8S8=;
        b=Gv7IBk3x7o73M+pmKN5gDQ7EcA3dF5QAuOosTYYaq2wbnSSzvEa0fbsGzPkJi8hNrc
         rfmYuVdl9q9P1dvQOjoWDFgiz3dRz1dfD42z899aqWdyMlepTyxkujW2nZfVAJfeYMts
         /4GI7yBuq2aCqPs5vtMthVu8KwaJTHY4IaaZihP41FV51RHc3JF/fpk6/kP9izlG2H68
         QWAONDG56C6/+dP70MVCoBO9WpTWAxcQFAcRsvOT+CP3OJqZNbweLsG/NO4nR5t8EODs
         nAu76gj09qO8nmRovCLrf7pFJjsSUj2BGXBg3tkT7Q5elYIsjtz3CXqHV9puxMsIUUbw
         GWug==
X-Gm-Message-State: AJcUukdjd+I3xv8gaxDNR+QUgBZok+tqcwHwwpMEDkc22pezfWh+iNTN
        QQAkYqOV8sVhXSyvL8CaLBbU+Q==
X-Google-Smtp-Source: ALg8bN72oOqYRHwNsZIuVQaTR8rxVSVL5GLpz8DmLgJBjpErlNxnZOj+WE7xfOqy8DdkWzu7dAZyAQ==
X-Received: by 2002:a37:2808:: with SMTP id o8mr16083312qkh.14.1545791747299;
        Tue, 25 Dec 2018 18:35:47 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m68sm11498477qte.49.2018.12.25.18.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 18:35:46 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        mingo@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -mmotm] efi: drop kmemleak_ignore() for page allocator
Date:   Tue, 25 Dec 2018 21:35:34 -0500
Message-Id: <20181226023534.64048-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a0fc5578f1d (efi: Let kmemleak ignore false positives) is no longer
needed due to efi_mem_reserve_persistent() uses __get_free_page()
instead where kmemelak is not able to track regardless. Otherwise,
kernel reported "kmemleak: Trying to color unknown object at
0xffff801060ef0000 as Black"

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/firmware/efi/efi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7ac09dd8f268..4c46ff6f2242 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -31,7 +31,6 @@
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
 #include <linux/memblock.h>
-#include <linux/kmemleak.h>
 
 #include <asm/early_ioremap.h>
 
@@ -1027,8 +1026,6 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	if (!rsv)
 		return -ENOMEM;
 
-	kmemleak_ignore(rsv);
-
 	rsv->size = EFI_MEMRESERVE_COUNT(PAGE_SIZE);
 	atomic_set(&rsv->count, 1);
 	rsv->entry[0].base = addr;
-- 
2.17.2 (Apple Git-113)

