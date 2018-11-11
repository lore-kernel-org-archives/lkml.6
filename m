Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CBDC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A61820869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A61820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbeKLGa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:30:29 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49438 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729548AbeKLFsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:04 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0000lJ-Go; Sun, 11 Nov 2018 19:58:34 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001OH-69; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Xin Long" <lucien.xin@gmail.com>,
        "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Neil Horman" <nhorman@tuxdriver.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.359690416@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 028/366] sctp: fix identification of new acks for
 SFR-CACC
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

commit 51446780fc33e45cb790c05a7fa2c5bf7e8bc53b upstream.

It's currently written as:

if (!tchunk->tsn_gap_acked) {   [1]
	tchunk->tsn_gap_acked = 1;
	...
}

if (TSN_lte(tsn, sack_ctsn)) {
	if (!tchunk->tsn_gap_acked) {
		/* SFR-CACC processing */
		...
	}
}

Which causes the SFR-CACC processing on ack reception to never process,
as tchunk->tsn_gap_acked is always true by then. Block [1] was
moved to that position by the commit marked below.

This patch fixes it by doing SFR-CACC processing earlier, before
tsn_gap_acked is set to true.

Fixes: 31b02e154940 ("sctp: Failover transmitted list on transport delete")
Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sctp/outqueue.c | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -1346,7 +1346,7 @@ static void sctp_check_transmitted(struc
 			 * the outstanding bytes for this chunk, so only
 			 * count bytes associated with a transport.
 			 */
-			if (transport) {
+			if (transport && !tchunk->tsn_gap_acked) {
 				/* If this chunk is being used for RTT
 				 * measurement, calculate the RTT and update
 				 * the RTO using this value.
@@ -1358,14 +1358,34 @@ static void sctp_check_transmitted(struc
 				 * first instance of the packet or a later
 				 * instance).
 				 */
-				if (!tchunk->tsn_gap_acked &&
-				    !tchunk->resent &&
+				if (!tchunk->resent &&
 				    tchunk->rtt_in_progress) {
 					tchunk->rtt_in_progress = 0;
 					rtt = jiffies - tchunk->sent_at;
 					sctp_transport_update_rto(transport,
 								  rtt);
 				}
+
+				if (TSN_lte(tsn, sack_ctsn)) {
+					/*
+					 * SFR-CACC algorithm:
+					 * 2) If the SACK contains gap acks
+					 * and the flag CHANGEOVER_ACTIVE is
+					 * set the receiver of the SACK MUST
+					 * take the following action:
+					 *
+					 * B) For each TSN t being acked that
+					 * has not been acked in any SACK so
+					 * far, set cacc_saw_newack to 1 for
+					 * the destination that the TSN was
+					 * sent to.
+					 */
+					if (sack->num_gap_ack_blocks &&
+					    q->asoc->peer.primary_path->cacc.
+					    changeover_active)
+						transport->cacc.cacc_saw_newack
+							= 1;
+				}
 			}
 
 			/* If the chunk hasn't been marked as ACKED,
@@ -1397,28 +1417,6 @@ static void sctp_check_transmitted(struc
 				restart_timer = 1;
 				forward_progress = true;
 
-				if (!tchunk->tsn_gap_acked) {
-					/*
-					 * SFR-CACC algorithm:
-					 * 2) If the SACK contains gap acks
-					 * and the flag CHANGEOVER_ACTIVE is
-					 * set the receiver of the SACK MUST
-					 * take the following action:
-					 *
-					 * B) For each TSN t being acked that
-					 * has not been acked in any SACK so
-					 * far, set cacc_saw_newack to 1 for
-					 * the destination that the TSN was
-					 * sent to.
-					 */
-					if (transport &&
-					    sack->num_gap_ack_blocks &&
-					    q->asoc->peer.primary_path->cacc.
-					    changeover_active)
-						transport->cacc.cacc_saw_newack
-							= 1;
-				}
-
 				list_add_tail(&tchunk->transmitted_list,
 					      &q->sacked);
 			} else {

