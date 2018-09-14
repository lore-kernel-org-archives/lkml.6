Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD3AECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08C020853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nM6jw1di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08C020853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeIODLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 23:11:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23763 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbeIODLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 23:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536962097; x=1568498097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=3mJpoam2A2xj4ZksT23VyuZFVe6fICI7QinZh5RdjX0=;
  b=nM6jw1diRZygjK8u/ZlsLZGBY6a0Tb5qONCKrpipw0yYADVXfXC2ix/l
   klgvsN/J7h+3J5mOOiZN2L8Vl+7COQoH7O50EIU1Yh1tlZ3HOGUcsRgOO
   VLV9NioCMQ4PFR7M+l3ebf3dofwGZOjXo1LP1go21d5mS+mEbd2YJhc1Q
   EJEOMH3P4Q4dlcvxRG+iaAwt6bnLgg7W5eCwTjBH0dZuS6+hVAOPcQLLH
   hJfUhv5UDle4rRvmWAAujH7eJ3iaDmHhk+3C61NTOr5VbHnKMFGfxiAaM
   WdtVVUuO4V+m7l81VOag3P5Mq931wcxYJJXUAU8wbUDpVPeoW/loSA7xQ
   g==;
X-IronPort-AV: E=Sophos;i="5.53,374,1531756800"; 
   d="scan'208";a="89803043"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2018 05:54:57 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 14 Sep 2018 14:41:22 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Sep 2018 14:54:57 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org
Cc:     anup@brainfault.org, atish.patra@wdc.com, mark.rutland@arm.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Damien.LeMoal@wdc.com, marc.zyngier@arm.com, robh@kernel.org
Subject: [RFC 1/3] dt-bindings: Correct RISC-V's timebase-frequency
Date:   Fri, 14 Sep 2018 14:54:54 -0700
Message-Id: <1536962096-233842-2-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
References: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/riscv/cpus.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
index adf7b7af..b0b038d6 100644
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
2.7.4

