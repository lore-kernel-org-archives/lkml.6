Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C801EECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C89A21479
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C89A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeIXDKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 23:10:43 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:39518
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727191AbeIXDKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 23:10:42 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 4BeQgoiWosezk4BeQgk9gh; Sun, 23 Sep 2018 14:10:46 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1g4BeQ-0007HN-23; Sun, 23 Sep 2018 14:10:46 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Stable@vger.kernel.org
Subject: [PATCH 4/4] Drivers: hv: vmbus: Use cpumask_var_t for on-stack cpu mask
Date:   Sun, 23 Sep 2018 21:10:44 +0000
Message-Id: <20180923211044.27922-4-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180923211044.27922-1-kys@linuxonhyperv.com>
References: <20180923210938.27859-1-kys@linuxonhyperv.com>
 <20180923211044.27922-1-kys@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: kys@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGL/VmB8lC2Co1lkZ52Slf/WMpK9yEDR9q5mMwmY8KxKmXJo8VyPcEelL+795/DEKSeFXUMAaNAD09LBKAQSNBaB4qI/p6A3ZFhBGVDFTfbYS5LqB/Xc
 y0Z1uAyS7dpGYI7eg32pO6a3t5D+puaEOMIUklureZqseZ+Q/KCUjOzawwnZ08yp0aQUindeVlNoiG1whlDIQheCLM0KXZwSsDct3+6sjytG0YhDbfN5MJcO
 VKfgi/4r0jsJ6KMO4SKPDLqyfYdl0PD4slUCI9EvMxLAyiWUhElfr1YT2xTEzwAlMzAHnNzGFT/sYQiHzcXLL5BRc0iMAHl1LVoPXu7OqWRAHeCWJieJAYgY
 Jfl4rWa/d3uZEeX+EWMve3kGE2cAxYiKfyIFSmlaIoTkQ1A5CcYoDTc+qyu6msfJBiEYxDWhvvLHb6oFrnl/FK+Gh8b7Qa6UDnvDuofdbJJk7bpeMx9MeWOZ
 acb7EcfonFapqGzcDvmjpvXQOPU6xvJ3TsvdNBmQ05mTEUueLU0jwe0uY2WaCSzVAKwnswb/qB6pm3wM9s3U9YbRMjoeo0XnKNGk/HXOVngDar7U69FUj1Um
 Isi9WXXv76Jz6CUXBGVshMnkYQ5aM5airPBcma47e6CCIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

A cpumask structure on the stack can cause a warning with
CONFIG_NR_CPUS=8192 (e.g. Ubuntu 16.04 and 18.04 use this):

drivers/hv//channel_mgmt.c: In function ‘init_vp_index’:
drivers/hv//channel_mgmt.c:702:1: warning: the frame size of 1032 bytes
  is larger than 1024 bytes [-Wframe-larger-than=]

Nowadays it looks most distros enable CONFIG_CPUMASK_OFFSTACK=y, and
hence we can work around the warning by using cpumask_var_t.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index e7598b569bea..d943fa022e34 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -601,16 +601,18 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 	bool perf_chn = vmbus_devs[dev_type].perf_device;
 	struct vmbus_channel *primary = channel->primary_channel;
 	int next_node;
-	struct cpumask available_mask;
+	cpumask_var_t available_mask;
 	struct cpumask *alloced_mask;
 
 	if ((vmbus_proto_version == VERSION_WS2008) ||
-	    (vmbus_proto_version == VERSION_WIN7) || (!perf_chn)) {
+	    (vmbus_proto_version == VERSION_WIN7) || (!perf_chn) ||
+	    !alloc_cpumask_var(&available_mask, GFP_KERNEL)) {
 		/*
 		 * Prior to win8, all channel interrupts are
 		 * delivered on cpu 0.
 		 * Also if the channel is not a performance critical
 		 * channel, bind it to cpu 0.
+		 * In case alloc_cpumask_var() fails, bind it to cpu 0.
 		 */
 		channel->numa_node = 0;
 		channel->target_cpu = 0;
@@ -648,7 +650,7 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 		cpumask_clear(alloced_mask);
 	}
 
-	cpumask_xor(&available_mask, alloced_mask,
+	cpumask_xor(available_mask, alloced_mask,
 		    cpumask_of_node(primary->numa_node));
 
 	cur_cpu = -1;
@@ -666,10 +668,10 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 	}
 
 	while (true) {
-		cur_cpu = cpumask_next(cur_cpu, &available_mask);
+		cur_cpu = cpumask_next(cur_cpu, available_mask);
 		if (cur_cpu >= nr_cpu_ids) {
 			cur_cpu = -1;
-			cpumask_copy(&available_mask,
+			cpumask_copy(available_mask,
 				     cpumask_of_node(primary->numa_node));
 			continue;
 		}
@@ -699,6 +701,8 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 
 	channel->target_cpu = cur_cpu;
 	channel->target_vp = hv_cpu_number_to_vp_number(cur_cpu);
+
+	free_cpumask_var(available_mask);
 }
 
 static void vmbus_wait_for_unload(void)
-- 
2.18.0

