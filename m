Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BC3C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D519D21570
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D519D21570
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeHTOKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:10:06 -0400
Received: from mail.windriver.com ([147.11.1.11]:44497 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeHTOKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:10:06 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w7KAskYM023235
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 20 Aug 2018 03:54:46 -0700 (PDT)
Received: from pek-lpgtest5.wrs.com (128.224.153.85) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.399.0; Mon, 20 Aug 2018 03:54:46 -0700
From:   Haiqing Bai <Haiqing.Bai@windriver.com>
To:     <jon.maloy@ericsson.com>, <ying.xue@windriver.com>,
        <davem@davemloft.net>, <zhenbo.gao@windriver.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tipc: fix issue that tipc_dest neglects of big-endian
Date:   Mon, 20 Aug 2018 18:26:01 +0800
Message-ID: <1534760761-30206-1-git-send-email-Haiqing.Bai@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tipc multicast demo in tipcutils fails to work on big-endian hardware.
The tipc multicast server can not receive the packets sent by the multicast
client for that the dest port is always zero after tipc_dest_pop, then it
is found that the struct tipc_dest fails to take big/little endian into
account.

Signed-off-by: Haiqing Bai <Haiqing.Bai@windriver.com>
Signed-off-by: Zhenbo Gao <zhenbo.gao@windriver.com>
---
 net/tipc/name_table.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h
index 0febba4..6e1e0ab 100644
--- a/net/tipc/name_table.h
+++ b/net/tipc/name_table.h
@@ -135,8 +135,13 @@ struct tipc_dest {
 	struct list_head list;
 	union {
 		struct {
+#ifdef __LITTLE_ENDIAN_BITFIELD
 			u32 port;
 			u32 node;
+#else /* __BIG_ENDIAN_BITFIELD */
+			u32 node;
+			u32 port;
+#endif
 		};
 		u64 value;
 	};
-- 
1.9.1

