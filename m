Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB2CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D1A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D1A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389181AbeGWNbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:31:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387849AbeGWNbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:31:02 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F3F01C37;
        Mon, 23 Jul 2018 12:30:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 36/44] hv_netvsc: Fix napi reschedule while receive completion is busy
Date:   Mon, 23 Jul 2018 14:25:12 +0200
Message-Id: <20180723122439.183069143@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122437.447870153@linuxfoundation.org>
References: <20180723122437.447870153@linuxfoundation.org>
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

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit 6b81b193b83e87da1ea13217d684b54fccf8ee8a ]

If out ring is full temporarily and receive completion cannot go out,
we may still need to reschedule napi if certain conditions are met.
Otherwise the napi poll might be stopped forever, and cause network
disconnect.

Fixes: 7426b1a51803 ("netvsc: optimize receive completions")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1250,6 +1250,7 @@ int netvsc_poll(struct napi_struct *napi
 	struct hv_device *device = netvsc_channel_to_device(channel);
 	struct net_device *ndev = hv_get_drvdata(device);
 	int work_done = 0;
+	int ret;
 
 	/* If starting a new interval */
 	if (!nvchan->desc)
@@ -1261,16 +1262,18 @@ int netvsc_poll(struct napi_struct *napi
 		nvchan->desc = hv_pkt_iter_next(channel, nvchan->desc);
 	}
 
-	/* If send of pending receive completions suceeded
-	 *   and did not exhaust NAPI budget this time
-	 *   and not doing busy poll
+	/* Send any pending receive completions */
+	ret = send_recv_completions(ndev, net_device, nvchan);
+
+	/* If it did not exhaust NAPI budget this time
+	 *  and not doing busy poll
 	 * then re-enable host interrupts
-	 *     and reschedule if ring is not empty.
+	 *  and reschedule if ring is not empty
+	 *   or sending receive completion failed.
 	 */
-	if (send_recv_completions(ndev, net_device, nvchan) == 0 &&
-	    work_done < budget &&
+	if (work_done < budget &&
 	    napi_complete_done(napi, work_done) &&
-	    hv_end_read(&channel->inbound) &&
+	    (ret || hv_end_read(&channel->inbound)) &&
 	    napi_schedule_prep(napi)) {
 		hv_begin_read(&channel->inbound);
 		__napi_schedule(napi);


