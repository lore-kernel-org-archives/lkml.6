Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D2FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF96D20685
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF96D20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeIQJlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:41:31 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:46642
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727224AbeIQJlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 05:41:31 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 1kw5ghB7wTEX41kw5gbZho; Sun, 16 Sep 2018 21:14:57 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1g1kw5-0002zU-Bi; Sun, 16 Sep 2018 21:14:57 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>, stable@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 1/2] Drivers: hv: vmbus: Use get/put_cpu() in vmbus_connect()
Date:   Mon, 17 Sep 2018 04:14:54 +0000
Message-Id: <20180917041455.11455-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180917041352.11402-1-kys@linuxonhyperv.com>
References: <20180917041352.11402-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfB7nA2z0KtHr1/sn6EmekgxkgAIwr+mUjjBwjCD57pI2y4J541XpOLP6FYv/Do2aYE8HiGWpuBn/fxcxG6+Z9QxZqfnYaT52tt8btsqQ4eN0QiopkJMA
 7A2sPYbVDrMnfFNceBXz6dyLdDggGV7r7P6EvbPUKhhawFxIR9zgam0GLG+GrrFM8Qw8KvvWSr0QI++z5HsC5p4XDxsOwUcpZbkLsz+Nbnuwew2hxafFntR+
 e0f55AJT8G/wGCSAAHvq1/D6sSyKtl1HcU/cT4b2Zj6e74EmxgP/jYhU6uDW83HkQCU1dmsFvIVt9ahLCbild4KmxMCJ3AuWuohDxThVr5jfMcU6lez38WDs
 YwYizr9vjW6M24P86WA0ZkpOaTJCbNNVeKrZq4I4q4jY9exqhkojqbj4bKz9KVi/GgSWB2uFrmxNML9rwMwzOAymXuDl+BA0fvcT2ltcjf2SFf6gKABeQleZ
 NQBj+3npK6rcdXsB53NN0oPcdmVLM6XAsd0s0SZlbREf6e+hwctNCTFc2FJJuB+aUrZOPUdueBEoE6imKYdWxEjLAjaUp8R/0eJImevB7POSbsIrqfYOJm1J
 om72PuGl/IblhhbzC3Kq/LA0yM6CQggcTBpio7BYwOaRxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

With CONFIG_DEBUG_PREEMPT=y, I always see this warning:
BUG: using smp_processor_id() in preemptible [00000000]

Fix the false warning by using get/put_cpu().

Here vmbus_connect() sends a message to the host and waits for the
host's response. The host will deliver the response message and an
interrupt on CPU msg->target_vcpu, and later the interrupt handler
will wake up vmbus_connect(). vmbus_connect() doesn't really have
to run on the same cpu as CPU msg->target_vcpu, so it's safe to
call put_cpu() just here.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/connection.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index ced041899456..f4d08c8ac7f8 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -76,6 +76,7 @@ static int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo,
 					__u32 version)
 {
 	int ret = 0;
+	unsigned int cur_cpu;
 	struct vmbus_channel_initiate_contact *msg;
 	unsigned long flags;
 
@@ -118,9 +119,10 @@ static int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo,
 	 * the CPU attempting to connect may not be CPU 0.
 	 */
 	if (version >= VERSION_WIN8_1) {
-		msg->target_vcpu =
-			hv_cpu_number_to_vp_number(smp_processor_id());
-		vmbus_connection.connect_cpu = smp_processor_id();
+		cur_cpu = get_cpu();
+		msg->target_vcpu = hv_cpu_number_to_vp_number(cur_cpu);
+		vmbus_connection.connect_cpu = cur_cpu;
+		put_cpu();
 	} else {
 		msg->target_vcpu = 0;
 		vmbus_connection.connect_cpu = 0;
-- 
2.18.0

