Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F723C04AB9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AA821529
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AA821529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeHXTBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:01:38 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39050 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbeHXTBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:01:36 -0400
Received: by mail-oi0-f67.google.com with SMTP id c190-v6so15964777oig.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 08:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=er0GzXSeVJtNhqN9ZifGbLZccCBBYHKursu1yRoIKcY=;
        b=O7Oc9l4DlTGXt+B+0colKEG6/NFyllQ7mnm0TpRzmxwVMLtFbX6OlBtAQy9a/3GP4L
         bywzObpVPUcfAwtsCqhY6Mn0hRrL5kgFQ1P13J23PCbij2Ssm5zaD2iORda6ASzzsnF0
         +xxc3Ty1YOd4JdMwdpA130/UX//StitgAwQvke+jalQhNehQe9gaZPhbjPsPhNm+rvbV
         3HhxJxo4c5+RV5rnx1EtmxFHqj7NP3fOOWe/Ov6LGy2JVLb8cTVnAsPTkh62XPxN6DDq
         +nCZwP4/VkxPpuOCoRn9zD5mfMaytGG/ntuk7BrlRlQCv2FKw0PZm8hxdAy1MyXWDMON
         S/Ig==
X-Gm-Message-State: APzg51CZxVTIBDwbTYgdxFEco3jNqfLsi0pPgXpUHA7E/MbTeOCANJDR
        2JXry1uGHLm8BNQe3rTNNk/+U306v9E=
X-Google-Smtp-Source: ANB0VdbF4ybZ37YtXzQfycYmkP4JBCVXXNZfepsZz31Mv75JMNo8aPa89v6vTGJOytEa+Y6rftDOLg==
X-Received: by 2002:aca:d015:: with SMTP id h21-v6mr1973709oig.142.1535124388789;
        Fri, 24 Aug 2018 08:26:28 -0700 (PDT)
Received: from localhost ([130.164.62.204])
        by smtp.gmail.com with ESMTPSA id e143-v6sm12379606oic.56.2018.08.24.08.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 08:26:28 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     hao.wu@intel.com, atull@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 2/2] fpga: dfl-fme-region: Use platform_get_drvdata()
Date:   Fri, 24 Aug 2018 08:25:13 -0700
Message-Id: <20180824152513.8336-2-mdf@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824152513.8336-1-mdf@kernel.org>
References: <20180824152513.8336-1-mdf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use platform_get_drvdata() in remove() function of
the platform driver rather than dev_get_drvdata()
to match the platform_set_drvdata in the probe().

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-fme-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 0b7e19c27c6d..11d3c23a8936 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -65,7 +65,7 @@ static int fme_region_probe(struct platform_device *pdev)
 
 static int fme_region_remove(struct platform_device *pdev)
 {
-	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
+	struct fpga_region *region = platform_get_drvdata(pdev);
 
 	fpga_region_unregister(region);
 	fpga_mgr_put(region->mgr);
-- 
2.18.0

