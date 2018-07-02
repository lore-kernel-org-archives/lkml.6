Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC59C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3423023EF1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3423023EF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753414AbeGBSPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:15:14 -0400
Received: from www.osadl.org ([62.245.132.105]:55727 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752797AbeGBSPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:15:12 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w62IDuCs024920;
        Mon, 2 Jul 2018 20:13:56 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Derek Chickles <derek.chickles@caviumnetworks.com>
Cc:     Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] liquidio: make timeout HZ independent and readable
Date:   Mon,  2 Jul 2018 20:13:15 +0200
Message-Id: <1530555195-28129-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

schedule_timeout_* takes a timeout in jiffies but the code currently is
passing in a constant which makes this timeout HZ dependent. So define
a constant with (hopefully) meaningful name and pass it through
msecs_to_jiffies() to fix the HZ dependency.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
commit f21fb3ed364b ("Add support of Cavium Liquidio ethernet adapters")
---

Problem found by experimental coccinelle script

The current wait time can vary by a factor 10 depending on the HZ
setting chose, which does not seem reasonable here.

The below patch sets the timeout to 1s - which is the current duration
assuming a setting of HZ== 100. It is though not clear if this is the
intent or if it should be shorter as it is not clear what HZ setting
was assumed during design and used for testing.

This needs an ack by someone who knows the device and can confirm that
waiting 1s for in-flight requests on device removal is reasonable.

Patch was compile tested with: x86_64_defconfig (implies
CONFIG_NET_VENDOR_CAVIUM=y)
(with a large number of sparse warnings though unrelated to the
proposed change)

Patch is against 4.18-rc2 (localversion-next is -next-20180702)

 drivers/net/ethernet/cavium/liquidio/lio_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 7cb4e75..b2d0598 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -91,6 +91,9 @@ static int octeon_console_debug_enabled(u32 console)
  */
 #define LIO_SYNC_OCTEON_TIME_INTERVAL_MS 60000
 
+/* time to wait for possible in-flight requests in milliseconds */
+#define WAIT_INFLIGHT_REQUEST	msecs_to_jiffies(1000)
+
 struct lio_trusted_vf_ctx {
 	struct completion complete;
 	int status;
@@ -259,7 +262,7 @@ static inline void pcierror_quiesce_device(struct octeon_device *oct)
 	force_io_queues_off(oct);
 
 	/* To allow for in-flight requests */
-	schedule_timeout_uninterruptible(100);
+	schedule_timeout_uninterruptible(WAIT_INFLIGHT_REQUEST);
 
 	if (wait_for_pending_requests(oct))
 		dev_err(&oct->pci_dev->dev, "There were pending requests\n");
-- 
2.1.4

