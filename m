Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F400C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370302172F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZeNjSzz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370302172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbeHNTyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:54:55 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46321 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387624AbeHNTyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:54:55 -0400
Received: by mail-pl0-f68.google.com with SMTP id t17-v6so8551007ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0IryqUHHn803R0vItVfBlrN0avv0GNYFsdGQ+ij7oqE=;
        b=ZeNjSzz5HLbhfuNJQcituRS361qr5a2daqWMHzECXaRpDGJcRXC60eouLteyl9fz4V
         KWPpR40choIe2dSpDgi+pQ+Hxxxv1VoKbzOjNGFZRXZRmrd8GeMbkZI83V7w28imhiHp
         dtyeDugjHMhp3RT3mq1Olmymyaq5bVW7WHKWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0IryqUHHn803R0vItVfBlrN0avv0GNYFsdGQ+ij7oqE=;
        b=QVLAqtQ8aAXbfFm21Nd0VctzNAE+s6/nZ5FWsbCWISP+lDJX6q0huJ4C+U9XeslfFG
         mx7DS49S3gAAcu7li2kChFfGnSMsuGJYjj76CImmIcJFWo+V+jCdMe57FdBNf8kTK8Ef
         UY/eo+Zgbk/3AY4RVP0ORTnscIGcwLoR6s+/KWzv9pfYTUXRC1+yebwfmxavERB2vL13
         t/hpIF2/25X2eBwaH8waVkC3wze4dUsINJyjN/+LgVkt1w8ACXubdtmX9i3bBO+nUF5B
         8MYAcPzZWOvnrtvg71nl5OSMAqnSCRJskvnUmjpceHwI3975MWHEbJEUHhBnCSjQ8c8J
         7/8A==
X-Gm-Message-State: AOUpUlHilFs+glOgpT/z/BJtSY684EE2d9XD2j8Hiby7pEPHjILdiqZy
        eMMLiXneMriGmCMkgSfTqcxyig==
X-Google-Smtp-Source: AA+uWPyQrwjmOQuqmBW8AnCV+/Mz0X0CtsBBURdzMZmqqFH5AB+24KWSqB98yK8eGYfQzr3lqMH75A==
X-Received: by 2002:a17:902:622:: with SMTP id 31-v6mr21189586plg.153.1534266415190;
        Tue, 14 Aug 2018 10:06:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id d19-v6sm67940763pfe.42.2018.08.14.10.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 10:06:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     broonie@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        collinsd@codeaurora.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] regulator: core: Add the opmode to regulator_summary
Date:   Tue, 14 Aug 2018 10:06:15 -0700
Message-Id: <20180814170617.100087-3-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
In-Reply-To: <20180814170617.100087-1-dianders@chromium.org>
References: <20180814170617.100087-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's handy to know what opmode a regulator has been configured to in
the summary.  Add it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a4da68775b49..b8b8048efbdd 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -426,19 +426,24 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(name);
 
-static ssize_t regulator_print_opmode(char *buf, int mode)
+static const char *regulator_opmode_to_str(int mode)
 {
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
-		return sprintf(buf, "fast\n");
+		return "fast";
 	case REGULATOR_MODE_NORMAL:
-		return sprintf(buf, "normal\n");
+		return "normal";
 	case REGULATOR_MODE_IDLE:
-		return sprintf(buf, "idle\n");
+		return "idle";
 	case REGULATOR_MODE_STANDBY:
-		return sprintf(buf, "standby\n");
+		return "standby";
 	}
-	return sprintf(buf, "unknown\n");
+	return "unknown";
+}
+
+static ssize_t regulator_print_opmode(char *buf, int mode)
+{
+	return sprintf(buf, "%s\n", regulator_opmode_to_str(mode));
 }
 
 static ssize_t regulator_opmode_show(struct device *dev,
@@ -4668,10 +4673,11 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 	if (!rdev)
 		return;
 
-	seq_printf(s, "%*s%-*s %3d %4d %6d ",
+	seq_printf(s, "%*s%-*s %3d %4d %6d %7s ",
 		   level * 3 + 1, "",
 		   30 - level * 3, rdev_get_name(rdev),
-		   rdev->use_count, rdev->open_count, rdev->bypass_count);
+		   rdev->use_count, rdev->open_count, rdev->bypass_count,
+		   regulator_opmode_to_str(_regulator_get_mode(rdev)));
 
 	seq_printf(s, "%5dmV ", _regulator_get_voltage(rdev) / 1000);
 	seq_printf(s, "%5dmA ", _regulator_get_current_limit(rdev) / 1000);
@@ -4703,7 +4709,7 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 
 		switch (rdev->desc->type) {
 		case REGULATOR_VOLTAGE:
-			seq_printf(s, "%37dmV %5dmV",
+			seq_printf(s, "%45dmV %5dmV",
 				   consumer->voltage[PM_SUSPEND_ON].min_uV / 1000,
 				   consumer->voltage[PM_SUSPEND_ON].max_uV / 1000);
 			break;
@@ -4735,8 +4741,8 @@ static int regulator_summary_show_roots(struct device *dev, void *data)
 
 static int regulator_summary_show(struct seq_file *s, void *data)
 {
-	seq_puts(s, " regulator                      use open bypass voltage current     min     max\n");
-	seq_puts(s, "-------------------------------------------------------------------------------\n");
+	seq_puts(s, " regulator                      use open bypass  opmode voltage current     min     max\n");
+	seq_puts(s, "---------------------------------------------------------------------------------------\n");
 
 	class_for_each_device(&regulator_class, NULL, s,
 			      regulator_summary_show_roots);
-- 
2.18.0.865.gffc8e1a3cd6-goog

