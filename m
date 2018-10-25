Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5D9C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1A52064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEEQK4p5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1A52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeJYXMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbeJYWst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:49 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9FF2085B;
        Thu, 25 Oct 2018 14:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476952;
        bh=x//4R1wPQiwxgCoz3IQ/K3yEuZ724e6MlMZ0G+OECjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TEEQK4p5NT+74a0whh2FTPkoU1cO7lAOF6pvMMaQaVIDanITkR3SxJTwxGy0LC2SA
         XHAK89b5GujIn9ncMnxQlYXuQGl88zdKe8TiWmj3TNMxo9Y6oGnEtumloPePWLhqJi
         NzvRECJQtfljycrFEDVhKMk7GTXz3AV2xsiGXIDY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 60/98] sctp: use right member as the param of list_for_each_entry
Date:   Thu, 25 Oct 2018 10:13:45 -0400
Message-Id: <20181025141423.213774-60-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit a8dd397903a6e57157f6265911f7d35681364427 ]

Commit d04adf1b3551 ("sctp: reset owner sk for data chunks on out queues
when migrating a sock") made a mistake that using 'list' as the param of
list_for_each_entry to traverse the retransmit, sacked and abandoned
queues, while chunks are using 'transmitted_list' to link into these
queues.

It could cause NULL dereference panic if there are chunks in any of these
queues when peeling off one asoc.

So use the chunk member 'transmitted_list' instead in this patch.

Fixes: d04adf1b3551 ("sctp: reset owner sk for data chunks on out queues when migrating a sock")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/socket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 64d2d9ea2f8c..16aa8673f918 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -185,13 +185,13 @@ static void sctp_for_each_tx_datachunk(struct sctp_association *asoc,
 		list_for_each_entry(chunk, &t->transmitted, transmitted_list)
 			cb(chunk);
 
-	list_for_each_entry(chunk, &q->retransmit, list)
+	list_for_each_entry(chunk, &q->retransmit, transmitted_list)
 		cb(chunk);
 
-	list_for_each_entry(chunk, &q->sacked, list)
+	list_for_each_entry(chunk, &q->sacked, transmitted_list)
 		cb(chunk);
 
-	list_for_each_entry(chunk, &q->abandoned, list)
+	list_for_each_entry(chunk, &q->abandoned, transmitted_list)
 		cb(chunk);
 
 	list_for_each_entry(chunk, &q->out_chunk_list, list)
-- 
2.17.1

