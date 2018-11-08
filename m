Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5A0ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E6621486
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTbyjryo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E6621486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbeKIHnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbeKIHnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:02 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 995E02086C;
        Thu,  8 Nov 2018 22:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714731;
        bh=SHDmP1dexCyrvfRHjU5cZocWceZU6tNjCkeh16TCRh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BTbyjryokjEgOiJFa3zXAdc7svRYtk2AhC49TzW5eupy91USKI8h7R/CTXTrpTlU5
         A4joEkr18EOEdRWRBvYVMLGl/P2Pawc8RZ91szgLN5XWbY/z2K86nvL+MRS3a0ak5Y
         biXPpjlL1b3rXmA4oEzGCsWVX4lIeUC8l2MuPyyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 090/171] sctp: use right member as the param of list_for_each_entry
Date:   Thu,  8 Nov 2018 13:51:00 -0800
Message-Id: <20181108215133.921126856@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



