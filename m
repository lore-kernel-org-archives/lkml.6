Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C247DC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E3C21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E3C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeJIRtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:49:32 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:47494 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIRtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:49:32 -0400
X-IronPort-AV: E=Sophos;i="5.54,360,1534809600"; 
   d="scan'208";a="67353696"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH] xen/pvh: increase early stack size
Date:   Tue, 9 Oct 2018 12:32:37 +0200
Message-ID: <20181009103237.52527-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While booting on an AMD EPYC box the stack canary would detect stack
overflows when using the current PVH early stack size (256). Switch to
using the value defined by BOOT_STACK_SIZE, which prevents the stack
overflow.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/xen/xen-pvh.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index ca2d3b2bf2af..58722a052f9c 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -181,7 +181,7 @@ canary:
 	.fill 48, 1, 0
 
 early_stack:
-	.fill 256, 1, 0
+	.fill BOOT_STACK_SIZE, 1, 0
 early_stack_end:
 
 	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,
-- 
2.19.0

