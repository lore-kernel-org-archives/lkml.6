Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA40AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A480B21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjYHHuOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A480B21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbeJQBLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:11:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbeJQBLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:11:22 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70C4D21477;
        Tue, 16 Oct 2018 17:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710397;
        bh=WcI3tnG8YjTtjFQhA0MBciRASopNMTgO07mrLs1k9l8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjYHHuOAkg5MKnT534LhrVgRpSAfRioDeCj8SOKq2kJziBZT0vsAlwCLOtWaMLAGM
         3c9cstrrOtKXm9JF/y2FY3tAdClFySUVlYgswr3w1x4fNTlHmnQhgr/ALQvDoUbObW
         6MdPrcBiUsG7EveTXtIPt0x3FyBRusypGFXK2UKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 4.14 064/109] percpu: stop leaking bitmap metadata blocks
Date:   Tue, 16 Oct 2018 19:05:32 +0200
Message-Id: <20181016170528.331231775@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Rapoport <rppt@linux.vnet.ibm.com>

commit 6685b357363bfe295e3ae73665014db4aed62c58 upstream.

The commit ca460b3c9627 ("percpu: introduce bitmap metadata blocks")
introduced bitmap metadata blocks. These metadata blocks are allocated
whenever a new chunk is created, but they are never freed. Fix it.

Fixes: ca460b3c9627 ("percpu: introduce bitmap metadata blocks")
Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dennis Zhou <dennis@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/percpu.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1208,6 +1208,7 @@ static void pcpu_free_chunk(struct pcpu_
 {
 	if (!chunk)
 		return;
+	pcpu_mem_free(chunk->md_blocks);
 	pcpu_mem_free(chunk->bound_map);
 	pcpu_mem_free(chunk->alloc_map);
 	pcpu_mem_free(chunk);


