Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D691BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F2520652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F2520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbeGTN2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:28:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbeGTN2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:28:17 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D674BCA0;
        Fri, 20 Jul 2018 12:36:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 016/101] net: dccp: switch rx_tstamp_last_feedback to monotonic clock
Date:   Fri, 20 Jul 2018 14:13:22 +0200
Message-Id: <20180720121423.628405497@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 0ce4e70ff00662ad7490e545ba0cd8c1fa179fca ]

To compute delays, better not use time of the day which can
be changed by admins or malicious programs.

Also change ccid3_first_li() to use s64 type for delta variable
to avoid potential overflows.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Cc: dccp@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dccp/ccids/ccid3.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/dccp/ccids/ccid3.c
+++ b/net/dccp/ccids/ccid3.c
@@ -600,7 +600,7 @@ static void ccid3_hc_rx_send_feedback(st
 {
 	struct ccid3_hc_rx_sock *hc = ccid3_hc_rx_sk(sk);
 	struct dccp_sock *dp = dccp_sk(sk);
-	ktime_t now = ktime_get_real();
+	ktime_t now = ktime_get();
 	s64 delta = 0;
 
 	switch (fbtype) {
@@ -632,7 +632,7 @@ static void ccid3_hc_rx_send_feedback(st
 		return;
 	}
 
-	ccid3_pr_debug("Interval %ldusec, X_recv=%u, 1/p=%u\n", (long)delta,
+	ccid3_pr_debug("Interval %lldusec, X_recv=%u, 1/p=%u\n", delta,
 		       hc->rx_x_recv, hc->rx_pinv);
 
 	hc->rx_tstamp_last_feedback = now;
@@ -679,7 +679,8 @@ static int ccid3_hc_rx_insert_options(st
 static u32 ccid3_first_li(struct sock *sk)
 {
 	struct ccid3_hc_rx_sock *hc = ccid3_hc_rx_sk(sk);
-	u32 x_recv, p, delta;
+	u32 x_recv, p;
+	s64 delta;
 	u64 fval;
 
 	if (hc->rx_rtt == 0) {
@@ -687,7 +688,9 @@ static u32 ccid3_first_li(struct sock *s
 		hc->rx_rtt = DCCP_FALLBACK_RTT;
 	}
 
-	delta  = ktime_to_us(net_timedelta(hc->rx_tstamp_last_feedback));
+	delta = ktime_us_delta(ktime_get(), hc->rx_tstamp_last_feedback);
+	if (delta <= 0)
+		delta = 1;
 	x_recv = scaled_div32(hc->rx_bytes_recv, delta);
 	if (x_recv == 0) {		/* would also trigger divide-by-zero */
 		DCCP_WARN("X_recv==0\n");


