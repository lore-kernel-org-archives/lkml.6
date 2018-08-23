Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B4BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA62208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA62208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389343AbeHWMlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:41:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57266 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbeHWMli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:41:38 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A7507BC8;
        Thu, 23 Aug 2018 09:12:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6f18401420df260e37ed@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 206/217] netfilter: conntrack: dccp: treat SYNC/SYNCACK as invalid if no prior state
Date:   Thu, 23 Aug 2018 09:55:19 +0200
Message-Id: <20180823075514.952275719@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -243,14 +243,14 @@ dccp_state_table[CT_DCCP_ROLE_MAX + 1][D
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
@@ -371,14 +371,14 @@ dccp_state_table[CT_DCCP_ROLE_MAX + 1][D
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


