Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6C5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718DF20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718DF20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbeGWN3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:29:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388086AbeGWN3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:29:39 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A922C03;
        Mon, 23 Jul 2018 12:28:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.14 10/44] ARCv2: [plat-hsdk]: Save accl reg pair by default
Date:   Mon, 23 Jul 2018 14:24:46 +0200
Message-Id: <20180723122437.939085285@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122437.447870153@linuxfoundation.org>
References: <20180723122437.447870153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vineet Gupta <vgupta@synopsys.com>

commit af1fc5baa724c63ce1733dfcf855bad5ef6078e3 upstream.

This manifsted as strace segfaulting on HSDK because gcc was targetting
the accumulator registers as GPRs, which kernek was not saving/restoring
by default.

Cc: stable@vger.kernel.org   #4.14+
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/Kconfig           |    2 +-
 arch/arc/plat-hsdk/Kconfig |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -408,7 +408,7 @@ config ARC_HAS_DIV_REM
 
 config ARC_HAS_ACCL_REGS
 	bool "Reg Pair ACCL:ACCH (FPU and/or MPY > 6)"
-	default n
+	default y
 	help
 	  Depending on the configuration, CPU can contain accumulator reg-pair
 	  (also referred to as r58:r59). These can also be used by gcc as GPR so
--- a/arch/arc/plat-hsdk/Kconfig
+++ b/arch/arc/plat-hsdk/Kconfig
@@ -7,5 +7,7 @@
 
 menuconfig ARC_SOC_HSDK
 	bool "ARC HS Development Kit SOC"
+	depends on ISA_ARCV2
+	select ARC_HAS_ACCL_REGS
 	select CLK_HSDK
 	select RESET_HSDK


