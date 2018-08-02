Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE59C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8BE208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MNYZW5Ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8BE208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbeHBNlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:41:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38956 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbeHBNlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/lbxZxozS8tvIqsOyT7OgjcPkjwajRLKeNgqmPo8/tE=; b=MNYZW5RiAhd2VCQiPBd+IsJwu
        3IBVbXbDzrygmT6v7NAfGm3q4B/cpca+nee3ywRVqyhb7FhYbqys+xVDalJlNo+z7ot7OmMH94r87
        y2R0mRxFKnIgHA1kR6RirMT+yMpinYWjioMhwkDMbsf76m/0RC/kSPaobHr+P9OGfW4NQztJo3GAs
        5ArbxQAS5wSTB6QN+89RnkXUgfpEgY6x2nYhywWxMPyJmxmj319drnEovNFH5Q0qsw3m99MRCuMtp
        Ikk/WhfBk4S0FKFstA2Dl9aeeddh/soTaq0ZfyncPvMIKoFOMmrdUEPuAEUOS15mgVV/zSU2YsYOb
        16FwiVJ1w==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flC7Y-0005AI-5C; Thu, 02 Aug 2018 11:50:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: [PATCH 02/11] dt-bindings: Add an enable method to RISC-V
Date:   Thu,  2 Aug 2018 13:49:59 +0200
Message-Id: <20180802115008.4031-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802115008.4031-1-hch@lst.de>
References: <20180802115008.4031-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

RISC-V doesn't currently specify a mechanism for enabling or disabling
CPUs.  Instead, we assume that all CPUs are enabled on boot, and if
someone wants to save power we instead put a CPU to sleep via a WFI
loop.  Future systems may have an explicit mechanism for putting a CPU
to sleep, so we're standardizing the device tree entry for when that
happens.

We're not defining a spin-table based interface to the firmware, as the
plan is to handle this entirely within the kernel instead.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/devicetree/bindings/riscv/cpus.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
index b0b038d6c406..6aa9cd075a5b 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.txt
+++ b/Documentation/devicetree/bindings/riscv/cpus.txt
@@ -82,6 +82,15 @@ described below.
                 Value type: <string>
                 Definition: Contains the RISC-V ISA string of this hart.  These
                             ISA strings are defined by the RISC-V ISA manual.
+        - cpu-enable-method:
+                Usage: optional
+                Value type: <stringlist>
+                Definition: When absent, default is either "always-disabled"
+                            "always-enabled", depending on the current state
+                            of the CPU.
+                            Must be one of:
+                                * "always-disabled": This CPU cannot be enabled.
+                                * "always-enabled": This CPU cannot be disabled.
 
 Example: SiFive Freedom U540G Development Kit
 ---------------------------------------------
-- 
2.18.0

