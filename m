Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98740C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D20D25054
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D20D25054
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755859AbeFXPko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:40:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755321AbeFXPkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:40:43 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9D27C49F;
        Sun, 24 Jun 2018 15:40:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 05/70] net: dsa: add error handling for pskb_trim_rcsum
Date:   Sun, 24 Jun 2018 23:21:57 +0800
Message-Id: <20180624142740.793660001@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 349b71d6f427ff8211adf50839dbbff3f27c1805 ]

When pskb_trim_rcsum fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pskb_trim_rcsum.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/tag_trailer.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/dsa/tag_trailer.c
+++ b/net/dsa/tag_trailer.c
@@ -75,7 +75,8 @@ static struct sk_buff *trailer_rcv(struc
 	if (!skb->dev)
 		return NULL;
 
-	pskb_trim_rcsum(skb, skb->len - 4);
+	if (pskb_trim_rcsum(skb, skb->len - 4))
+		return NULL;
 
 	return skb;
 }


