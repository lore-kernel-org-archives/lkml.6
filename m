Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3090DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA54021502
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sSAX9YR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA54021502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbeHBNlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:41:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732269AbeHBNlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KmtehZBvQ8FHrHdjfV2nyNHi6QaRR6lTpkmbGqVhkOw=; b=sSAX9YR/EaTonCaRf7vNEgwmw
        KP69vG4OfEv0NRDcdkTfwzgPcEB0NQwSJxnTvMJE/KtPNYg1nqYGjAeOwi6lO7mPKxkgaZn+aeqqo
        ThHzOSSk0aYb0eR/1i1QcW+Gp4ZXefa+6Ojwy0uGokpuZ//14EJH10848bx221n0ueKhHHou2WX3A
        YsV6hOQqAl8YvRFMRwlDia+yvNFKXGFId0tU/wnGUDk3WT7jmhRA2zGGqJS1ecGkQLRmdkLZflf5g
        499lkTI0JyHCYRMgi9hiHm6Vw4/qnO/tERq/FxMjBtJSFoIDYFMq8RRJh/1exfwo4w//apFJ+4eRW
        HHxAnsqdA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flC7U-00058m-BW; Thu, 02 Aug 2018 11:50:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: [PATCH 01/11] dt-bindings: Correct RISC-V's timebase-frequency
Date:   Thu,  2 Aug 2018 13:49:58 +0200
Message-Id: <20180802115008.4031-2-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802115008.4031-1-hch@lst.de>
References: <20180802115008.4031-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

Someone must have read the device tree specification incorrectly,
because we were putting timebase-frequency in the wrong place.  This
corrects the issue, moving it from

/ {
        cpus {
                timebase-frequency = X;
        }
}

to

/ {
        cpus {
                cpu@0 {
                        timebase-frequency = X;
                }
        }
}

This is great, because the timer's frequency should really be a per-cpu
quantity on RISC-V systems since there's a timer per CPU.  This should
lead to some cleanups in our timer driver.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/devicetree/bindings/riscv/cpus.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
index adf7b7af5dc3..b0b038d6c406 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.txt
+++ b/Documentation/devicetree/bindings/riscv/cpus.txt
@@ -93,9 +93,9 @@ Linux is allowed to run on.
         cpus {
                 #address-cells = <1>;
                 #size-cells = <0>;
-                timebase-frequency = <1000000>;
                 cpu@0 {
                         clock-frequency = <1600000000>;
+                        timebase-frequency = <1000000>;
                         compatible = "sifive,rocket0", "riscv";
                         device_type = "cpu";
                         i-cache-block-size = <64>;
@@ -113,6 +113,7 @@ Linux is allowed to run on.
                 };
                 cpu@1 {
                         clock-frequency = <1600000000>;
+                        timebase-frequency = <1000000>;
                         compatible = "sifive,rocket0", "riscv";
                         d-cache-block-size = <64>;
                         d-cache-sets = <64>;
@@ -145,6 +146,7 @@ Example: Spike ISA Simulator with 1 Hart
 This device tree matches the Spike ISA golden model as run with `spike -p1`.
 
         cpus {
+                timebase-frequency = <1000000>;
                 cpu@0 {
                         device_type = "cpu";
                         reg = <0x00000000>;
-- 
2.18.0

