Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F90BECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 00:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C4D208CC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 00:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i6MdIUa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C4D208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbeGOA6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 20:58:11 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44507 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731877AbeGOA6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 20:58:11 -0400
Received: by mail-pf0-f195.google.com with SMTP id j3-v6so24542971pfh.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 17:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LLi7oDyVUmGwjn4VbSGEb9paGFsJxF2mdUuOAQXcgKU=;
        b=i6MdIUa8e0su7yIcfzBqVBEG1AI+9lFhBYkXpryoj6ak3nS86g553jOsnz1YGg6CnR
         t8e6+0fdEh0m4iilnynYXKyDWZUcQUgGXUKtuNJF5K3biVa3LdoJOyPYkBt9kVXqDZzr
         2XcvqaiwfyoHnvsHVv8jl8YLdFzWrWVRGcapw/5GVrqSJq0Ss5k/D3J/cuN6t85+SQaZ
         AQXuCbVLYf3Zjk930vDVSBPESeV3PRRzRxbDsmJR91MNFLI0GJeeaCU3dww0rfobSOqh
         5XIyDN/FJnfCZ3g1XpK0/Iz7nZL89A+g5uGJLOno7TVWNBZC1wG+O3wk/AivQiWZi9mS
         JiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LLi7oDyVUmGwjn4VbSGEb9paGFsJxF2mdUuOAQXcgKU=;
        b=uEcIDm1oZ3XNmn9ha+0vNIuDZojVHs4k9Ty/NIp58yjQ2oVxevhtXI1B6vfMRZWp+f
         RIZr9vGqrBQNzhNjL0orqfYCR4HmLIBLw9q2b2Jksxv1OVCnxhDLzJ/P9ytHbZsWTHBS
         q/i2028sOqHjcgKnQ71y7vtqy2m9APgJ22hIoyS8CuZstX2SaL0k3foh2qF/Wms6w5t1
         xSVpa/KWDzY2kjOh1Eafoq4mg4l8GNI1twAIdIIdQ8lKUqxr+l/ErtaAp2U+MNL0Tytn
         IP4dadqgRZcK9lwQhkXeMCbF1uh8UpICI8i6omFE4R5l0pnNPXWJ+SrOK2DRxA/IrBvC
         g4ZQ==
X-Gm-Message-State: AOUpUlEl1byBngOZBPtQHFOilmjGbaVl5BLyFTM0DFuHU9I2d6p6mB20
        45axe/oSnwtjwdbs5aurpgcTjw==
X-Google-Smtp-Source: AAOMgpek0CoAQVgkxnAyQ51dCD6JfRCYYVHlXTjxYKwTeeIrb60G76iNoZOCQnzzzD672faxwocSeA==
X-Received: by 2002:a65:448a:: with SMTP id l10-v6mr10916967pgq.382.1531615037886;
        Sat, 14 Jul 2018 17:37:17 -0700 (PDT)
Received: from rohan.hsd1.ca.comcast.net ([2601:646:c103:8ec:512d:ce75:aa80:7b73])
        by smtp.gmail.com with ESMTPSA id r25-v6sm14114672pfj.117.2018.07.14.17.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 17:37:16 -0700 (PDT)
From:   Jim Wilson <jimw@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     Jim Wilson <jimw@sifive.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: Don't increment sepc after breakpoint.
Date:   Sat, 14 Jul 2018 17:34:39 -0700
Message-Id: <20180715003442.32216-1-jimw@sifive.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding 4 to sepc is pointless, and is wrong if we executed a 2-byte
compressed breakpoint.  This plus a corresponding gdb patch allows
compressed breakpoints to work in gdb.  Gdb maintainers have already
agreed that this is the right approach.

Signed-off-by: Jim Wilson <jimw@sifive.com>
---
 arch/riscv/kernel/traps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 14fcec5bdd24..ae323071c786 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -150,7 +150,6 @@ asmlinkage void do_trap_break(struct pt_regs *regs)
 #endif /* CONFIG_GENERIC_BUG */
 
 	do_trap_siginfo(SIGTRAP, TRAP_BRKPT, regs->sepc, current);
-	regs->sepc += 0x4;
 }
 
 #ifdef CONFIG_GENERIC_BUG
-- 
2.17.1

