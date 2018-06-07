Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id n5m+MaVGGVtjOAAAmS7hNA
	; Thu, 07 Jun 2018 14:52:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D3070608B8; Thu,  7 Jun 2018 14:52:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 669046074D;
	Thu,  7 Jun 2018 14:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 669046074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935217AbeFGOwu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:52:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40919 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934776AbeFGOwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:52:47 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbQ-0005Zq-MY; Thu, 07 Jun 2018 15:09:25 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003Cs-71; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Arkadi Sharshevsky" <arkadis@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Jiri Pirko" <jiri@mellanox.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.134643840@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 336/410] team: Fix double free in error path
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arkadi Sharshevsky <arkadis@mellanox.com>

commit cbcc607e18422555db569b593608aec26111cb0b upstream.

The __send_and_alloc_skb() receives a skb ptr as a parameter but in
case it fails the skb is not valid:
- Send failed and released the skb internally.
- Allocation failed.

The current code tries to release the skb in case of failure which
causes redundant freeing.

Fixes: 9b00cf2d1024 ("team: implement multipart netlink messages for options transfers")
Signed-off-by: Arkadi Sharshevsky <arkadis@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/team/team.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2356,7 +2356,7 @@ send_done:
 	if (!nlh) {
 		err = __send_and_alloc_skb(&skb, team, portid, send_func);
 		if (err)
-			goto errout;
+			return err;
 		goto send_done;
 	}
 
@@ -2636,7 +2636,7 @@ send_done:
 	if (!nlh) {
 		err = __send_and_alloc_skb(&skb, team, portid, send_func);
 		if (err)
-			goto errout;
+			return err;
 		goto send_done;
 	}
 
