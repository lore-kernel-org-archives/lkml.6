Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AB9C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84CA20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84CA20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967384AbeFRIdB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:33:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35256 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966870AbeFRIc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:32:58 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 43202C9F;
        Mon, 18 Jun 2018 08:32:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andres Rodriguez <andres.rodriguez@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 057/189] drm/amdkfd: fix clock counter retrieval for node without GPU
Date:   Mon, 18 Jun 2018 10:12:33 +0200
Message-Id: <20180618081211.617167186@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
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

From: Andres Rodriguez <andres.rodriguez@amd.com>

[ Upstream commit 1cf6cc74bbeb85bb87c3ca3f3df97a283c3aa737 ]

Currently if a user requests clock counters for a node without a GPU
resource we will always return EINVAL.

Instead if no GPU resource is attached, fill the gpu_clock_counter
argument with zeroes so that we may proceed and return valid CPU
counters.

Signed-off-by: Andres Rodriguez <andres.rodriguez@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -716,12 +716,13 @@ static int kfd_ioctl_get_clock_counters(
 	struct timespec64 time;
 
 	dev = kfd_device_by_id(args->gpu_id);
-	if (dev == NULL)
-		return -EINVAL;
-
-	/* Reading GPU clock counter from KGD */
-	args->gpu_clock_counter =
-		dev->kfd2kgd->get_gpu_clock_counter(dev->kgd);
+	if (dev)
+		/* Reading GPU clock counter from KGD */
+		args->gpu_clock_counter =
+			dev->kfd2kgd->get_gpu_clock_counter(dev->kgd);
+	else
+		/* Node without GPU resource */
+		args->gpu_clock_counter = 0;
 
 	/* No access to rdtsc. Using raw monotonic time */
 	getrawmonotonic64(&time);


