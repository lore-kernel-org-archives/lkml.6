Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5B3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3599521783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AqRwU0Zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfAKW2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:28:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36441 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfAKW2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:28:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so7589689pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 14:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bFo0pbqsh0Dvh5rNBGhBWDBhm/iPdshZj7ccQgr+vtQ=;
        b=AqRwU0ZisWmvHZrIYus5ZptOMtgKTuGtzX2PK5ZonT5hxjvJZ69inV8++4fwiSBTYM
         La7KgHuadmhngQMXkw8MD18ePbULQeiT6717E++j2g/bCjtwsr+CphyphvkL9A3lCfbh
         8++h2yRlAf46/IIfBU3+c/PmebkJM2/mLdVZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bFo0pbqsh0Dvh5rNBGhBWDBhm/iPdshZj7ccQgr+vtQ=;
        b=Symzs40NSYmP2xnqUPCXti8q3E4cezg3AmiS6VuSl/12MIPI1y81ooznwwb07avta1
         4+VFODSNRTYsM6TI0umSEepsk6eSEh5fIHDhPbst8LZfl+3nFrQQgcXsLhb/R7oLNKhX
         l0RIpBwU2EhuMyBaiXXVLVHPU3zesoo99DRTDU4su4pCQGtiVVpKwLE/R4YX28DBDx6X
         TEwKtQ5Wsfr1GdIEj29X5ekDyaKJUwR+11CACt7HbdAi7BZQ0KW/8myoQkiV9qM+A9vc
         vWCwD5KjKYwdR1dEr+G8xX1rfFntH2buLKwpjj+uWqwSEkCFjYrxcg/Jpc5u0PWcOlPg
         btqw==
X-Gm-Message-State: AJcUukeBWhvDzXcGvwe1WYvNidHrbvlaQ7aIKpzu/1IEBnzuoNlDbgQC
        byEYdASwrsmZlazC9BhS4sqBUg==
X-Google-Smtp-Source: ALg8bN6Y95vumKWEwb8PqGLyXo+RNP5N5pOi/Y2DrEDcSTe19V2itjJ0qZ8lPryfmRXM5qRm7gEv9A==
X-Received: by 2002:a62:62c5:: with SMTP id w188mr16471072pfb.160.1547245682936;
        Fri, 11 Jan 2019 14:28:02 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id x3sm239960227pgt.45.2019.01.11.14.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 14:28:02 -0800 (PST)
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
Subject: [PATCH] drm/msm: Fix A6XX support for opp-level
Date:   Fri, 11 Jan 2019 14:27:21 -0800
Message-Id: <20190111222721.246972-1-dianders@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings for Qualcomm opp levels changed after being Acked but
before landing.  Thus the code in the GPU that was relying on the old
bindings is now broken.

While we could just change the string 'qcom,level' to the string
'opp-level', it actually seems better to use the newly-introduced
dev_pm_opp_get_level().

This patch thus has a hard dependency on the outstanding patch ("OPP:
Add support for parsing the 'opp-level' property") and will need to
land in a tree that contains that patch.

This patch needs to land before the patch ("arm64: dts: sdm845: Add
gpu and gmu device nodes") since if a tree contains the device tree
patch but not this one you'll get a crash at bootup.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 5beb83d1cf87..900f18dc1577 100644
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
-		of_property_read_u32(np, "qcom,level", &val);
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

