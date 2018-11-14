Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFDDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6501C2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OERHG8KZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6501C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbeKOIrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:47:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728747AbeKOI1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:22 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A96852251D;
        Wed, 14 Nov 2018 22:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234138;
        bh=6TmoVjPS0F7A73e/ZAt02YzjdxfJpinryyjqbLTc7EM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OERHG8KZ9JaafGimQUgswIoTilit2q29ULO3IKi/HjO5l+UcV44McyKNVzMnMh0Ld
         8E4s61bWCihvYhvBly9qZq0OX6Z83B2hc/5bKKPM2NAi/DC9Kwtgf7Rem4fKtZBVQ7
         LZyeOwbTjBS5DCJHjgmMY4VhmAiHTHj0jyHUQsoE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 44/73] s390/perf: Change CPUM_CF return code in event init function
Date:   Wed, 14 Nov 2018 17:21:38 -0500
Message-Id: <20181114222207.98701-44-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
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
index cc085e2d2ce9..74091fd3101e 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -373,7 +373,7 @@ static int __hw_perf_event_init(struct perf_event *event)
 		return -ENOENT;
 
 	if (ev > PERF_CPUM_CF_MAX_CTR)
-		return -EINVAL;
+		return -ENOENT;
 
 	/* Obtain the counter set to which the specified counter belongs */
 	set = get_counter_set(ev);
-- 
2.17.1

