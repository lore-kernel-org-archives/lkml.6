Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EA6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103C52077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jHqBT+Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103C52077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeIFMjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:39:49 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53549 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeIFMjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536221193; x=1567757193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UL8JbRBIj8Dgmic5yuT7Oytfq+yluzZfU5sZRa27+/M=;
  b=jHqBT+DxgYfqV72xvuZXRsK8I7zVcIAEMSCYX4K7sZFrGta0gU6jd/Yd
   VFx8mTlWdNj2jZEEzG9IK0jOUoGz8HkiU8UbAcxb50CSMs1FlasHQ2B4i
   DSf+KU7hzANe4ylb5GH0jBXoye4EyprZLN0F+1hTmiE73XdUGSHoubrkS
   ViMfKPFl4KzhbIbMtVoMZme6GQmsaY39sE/Gclns0GNn2yrz0Fnr9JUwB
   EhXPJls0vq/B/sXekXR6W7ZvWqMDaFWtQzHIGi/sBMmxreIchv62O2zNT
   qXsIlBJh25fjb1RUTQwLEzRm5IW0ju+6Y/6NWlvFTs/b2XqIND2MRh/99
   w==;
X-IronPort-AV: E=Sophos;i="5.53,337,1531756800"; 
   d="scan'208";a="186673937"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2018 16:06:32 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 06 Sep 2018 00:52:11 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Sep 2018 01:05:36 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org
Cc:     mark.rutland@arm.com, atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: [PATCH v3 01/12] RISC-V: Don't set cacheinfo.{physical_line_partition,attributes}
Date:   Thu,  6 Sep 2018 01:05:24 -0700
Message-Id: <1536221135-182613-2-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
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

