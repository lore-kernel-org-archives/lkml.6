Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD6AC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4162148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763828;
	bh=fJjjU8nzu1xU5j5e4juquVS+Ph+Ncma9VLZ01m3pDHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ucpnNgh1wieqEBDD6t+iMDAEP+Hozh/LtZid+jYYWRxjPjL3s4Pmkx5QY1UwVPsee
	 blpRviS9DaJQcCja9ShyG7XSQx6NW45InY+MOW6/zpvQbjyDsN83ZZjrB7HnEEWO2d
	 c3qT3OqFksmLIFv2hyQOz4HNaTl2CYOU5x2TaA3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfA2MK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:10:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728849AbfA2Lhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:37:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1869E20844;
        Tue, 29 Jan 2019 11:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761851;
        bh=fJjjU8nzu1xU5j5e4juquVS+Ph+Ncma9VLZ01m3pDHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFK1V59MyJebhkctcROi0EwqkCVJ836+42DTjLTzmKGvhU29J+yPNAtpSAuEZiuwg
         V13/QXyMlHh8AQmKwrkwYfP34coeUNEMobCbdN6eVUGsMfjK6D17wBDbChSzKqnmOA
         zfP2+2vio0UxmnyJCuBqkbWyrflsif2e5/umupHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        "David A. Long" <dave.long@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 022/117] ARM: fix the cockup in the previous patch
Date:   Tue, 29 Jan 2019 12:34:33 +0100
Message-Id: <20190129113208.768937385@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

Commit d6951f582cc50ba0ad22ef46b599740966599b14 upstream.

The intention in the previous patch was to only place the processor
tables in the .rodata section if big.Little was being built and we
wanted the branch target hardening, but instead (due to the way it
was tested) it ended up always placing the tables into the .rodata
section.

Although harmless, let's correct this anyway.

Fixes: 3a4d0c2172bc ("ARM: ensure that processor vtables is not lost after boot")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mm/proc-macros.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -278,7 +278,7 @@
  * If we are building for big.Little with branch predictor hardening,
  * we need the processor function tables to remain available after boot.
  */
-#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
 	.section ".rodata"
 #endif
 	.type	\name\()_processor_functions, #object
@@ -316,7 +316,7 @@ ENTRY(\name\()_processor_functions)
 	.endif
 
 	.size	\name\()_processor_functions, . - \name\()_processor_functions
-#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
 	.previous
 #endif
 .endm


