Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD683C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E9620880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hSJ7vXwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E9620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeIMXrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:47:51 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26981 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbeIMXrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536863830; x=1568399830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jQTZ23SgNKhmVMpyXw8suw05ppQjTGFZ9dEM3MSqxbk=;
  b=hSJ7vXwlKds0sG0stJSiEV29oz8e+lBlCbJ5w2tspcQu6LuLw09/G1XH
   cdGhs6qF/auVNjRmLHKrL8wbaMUB6bYhwxaDkULU5bTExWB+T8cpATQsW
   Ex6I/DT8FL4jaz/6MRzc8ftW/ZuL/ZwrEDESmzNa2GG2veI/uYTyAjoxL
   PQMiKqEP85vmnazwnuM23wYx4M8ryYdzM/CuOkBLlTKgkiP3T32FYsqR4
   mA94sMImbhwTo/b0fDCXLmuDdn8zMHykCfnh6Ft6BfjkowRk2WHKCU2IW
   7HAmU285qmBilMrbjfU0I7JL9MPYEQDVoQrTq1IfIRO5fk3vFs/b99EtY
   g==;
X-IronPort-AV: E=Sophos;i="5.53,370,1531756800"; 
   d="scan'208";a="89712029"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2018 02:37:10 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 13 Sep 2018 11:23:40 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Sep 2018 11:37:09 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org
Cc:     mark.rutland@arm.com, atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org, schwab@linux-m68k.org
Subject: [PATCH v5 10/12] RISC-V: Use WRITE_ONCE instead of direct access
Date:   Thu, 13 Sep 2018 11:37:03 -0700
Message-Id: <1536863825-66808-11-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536863825-66808-1-git-send-email-atish.patra@wdc.com>
References: <1536863825-66808-1-git-send-email-atish.patra@wdc.com>
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

