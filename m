Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3ADC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E23120840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KrGLquoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfAPSqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:46:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42295 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbfAPSqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:46:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so3471939pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 10:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FU7vnujm7PFqQbun8zmDwXg0wlx5eTmKlDoI+BggiOU=;
        b=KrGLquoODRhwxeMU7zgaKr61t6GHgp3yL7dO1D3O4j+XaXhhLQfp00LkNE4wYTeeJ1
         GBBj8fZlb2U8a+HH5VsLf/stDaGODzNt4HXXsUQH90UOVbh5k+7DN8gibqYRFDZsuPkf
         4z1j4KHKTLXP57jkQj9CThndsjF0hQboeqpkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FU7vnujm7PFqQbun8zmDwXg0wlx5eTmKlDoI+BggiOU=;
        b=nmYMepbr003MKIB9obfWpsMF9rHFK+hz3TKJz3H6oDtebm9JCnoisYOemzm0fPoOjH
         tebPfzGG6nwAXP6MJW2ik+N0SzHqtHD5mfnIhuaSRYuxvEuxMsv5I0J0Q+SzMIk+kTyA
         6RAw2+hZfqEYU7stS857xTgV6IKaCwXyfNUSJDTrvOS+0GrupMfaU7U7KiCMec2RaBV3
         I8zzbmfVK82oQlIsSznnrMb9Hgtd4dN1QaL/aTmDxmPGgwx5iqvLMTg7ua5COiJi8b32
         w7xPs6/GbBToqkz2I/I92655L2rhPTeibMX2d0ycjb8D5Z66BX2m0Xsd/bC3xiKgwWLJ
         75Mg==
X-Gm-Message-State: AJcUukcZZlFs8di7OnGxEnUSYJDyFPzEfLqDHNB0BzhsxA4MIjAKzCan
        wz0CxZzJhk1BnPSuxKZjmT5WnA==
X-Google-Smtp-Source: ALg8bN415uNxmPPZwJn8lkLzuqEUKrI/rXNceInBgwImlGAIb5dSZBe4/+wy2j3BE49nDqGts9qTLw==
X-Received: by 2002:a62:6ec8:: with SMTP id j191mr11252708pfc.198.1547664394565;
        Wed, 16 Jan 2019 10:46:34 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id k186sm8138902pge.13.2019.01.16.10.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:46:33 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 2/2] drm/msm: Cleanup A6XX opp-level reading
Date:   Wed, 16 Jan 2019 10:46:22 -0800
Message-Id: <20190116184623.77136-2-dianders@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190116184623.77136-1-dianders@chromium.org>
References: <20190116184623.77136-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch ("OPP: Add support for parsing the 'opp-level' property")
adds an API enabling a cleaner way to read the opp-level.  Let's use
the new API.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
---
Obviously this can't land until we have a tree that contains the patch
adding the API.  I believe that means we'll want to target this patch
for 5.2.  Luckily it's fine to wait since this patch has no functional
changes--it's all cleanup.

Changes in v2:
- Split into two patches to facilitate landing.

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index ce1b3cc4bf6d..900f18dc1577 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -928,25 +928,20 @@ static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
 }
 
 /* Return the 'arc-level' for the given frequency */
-static u32 a6xx_gmu_get_arc_level(struct device *dev, unsigned long freq)
+static unsigned int a6xx_gmu_get_arc_level(struct device *dev,
+					   unsigned long freq)
 {
 	struct dev_pm_opp *opp;
-	struct device_node *np;
-	u32 val = 0;
+	unsigned int val;
 
 	if (!freq)
 		return 0;
 
-	opp  = dev_pm_opp_find_freq_exact(dev, freq, true);
+	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
 	if (IS_ERR(opp))
 		return 0;
 
-	np = dev_pm_opp_get_of_node(opp);
-
-	if (np) {
-		of_property_read_u32(np, "opp-level", &val);
-		of_node_put(np);
-	}
+	val = dev_pm_opp_get_level(opp);
 
 	dev_pm_opp_put(opp);
 
@@ -982,7 +977,7 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 	/* Construct a vote for each frequency */
 	for (i = 0; i < freqs_count; i++) {
 		u8 pindex = 0, sindex = 0;
-		u32 level = a6xx_gmu_get_arc_level(dev, freqs[i]);
+		unsigned int level = a6xx_gmu_get_arc_level(dev, freqs[i]);
 
 		/* Get the primary index that matches the arc level */
 		for (j = 0; j < pri_count; j++) {
-- 
2.20.1.97.g81188d93c3-goog

