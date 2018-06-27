Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAD1C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEA726390
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEA726390
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965516AbeF0N0x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:26:53 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47352 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964969AbeF0N0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:26:51 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MSDwg-1fijPR0yEM-00TBds; Wed, 27 Jun 2018 15:26:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Henry Orosco <henry.orosco@intel.com>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] [v2] infiniband: i40iw, nes: don't use wall time for TCP sequence numbers
Date:   Wed, 27 Jun 2018 15:26:05 +0200
Message-Id: <20180627132628.915978-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:kGuJaX4Ijbwfy5kQA226izXIBETcKwmuXeUpta8Nyl0EPC17CMG
 /nDCzBlrulRr/zWj5ihP4EEoGeiyJXs6uCP/+YCzFnIG69vGJDjflrXUQDBlGtwJPFCixhd
 YvBq/YoU09axHytwZJZuM0oLNRAQIhpGS8oDu+KdD+ungKy9gqGQ+e7ksTnh9qYbZqYXMPn
 P7WDvFUPoGjsBOxBVtrsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:58jnna7/ffE=:udBbJFph8Yi/KyzEsPPGBc
 X6WK39fdD/O/7D2k4xOz+3lIXfxx2/XC7+x9wE0dj96AOang6AOsr6bnndYqMptNMX0MmdWFJ
 k6rzmPvpVkbAmksMTVB8ZJ0OCxUEX278cdcbL2O7YuYb3WT0LWFsVBPJYs1aVTn7/3+adLxPm
 MnAqmVkJOADpchk0DFz9QKTt6oJHRT+ZEgGbZBr3Q6cgSFRWDyk4Ru6n7W9jIQ1oDKj7B8lyJ
 Gb5I+2eOZU5HZw11sRLHrhmfFW64n6rmTubt6PzDRpCTcC1LbObT2QD57tHhpxr9lIHTHg9Mh
 jUUOoMXaxjt04+Vy8aSP14PEXmiToWZSu9sJU6qWGWDsA20/BEDJ5ROr43DKJJyO/iLVJOSKf
 Mkb70bTI4ylqOgMffkYlWF883pKI5tke6RDP+f6GZEuuYE2kHNqbUmBpyobPh2pmrXL3IV0Vn
 KTyB+RTk1XKV8pSefD1h0VCPM1F4xNSuRJE6pBLciptmVxSJ48t/HCjHYpyjht7CNCB/R6rtN
 GbN6fpRiLBW2kFpDwRrat9tyRdYLDGb9SaRh3vnQ6xV/oA0edRs3vQzyqC46FnEfASQs2ByxA
 psr4O2s1/XTtFW4qvMApZvYSTz+VLQnAxHHkIbEUgbqDzf+B3Kl+lPcNUFRxgYYyWLjxZ+m6G
 agfByt3cGFrm89AxmbDvQ09x4+qZZYcr5Pl6xr1YgooBcHBAn5lfaK4FVERuQra0esJM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nes infiniband driver uses current_kernel_time() to get a nanosecond
granunarity timestamp to initialize its tcp sequence counters. This is
one of only a few remaining users of that deprecated function, so we
should try to get rid of it.

Aside from using a deprecated API, there are several problems I see here:

- Using a CLOCK_REALTIME based time source makes it predictable in
  case the time base is synchronized.
- Using a coarse timestamp means it only gets updated once per jiffie,
  making it even more predictable in order to avoid having to access
  the hardware clock source
- The upper 2 bits are always zero because the nanoseconds are at most
  999999999.

For the Linux TCP implementation, we use secure_tcp_seq(), which appears
to be appropriate here as well, and solves all the above problems.

i40iw uses a variant of the same code, so I do that same thing there
for ipv4. Unlike nes, i40e also supports ipv6, which needs to call
secure_tcpv6_seq instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use secure_tcpv6_seq for IPv6 support as suggested by Shiraz Saleem.
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 26 +++++++++++++++++++++-----
 drivers/infiniband/hw/nes/nes_cm.c     |  8 +++++---
 net/core/secure_seq.c                  |  1 +
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 7b2655128b9f..e2590784b857 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -57,6 +57,7 @@
 #include <net/addrconf.h>
 #include <net/ip6_route.h>
 #include <net/ip_fib.h>
+#include <net/secure_seq.h>
 #include <net/tcp.h>
 #include <asm/checksum.h>
 
