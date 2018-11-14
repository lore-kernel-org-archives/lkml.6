Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2DEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A21D22545
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHMUm7Ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A21D22545
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbeKOIau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732655AbeKOIas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:30:48 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 080D12252F;
        Wed, 14 Nov 2018 22:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234344;
        bh=ghs7g8LiOyskv7wZcQDpY3Ipy+xaltBwxU+uIkrkG/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IHMUm7Ea6rP0Pei8pMsjIZEKgp1iPLsjXhppRGf8xUGmwnQVkm/N6iGMwtaegzjU3
         0fVXQSfsYWW0oy0utf95wZV5+OYk8Ik2/l8/oleejjhCIxXID/Xf/Bo2HSp+7VIEYp
         oeDgvS6+/Ix7IN4DMZWWxP7yqjQqfGUrguZNBVJM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 16/27] s390/perf: Change CPUM_CF return code in event init function
Date:   Wed, 14 Nov 2018 17:25:05 -0500
Message-Id: <20181114222520.99926-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222520.99926-1-sashal@kernel.org>
References: <20181114222520.99926-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 0bb2ae1b26e1fb7543ec7474cdd374ac4b88c4da ]

The function perf_init_event() creates a new event and
assignes it to a PMU. This a done in a loop over all existing
PMUs. For each listed PMU the event init function is called
and if this function does return any other error than -ENOENT,
the loop is terminated the creation of the event fails.

If the event is invalid, return -ENOENT to try other PMUs.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_cf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 746d03423333..61e91fee8467 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -376,7 +376,7 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	if (ev > PERF_CPUM_CF_MAX_CTR)
-		return -EINVAL;
+		return -ENOENT;
 
 	/* Obtain the counter set to which the specified counter belongs */
 	set = get_counter_set(ev);
-- 
2.17.1

