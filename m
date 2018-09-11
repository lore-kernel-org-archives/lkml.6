Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A29CC4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2949220880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OstrpvlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2949220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeILCvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:51:21 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41956 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeILCvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:51:20 -0400
Received: by mail-io0-f194.google.com with SMTP id q4-v6so4846130iob.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nE54tmiDsnKsQusmU2kfw+Wu31P7rt65tLwJCDG9RhE=;
        b=OstrpvlOZh00NoAWFSuVHHq9Q+vpuKiDeGtbGDGYi/Kugb6pGffEpallajzSyDfbGi
         zPYtWuNo4uy4zaE2VSjGl90u1OneBnqfiZr8TkFxHz1VjpKEXDdHMKXZgyJMpD2JH1NP
         eDxMqGh8/tQUjfWmlK0wV4d0myiY6362dF89o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nE54tmiDsnKsQusmU2kfw+Wu31P7rt65tLwJCDG9RhE=;
        b=YjKykcD9ANYUmDsK60r2PM9oQVHcg0RalldNTkFb16OwJu0lu29DmRV6Y7Dom9haNg
         Z5UrrP2XYXbiBd/0s8IBHQ92tMwZE4LdTmd5dvTiFnEzyLWxbl5UpmNmPQNZSYlXLVzJ
         Q0Lj4RTEPZ5qrZA7f6lJZnlCuHKkAydgnftu0cD5eyqZABgojMpvy20P+lHWFCJocqMg
         YrNEsG1CBOMf1arZuEyK0Gx9RiMYDHlWSGd+h3CjPX60IhcaMXMNJiMmc4X2QOE+hRJG
         KmjdnbeVk3VJOCZpozhvG+ts7plhOfusx2O+bhGdJmUZezYVQ9hnqU9tZtAgsueykurb
         GABw==
X-Gm-Message-State: APzg51BDcpYkHoGs3uAbwdCmdq73+GNSOaycU5RwUATzidvQSbWFcdDQ
        bjiHP9rOp4XlzSgBejuBRnKQ3A==
X-Google-Smtp-Source: ANB0VdYnJKFGhASZnoHx/6JlTIwVNuHvmVdXqUq3WB/FQZud5e5AqPH9WxTpILU4/svfvZG21ky/cQ==
X-Received: by 2002:a6b:7308:: with SMTP id e8-v6mr6622475ioh.57.1536702602424;
        Tue, 11 Sep 2018 14:50:02 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c3-v6sm1102172itd.8.2018.09.11.14.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Sep 2018 14:50:01 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
        gregkh@linuxfoundation.org, kim.phillips@arm.com,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] coresight: Make link components aware of operation mode
