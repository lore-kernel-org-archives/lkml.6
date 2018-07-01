Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2934AC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D689E25AAB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D689E25AAB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933192AbeGAShs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:37:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932896AbeGAQPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:15:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3ABEA4A3;
        Sun,  1 Jul 2018 16:15:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Rivshin <drivshin@allworx.com>,
        Rabin Vincent <rabin@rab.in>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 3.18 62/85] ARM: 8764/1: kgdb: fix NUMREGBYTES so that gdb_regs[] is the correct size
Date:   Sun,  1 Jul 2018 18:02:20 +0200
Message-Id: <20180701153124.837055940@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Rivshin <DRivshin@allworx.com>

commit 76ed0b803a2ab793a1b27d1dfe0de7955282cd34 upstream.

NUMREGBYTES (which is used as the size for gdb_regs[]) is incorrectly
based on DBG_MAX_REG_NUM instead of GDB_MAX_REGS. DBG_MAX_REG_NUM
is the number of total registers, while GDB_MAX_REGS is the number
of 'unsigned longs' it takes to serialize those registers. Since
FP registers require 3 'unsigned longs' each, DBG_MAX_REG_NUM is
smaller than GDB_MAX_REGS.

This causes GDB 8.0 give the following error on connect:
"Truncated register 19 in remote 'g' packet"

This also causes the register serialization/deserialization logic
to overflow gdb_regs[], overwriting whatever follows.

Fixes: 834b2964b7ab ("kgdb,arm: fix register dump")
Cc: <stable@vger.kernel.org> # 2.6.37+
Signed-off-by: David Rivshin <drivshin@allworx.com>
Acked-by: Rabin Vincent <rabin@rab.in>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/include/asm/kgdb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/include/asm/kgdb.h
+++ b/arch/arm/include/asm/kgdb.h
@@ -76,7 +76,7 @@ extern int kgdb_fault_expected;
 
 #define KGDB_MAX_NO_CPUS	1
 #define BUFMAX			400
-#define NUMREGBYTES		(DBG_MAX_REG_NUM << 2)
+#define NUMREGBYTES		(GDB_MAX_REGS << 2)
 #define NUMCRITREGBYTES		(32 << 2)
 
 #define _R0			0


