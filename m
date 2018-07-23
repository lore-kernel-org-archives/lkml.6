Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6725FECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC5320854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC5320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389571AbeGWNce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:32:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46486 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389559AbeGWNcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:32:32 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5F63EBDB;
        Mon, 23 Jul 2018 12:31:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 25/28] skbuff: Unconditionally copy pfmemalloc in __skb_clone()
Date:   Mon, 23 Jul 2018 14:25:25 +0200
Message-Id: <20180723122427.000745641@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122425.241418073@linuxfoundation.org>
References: <20180723122425.241418073@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit e78bfb0751d4e312699106ba7efbed2bab1a53ca ]

Commit 8b7008620b84 ("net: Don't copy pfmemalloc flag in
__copy_skb_header()") introduced a different handling for the
pfmemalloc flag in copy and clone paths.

In __skb_clone(), now, the flag is set only if it was set in the
original skb, but not cleared if it wasn't. This is wrong and
might lead to socket buffers being flagged with pfmemalloc even
if the skb data wasn't allocated from pfmemalloc reserves. Copy
the flag instead of ORing it.

Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Fixes: 8b7008620b84 ("net: Don't copy pfmemalloc flag in __copy_skb_header()")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Tested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -904,8 +904,7 @@ static struct sk_buff *__skb_clone(struc
 	n->cloned = 1;
 	n->nohdr = 0;
 	n->peeked = 0;
-	if (skb->pfmemalloc)
-		n->pfmemalloc = 1;
+	C(pfmemalloc);
 	n->destructor = NULL;
 	C(tail);
 	C(end);


