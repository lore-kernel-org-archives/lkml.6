Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F54C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01ADB208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YnqHJL3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01ADB208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbeHBBUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:20:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41217 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbeHBBUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:20:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id y10-v6so175783pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 16:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDvt/GCgaWpsd5l3cemd2bpMfBjZYyk8QlX09qp5Yis=;
        b=YnqHJL3AnOPsZGLDZXhOgX7LqzhNISORpQwFjzyxmCJJfuzbb8uDWA7YRyPWruSc8T
         JyOpui2GvVrQmTHU5MRutOSFmk/SSUWsm/WeofOrS4fjPRuWsWP8fjEpF+Zl1XzoSBKh
         IaRyzSdIUlqWK/Wq4CAMRef65VGvqZYWdWu6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDvt/GCgaWpsd5l3cemd2bpMfBjZYyk8QlX09qp5Yis=;
        b=TjNvIPqItfjlDqgvZynaci0RYrnzKKm0ZlJd6r+RkucptN2D/Ww9zhiWFJ4GSFhZTt
         JAtcaJZv9aY4XWd9adF+QGz8/2Ci3qvy4g7z54y5VUHphzM8oUoyFJCuWTRDhfIlmRMY
         N4MtrwEpz01eWlUMX/lbhS29tfl5GPxfAin5JEd0qj5YLejh3/O43HjkcOWga8tDi2Qb
         7xmsXQoSj+g8EHYfRtwEsx4MNeUaRyDAF/KP3QyVFD4Jgr9NEjOHS/YRSW+5WSUiQmiP
         d2h2IGxXMRHAkZ64/a4ui5d4oFUSS3hDjikTUMVeeSq5RAqE+fGjUWnXJD2XSTFHlhKM
         QHNQ==
X-Gm-Message-State: AOUpUlFevt2XhAPKJD0lHoAsQciTnGtQC8gfVAeYlcH43TEHeZ2Kxc7g
        +nBR5naVrxUxcrAOnpcTbRxxbQ==
X-Google-Smtp-Source: AAOMgpcPkwhOoZjro0F+gLA425Btb4A+QSP2F3RkimSuoUzmQP1LHdDyXzorkMCVvGyoim10eomoHQ==
X-Received: by 2002:a63:375b:: with SMTP id g27-v6mr367112pgn.59.1533166312315;
        Wed, 01 Aug 2018 16:31:52 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id l84-v6sm264463pfg.3.2018.08.01.16.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 16:31:51 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Subhash Jadavani <subhashj@codeaurora.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] scsi: ufs: Suspend clock scaling only once in ufshcd_hba_exit()
Date:   Wed,  1 Aug 2018 16:31:45 -0700
Message-Id: <20180801233145.65049-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 401f1e4490ee ("scsi: ufs: don't suspend clock scaling during
clock gating") introduced a check in ufshcd_hba_exit() to suspend
clock scaling only when the controller supports clock scaling.
However the unconditional call to ufshcd_suspend_clkscaling() was
also left in place, so that it is now called twice when clock
scaling is supported and still once when the controller doesn't
support it. Remove the unconditional call.

Fixes: 401f1e4490ee ("scsi: ufs: don't suspend clock scaling during clock gating")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/scsi/ufs/ufshcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 397081d320b1..dca7525af696 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7186,7 +7186,6 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
 	if (hba->is_powered) {
 		ufshcd_variant_hba_exit(hba);
 		ufshcd_setup_vreg(hba, false);
-		ufshcd_suspend_clkscaling(hba);
 		if (ufshcd_is_clkscaling_supported(hba)) {
 			if (hba->devfreq)
 				ufshcd_suspend_clkscaling(hba);
-- 
2.18.0.597.ga71716f1ad-goog