@@ -2164,7 +2165,6 @@ static struct i40iw_cm_node *i40iw_make_cm_node(
 				   struct i40iw_cm_listener *listener)
 {
 	struct i40iw_cm_node *cm_node;
-	struct timespec ts;
 	int oldarpindex;
 	int arpindex;
 	struct net_device *netdev = iwdev->netdev;
@@ -2214,10 +2214,26 @@ static struct i40iw_cm_node *i40iw_make_cm_node(
 	cm_node->tcp_cntxt.rcv_wscale = I40IW_CM_DEFAULT_RCV_WND_SCALE;
 	cm_node->tcp_cntxt.rcv_wnd =
 			I40IW_CM_DEFAULT_RCV_WND_SCALED >> I40IW_CM_DEFAULT_RCV_WND_SCALE;
-	ts = current_kernel_time();
-	cm_node->tcp_cntxt.loc_seq_num = ts.tv_nsec;
-	cm_node->tcp_cntxt.mss = (cm_node->ipv4) ? (iwdev->vsi.mtu - I40IW_MTU_TO_MSS_IPV4) :
-				 (iwdev->vsi.mtu - I40IW_MTU_TO_MSS_IPV6);
+	if (cm_node->ipv4) {
+		cm_node->tcp_cntxt.loc_seq_num = secure_tcp_seq(htonl(cm_node->loc_addr[0]),
+							htonl(cm_node->rem_addr[0]),
+							htons(cm_node->loc_port),
+							htons(cm_node->rem_port));
+		cm_node->tcp_cntxt.mss = iwdev->vsi.mtu - I40IW_MTU_TO_MSS_IPV4;
+	} else {
+		__be32 loc[4] = {
+			htonl(cm_node->loc_addr[0]), htonl(cm_node->loc_addr[1]),
+			htonl(cm_node->loc_addr[2]), htonl(cm_node->loc_addr[3])
+		};
+		__be32 rem[4] = {
+			htonl(cm_node->rem_addr[0]), htonl(cm_node->rem_addr[1]),
+			htonl(cm_node->rem_addr[2]), htonl(cm_node->rem_addr[3])
+		};
+		cm_node->tcp_cntxt.loc_seq_num = secure_tcpv6_seq(loc, rem,
+							htons(cm_node->loc_port),
+							htons(cm_node->rem_port));
+		cm_node->tcp_cntxt.mss = iwdev->vsi.mtu - I40IW_MTU_TO_MSS_IPV6;
+	}
 
 	cm_node->iwdev = iwdev;
 	cm_node->dev = &iwdev->sc_dev;
diff --git a/drivers/infiniband/hw/nes/nes_cm.c b/drivers/infiniband/hw/nes/nes_cm.c
index 6cdfbf8c5674..2b67ace5b614 100644
--- a/drivers/infiniband/hw/nes/nes_cm.c
+++ b/drivers/infiniband/hw/nes/nes_cm.c
@@ -58,6 +58,7 @@
 #include <net/neighbour.h>
 #include <net/route.h>
 #include <net/ip_fib.h>
+#include <net/secure_seq.h>
 #include <net/tcp.h>
 #include <linux/fcntl.h>
 
@@ -1445,7 +1446,6 @@ static struct nes_cm_node *make_cm_node(struct nes_cm_core *cm_core,
 					struct nes_cm_listener *listener)
 {
 	struct nes_cm_node *cm_node;
-	struct timespec ts;
 	int oldarpindex = 0;
 	int arpindex = 0;
 	struct nes_device *nesdev;
@@ -1496,8 +1496,10 @@ static struct nes_cm_node *make_cm_node(struct nes_cm_core *cm_core,
 	cm_node->tcp_cntxt.rcv_wscale = NES_CM_DEFAULT_RCV_WND_SCALE;
 	cm_node->tcp_cntxt.rcv_wnd = NES_CM_DEFAULT_RCV_WND_SCALED >>
 				     NES_CM_DEFAULT_RCV_WND_SCALE;
-	ts = current_kernel_time();
-	cm_node->tcp_cntxt.loc_seq_num = htonl(ts.tv_nsec);
+	cm_node->tcp_cntxt.loc_seq_num = secure_tcp_seq(htonl(cm_node->loc_addr),
+							htonl(cm_node->rem_addr),
+							htons(cm_node->loc_port),
+							htons(cm_node->rem_port));
 	cm_node->tcp_cntxt.mss = nesvnic->max_frame_size - sizeof(struct iphdr) -
 				 sizeof(struct tcphdr) - ETH_HLEN - VLAN_HLEN;
 	cm_node->tcp_cntxt.rcv_nxt = 0;
diff --git a/net/core/secure_seq.c b/net/core/secure_seq.c
index 7232274de334..af6ad467ed61 100644
--- a/net/core/secure_seq.c
+++ b/net/core/secure_seq.c
@@ -140,6 +140,7 @@ u32 secure_tcp_seq(__be32 saddr, __be32 daddr,
 			    &net_secret);
 	return seq_scale(hash);
 }
+EXPORT_SYMBOL_GPL(secure_tcp_seq);
 
 u32 secure_ipv4_port_ephemeral(__be32 saddr, __be32 daddr, __be16 dport)
 {
-- 
2.9.0

