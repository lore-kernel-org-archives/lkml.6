Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A34C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504F820663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yc8U4TRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504F820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeK0EDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:03:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35246 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeK0EDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:03:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so6453800pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zSJaFg264tb2HzfZbkslyNfTGBGf+AM92JOHgcmxpY4=;
        b=Yc8U4TRH5vGPPwT182qrDaAEZ7zAQYHAuC3Vl0dWkNtqzjdCcSUAzYKVkkmx6s/nfM
         bSFpMs++SJ9nSG9m7o0VJ7S5qxgopmFa5JqNuMhLVmah8YLd3C0vVSd+ZHDdS+/+Peku
         stqF9tyoffbM6gsBagNvP/Y3ZlqSuHwstUwRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zSJaFg264tb2HzfZbkslyNfTGBGf+AM92JOHgcmxpY4=;
        b=oeeYUeLt76o+cRlJ/4Fyr/q1Nk0RUNV4Cuyt1LMCWodYc3KZXpRAKp3bxcCGAMHQbV
         F+JTgpTQV8RZrh8eiIsKPEQAPxVlYqiVLL3ijMGMcdNdoozI5eu8SX5OeD7AURZXLjGB
         FHRqs0Sf6Gh0x91ztmXVDQSIiO4oLM6nbc+JWg/M2yoYDtfC+nNF+3elb5xBLOHnH/Gn
         4Oo8Xaxam3t9NAOgyUhoebI6kE4ucAHxtE8mHVt+uAWaPS0odSFFirEPWq99gNGui5tI
         LseAHo6tZ5q/SJfi2Zypv9RDgTSNpQ/clKXf/et7U1TYP1J67S4lBxmRZkyi/Sm8U1hP
         RJUg==
X-Gm-Message-State: AA+aEWYt74/7ekQ95MQc8Tk3Gx/qRpzS+V1ngslTEK9okgEwFBZubUmS
        2McDUwyCKASbrkQk0n3ep5WeMA==
X-Google-Smtp-Source: AFSGD/WD6VkjhtY/IkGkGmeUf0zOvO5Qh+6CiCRjTP8lN5O3MQZUxPECCg8E4+v6bI8Q0qFhEjM3iw==
X-Received: by 2002:a62:5182:: with SMTP id f124mr26647790pfb.238.1543252128786;
        Mon, 26 Nov 2018 09:08:48 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id h129sm1167105pfb.110.2018.11.26.09.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 09:08:48 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Brian Masney <masneyb@onstation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Apply system load even if no consumer loads
Date:   Mon, 26 Nov 2018 09:08:27 -0800
Message-Id: <20181126170827.160567-1-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit 5451781dadf8 ("regulator: core: Only count load for
enabled consumers") we used to always add up the total load on every
enable in _regulator_enable().  After that commit we only updated the
total load when enabling / disabling a regulator where a consumer
specified a load or when changing the consumer load on an enabled
regulator.

The problem with the new scheme is that if there is a system load
specified for a regulator but no consumers specify a load then we
never account for it.

Let's account for the system load in set_machine_constraints().

NOTE: with the new scheme we end up with a bit of a quandry.  What if
someone specifies _both_ an initial mode and a system load?  If we
take the system load into account right at init time then it will
effectively clobber the initial mode.  We'll resolve this by saying
that if both are specified then the initial mode will win.  The system
load will then only take effect if/when a consumer specifies a load.
If no consumers ever specify a load then the initial mode will persist
and the system load will have no effect.

Fixes: 5451781dadf8 ("regulator: core: Only count load for enabled consumers")
Reported-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Brian Masney <masneyb@onstation.org>
---

 drivers/regulator/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dbe2f2e6e625..dffee5432ca1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1344,6 +1344,12 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 			rdev_err(rdev, "failed to set initial mode: %d\n", ret);
 			return ret;
 		}
+	} else if (rdev->constraints->system_load) {
+		/*
+		 * We'll only apply the initial system load if an
+		 * initial mode wasn't specified.
+		 */
+		drms_uA_update(rdev);
 	}
 
 	/* If the constraints say the regulator should be on at this point
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

