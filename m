Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753064AbeFAPVj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:21:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53098 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeFAPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:21:31 -0400
X-Google-Smtp-Source: ADUXVKJsPmiCUZXa1nJdziM0v7gygooktLqHfJLS97BW23y3OhMvJ5mGK26g9L5uvpz1YPUfJy5g2A==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] riscv: no __user for probe_kernel_address()
Date: Fri,  1 Jun 2018 17:21:22 +0200
Message-Id: <20180601152123.47256-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180601152123.47256-1-luc.vanoostenryck@gmail.com>
References: <20180601152123.47256-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In is_valid_bugaddr(), probe_kernel_address() is called with
the PC casted to (bug_inst_t __user *) but this function
only take a plain void* as argument, not a __user pointer.

Fix this by removing the unnneded __user in the cast.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/riscv/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 93132cb59..4c92e5af8 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -160,7 +160,7 @@ int is_valid_bugaddr(unsigned long pc)
 
 	if (pc < PAGE_OFFSET)
 		return 0;
-	if (probe_kernel_address((bug_insn_t __user *)pc, insn))
+	if (probe_kernel_address((bug_insn_t *)pc, insn))
 		return 0;
 	return (insn == __BUG_INSN);
 }
-- 
2.17.1
