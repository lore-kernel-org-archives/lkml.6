Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8933FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7612170B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7612170B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeHZK32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 06:29:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeHZK31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 06:29:27 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D0B739D2;
        Sun, 26 Aug 2018 06:47:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 26/56] ipv6: mcast: fix unsolicited report interval after receiving querys
Date:   Sun, 26 Aug 2018 08:44:47 +0200
Message-Id: <20180826064233.656232955@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826064232.320669119@linuxfoundation.org>
References: <20180826064232.320669119@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 6c6da92808442908287fae8ebb0ca041a52469f4 ]

After recieving MLD querys, we update idev->mc_maxdelay with max_delay
from query header. This make the later unsolicited reports have the same
interval with mc_maxdelay, which means we may send unsolicited reports with
long interval time instead of default configured interval time.

Also as we will not call ipv6_mc_reset() after device up. This issue will
be there even after leave the group and join other groups.

Fixes: fc4eba58b4c14 ("ipv6: make unsolicited report intervals configurable for mld")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/mcast.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2062,7 +2062,8 @@ void ipv6_mc_dad_complete(struct inet6_d
 		mld_send_initial_cr(idev);
 		idev->mc_dad_count--;
 		if (idev->mc_dad_count)
-			mld_dad_start_timer(idev, idev->mc_maxdelay);
+			mld_dad_start_timer(idev,
+					    unsolicited_report_interval(idev));
 	}
 }
 
@@ -2074,7 +2075,8 @@ static void mld_dad_timer_expire(unsigne
 	if (idev->mc_dad_count) {
 		idev->mc_dad_count--;
 		if (idev->mc_dad_count)
-			mld_dad_start_timer(idev, idev->mc_maxdelay);
+			mld_dad_start_timer(idev,
+					    unsolicited_report_interval(idev));
 	}
 	in6_dev_put(idev);
 }
@@ -2432,7 +2434,8 @@ static void mld_ifc_timer_expire(unsigne
 	if (idev->mc_ifc_count) {
 		idev->mc_ifc_count--;
 		if (idev->mc_ifc_count)
-			mld_ifc_start_timer(idev, idev->mc_maxdelay);
+			mld_ifc_start_timer(idev,
+					    unsolicited_report_interval(idev));
 	}
 	in6_dev_put(idev);
 }


