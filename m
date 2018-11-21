Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFE4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3A2214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3SApyc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3A2214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbeKVFm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731730AbeKVFm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DDC12151B;
        Wed, 21 Nov 2018 19:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827214;
        bh=Ic38ja+f8gvPrz7tkv2kV/F2H9SmMW6A4ylFAICX/DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3SApyc6u482lPsAj/MbuNEsW1ttW42Qc07YgeQ48UBrOXsgKV1JXJ7vnjLbODnUs
         H5DwMWWOjge9gitdo8f3obKGVbEFeWsh3+ngQET/G6gwkd4RxUHfD4OX0O17SyrTQd
         IbEBQ8g6MNzVMFBQk3GP5V8HSh9jd6RP7/UPf/1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 17/42] tipc: fix link re-establish failure
Date:   Wed, 21 Nov 2018 20:05:53 +0100
Message-Id: <20181121183148.784210432@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Maloy <donmalo99@gmail.com>

[ Upstream commit 7ab412d33b4c7ff3e0148d3db25dd861edd1283d ]

When a link failure is detected locally, the link is reset, the flag
link->in_session is set to false, and a RESET_MSG with the 'stopping'
bit set is sent to the peer.

The purpose of this bit is to inform the peer that this endpoint just
is going down, and that the peer should handle the reception of this
particular RESET message as a local failure. This forces the peer to
accept another RESET or ACTIVATE message from this endpoint before it
can re-establish the link. This again is necessary to ensure that
link session numbers are properly exchanged before the link comes up
again.

If a failure is detected locally at the same time at the peer endpoint
this will do the same, which is also a correct behavior.

However, when receiving such messages, the endpoints will not
distinguish between 'stopping' RESETs and ordinary ones when it comes
to updating session numbers. Both endpoints will copy the received
session number and set their 'in_session' flags to true at the
reception, while they are still expecting another RESET from the
peer before they can go ahead and re-establish. This is contradictory,
since, after applying the validation check referred to below, the
'in_session' flag will cause rejection of all such messages, and the
link will never come up again.

We now fix this by not only handling received RESET/STOPPING messages
as a local failure, but also by omitting to set a new session number
and the 'in_session' flag in such cases.

Fixes: 7ea817f4e832 ("tipc: check session number before accepting link protocol messages")
Signed-off-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/link.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1594,14 +1594,17 @@ static int tipc_link_proto_rcv(struct ti
 		if (in_range(peers_prio, l->priority + 1, TIPC_MAX_LINK_PRI))
 			l->priority = peers_prio;
 
-		/* ACTIVATE_MSG serves as PEER_RESET if link is already down */
-		if (msg_peer_stopping(hdr))
+		/* If peer is going down we want full re-establish cycle */
+		if (msg_peer_stopping(hdr)) {
 			rc = tipc_link_fsm_evt(l, LINK_FAILURE_EVT);
-		else if ((mtyp == RESET_MSG) || !link_is_up(l))
+			break;
+		}
+		/* ACTIVATE_MSG serves as PEER_RESET if link is already down */
+		if (mtyp == RESET_MSG || !link_is_up(l))
 			rc = tipc_link_fsm_evt(l, LINK_PEER_RESET_EVT);
 
 		/* ACTIVATE_MSG takes up link if it was already locally reset */
-		if ((mtyp == ACTIVATE_MSG) && (l->state == LINK_ESTABLISHING))
+		if (mtyp == ACTIVATE_MSG && l->state == LINK_ESTABLISHING)
 			rc = TIPC_LINK_UP_EVT;
 
 		l->peer_session = msg_session(hdr);


