Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAAFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98D320866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVA8q5xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98D320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbeKLJ4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:56:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731830AbeKLIRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:39 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F071E22360;
        Sun, 11 Nov 2018 22:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975264;
        bh=G0xTNfAdlF31xeduZTzyhb63sCFhet0szjMb0tfETDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YVA8q5xt+ByNsGRaJd6/sajuL3UrT6KSaQtckycPYNlp6Q9G2Qy24D89CnI1kG3Gl
         OFXMclcCzISgTc8ngz+czgz+EeyfWXg3tdH+h088YZAcBIuMzSmTN0fsc+2L42gA7z
         vW/tc085iSa37hWPYHnsZ4ll05Y3VS8tY0BHHbbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 153/361] Drivers: hv: vmbus: Use cpumask_var_t for on-stack cpu mask
Date:   Sun, 11 Nov 2018 14:18:20 -0800
Message-Id: <20181111221641.889573256@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hv/channel_mgmt.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -606,16 +606,18 @@ static void init_vp_index(struct vmbus_c
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
@@ -653,7 +655,7 @@ static void init_vp_index(struct vmbus_c
 		cpumask_clear(alloced_mask);
 	}
 
-	cpumask_xor(&available_mask, alloced_mask,
+	cpumask_xor(available_mask, alloced_mask,
 		    cpumask_of_node(primary->numa_node));
 
 	cur_cpu = -1;
@@ -671,10 +673,10 @@ static void init_vp_index(struct vmbus_c
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
@@ -704,6 +706,8 @@ static void init_vp_index(struct vmbus_c
 
 	channel->target_cpu = cur_cpu;
 	channel->target_vp = hv_cpu_number_to_vp_number(cur_cpu);
+
+	free_cpumask_var(available_mask);
 }
 
 static void vmbus_wait_for_unload(void)


