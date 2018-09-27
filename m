Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0D6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442872150D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442872150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeI0PoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:44:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbeI0PoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:44:12 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5D1471113;
        Thu, 27 Sep 2018 09:26:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Khoruzhick <vasilykh@arista.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 24/44] neighbour: confirm neigh entries when ARP packet is received
Date:   Thu, 27 Sep 2018 11:04:13 +0200
Message-Id: <20180927090121.255085864@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090117.997362691@linuxfoundation.org>
References: <20180927090117.997362691@linuxfoundation.org>
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

From: Vasily Khoruzhick <vasilykh@arista.com>

[ Upstream commit f0e0d04413fcce9bc76388839099aee93cd0d33b ]

Update 'confirmed' timestamp when ARP packet is received. It shouldn't
affect locktime logic and anyway entry can be confirmed by any higher-layer
protocol. Thus it makes sense to confirm it when ARP packet is received.

Fixes: 77d7123342dc ("neighbour: update neigh timestamps iff update is effective")
Signed-off-by: Vasily Khoruzhick <vasilykh@arista.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/neighbour.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1138,6 +1138,12 @@ int neigh_update(struct neighbour *neigh
 		lladdr = neigh->ha;
 	}
 
+	/* Update confirmed timestamp for neighbour entry after we
+	 * received ARP packet even if it doesn't change IP to MAC binding.
+	 */
+	if (new & NUD_CONNECTED)
+		neigh->confirmed = jiffies;
+
 	/* If entry was valid and address is not changed,
 	   do not change entry state, if new one is STALE.
 	 */
@@ -1159,15 +1165,12 @@ int neigh_update(struct neighbour *neigh
 		}
 	}
 
-	/* Update timestamps only once we know we will make a change to the
+	/* Update timestamp only once we know we will make a change to the
 	 * neighbour entry. Otherwise we risk to move the locktime window with
 	 * noop updates and ignore relevant ARP updates.
 	 */
-	if (new != old || lladdr != neigh->ha) {
-		if (new & NUD_CONNECTED)
-			neigh->confirmed = jiffies;
+	if (new != old || lladdr != neigh->ha)
 		neigh->updated = jiffies;
-	}
 
 	if (new != old) {
 		neigh_del_timer(neigh);