Date:   Tue, 11 Sep 2018 15:49:52 -0600
Message-Id: <1536702595-9999-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
References: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following what has been done for source and sinks, make link
devices aware of the mode they are being operated from so that
their verbosity can be controlled.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-dynamic-replicator.c |  4 ++--
 drivers/hwtracing/coresight/coresight-funnel.c             |  4 ++--
 drivers/hwtracing/coresight/coresight-replicator.c         |  4 ++--
 drivers/hwtracing/coresight/coresight-tmc-etf.c            |  4 ++--
 drivers/hwtracing/coresight/coresight.c                    | 13 +++++++------
 include/linux/coresight.h                                  |  6 ++++--
 6 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index ebb80438f6a5..de2c197886c6 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -35,7 +35,7 @@ struct replicator_state {
 };
 
 static int replicator_enable(struct coresight_device *csdev, int inport,
-			      int outport)
+			      int outport, u32 mode)
 {
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -61,7 +61,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 }
 
 static void replicator_disable(struct coresight_device *csdev, int inport,
-				int outport)
+				int outport, u32 mode)
 {
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index ee7a30bf9480..c1c9f5fccc4b 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -59,7 +59,7 @@ static void funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
 }
 
 static int funnel_enable(struct coresight_device *csdev, int inport,
-			 int outport)
+			 int outport, u32 mode)
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -83,7 +83,7 @@ static void funnel_disable_hw(struct funnel_drvdata *drvdata, int inport)
 }
 
 static void funnel_disable(struct coresight_device *csdev, int inport,
-			   int outport)
+			   int outport, u32 mode)
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index feac98315471..0b749302c066 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -31,7 +31,7 @@ struct replicator_drvdata {
 };
 
 static int replicator_enable(struct coresight_device *csdev, int inport,
-			     int outport)
+			     int outport, u32 mode)
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -40,7 +40,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 }
 
 static void replicator_disable(struct coresight_device *csdev, int inport,
-			       int outport)
+			       int outport, u32 mode)
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 4156c95ce1bb..28b3ff830597 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -269,7 +269,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 }
 
 static int tmc_enable_etf_link(struct coresight_device *csdev,
-			       int inport, int outport)
+			       int inport, int outport, u32 mode)
 {
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -289,7 +289,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 }
 
 static void tmc_disable_etf_link(struct coresight_device *csdev,
-				 int inport, int outport)
+				 int inport, int outport, u32 mode)
 {
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 118b435f0887..edfb7f8d2f0b 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -161,7 +161,7 @@ static void coresight_disable_sink(struct coresight_device *csdev)
 
 static int coresight_enable_link(struct coresight_device *csdev,
 				 struct coresight_device *parent,
-				 struct coresight_device *child)
+				 struct coresight_device *child, u32 mode)
 {
 	int ret;
 	int link_subtype;
@@ -186,7 +186,8 @@ static int coresight_enable_link(struct coresight_device *csdev,
 
 	if (atomic_inc_return(&csdev->refcnt[refport]) == 1) {
 		if (link_ops(csdev)->enable) {
-			ret = link_ops(csdev)->enable(csdev, inport, outport);
+			ret = link_ops(csdev)->enable(csdev, inport,
+						      outport, mode);
 			if (ret)
 				return ret;
 		}
@@ -199,7 +200,7 @@ static int coresight_enable_link(struct coresight_device *csdev,
 
 static void coresight_disable_link(struct coresight_device *csdev,
 				   struct coresight_device *parent,
-				   struct coresight_device *child)
+				   struct coresight_device *child, u32 mode)
 {
 	int i, nr_conns;
 	int link_subtype;
@@ -225,7 +226,7 @@ static void coresight_disable_link(struct coresight_device *csdev,
 
 	if (atomic_dec_return(&csdev->refcnt[refport]) == 0) {
 		if (link_ops(csdev)->disable)
-			link_ops(csdev)->disable(csdev, inport, outport);
+			link_ops(csdev)->disable(csdev, inport, outport, mode);
 	}
 
 	for (i = 0; i < nr_conns; i++)
@@ -308,7 +309,7 @@ void coresight_disable_path(struct list_head *path, u32 mode)
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
 			child = list_next_entry(nd, link)->csdev;
-			coresight_disable_link(csdev, parent, child);
+			coresight_disable_link(csdev, parent, child, mode);
 			break;
 		default:
 			break;
@@ -357,7 +358,7 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
 		case CORESIGHT_DEV_TYPE_LINK:
 			parent = list_prev_entry(nd, link)->csdev;
 			child = list_next_entry(nd, link)->csdev;
-			ret = coresight_enable_link(csdev, parent, child);
+			ret = coresight_enable_link(csdev, parent, child, mode);
 			if (ret)
 				goto err;
 			break;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 53535821dc25..8fc6f1e82c17 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -205,8 +205,10 @@ struct coresight_ops_sink {
  * @disable:	disables flow between iport and oport.
  */
 struct coresight_ops_link {
-	int (*enable)(struct coresight_device *csdev, int iport, int oport);
-	void (*disable)(struct coresight_device *csdev, int iport, int oport);
+	int (*enable)(struct coresight_device *csdev,
+		      int iport, int oport, u32 mode);
+	void (*disable)(struct coresight_device *csdev,
+			int iport, int oport, u32 mode);
 };
 
 /**
-- 
2.7.4

