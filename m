Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0A0C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EAC20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791078;
	bh=sG9cscE/W5a/o7IFtSzRBFvi+Em6jgqT04bI8+hXFwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mQma7sZzLzQ3VaBc+fJ0J3+DtLVtjee9AVhsIAMpmvHPDbrHGj7t0t0VIb9C6YKC+
	 uS8dZL6OlEJ9pHcopZ1qdOImAZmq64CwsCDAp8ABBPuk7BOuAClnFVLaUeX2TVc9fy
	 xhr0i7S14BLCBWMHwM/tJa+G2uX937ZgDX+ywtxM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EAC20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbeLNMh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:37:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730381AbeLNMGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4F1321486;
        Fri, 14 Dec 2018 12:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789164;
        bh=sG9cscE/W5a/o7IFtSzRBFvi+Em6jgqT04bI8+hXFwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zZfoW1n0Iq8cJibhERM0r7L4U17BpcdSgUNeOIB8AZzBEiwM2AdfFCNWY+tr+e/c5
         fLCVBID3OTBNLk66lSJxTjzFVXS4zU190sZ52wDSk6jlTc9ioJAXkuFDq/eItKUoDy
         DWT0jCDCphkX4CsMfH4oNZ1Xzg3v0sPRxtn8kRt8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 096/142] netfilter: nf_conncount: remove wrong condition check routine
Date:   Fri, 14 Dec 2018 12:59:41 +0100
Message-Id: <20181214115750.898134166@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 53ca0f2fec39c80ccd19e6e3f30cc8daef174b70 ]

All lists that reach the tree_nodes_free() function have both zero
counter and true dead flag. The reason for this is that lists to be
release are selected by nf_conncount_gc_list() which already decrements
the list counter and sets on the dead flag. Therefore, this if statement
in tree_nodes_free() is unnecessary and wrong.

Fixes: 31568ec09ea0 ("netfilter: nf_conncount: fix list_del corruption in conn_free")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conncount.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 8acae4a3e4c0..b6d0f6deea86 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -323,11 +323,8 @@ static void tree_nodes_free(struct rb_root *root,
 	while (gc_count) {
 		rbconn = gc_nodes[--gc_count];
 		spin_lock(&rbconn->list.list_lock);
-		if (rbconn->list.count == 0 && rbconn->list.dead == false) {
-			rbconn->list.dead = true;
-			rb_erase(&rbconn->node, root);
-			call_rcu(&rbconn->rcu_head, __tree_nodes_free);
-		}
+		rb_erase(&rbconn->node, root);
+		call_rcu(&rbconn->rcu_head, __tree_nodes_free);
 		spin_unlock(&rbconn->list.list_lock);
 	}
 }
-- 
2.19.1



