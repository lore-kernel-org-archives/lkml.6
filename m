Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B45C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B8920645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XzR7cqqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B8920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeILBGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:06:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52878 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeILBGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536696341; x=1568232341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UL8JbRBIj8Dgmic5yuT7Oytfq+yluzZfU5sZRa27+/M=;
  b=XzR7cqqrTHM2YDwv17YrS1OHAk5rgN+DOvE2040Cz6pC6bQhCYVIJvsX
   ulefdmgI3dAsDGr20ncJ3lgKbzaMWLbIoULCjR1p78m6GSiJRBkBX8g7C
   gtLWAl95WTxKosK3K/ZLR4mcuOAoqQbixhyFAwqDScY8FZhDdWp6oQHvD
   ky7YqAGhIqm8ABD01XYvAOt/mKJ9AL1mnTqTaaBBq4iNVd6jVp7TzXTD0
   8yy+GR4LW7MuAFXqTPOxH5lunvaz+IAlYJFNIFlGElMLWnZdqs4gltAbx
   NSZ2xWzd7qKk8mOcWFA80jsJRp+uwhctm6IO87D72ERdCjnKlgqZ0EtG7
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,361,1531756800"; 
   d="scan'208";a="193728822"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2018 04:05:40 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 11 Sep 2018 12:52:15 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2018 13:05:41 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org
Cc:     mark.rutland@arm.com, hch@infradead.org, anup@brainfault.org,
        atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: [PATCH v4 02/12] RISC-V: Don't set cacheinfo.{physical_line_partition,attributes}
Date:   Tue, 11 Sep 2018 13:05:29 -0700
Message-Id: <1536696339-15204-3-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536696339-15204-1-git-send-email-atish.patra@wdc.com>
References: <1536696339-15204-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

These are just hard coded in the RISC-V port, which doesn't make any
sense.  We should probably be setting these from device tree entries
when they exist, but for now I think it's saner to just leave them all
as their default values.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/riscv/kernel/cacheinfo.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 0bc86e5f..cb35ffd8 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -22,13 +22,6 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 {
 	this_leaf->level = level;
 	this_leaf->type = type;
-	/* not a sector cache */
-	this_leaf->physical_line_partition = 1;
-	/* TODO: Add to DTS */
-	this_leaf->attributes =
-		CACHE_WRITE_BACK
-		| CACHE_READ_ALLOCATE
-		| CACHE_WRITE_ALLOCATE;
 }
 
 static int __init_cache_level(unsigned int cpu)
-- 
2.7.4

