Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5D1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E422080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E422080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbeKLF5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:57:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52200 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731209AbeKLF5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:57:14 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt9-0000lM-7N; Sun, 11 Nov 2018 19:59:19 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001Ra-Lr; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michael Ellerman" <mpe@ellerman.id.au>,
        "Michael Neuling" <mikey@neuling.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.690048409@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 069/366] powerpc/ptrace: Fix enforcement of DAWR
 constraints
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

From: Michael Neuling <mikey@neuling.org>

commit cd6ef7eebf171bfcba7dc2df719c2a4958775040 upstream.

Back when we first introduced the DAWR, in commit 4ae7ebe9522a
("powerpc: Change hardware breakpoint to allow longer ranges"), we
screwed up the constraint making it a 1024 byte boundary rather than a
512. This makes the check overly permissive. Fortunately GDB is the
only real user and it always did they right thing, so we never
noticed.

This fixes the constraint to 512 bytes.

Fixes: 4ae7ebe9522a ("powerpc: Change hardware breakpoint to allow longer ranges")
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/kernel/hw_breakpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -174,8 +174,8 @@ int arch_validate_hwbkpt_settings(struct
 	if (cpu_has_feature(CPU_FTR_DAWR)) {
 		length_max = 512 ; /* 64 doublewords */
 		/* DAWR region can't cross 512 boundary */
-		if ((bp->attr.bp_addr >> 10) != 
-		    ((bp->attr.bp_addr + bp->attr.bp_len - 1) >> 10))
+		if ((bp->attr.bp_addr >> 9) !=
+		    ((bp->attr.bp_addr + bp->attr.bp_len - 1) >> 9))
 			return -EINVAL;
 	}
 	if (info->len >

