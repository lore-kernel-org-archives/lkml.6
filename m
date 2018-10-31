Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E004ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AA22064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJL6djfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AA22064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeKAIHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728910AbeKAIHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CFFA20854;
        Wed, 31 Oct 2018 23:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027239;
        bh=++X5Yn8sFko6tNfAWfirVz2VbCNRT51+Q+00y68Xhaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJL6djfwna06yq3AT+3hESalb//3rV31LA3i3XLmM3gaktsty8wcSWxHoWMgl7ySl
         cdC8MbbxGNxi8Lt9RThsjOon700Qa0Vg0+uThrc+kxLTp8Ty9nuQgqxkAIM6A7mmjD
         yqBXKoNJCikrgseAnfSmAy3MA3F2iL4r53246YDg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 108/146] Drivers: hv: vmbus: Use cpumask_var_t for on-stack cpu mask
Date:   Wed, 31 Oct 2018 19:05:03 -0400
Message-Id: <20181031230541.28822-108-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit 25355252607ca288f329ee033f387764883393f6 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/channel_mgmt.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 0f0e091c117c..c4a1ebcfffb6 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -606,16 +606,18 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
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
@@ -653,7 +655,7 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 		cpumask_clear(alloced_mask);
 	}
 
-	cpumask_xor(&available_mask, alloced_mask,
+	cpumask_xor(available_mask, alloced_mask,
 		    cpumask_of_node(primary->numa_node));
 
 	cur_cpu = -1;
@@ -671,10 +673,10 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
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
@@ -704,6 +706,8 @@ static void init_vp_index(struct vmbus_channel *channel, u16 dev_type)
 
 	channel->target_cpu = cur_cpu;
 	channel->target_vp = hv_cpu_number_to_vp_number(cur_cpu);
+
+	free_cpumask_var(available_mask);
 }
 
 static void vmbus_wait_for_unload(void)
-- 
2.17.1

