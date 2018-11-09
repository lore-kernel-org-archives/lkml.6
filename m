Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18C2C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8D420827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8D420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=packi.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeKJHZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:25:53 -0500
Received: from mail.binarylogic.ch ([88.198.23.72]:45508 "EHLO
        mail.binarylogic.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbeKJHZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:25:52 -0500
Received: from fortknox.localdomain (unknown [192.168.122.1])
        by mail.binarylogic.ch (Postfix) with ESMTP id 40681DF386;
        Fri,  9 Nov 2018 22:43:25 +0100 (CET)
From:   =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>
To:     linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] RISC-V: recognize S/U mode bits in print_isa
Date:   Fri,  9 Nov 2018 22:42:16 +0100
Message-Id: <20181109214217.27494-1-me@packi.ch>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <mhng-cff31d5f-053e-4e62-997c-232c8bdd5fd3@palmer-si-x1c4>
References: <mhng-cff31d5f-053e-4e62-997c-232c8bdd5fd3@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the warning about an unsupported ISA when reading /proc/cpuinfo
on QEMU. The "S" extension is not being returned as it is not accessible
from userspace.

Signed-off-by: Patrick Stählin <me@packi.ch>
---
 arch/riscv/kernel/cpu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 3a5a2ee31547..b4a7d4427fbb 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -64,7 +64,7 @@ int riscv_of_processor_hartid(struct device_node *node)
 
 static void print_isa(struct seq_file *f, const char *orig_isa)
 {
-	static const char *ext = "mafdc";
+	static const char *ext = "mafdcsu";
 	const char *isa = orig_isa;
 	const char *e;
 
@@ -88,11 +88,14 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
 	/*
 	 * Check the rest of the ISA string for valid extensions, printing those
 	 * we find.  RISC-V ISA strings define an order, so we only print the
-	 * extension bits when they're in order.
+	 * extension bits when they're in order. Hide the supervisor (S)
+	 * extension from userspace as it's not accessible from there.
 	 */
 	for (e = ext; *e != '\0'; ++e) {
 		if (isa[0] == e[0]) {
-			seq_write(f, isa, 1);
+			if (isa[0] != 's')
+				seq_write(f, isa, 1);
+
 			isa++;
 		}
 	}
-- 
2.17.1

