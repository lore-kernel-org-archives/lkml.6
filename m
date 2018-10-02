Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558AAC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161362064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XEOBl6Ik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161362064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeJCCAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:00:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61582 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbeJCCAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538507711; x=1570043711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jQTZ23SgNKhmVMpyXw8suw05ppQjTGFZ9dEM3MSqxbk=;
  b=XEOBl6IkwYWOwBb7ILhglHimPzYhhLMsEefpK9UG1SJ6BkoQcgoOeypI
   7GOeeSYpdgdxbkThLmfu3xGGQe6YaESZM2hCg0ofJZjU0ZL2WTPL6OZfZ
   OktFLJIDbg4iLMjw8ppFJRBAj4+vW5A1dDMUnHqTXR05fQG5vKh6x9zGz
   dxL8S6j2u+eGAGSwiwnw5JevaDsbEB1q+LVEV138I8nPPjbBnyjLgF7kx
   X4jmJIQJTd819Fx/pTHpA+17/63enAWz/26WOb/BtQ3T8oouMwmUwIEXx
   seCMS15HL6wgCgqNRIljMqSEpBFJDKiB9nuIi7jlCR4nq40NNsULIGG3X
   w==;
X-IronPort-AV: E=Sophos;i="5.54,332,1534780800"; 
   d="scan'208";a="91076752"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2018 03:15:10 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Oct 2018 12:00:51 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2018 12:15:11 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org, palmer@sifive.com
Cc:     anup@brainfault.org, hch@infradead.org,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com
Subject: [PATCH v6 10/14] RISC-V: Use WRITE_ONCE instead of direct access
Date:   Tue,  2 Oct 2018 12:15:03 -0700
Message-Id: <1538507707-22299-11-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
References: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The secondary harts spin on couple of per cpu variables until both of
these are non-zero so it's not necessary to have any ordering here.
However, WRITE_ONCE should be used to avoid tearing.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/smpboot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 17e74831..1e478615 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -81,8 +81,9 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	 * the spinning harts that they can continue the boot process.
 	 */
 	smp_mb();
-	__cpu_up_stack_pointer[cpu] = task_stack_page(tidle) + THREAD_SIZE;
-	__cpu_up_task_pointer[cpu] = tidle;
+	WRITE_ONCE(__cpu_up_stack_pointer[cpu],
+		  task_stack_page(tidle) + THREAD_SIZE);
+	WRITE_ONCE(__cpu_up_task_pointer[cpu], tidle);
 
 	while (!cpu_online(cpu))
 		cpu_relax();
-- 
2.7.4

