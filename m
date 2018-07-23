Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C22ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1DB20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1DB20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbeGWN2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:28:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45490 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbeGWN2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:28:40 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E9F93BB3;
        Mon, 23 Jul 2018 12:27:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 52/63] sctp: introduce sctp_dst_mtu
Date:   Mon, 23 Jul 2018 14:24:58 +0200
Message-Id: <20180723122448.327988130@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
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

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

[ Upstream commit 6ff0f871c20ec1769a481edca86f23c76b2b06d3 ]

Which makes sure that the MTU respects the minimum value of
SCTP_DEFAULT_MINSEGMENT and that it is correctly aligned.

Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sctp/sctp.h |    9 +++++++--
 net/sctp/associola.c    |    6 ++----
 net/sctp/transport.c    |    6 +++---
 3 files changed, 12 insertions(+), 9 deletions(-)

--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -609,10 +609,15 @@ static inline struct dst_entry *sctp_tra
 	return t->dst;
 }
 
+static inline __u32 sctp_dst_mtu(const struct dst_entry *dst)
+{
+	return SCTP_TRUNC4(max_t(__u32, dst_mtu(dst),
+				 SCTP_DEFAULT_MINSEGMENT));
+}
+
 static inline bool sctp_transport_pmtu_check(struct sctp_transport *t)
 {
-	__u32 pmtu = max_t(size_t, SCTP_TRUNC4(dst_mtu(t->dst)),
-			   SCTP_DEFAULT_MINSEGMENT);
+	__u32 pmtu = sctp_dst_mtu(t->dst);
 
 	if (t->pathmtu == pmtu)
 		return true;
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1446,11 +1446,9 @@ void sctp_assoc_sync_pmtu(struct sctp_as
 		return;
 
 	/* Get the lowest pmtu of all the transports. */
-	list_for_each_entry(t, &asoc->peer.transport_addr_list,
-				transports) {
+	list_for_each_entry(t, &asoc->peer.transport_addr_list, transports) {
 		if (t->pmtu_pending && t->dst) {
-			sctp_transport_update_pmtu(
-					t, SCTP_TRUNC4(dst_mtu(t->dst)));
+			sctp_transport_update_pmtu(t, sctp_dst_mtu(t->dst));
 			t->pmtu_pending = 0;
 		}
 		if (!pmtu || (t->pathmtu < pmtu))
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -242,9 +242,9 @@ void sctp_transport_pmtu(struct sctp_tra
 						&transport->fl, sk);
 	}
 
-	if (transport->dst) {
-		transport->pathmtu = SCTP_TRUNC4(dst_mtu(transport->dst));
-	} else
+	if (transport->dst)
+		transport->pathmtu = sctp_dst_mtu(transport->dst);
+	else
 		transport->pathmtu = SCTP_DEFAULT_MAXSEGMENT;
 }
 


