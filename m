Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF60C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA1A20838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760031;
	bh=ihVioELF6UUkH0+pN6NzQ95QXChw5kJ7i2TffBTwZp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fpy994QwK+IDfIpeLKRLuOwQer75ha1v5CreoCbK5EsWj6XRp8TfdDhDz6MJsdJ7P
	 27nJ7EKHFoZvhASUiVPZF4DcvPj71ZS9FXX49GWh4v1PxfCCBLLDBgons623OWC0EB
	 ay5+TEEFykbG7KpqVrutZ5hoqjUqyiZGfnNXWnyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfBUOka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbfBUOk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:40:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF2820838;
        Thu, 21 Feb 2019 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760026;
        bh=ihVioELF6UUkH0+pN6NzQ95QXChw5kJ7i2TffBTwZp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qGusetheuytCtCJEG/Jd97V35nQdtSco6INcM247hPADdPyINmkxlEK4+NvA3FGEf
         BEY6b1/vbvdCLOUzG4oE3LMIRBdavtFchGFc+ty0vGu0rSW8zuitS2jZzjCP20DkJi
         n/YWru0uh1KMpF2/NDAQJ5S14qFGVwoQw4gUcLF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 05/23] vxlan: test dev->flags & IFF_UP before calling netif_rx()
Date:   Thu, 21 Feb 2019 15:35:47 +0100
Message-Id: <20190221125246.676378332@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125246.162644302@linuxfoundation.org>
References: <20190221125246.162644302@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4179cb5a4c924cd233eaadd081882425bc98f44e ]

netif_rx() must be called under a strict contract.

At device dismantle phase, core networking clears IFF_UP
and flush_all_backlogs() is called after rcu grace period
to make sure no incoming packet might be in a cpu backlog
and still referencing the device.

Most drivers call netif_rx() from their interrupt handler,
and since the interrupts are disabled at device dismantle,
netif_rx() does not have to check dev->flags & IFF_UP

Virtual drivers do not have this guarantee, and must
therefore make the check themselves.

Otherwise we risk use-after-free and/or crashes.

Note this patch also fixes a small issue that came
with commit ce6502a8f957 ("vxlan: fix a use after free
in vxlan_encap_bypass"), since the dev->stats.rx_dropped
change was done on the wrong device.

Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
Fixes: ce6502a8f957 ("vxlan: fix a use after free in vxlan_encap_bypass")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Petr Machata <petrm@mellanox.com>
Cc: Ido Schimmel <idosch@mellanox.com>
Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
Cc: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 13d39a72fe0d0..a1b40b9c4906e 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2002,7 +2002,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	struct pcpu_sw_netstats *tx_stats, *rx_stats;
 	union vxlan_addr loopback;
 	union vxlan_addr *remote_ip = &dst_vxlan->default_dst.remote_ip;
-	struct net_device *dev = skb->dev;
+	struct net_device *dev;
 	int len = skb->len;
 
 	tx_stats = this_cpu_ptr(src_vxlan->dev->tstats);
@@ -2022,9 +2022,15 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 #endif
 	}
 
+	rcu_read_lock();
+	dev = skb->dev;
+	if (unlikely(!(dev->flags & IFF_UP))) {
+		kfree_skb(skb);
+		goto drop;
+	}
+
 	if (dst_vxlan->cfg.flags & VXLAN_F_LEARN)
-		vxlan_snoop(skb->dev, &loopback, eth_hdr(skb)->h_source, 0,
-			    vni);
+		vxlan_snoop(dev, &loopback, eth_hdr(skb)->h_source, 0, vni);
 
 	u64_stats_update_begin(&tx_stats->syncp);
 	tx_stats->tx_packets++;
@@ -2037,8 +2043,10 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 		rx_stats->rx_bytes += len;
 		u64_stats_update_end(&rx_stats->syncp);
 	} else {
+drop:
 		dev->stats.rx_dropped++;
 	}
+	rcu_read_unlock();
 }
 
 static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
-- 
2.19.1



