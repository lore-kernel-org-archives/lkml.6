Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C01DC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DB3208A2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DB3208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbeG0LtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:49:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42458 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730515AbeG0LtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:49:21 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 82E63CD2;
        Fri, 27 Jul 2018 10:28:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 09/27] skbuff: Unconditionally copy pfmemalloc in __skb_clone()
Date:   Fri, 27 Jul 2018 12:26:46 +0200
Message-Id: <20180727102649.382023308@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727102649.049641021@linuxfoundation.org>
References: <20180727102649.049641021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -780,8 +780,7 @@ static struct sk_buff *__skb_clone(struc
 	n->cloned = 1;
 	n->nohdr = 0;
 	n->peeked = 0;
-	if (skb->pfmemalloc)
-		n->pfmemalloc = 1;
+	C(pfmemalloc);
 	n->destructor = NULL;
 	C(tail);
 	C(end);


