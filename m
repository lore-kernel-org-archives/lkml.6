Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59873C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A09622545
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VYlkuyzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A09622545
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933800AbeGFRPQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:15:16 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:39275 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933714AbeGFRPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:15:15 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8F14324E03F1;
        Fri,  6 Jul 2018 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1530897314; bh=HfOI10sPGCBNQSQJ+v2HPxHsCVuwvp9NlMMRqkAGvoU=;
        h=From:To:Cc:Subject:Date:From;
        b=VYlkuyzNLwyvC26NLyd/S/wwQzKJwNMLjB8S5SyiqkXrQhA0zBsQMAsCpMAza0DDV
         Wl7UdSI+AYpORV6hPggr9n1wporKWnHxaqiKnXylAvBzd9sJ5Xaob1yqh0y9hLkjJW
         qh9rHVHxM3/Xhd/qu+mdXLB4f1X9BlR4g06n+mGsS1VTixt5lwDHLLG2CcRsumThbo
         ztMWOIkiv90Fi/QrtZ3iWT9ZoLr/Q8cnQ4w8s3gxQRS7ucHCHjgsT/QfTFp3HBXgXC
         Ne9E3jDztqyR4UUu4wUaDff1o8BICrLbpmO1JgrMDRhQWsV5oslizC0O26hcabtfGA
         FAfd47wlsXCEg==
Received: from abrodkin-7480l.internal.synopsys.com (unknown [10.121.8.87])
        by mailhost.synopsys.com (Postfix) with ESMTP id 28994320E;
        Fri,  6 Jul 2018 10:15:12 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        stable@vger.kernel.org
Subject: [PATCH] devres: Really align data field to unsigned long long
Date:   Fri,  6 Jul 2018 20:15:04 +0300
Message-Id: <20180706171504.10265-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like on most of architectures "data" member of devres struture
gets aligned to 8-byte "unsigned long long" boundary as one may expect:
if we don't explicitly pack a structure then natural alignment
(which matches each member data type) is used.

But at least on 32-bit ARC architecture ABI requires "long long" types
to be aligned by normal 32-bit word. This makes "data" field aligned to
12 bytes. This is still OK as long as we use 32-bit data only.

But once we want to use native atomic64_t type (i.e. when we use special
instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
misaligned access exception.

That's because even on CPUs capable of non-aligned data access LL/SC
instructions require strict alignment.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: stable@vger.kernel.org
---
 drivers/base/devres.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index f98a097e73f2..35ddc8b66bc9 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -25,7 +25,7 @@ struct devres_node {
 struct devres {
 	struct devres_node		node;
 	/* -- 3 pointers */
-	unsigned long long		data[];	/* guarantee ull alignment */
+	unsigned long long		data[] __aligned(sizeof(unsigned long long));
 };
 
 struct devres_group {
-- 
2.17.1

