Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481CEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144D32080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144D32080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbeKLGE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:04:29 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52930 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729602AbeKLGE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:04:28 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt9-0000l5-7F; Sun, 11 Nov 2018 19:59:19 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001RV-Kd; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Rivshin" <DRivshin@allworx.com>,
        "Rabin Vincent" <rabin@rab.in>,
        "David Rivshin" <drivshin@allworx.com>,
        "Daniel Thompson" <daniel.thompson@linaro.org>,
        "Russell King" <rmk+kernel@armlinux.org.uk>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.7447554@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 068/366] ARM: 8764/1: kgdb: fix NUMREGBYTES so that
 gdb_regs[] is the correct size
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: David Rivshin <drivshin@allworx.com>
Acked-by: Rabin Vincent <rabin@rab.in>
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/include/asm/kgdb.h | 2 +-
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

