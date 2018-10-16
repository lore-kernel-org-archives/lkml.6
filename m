Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66AFC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91902204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="htXhAqXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91902204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbeJQBR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730677AbeJQBRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:17:25 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA7B4204EC;
        Tue, 16 Oct 2018 17:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710759;
        bh=C/in+rhltW4nHOk2LpLH2B01nocaZhixx65+YtiH3qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htXhAqXbxnYRexJ5XRS6PbFiQcrgaC5shgL7F1gSbtG01KsgGVfVcddq0u7FHhn1t
         vGCCA1Rav3TYtRBDdz8GhkDJpbBEQK/E0FDULOg/Z9LKi3V40q/TofmyiWbg2eBaLu
         vyWOM1qN/mPobsGql1TvAYWoTxLnCk3EJOD/vPnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 55/71] inet: frags: do not clone skb in ip_expire()
Date:   Tue, 16 Oct 2018 19:09:52 +0200
Message-Id: <20181016170542.123827549@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

An skb_clone() was added in commit ec4fbd64751d ("inet: frag: release
spinlock before calling icmp_send()")

While fixing the bug at that time, it also added a very high cost
for DDOS frags, as the ICMP rate limit is applied after this
expensive operation (skb_clone() + consume_skb(), implying memory
allocations, copy, and freeing)

We can use skb_get(head) here, all we want is to make sure skb wont
be freed by another cpu.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 1eec5d5670084ee644597bd26c25e22c69b9f748)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_fragment.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -141,8 +141,8 @@ static bool frag_expire_skip_icmp(u32 us
  */
 static void ip_expire(unsigned long arg)
 {
-	struct sk_buff *clone, *head;
 	const struct iphdr *iph;
+	struct sk_buff *head;
 	struct net *net;
 	struct ipq *qp;
 	int err;
@@ -185,16 +185,12 @@ static void ip_expire(unsigned long arg)
 	    (skb_rtable(head)->rt_type != RTN_LOCAL))
 		goto out;
 
-	clone = skb_clone(head, GFP_ATOMIC);
+	skb_get(head);
+	spin_unlock(&qp->q.lock);
+	icmp_send(head, ICMP_TIME_EXCEEDED, ICMP_EXC_FRAGTIME, 0);
+	kfree_skb(head);
+	goto out_rcu_unlock;
 
-	/* Send an ICMP "Fragment Reassembly Timeout" message. */
-	if (clone) {
-		spin_unlock(&qp->q.lock);
-		icmp_send(clone, ICMP_TIME_EXCEEDED,
-			  ICMP_EXC_FRAGTIME, 0);
-		consume_skb(clone);
-		goto out_rcu_unlock;
-	}
 out:
 	spin_unlock(&qp->q.lock);
 out_rcu_unlock:


