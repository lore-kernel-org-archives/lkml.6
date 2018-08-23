Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A93EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470B821473
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470B821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeHWL2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:28:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHWL2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:28:54 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8364C74;
        Thu, 23 Aug 2018 08:00:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6f18401420df260e37ed@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.4 71/79] netfilter: conntrack: dccp: treat SYNC/SYNCACK as invalid if no prior state
Date:   Thu, 23 Aug 2018 09:53:47 +0200
Message-Id: <20180823074923.817061817@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 6613b6173dee098997229caf1f3b961c49da75e6 upstream.

When first DCCP packet is SYNC or SYNCACK, we insert a new conntrack
that has an un-initialized timeout value, i.e. such entry could be
reaped at any time.

Mark them as INVALID and only ignore SYNC/SYNCACK when connection had
an old state.

Reported-by: syzbot+6f18401420df260e37ed@syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conntrack_proto_dccp.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/netfilter/nf_conntrack_proto_dccp.c
+++ b/net/netfilter/nf_conntrack_proto_dccp.c
@@ -244,14 +244,14 @@ dccp_state_table[CT_DCCP_ROLE_MAX + 1][D
 		 * We currently ignore Sync packets
 		 *
 		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIG, sIG, sIG, sIG, sIG, sIG, sIG, sIG,
+			sIV, sIG, sIG, sIG, sIG, sIG, sIG, sIG,
 		},
 		[DCCP_PKT_SYNCACK] = {
 		/*
 		 * We currently ignore SyncAck packets
 		 *
 		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIG, sIG, sIG, sIG, sIG, sIG, sIG, sIG,
+			sIV, sIG, sIG, sIG, sIG, sIG, sIG, sIG,
 		},
 	},
 	[CT_DCCP_ROLE_SERVER] = {
@@ -372,14 +372,14 @@ dccp_state_table[CT_DCCP_ROLE_MAX + 1][D
 		 * We currently ignore Sync packets
 		 *
 		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIG, sIG, sIG, sIG, sIG, sIG, sIG, sIG,
+			sIV, sIG, sIG, sIG, sIG, sIG, sIG, sIG,
 		},
 		[DCCP_PKT_SYNCACK] = {
 		/*
 		 * We currently ignore SyncAck packets
 		 *
 		 *	sNO, sRQ, sRS, sPO, sOP, sCR, sCG, sTW */
-			sIG, sIG, sIG, sIG, sIG, sIG, sIG, sIG,
+			sIV, sIG, sIG, sIG, sIG, sIG, sIG, sIG,
 		},
 	},
 };


