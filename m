Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FF1C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4CA2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbfA3Qkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:40:40 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:26162 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732089AbfA3Qki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:40:38 -0500
X-IronPort-AV: E=Sophos;i="5.56,541,1539648000"; 
   d="scan'208";a="656543771"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 30 Jan 2019 16:40:34 +0000
Received: from u54ee758033e858cfa736 (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id A6357A0188;
        Wed, 30 Jan 2019 16:40:33 +0000 (UTC)
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736 (8.15.2/8.15.2/Debian-3) with ESMTP id x0UGeUSq013437;
        Wed, 30 Jan 2019 17:40:31 +0100
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id x0UGeT2T013436;
        Wed, 30 Jan 2019 17:40:29 +0100
From:   Julian Stecklina <js@alien8.de>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, linux-kernel@vger.kernel.org, jschoenh@amazon.de,
        Julian Stecklina <jsteckli@amazon.de>
Subject: [PATCH 1/2] x86/boot: fix KASL when memmap range manipulation is used
Date:   Wed, 30 Jan 2019 17:40:02 +0100
Message-Id: <1548866403-13390-1-git-send-email-js@alien8.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Stecklina <jsteckli@amazon.de>

When the user passes a memmap=<size>%<offset>-<oldtype>+<newtype>
parameter to the kernel to reclassify some memory, this information is
ignored during the randomization of the kernel base address. This in
turn leads to cases where the kernel is unpacked to memory regions that
the user marked as reserved.

Fix this situation to avoid any memory region for KASLR that is
reclassified.

Fixes: ef61f8a340fd6d49df6b367785743febc47320c1 ("x86/boot/e820: Implement a range manipulation operator")

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
---
 arch/x86/boot/compressed/kaslr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 9ed9709..5657e34 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -155,6 +155,12 @@ parse_memmap(char *p, unsigned long long *start, unsigned long long *size)
 	case '#':
 	case '$':
 	case '!':
+		/*
+		 * % would need some more complex parsing, because regions might
+		 * actually become usable for KASLR, but the simple way of
+		 * ignoring anything that is mentioned in % works for now.
+		 */
+	case '%':
 		*start = memparse(p + 1, &p);
 		return 0;
 	case '@':
-- 
2.7.4

