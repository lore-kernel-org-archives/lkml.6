Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC36FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D319A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="l4CcOPo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D319A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeG3SCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:02:33 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:43641 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeG3SCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:02:32 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1A36B24E058D;
        Mon, 30 Jul 2018 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532968008; bh=ZJvL218cX4y5CWXvtZBhsSD7wmVUVLGyhAc4BivuFhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4CcOPo7or7wO5XaeQiliBlEM9sA5dpIqHj1Lu1laPwwIl5Vh7ASLYZARVPF0F3Ig
         CXGdVtZxd9VJDujI23GQfYXT3k7Zk7k7YvVGaglNNnQapo2JGylqRK7kNwpdGs6ggl
         dLYM9QL8QnS3AU3gJnds28AFl6WyZF7NeJzpbwFGQCzaDVUKNwCvI95oAkbKxiisz8
         L+HVmFIChtOwNFHlXWZLT6K4HfcLYFL9u5RlUsusNLUflTDA92pzfEHqHB6m4X+IgD
         E4My9qM+t8nlzU0NuRY2+xDTEKJSEMOYo7o6eamNq5rK1/o217keuZMmxKoT9AQ0dO
         JQfkhh6kYQ71g==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3E2D53FA6;
        Mon, 30 Jul 2018 09:26:46 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 3/4] ARC: IOC: panic if both IOC and ZONE_HIGHMEM enabled
Date:   Mon, 30 Jul 2018 19:26:35 +0300
Message-Id: <20180730162636.3556-4-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * None.

 arch/arc/mm/cache.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index dac12afbb93a..389602cf1594 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -1143,6 +1143,19 @@ noinline void __init arc_ioc_setup(void)
 {
 	unsigned int ioc_base, mem_sz;
 
+	/*
+	 * As for today we don't support both IOC and ZONE_HIGHMEM enabled
+	 * simultaneously. This happens because as of today IOC aperture covers
+	 * only ZONE_NORMAL (low mem) and any dma transactions outside this
+	 * region won't be HW coherent.
+	 * If we want to use both IOC and ZONE_HIGHMEM we can use
+	 * bounce_buffer to handle dma transactions to HIGHMEM.
+	 * Also it is possible to modify dma_direct cache ops or increase IOC
+	 * aperture size if we are planning to use HIGHMEM without PAE.
+	 */
+	if (IS_ENABLED(CONFIG_HIGHMEM))
+		panic("IOC and HIGHMEM can't be used simultaneously");
+
 	/* Flush + invalidate + disable L1 dcache */
 	__dc_disable();
 
-- 
2.14.4

