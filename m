Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F391C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C512320875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C512320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933655AbeGIQoh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:44:37 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:48928
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932755AbeGIQoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:44:34 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id cZG9friwnIHuScZG9fQ5qv; Mon, 09 Jul 2018 09:43:33 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1fcZG9-0001KK-7Z; Mon, 09 Jul 2018 09:43:33 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] hv_netvsc: Fix napi reschedule while receive completion is busy
Date:   Mon,  9 Jul 2018 16:43:19 +0000
Message-Id: <20180709164319.5058-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfOHQ2SEyFCyxYbuYwolLF18kkTSSUxE6dStyPtcpB1e9EsCFRDxBhJHrHccapKviWcktFcvx2NAHOAJkRA1ji//DcKHRF8mq4IgBxI0X+GU7nmwfeRyV
 PjNgAChrBJG49gdcWBgDA/cuHVoKdHlobdWxRle1U3TIGozjgzG1trhDxWbIeI+tKYVT3KEvdyTPJJrr6QndlPgRa3O41JV9Ct+JitvHwQnroJ8ZFCFxrjTM
 RvFuwnQpd2iz5EF5LTaoZROC4E2I6fL4xnuFgJ3/DFeDTQTvGKHOgdrijcKLgeEirYiv/ukCu6Slb6EX8Abnu2xdb/0DhCpx0EfbXl/SK3qQgwgAEE6G02Ba
 ykpFrozoH88xB6SgB9yhsLCc/q2LHYlIJhf7vkC+HOUBo95i5ZvOUbcAjjVWu3umLxX7QVFA1W2ZrPjkZ45ajB7RYJLacJhe3BdHxeTTnJ69szCvhHpnNtUo
 KPN6OokvLseaPIK0iZzxbpx2Ai/5OPiH5+MHyw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

If out ring is full temporarily and receive completion cannot go out,
we may still need to reschedule napi if other conditions are met.
Otherwise the napi poll might be stopped forever, and cause network
disconnect.

Fixes: 7426b1a51803 ("netvsc: optimize receive completions")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/netvsc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 8e9d0ee1572b..caaf5054f446 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1285,14 +1285,14 @@ int netvsc_poll(struct napi_struct *napi, int budget)
 		nvchan->desc = hv_pkt_iter_next(channel, nvchan->desc);
 	}
 
-	/* If send of pending receive completions suceeded
-	 *   and did not exhaust NAPI budget this time
+	send_recv_completions(ndev, net_device, nvchan);
+
+	/* If it did not exhaust NAPI budget this time
 	 *   and not doing busy poll
 	 * then re-enable host interrupts
 	 *     and reschedule if ring is not empty.
 	 */
-	if (send_recv_completions(ndev, net_device, nvchan) == 0 &&
-	    work_done < budget &&
+	if (work_done < budget &&
 	    napi_complete_done(napi, work_done) &&
 	    hv_end_read(&channel->inbound) &&
 	    napi_schedule_prep(napi)) {
-- 
2.17.1

