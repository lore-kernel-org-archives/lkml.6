Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2D5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C072089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xeScyFB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C072089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbeJQBDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbeJQBDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:03:50 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27DB520866;
        Tue, 16 Oct 2018 17:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709947;
        bh=XmBiKDKcpxhmGa6jExpSznHAvcQSnLJ+iPrxJlOneTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xeScyFB5J2hyemWQM6+epZJIM5fEdfn8kCUmQTKX69PQvx/jLMNc4Bvh8DWn/zr5T
         MeamldAdxVZF2Uosb5Q/n33YqLcj1bjC5BMffWKa0Y4yLuWDDTz6qTpxHtIESKg41a
         9Z3chyhkvvONQey/qABakrGPuWUIEcmqkRox/zoU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 052/135] net: ipv4: dont let PMTU updates increase route MTU
Date:   Tue, 16 Oct 2018 19:04:42 +0200
Message-Id: <20181016170518.220019849@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 28d35bcdd3925e7293408cdb8aa5f2aac5f0d6e3 ]

When an MTU update with PMTU smaller than net.ipv4.route.min_pmtu is
received, we must clamp its value. However, we can receive a PMTU
exception with PMTU < old_mtu < ip_rt_min_pmtu, which would lead to an
increase in PMTU.

To fix this, take the smallest of the old MTU and ip_rt_min_pmtu.

Before this patch, in case of an update, the exception's MTU would
always change. Now, an exception can have only its lock flag updated,
but not the MTU, so we need to add a check on locking to the following
"is this exception getting updated, or close to expiring?" test.

Fixes: d52e5a7e7ca4 ("ipv4: lock mtu in fnhe when received PMTU < net.ipv4.route.min_pmtu")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1001,21 +1001,22 @@ out:	kfree_skb(skb);
 static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 {
 	struct dst_entry *dst = &rt->dst;
+	u32 old_mtu = ipv4_mtu(dst);
 	struct fib_result res;
 	bool lock = false;
 
 	if (ip_mtu_locked(dst))
 		return;
 
-	if (ipv4_mtu(dst) < mtu)
+	if (old_mtu < mtu)
 		return;
 
 	if (mtu < ip_rt_min_pmtu) {
 		lock = true;
-		mtu = ip_rt_min_pmtu;
+		mtu = min(old_mtu, ip_rt_min_pmtu);
 	}
 
-	if (rt->rt_pmtu == mtu &&
+	if (rt->rt_pmtu == mtu && !lock &&
 	    time_before(jiffies, dst->expires - ip_rt_mtu_expires / 2))
 		return;
 


