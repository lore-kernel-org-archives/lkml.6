Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA66AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C2520862
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="emUTlNy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C2520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbeKCDxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbeKCDxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:53:05 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC68F20866;
        Fri,  2 Nov 2018 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184292;
        bh=rwBYUjk3+Y885THj6O7mHQnAPLPbHAZcxkkBonNHu6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=emUTlNy5v/Gm87L302tW4MnE+5ibudT3YQalg9OSkVvMDrbg9qF43PD/ebS1QOKM5
         aQElUvzh5RGvnj4LPCxl3t8GJrCVVGpZ1MTG7CSqQ2B84SrY6neJ+3lCr5sxkzhIYr
         cbevTYGiRVjE6wAw/mh3aU++KcntZBSG2rMAeCQA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tung Nguyen <tung.q.nguyen@dektech.com.au>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 118/150] tipc: fix unsafe rcu locking when accessing publication list
Date:   Fri,  2 Nov 2018 19:34:40 +0100
Message-Id: <20181102182911.272834121@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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

From: Tung Nguyen <tung.q.nguyen@dektech.com.au>

[ Upstream commit d3092b2efca1cd1d492d0b08499a2066c5ca8cec ]

The binding table's 'cluster_scope' list is rcu protected to handle
races between threads changing the list and those traversing the list at
the same moment. We have now found that the function named_distribute()
uses the regular list_for_each() macro to traverse the said list.
Likewise, the function tipc_named_withdraw() is removing items from the
same list using the regular list_del() call. When these two functions
execute in parallel we see occasional crashes.

This commit fixes this by adding the missing _rcu() suffixes.

Signed-off-by: Tung Nguyen <tung.q.nguyen@dektech.com.au>
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/name_distr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -115,7 +115,7 @@ struct sk_buff *tipc_named_withdraw(stru
 	struct sk_buff *buf;
 	struct distr_item *item;
 
-	list_del(&publ->binding_node);
+	list_del_rcu(&publ->binding_node);
 
 	if (publ->scope == TIPC_NODE_SCOPE)
 		return NULL;
@@ -147,7 +147,7 @@ static void named_distribute(struct net
 			ITEM_SIZE) * ITEM_SIZE;
 	u32 msg_rem = msg_dsz;
 
-	list_for_each_entry(publ, pls, binding_node) {
+	list_for_each_entry_rcu(publ, pls, binding_node) {
 		/* Prepare next buffer: */
 		if (!skb) {
 			skb = named_prepare_buf(net, PUBLICATION, msg_rem,


