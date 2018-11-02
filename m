Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6790CC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F3C2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm2OZIs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F3C2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbeKCDuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbeKCDuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:50:04 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 884F62084D;
        Fri,  2 Nov 2018 18:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184112;
        bh=uZg+UwKc1Nk6LyXiPX1IfsxWCNuHjqbPAvrzTLeKRAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cm2OZIs0Sg6WC/mNQ3W09mLPlJQnGlmQfigqSVJcZUVjmrtfQJHVB2pYcdcxIjtyN
         XXZ68L1t2KpRxH8QKn63sHiWR6mWkl1ipiXI8AiVrzXa8Uix/rxJMvaYqR/yzFHi+/
         9og7kGpcH7EZ+JrvnB5ZufitC0t6wi7U6EKht758=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 058/150] thunderbolt: Do not handle ICM events after domain is stopped
Date:   Fri,  2 Nov 2018 19:33:40 +0100
Message-Id: <20181102182907.587708075@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 86da809dda64a63fc27e05a215475325c3aaae92 ]

If there is a long chain of devices connected when the driver is loaded
ICM sends device connected event for each and those are put to tb->wq
for later processing. Now if the driver gets unloaded in the middle, so
that the work queue is not yet empty it gets flushed by tb_domain_stop().
However, by that time the root switch is already removed so the driver
crashes when it tries to dereference it in ICM event handling callbacks.

Fix this by checking whether the root switch is already removed. If it
is we know that the domain is stopped and we should merely skip handling
the event.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/icm.c | 49 ++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 500911f16498..5bad9fdec5f8 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -653,14 +653,6 @@ icm_fr_xdomain_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	bool approved;
 	u64 route;
 
-	/*
-	 * After NVM upgrade adding root switch device fails because we
-	 * initiated reset. During that time ICM might still send
-	 * XDomain connected message which we ignore here.
-	 */
-	if (!tb->root_switch)
-		return;
-
 	link = pkg->link_info & ICM_LINK_INFO_LINK_MASK;
 	depth = (pkg->link_info & ICM_LINK_INFO_DEPTH_MASK) >>
 		ICM_LINK_INFO_DEPTH_SHIFT;
@@ -950,14 +942,6 @@ icm_tr_device_connected(struct tb *tb, const struct icm_pkg_header *hdr)
 	if (pkg->hdr.packet_id)
 		return;
 
-	/*
-	 * After NVM upgrade adding root switch device fails because we
-	 * initiated reset. During that time ICM might still send device
-	 * connected message which we ignore here.
-	 */
-	if (!tb->root_switch)
-		return;
-
 	route = get_route(pkg->route_hi, pkg->route_lo);
 	authorized = pkg->link_info & ICM_LINK_INFO_APPROVED;
 	security_level = (pkg->hdr.flags & ICM_FLAGS_SLEVEL_MASK) >>
@@ -1317,19 +1301,26 @@ static void icm_handle_notification(struct work_struct *work)
 
 	mutex_lock(&tb->lock);
 
-	switch (n->pkg->code) {
-	case ICM_EVENT_DEVICE_CONNECTED:
-		icm->device_connected(tb, n->pkg);
-		break;
-	case ICM_EVENT_DEVICE_DISCONNECTED:
-		icm->device_disconnected(tb, n->pkg);
-		break;
-	case ICM_EVENT_XDOMAIN_CONNECTED:
-		icm->xdomain_connected(tb, n->pkg);
-		break;
-	case ICM_EVENT_XDOMAIN_DISCONNECTED:
-		icm->xdomain_disconnected(tb, n->pkg);
-		break;
+	/*
+	 * When the domain is stopped we flush its workqueue but before
+	 * that the root switch is removed. In that case we should treat
+	 * the queued events as being canceled.
+	 */
+	if (tb->root_switch) {
+		switch (n->pkg->code) {
+		case ICM_EVENT_DEVICE_CONNECTED:
+			icm->device_connected(tb, n->pkg);
+			break;
+		case ICM_EVENT_DEVICE_DISCONNECTED:
+			icm->device_disconnected(tb, n->pkg);
+			break;
+		case ICM_EVENT_XDOMAIN_CONNECTED:
+			icm->xdomain_connected(tb, n->pkg);
+			break;
+		case ICM_EVENT_XDOMAIN_DISCONNECTED:
+			icm->xdomain_disconnected(tb, n->pkg);
+			break;
+		}
 	}
 
 	mutex_unlock(&tb->lock);
-- 
2.17.1



