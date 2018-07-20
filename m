Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F55ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ED420652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39ED420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389916AbeGTNc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:32:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731629AbeGTNc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:32:58 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 89AD7D66;
        Fri, 20 Jul 2018 12:38:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4c20b3866171ce8441d2@syzkaller.appspotmail.com,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 077/101] rds: avoid unenecessary cong_update in loop transport
Date:   Fri, 20 Jul 2018 14:14:23 +0200
Message-Id: <20180720121426.552753935@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
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

From: Santosh Shilimkar <santosh.shilimkar@oracle.com>

commit f1693c63ab133d16994cc50f773982b5905af264 upstream.

Loop transport which is self loopback, remote port congestion
update isn't relevant. Infact the xmit path already ignores it.
Receive path needs to do the same.

Reported-by: syzbot+4c20b3866171ce8441d2@syzkaller.appspotmail.com
Reviewed-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rds/loop.c |    1 +
 net/rds/rds.h  |    5 +++++
 net/rds/recv.c |    5 +++++
 3 files changed, 11 insertions(+)

--- a/net/rds/loop.c
+++ b/net/rds/loop.c
@@ -193,4 +193,5 @@ struct rds_transport rds_loop_transport
 	.inc_copy_to_user	= rds_message_inc_copy_to_user,
 	.inc_free		= rds_loop_inc_free,
 	.t_name			= "loopback",
+	.t_type			= RDS_TRANS_LOOP,
 };
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -479,6 +479,11 @@ struct rds_notifier {
 	int			n_status;
 };
 
+/* Available as part of RDS core, so doesn't need to participate
+ * in get_preferred transport etc
+ */
+#define	RDS_TRANS_LOOP	3
+
 /**
  * struct rds_transport -  transport specific behavioural hooks
  *
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -103,6 +103,11 @@ static void rds_recv_rcvbuf_delta(struct
 		rds_stats_add(s_recv_bytes_added_to_socket, delta);
 	else
 		rds_stats_add(s_recv_bytes_removed_from_socket, -delta);
+
+	/* loop transport doesn't send/recv congestion updates */
+	if (rs->rs_transport->t_type == RDS_TRANS_LOOP)
+		return;
+
 	now_congested = rs->rs_rcv_bytes > rds_sk_rcvbuf(rs);
 
 	rdsdebug("rs %p (%pI4:%u) recv bytes %d buf %d "


