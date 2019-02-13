Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B64C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECD5222C7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025623;
	bh=WzLCbO9Q+NFcWIQq8t2V1lDtqh9N5r5L92d/nUYJ97Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rpR0uHHAYCYGI4rOT65CNKYseNFY/1dRwCmY5OR3+FrrPv5W4h5Yw9kd+OjInkeG4
	 F2hNPTrrDwKYF3xYmkP0kYYVrb7o9GvTlScjrXgsFaTOVQ6XYgAZCZH3Hz8qa17VWz
	 x90MiuX5p3LBCzamDda1++PReEGX/iEOuZashJTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbfBMCkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388936AbfBMCkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF2F2175B;
        Wed, 13 Feb 2019 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025615;
        bh=WzLCbO9Q+NFcWIQq8t2V1lDtqh9N5r5L92d/nUYJ97Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNOa8RHVxLmBc+IpJHYlQbM/kAqonBSCz79+xa9faKh0Qh3rHbPPnFks7g6uZwFF1
         YY/bWtQX1sL0+gvG9+hzidffFrYqHi2vWPmpBoea1yzWVbbuYa6VHRA3rQXgbjBFzA
         HvoVPDzk67hBd1hUsszaozKa0Lua4TQM12Kftzlw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 17/34] netfilter: nf_tables: fix leaking object reference count
Date:   Tue, 12 Feb 2019 21:39:35 -0500
Message-Id: <20190213023952.21311-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023952.21311-1-sashal@kernel.org>
References: <20190213023952.21311-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit b91d9036883793122cf6575ca4dfbfbdd201a83d ]

There is no code that decreases the reference count of stateful objects
in error path of the nft_add_set_elem(). this causes a leak of reference
count of stateful objects.

Test commands:
   $nft add table ip filter
   $nft add counter ip filter c1
   $nft add map ip filter m1 { type ipv4_addr : counter \;}
   $nft add element ip filter m1 { 1 : c1 }
   $nft add element ip filter m1 { 1 : c1 }
   $nft delete element ip filter m1 { 1 }
   $nft delete counter ip filter c1

Result:
   Error: Could not process rule: Device or resource busy
   delete counter ip filter c1
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

At the second 'nft add element ip filter m1 { 1 : c1 }', the reference
count of the 'c1' is increased then it tries to insert into the 'm1'. but
the 'm1' already has same element so it returns -EEXIST.
But it doesn't decrease the reference count of the 'c1' in the error path.
Due to a leak of the reference count of the 'c1', the 'c1' can't be
removed by 'nft delete counter ip filter c1'.

Fixes: 8aeff920dcc9 ("netfilter: nf_tables: add stateful object reference to set elements")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 623ec29ade26..bf26e27ca456 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4046,6 +4046,8 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 err5:
 	kfree(trans);
 err4:
+	if (obj)
+		obj->use--;
 	kfree(elem.priv);
 err3:
 	if (nla[NFTA_SET_ELEM_DATA] != NULL)
-- 
2.19.1

