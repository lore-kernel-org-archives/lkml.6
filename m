Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4B4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432552064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432552064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeH2TpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:45:23 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55541 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbeH2TpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:45:23 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MXp03-1gOSLQ1iNz-00Wqy9; Wed, 29 Aug 2018 17:47:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Willem de Bruijn <willemb@google.com>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Avinash Repaka <avinash.repaka@oracle.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] rds: store socket timestamps as ktime_t
Date:   Wed, 29 Aug 2018 17:47:19 +0200
Message-Id: <20180829154732.844217-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:x03ehuuYWLKYMEwVUAHZJeXM3QlYVIuaFL18LzQ0/R16BzuiL3S
 0wRDTDHfLICIgKYNI7zb2cRrHP9rAlCztRVdBrXgMFVuxDENJhF/n5AT7RxW54tQO1lLewc
 b92H9iR1/AuW7LfGWqwIoKOwopMlwxSEsVR6IAhH5ZiuOL8+5amP7leyoY+g7c6yil2Zqx6
 /w1WzBy7gPXRXhI0onqBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TbNKnSoqhSw=:wsXajir3M770kERrsyI+Hv
 EhJeqc9W47u3uCMsoQcIRG+X6ngf5ohsb2VorF8T16+Mxp9pC1N+dFrTxqC8pFHZxUvkjBJph
 mGQedukzzE7hrN99XK+pTSZvx0vGPbBHK0Eqp2Um/mUv7N+l/hfYXHD+0UglQFCp8FrXS9v5X
 m3dlKTXwFtibCDQSepuloVwoLS0MHbspdwcSqbOdE52nmRr6/gmnAzTPN9v5579eVJLVSdga3
 mOpgcVFkK1DUWBRH+A+fhOhhdKCoovqWUPs96ZBzFO7X/PRD1nA1zBakZG48D03cZcKz4bx0o
 NcsmxH37VXy9Uk71PBaMUItgzXD6h7JavMtpiRkZ/OeQ7j0ngv/FLX6HRPy6fIIWPw59skK5N
 0n93HO651kqZIoolvWWS4apbDGdnZsVIBPSsokUftdrvY02VewQgYjDgJA1crZKpLiw45bKX7
 HNNUYF1ztxYQeZN7FmgbynqsqXHKY0y7pbB9xC/EyPLUMfafSDWJltCDMW6rMvCK1mGIZbSP4
 zAxWeNwg0uPYc1fD15AQbLwis1SG2K3kngyYs32q748kenlIDyYoJIk9LEETX9++4Yxx76pKj
 6KENABBfzjIzp87kQgP3/rFTDnpHIWFIAnWIBqNK/96kiiMj7Q73QbNmxFL4ob17Yvo+ThAA1
 bzgOehl352EdMRkqQ4Xl9z/M2b59XbyhG0ZSbKwU6zlwOl8Gh4KASU/chlv6D6TebOSc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rds is the last in-kernel user of the old do_gettimeofday()
function. Convert it over to ktime_get_real() to make it
work more like the generic socket timestamps, and to let
us kill off do_gettimeofday().

A follow-up patch will have to change the user space interface
to deal better with 32-bit tasks, which may use an incompatible
layout for 'struct timespec'.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/rds/rds.h  |  2 +-
 net/rds/recv.c | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/rds/rds.h b/net/rds/rds.h
index c4dcf654d8fe..6bfaf05b63b2 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -278,7 +278,7 @@ struct rds_incoming {
 	struct in6_addr		i_saddr;
 
 	rds_rdma_cookie_t	i_rdma_cookie;
-	struct timeval		i_rx_tstamp;
+	ktime_t			i_rx_tstamp;
 	u64			i_rx_lat_trace[RDS_RX_MAX_TRACES];
 };
 
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 504cd6bcc54c..12719653188a 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -50,8 +50,7 @@ void rds_inc_init(struct rds_incoming *inc, struct rds_connection *conn,
 	inc->i_conn = conn;
 	inc->i_saddr = *saddr;
 	inc->i_rdma_cookie = 0;
-	inc->i_rx_tstamp.tv_sec = 0;
-	inc->i_rx_tstamp.tv_usec = 0;
+	inc->i_rx_tstamp = ktime_set(0, 0);
 
 	for (i = 0; i < RDS_RX_MAX_TRACES; i++)
 		inc->i_rx_lat_trace[i] = 0;
@@ -67,8 +66,7 @@ void rds_inc_path_init(struct rds_incoming *inc, struct rds_conn_path *cp,
 	inc->i_conn_path = cp;
 	inc->i_saddr = *saddr;
 	inc->i_rdma_cookie = 0;
-	inc->i_rx_tstamp.tv_sec = 0;
-	inc->i_rx_tstamp.tv_usec = 0;
+	inc->i_rx_tstamp = ktime_set(0, 0);
 }
 EXPORT_SYMBOL_GPL(rds_inc_path_init);
 
@@ -385,7 +383,7 @@ void rds_recv_incoming(struct rds_connection *conn, struct in6_addr *saddr,
 				      be32_to_cpu(inc->i_hdr.h_len),
 				      inc->i_hdr.h_dport);
 		if (sock_flag(sk, SOCK_RCVTSTAMP))
-			do_gettimeofday(&inc->i_rx_tstamp);
+			inc->i_rx_tstamp = ktime_get_real();
 		rds_inc_addref(inc);
 		inc->i_rx_lat_trace[RDS_MSG_RX_END] = local_clock();
 		list_add_tail(&inc->i_item, &rs->rs_recv_queue);
@@ -552,11 +550,11 @@ static int rds_cmsg_recv(struct rds_incoming *inc, struct msghdr *msg,
 			goto out;
 	}
 
-	if ((inc->i_rx_tstamp.tv_sec != 0) &&
+	if ((inc->i_rx_tstamp != 0) &&
 	    sock_flag(rds_rs_to_sk(rs), SOCK_RCVTSTAMP)) {
+		struct timeval tv = ktime_to_timeval(inc->i_rx_tstamp);
 		ret = put_cmsg(msg, SOL_SOCKET, SCM_TIMESTAMP,
-			       sizeof(struct timeval),
-			       &inc->i_rx_tstamp);
+			       sizeof(tv), &tv);
 		if (ret)
 			goto out;
 	}
-- 
2.18.0

