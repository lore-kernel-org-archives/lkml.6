Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE51C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB302080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB302080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbeKLGEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:04:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52922 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729602AbeKLGEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:04:24 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsz-0000oM-0Z; Sun, 11 Nov 2018 19:59:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001cV-PQ; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Hangbin Liu" <liuhangbin@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.868160472@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 185/366] ipv6: mcast: fix unsolicited report interval
 after receiving querys
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

From: Hangbin Liu <liuhangbin@gmail.com>

commit 6c6da92808442908287fae8ebb0ca041a52469f4 upstream.

After recieving MLD querys, we update idev->mc_maxdelay with max_delay
from query header. This make the later unsolicited reports have the same
interval with mc_maxdelay, which means we may send unsolicited reports with
long interval time instead of default configured interval time.

Also as we will not call ipv6_mc_reset() after device up. This issue will
be there even after leave the group and join other groups.

Fixes: fc4eba58b4c14 ("ipv6: make unsolicited report intervals configurable for mld")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv6/mcast.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2058,7 +2058,8 @@ void ipv6_mc_dad_complete(struct inet6_d
 		mld_send_initial_cr(idev);
 		idev->mc_dad_count--;
 		if (idev->mc_dad_count)
-			mld_dad_start_timer(idev, idev->mc_maxdelay);
+			mld_dad_start_timer(idev,
+					    unsolicited_report_interval(idev));
 	}
 }
 
@@ -2070,7 +2071,8 @@ static void mld_dad_timer_expire(unsigne
 	if (idev->mc_dad_count) {
 		idev->mc_dad_count--;
 		if (idev->mc_dad_count)
-			mld_dad_start_timer(idev, idev->mc_maxdelay);
+			mld_dad_start_timer(idev,
+					    unsolicited_report_interval(idev));
 	}
 	in6_dev_put(idev);
 }
@@ -2428,7 +2430,8 @@ static void mld_ifc_timer_expire(unsigne
 	if (idev->mc_ifc_count) {
 		idev->mc_ifc_count--;
 		if (idev->mc_ifc_count)
-			mld_ifc_start_timer(idev, idev->mc_maxdelay);
+			mld_ifc_start_timer(idev,
+					    unsolicited_report_interval(idev));
 	}
 	in6_dev_put(idev);
 }

