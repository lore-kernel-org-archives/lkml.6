Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417C4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044A42086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044A42086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935310AbeFROpU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:45:20 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40369 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935268AbeFROpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:45:17 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MNtFb-1faj5A1uod-007RBU; Mon, 18 Jun 2018 16:44:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, netdev@vger.kernel.org,
        Henry Orosco <henry.orosco@intel.com>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Kees Cook <keescook@chromium.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband: i40iw, nes: don't use wall time for TCP sequence numbers
Date:   Mon, 18 Jun 2018 16:44:17 +0200
Message-Id: <20180618144443.137068-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:bgpobGyGp8qz5YX86RA4EBUYoavY2o2XQMpH72mgwvsA+Vfz2Cy
 TzbR/SomELtSPL3zucYebeJ7fcK2u5+KbnpjInQt5aw4ZtHkji/vbI9XeKjQ/fRsbCpmKBJ
 hbshIPXuUr94XtWudMhe5+fWbV2kp8E5qCt6oagCDoK3q0CdVTLbhUaOQ+oHXR36Bzg/gq7
 sUQMmV3AnQgI7Q1/cAcuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8JHttKDuCvE=:fVKsNN69bg30Bz+8rkr7WC
 3szhA5v+0z2le/3nIs8OrITdv4NWJCfLdSwGfvLw3yfRQSuhhtcGyYfxwjGuruSEg6qrCFNPf
 uP9QmsOzm0ZnWsWFHxhARh7HcjE4AkzANzttyzRo+wCiv9QnXWhqg4I8dMg11czqDBn9vDRZ2
 7d89waaq5RRLVlu+Vb5/n7CLVzdJQAGN3RH2ZQMyrKP9lnxOkKZGjIjeX46Jsa+dZlXyVPTqo
 1k1rApmc4nIEZtcEY1Mfs0wqBAR/uWWh3f2QUtccJ1n9fLhenIj0e7F0HcLADgzoTC0HyGrG1
 LVd1Jtcqg0OyzePiA73txPC8uljV6jRalSCrwRoeTK/5msDNUMNqIeGJo7xV6MYsbIBsRlm+2
 +f1S/4JoHpvYW10sHKuOE8bleDcfxCk06eZp1Z39AH6sQuK561fZWwkdhtKYIM9cUiXYhoXTm
 KI6XZmwsDydCH6sxhNQ2LZWDzi4J2OkwBGn4teYckZOQjMkCueaA8hZa90tU8WMOkvU8j7Wb5
 FoYeR2t/h4fYjQQzoA066sYAzBT7UmZuvliujScXtFOv0r646pkVnfl0XTHDoNLNZ53bZJTIt
 BgKw9gCVbQqzCW/fwOignD0OmK1IJDxjp+k1rdoBoqRGJaJaugcUyEuKQV3mvkKfA8ntaUdDD
 kE9C63YqK15BuTAxeP5NKgYkgQl2NVnLy6vm3tkv2FsylPMVcmQv8SFdplpALHXndkrA=
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

I'm doing the same change in both versions of the nes driver, with
i40iw being a later copy of the same code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The above change is just a guess at what it should look like,
please review carefully and Ack/Nak as appropriate.
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 8 +++++---
 drivers/infiniband/hw/nes/nes_cm.c     | 8 +++++---
 net/core/secure_seq.c                  | 1 +
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 7b2655128b9f..da221d07f2dd 100644
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
@@ -2214,8 +2214,10 @@ static struct i40iw_cm_node *i40iw_make_cm_node(
 	cm_node->tcp_cntxt.rcv_wscale = I40IW_CM_DEFAULT_RCV_WND_SCALE;
 	cm_node->tcp_cntxt.rcv_wnd =
 			I40IW_CM_DEFAULT_RCV_WND_SCALED >> I40IW_CM_DEFAULT_RCV_WND_SCALE;
-	ts = current_kernel_time();
-	cm_node->tcp_cntxt.loc_seq_num = ts.tv_nsec;
+	cm_node->tcp_cntxt.loc_seq_num = secure_tcp_seq(htonl(cm_node->loc_addr[0]),
+							htonl(cm_node->rem_addr[0]),
+							htons(cm_node->loc_port),
+							htons(cm_node->rem_port));
 	cm_node->tcp_cntxt.mss = (cm_node->ipv4) ? (iwdev->vsi.mtu - I40IW_MTU_TO_MSS_IPV4) :
 				 (iwdev->vsi.mtu - I40IW_MTU_TO_MSS_IPV6);
 
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

