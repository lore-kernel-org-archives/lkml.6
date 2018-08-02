Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B428C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF25D20862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ONNst3Nx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF25D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbeHBCDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:03:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42521 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbeHBCDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:03:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so223317pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tm07p3DdL6tnTAG5XtlOmipO5/BFoXbS1enBIZxJsMA=;
        b=ONNst3NxFI5pIEmNv4GSkfmiicODZNgbFxO0Erqri1E+G0Nr4kR7tN3PCPG+BIQgnO
         k/l/3CKdzMCfNNd72E/J4PZOGLCN4/Ff+jD+795Ht0xXxFEaGM2t3eiNRCiggdohQU+9
         obXN5WSlfmP6EG/4GWofXWIGr+hSm8E0AzVx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tm07p3DdL6tnTAG5XtlOmipO5/BFoXbS1enBIZxJsMA=;
        b=YBFQIpuhFJfLk3dwOlDavVKPJw9+7jHJt15QnTuW0eF/LEO6MAABfNge8hl5bJ5Yw9
         suX3Bn1IBO85khr3dyVvil11VZeWjB5mWCinB1ZFioVBiUJsfpE6J8LyCLSJbh75GcL8
         uIPo1BepjG4DD35JB301Iv/7k2lPX713hChI4qgI33scYt5Thrc/1+SUY6FdT2MYG+DM
         Ux7v92CYJtmLbZrH1DcricXY1ehEg2NUx7xpPnM5+TNY8QOfoK8iyYNCscHosxG1l0y1
         qeXXjXcBHi1ZPdquVgYdpWAItuJbJq1sKAAMuUAyOX46l+mPZdvLDJv9OHdO7mhUJsi4
         3Ptg==
X-Gm-Message-State: AOUpUlFjUar5Qlt0tKgdsZ/M67LRjkwZifz5GHUR58V45K66Sw2B/TM/
        EkrLZfrMROHTcbHi670oqd8UAw==
X-Google-Smtp-Source: AAOMgpe1ZDrGCKcHXfbnfwMCwUIYLXkrDmc+I5Uy1PuTTm+QWQNvS5aegzLNLvfE1Lt72YTUInroYg==
X-Received: by 2002:a63:9741:: with SMTP id d1-v6mr429939pgo.403.1533168881677;
        Wed, 01 Aug 2018 17:14:41 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id i7-v6sm201497pgs.17.2018.08.01.17.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 17:14:41 -0700 (PDT)
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
Subject: [PATCH] scsi: ufs: Check workqueue exists before destroying it
Date:   Wed,  1 Aug 2018 17:14:35 -0700
Message-Id: <20180802001435.116963-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ufshcd_hba_exit() the clock gating workqueue is always destroyed
when clock gating is supported. However the workqueue pointer is NULL
when ufshcd_init() fails before the workqueue is created. Only destroy
the workqueue if it exists.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/scsi/ufs/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 397081d320b1..401f7dbe2981 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7190,7 +7190,8 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
 		if (ufshcd_is_clkscaling_supported(hba)) {
 			if (hba->devfreq)
 				ufshcd_suspend_clkscaling(hba);
-			destroy_workqueue(hba->clk_scaling.workq);
+			if (hba->clk_scaling.workq)
+				destroy_workqueue(hba->clk_scaling.workq);
 			ufshcd_devfreq_remove(hba);
 		}
 		ufshcd_setup_clocks(hba, false);
-- 
2.18.0.597.ga71716f1ad-goog

