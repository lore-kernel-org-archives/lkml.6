Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296FEC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE6020854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE6020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbeIMTAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:00:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730608AbeIMTAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:00:46 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4EEA7CFE;
        Thu, 13 Sep 2018 13:51:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 020/197] sctp: remove useless start_fail from sctp_ht_iter in proc
Date:   Thu, 13 Sep 2018 15:29:29 +0200
Message-Id: <20180913131842.375718310@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 834539e69a5fe2aab33cc777ccfd4a4fcc5b9770 ]

After changing rhashtable_walk_start to return void, start_fail would
never be set other value than 0, and the checking for start_fail is
pointless, so remove it.

Fixes: 97a6ec4ac021 ("rhashtable: Change rhashtable_walk_start to return void")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/proc.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/net/sctp/proc.c
+++ b/net/sctp/proc.c
@@ -215,7 +215,6 @@ static const struct seq_operations sctp_
 struct sctp_ht_iter {
 	struct seq_net_private p;
 	struct rhashtable_iter hti;
-	int start_fail;
 };
 
 static void *sctp_transport_seq_start(struct seq_file *seq, loff_t *pos)
@@ -224,7 +223,6 @@ static void *sctp_transport_seq_start(st
 
 	sctp_transport_walk_start(&iter->hti);
 
-	iter->start_fail = 0;
 	return sctp_transport_get_idx(seq_file_net(seq), &iter->hti, *pos);
 }
 
@@ -232,8 +230,6 @@ static void sctp_transport_seq_stop(stru
 {
 	struct sctp_ht_iter *iter = seq->private;
 
-	if (iter->start_fail)
-		return;
 	sctp_transport_walk_stop(&iter->hti);
 }
 


