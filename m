Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8BDECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E31620684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E31620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbeGQRqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:46:11 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:42450
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730362AbeGQRqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:46:11 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id fTVcfjA4j8JHPfTVcfnyLx; Tue, 17 Jul 2018 10:11:33 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1ffTVc-0001fj-Ho; Tue, 17 Jul 2018 10:11:32 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net,v2] hv_netvsc: Fix napi reschedule while receive completion is busy
Date:   Tue, 17 Jul 2018 17:11:13 +0000
Message-Id: <20180717171113.6390-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfDUeV8OGASemZmNUq5BiZwG7nzkXlq7E6AUjbkJJc7HhqoJL/sAMjLMnmwluZ/ECruUI7S7O6CyQVq1ssrFhSubvnP20YbYWgbzdrQLxGdoEiImTHRkS
 MKLp+iySKPfguQGQcepNaJDOFLe13S5W2lBA55zJ85yxhh7tLQ2MAUV0I/TigQv3aQcjT1lWjsCz3s69S5JUEDe05QMpAw/6+II9/kptAzsNlRmfYL3zKhgz
 mkK5Vu469yFmvwM4TdRE6DjP+O6fZyyzpibmYrhJQLDAfq8ePco/Tisgfa6puotfnGAEx6qypZCqouQcokxiH5A99xD4Pflcpf2iicSB+WDMSeTb5eAwc18z
 FRAUZQBS6Tw9fEeDPapox2t0L0956sXIfVxWEunR3VW6nXoPMol6SHis31j5aJaC9VD/CimUl07TC4HdE77iANHoQ7hBAeMJyqOahPn1A12//vIbxwGzfyun
 H7Gq/8Gl5MxH8uunVDaZVmo4sZpB9oL5RZZPMuj6yTAxQQtpxXPfpHHmiVf3Ux2qicQVAlmlcYUBU1Eb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

If out ring is full temporarily and receive completion cannot go out,
we may still need to reschedule napi if certain conditions are met.
Otherwise the napi poll might be stopped forever, and cause network
disconnect.

Fixes: 7426b1a51803 ("netvsc: optimize receive completions")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/netvsc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 8e9d0ee1572b..31c3d77b4733 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -1274,6 +1274,7 @@ int netvsc_poll(struct napi_struct *napi, int budget)
 	struct hv_device *device = netvsc_channel_to_device(channel);
 	struct net_device *ndev = hv_get_drvdata(device);
 	int work_done = 0;
+	int ret;
 
 	/* If starting a new interval */
 	if (!nvchan->desc)
@@ -1285,16 +1286,18 @@ int netvsc_poll(struct napi_struct *napi, int budget)
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
-- 
2.17.1

