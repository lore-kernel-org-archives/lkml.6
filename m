Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220FBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE2620844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egmxXMQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE2620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbeIGVpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:45:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36795 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeIGVpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:45:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id x207-v6so12612471lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y76QbRVPuYAx4cMhm4POn/qB+2QewOEilVnC7uvez2w=;
        b=egmxXMQk9Hd36znnQlC9IQHxpOvitvXBxGYfh5LZQC8Py3ms/sercdpteiFIOzwqyb
         qbo1RcRa5mNjgTMrPjRUWAXrtPMUpFOKXSSf8G5HVKfXDVBBKUV+/jYxoUKI8sZ72zXh
         TGciPfWY1iAtwk72axLJAopBFBbYgeodzmVTJyuOH9j1w9GV5ySkQlEHPgCn+OlnsIB8
         H3J57sv4uAyG1VbSH2UE5Qcc5A8ZjHDq4AMv+LsScpZ7K+YmQ7rPgwutqEre+p8fI0m9
         FaEXi8PKqsahiJAzg3VTw3q5vZSHeAoG3A5wZI4gjRwZ1w//nUZJhrCRIs6knUI13pW9
         OKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y76QbRVPuYAx4cMhm4POn/qB+2QewOEilVnC7uvez2w=;
        b=ArtNn3oJgPrFoq32zTCr03uwqx3qm15xrg2BPNwcB0IiNa2ewDVmpoLhTpeW142CMI
         6G5OGv4cHG9VR8QScYo5QMFxXgpPE5KwCjvmnixfmA8Jr55M2NFEvs95tuzHmTjfxrRU
         zkqPujYe5O7vjyz7ITmKBEgbvetys4Xm+2DLxnTVkZSsG3MITNxEDIC/AwZgNzJxtZqf
         mJYrdX2eiqLew7DdFs8TE7plHnGGz/2QikZ9JyXw7+76Gw2UHjNRKHfH5MVnk8JnSdFO
         oiVevMDXwGTKpdzkA+/VZmk9433b1DSyzGQ7uqUaBIQkLUL9eBdrwyGlDrkLADd8YSUk
         j2DQ==
X-Gm-Message-State: APzg51DLvYGmcZGJw0HIZEoCxNSRsuR1+GQxsOvXvYGSAKIiuV32obVO
        dSYSUN6dmxpgW//1sE2pG0M=
X-Google-Smtp-Source: ANB0VdYfweQ8HPj886jpJ6UHjmEVFgGSyNIvdODupa3A7KZrdZt3dVA0RbrPQ3ieKR3px9RBMRKHeA==
X-Received: by 2002:a19:c38b:: with SMTP id t133-v6mr5952084lff.7.1536339826738;
        Fri, 07 Sep 2018 10:03:46 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id q85-v6sm1384802lfg.20.2018.09.07.10.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 10:03:46 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Mike Snitzer <snitzer@redhat.com>, Joe Thornber <ejt@redhat.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lvm: device mapper: remove unnecessary unlikely()
Date:   Fri,  7 Sep 2018 20:03:37 +0300
Message-Id: <20180907170337.26846-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Joe Thornber <ejt@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
---
 drivers/md/dm-cache-policy-smq.c | 2 +-
 drivers/md/dm.c                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-cache-policy-smq.c b/drivers/md/dm-cache-policy-smq.c
index 1b5b9ad9e492..b61aac00ff40 100644
--- a/drivers/md/dm-cache-policy-smq.c
+++ b/drivers/md/dm-cache-policy-smq.c
@@ -1200,7 +1200,7 @@ static void queue_demotion(struct smq_policy *mq)
 	struct policy_work work;
 	struct entry *e;
 
-	if (unlikely(WARN_ON_ONCE(!mq->migrations_allowed)))
+	if (WARN_ON_ONCE(!mq->migrations_allowed))
 		return;
 
 	e = q_peek(&mq->clean, mq->clean.nr_levels / 2, true);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 20f7e4ef5342..0f0f8547106d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1653,7 +1653,7 @@ static blk_qc_t __process_bio(struct mapped_device *md,
 		 * Defend against IO still getting in during teardown
 		 * - as was seen for a time with nvme-fcloop
 		 */
-		if (unlikely(WARN_ON_ONCE(!ti || !dm_target_is_valid(ti)))) {
+		if (WARN_ON_ONCE(!ti || !dm_target_is_valid(ti))) {
 			error = -EIO;
 			goto out;
 		}
-- 
2.17.1

