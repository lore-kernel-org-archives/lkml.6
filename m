Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD08C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44E420854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44E420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeIMSob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:44:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeIMSoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:44:30 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 71433D10;
        Thu, 13 Sep 2018 13:35:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+fe62a0c9aa6a85c6de16@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 10/78] sctp: hold transport before accessing its asoc in sctp_transport_get_next
Date:   Thu, 13 Sep 2018 15:30:57 +0200
Message-Id: <20180913131806.402048634@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131805.732342940@linuxfoundation.org>
References: <20180913131805.732342940@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit bab1be79a5169ac748d8292b20c86d874022d7ba ]

As Marcelo noticed, in sctp_transport_get_next, it is iterating over
transports but then also accessing the association directly, without
checking any refcnts before that, which can cause an use-after-free
Read.

So fix it by holding transport before accessing the association. With
that, sctp_transport_hold calls can be removed in the later places.

Fixes: 626d16f50f39 ("sctp: export some apis or variables for sctp_diag and reuse some for proc")
Reported-by: syzbot+fe62a0c9aa6a85c6de16@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/proc.c   |    4 ----
 net/sctp/socket.c |   22 +++++++++++++++-------
 2 files changed, 15 insertions(+), 11 deletions(-)

--- a/net/sctp/proc.c
+++ b/net/sctp/proc.c
@@ -337,8 +337,6 @@ static int sctp_assocs_seq_show(struct s
 	}
 
 	transport = (struct sctp_transport *)v;
-	if (!sctp_transport_hold(transport))
-		return 0;
 	assoc = transport->asoc;
 	epb = &assoc->base;
 	sk = epb->sk;
@@ -428,8 +426,6 @@ static int sctp_remaddr_seq_show(struct
 	}
 
 	transport = (struct sctp_transport *)v;
-	if (!sctp_transport_hold(transport))
-		return 0;
 	assoc = transport->asoc;
 
 	list_for_each_entry_rcu(tsp, &assoc->peer.transport_addr_list,
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4476,9 +4476,14 @@ struct sctp_transport *sctp_transport_ge
 			break;
 		}
 
+		if (!sctp_transport_hold(t))
+			continue;
+
 		if (net_eq(sock_net(t->asoc->base.sk), net) &&
 		    t->asoc->peer.primary_path == t)
 			break;
+
+		sctp_transport_put(t);
 	}
 
 	return t;
@@ -4488,13 +4493,18 @@ struct sctp_transport *sctp_transport_ge
 					      struct rhashtable_iter *iter,
 					      int pos)
 {
-	void *obj = SEQ_START_TOKEN;
+	struct sctp_transport *t;
+
+	if (!pos)
+		return SEQ_START_TOKEN;
 
-	while (pos && (obj = sctp_transport_get_next(net, iter)) &&
-	       !IS_ERR(obj))
-		pos--;
+	while ((t = sctp_transport_get_next(net, iter)) && !IS_ERR(t)) {
+		if (!--pos)
+			break;
+		sctp_transport_put(t);
+	}
 
-	return obj;
+	return t;
 }
 
 int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
@@ -4556,8 +4566,6 @@ int sctp_for_each_transport(int (*cb)(st
 	for (; !IS_ERR_OR_NULL(obj); obj = sctp_transport_get_next(net, &hti)) {
 		struct sctp_transport *transport = obj;
 
-		if (!sctp_transport_hold(transport))
-			continue;
 		err = cb(transport, p);
 		sctp_transport_put(transport);
 		if (err)


