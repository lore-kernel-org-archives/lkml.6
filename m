Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59608C43145
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1045D26A4A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVwbcAdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1045D26A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935361AbeFZMMR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:12:17 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45869 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935259AbeFZMMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:12:12 -0400
Received: by mail-io0-f195.google.com with SMTP id l25-v6so15718743ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I57NxyETdS7bcU1Jd7YbgD9UZcuzgAQvo28u6b2l6Ek=;
        b=BVwbcAdxesZTOq5UrKvkrChLRF5weLtcqKkXCG0YUfp1GFLov9QwNdaLbXqjaI0fGu
         gbFFj20V6O485p8bHFJCLk4l4p3MpTvRHc2guDHAOarlbdUHyZtlIUQq8dq9wBxhGCS6
         8c7S392FJLxTohv/drjaHFXaxSo54ZbfFERgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I57NxyETdS7bcU1Jd7YbgD9UZcuzgAQvo28u6b2l6Ek=;
        b=W9CuHFiG7bEOTTcJCSgGTUAKE0x8nyHycB08PR1WcP66K1hAxy9z3Qa7DwxQ3N3zFS
         Ypx5KlBysTUU06IC4MVpyzaiTkvNglGiXumuAOnbNTeYU+Z6wIsjp4G/Ql6sN9271zeb
         /r5qyjUK5HMQgHdUP82Fo97K5mWdBgNrOfEOlS7vEFOb6w/lDdO6ctTOl7T/NTakGDiL
         5/qGJywbskyW+j7R4Gv04Nlh015zDFxuon34S8ULviTg/84DXN6ik9Jtb5oU2IxqxiYt
         f6FBpu5EfL9bbHoI1q0WhC9xwWNZMIBcTn4jaaDRK7RMp1WnomfJhxW3LmRcCbPFE1r3
         zSeQ==
X-Gm-Message-State: APt69E3vd21Wghs+ZEk1uposB+Qf/5AUdWy8P1MZ/uJyhTXFAZBD2Crw
        OoCZBfPjjvER68D83BM/RlCMwQ==
X-Google-Smtp-Source: AAOMgpceyunu9+Nw4AANVult0KFPwJzydcx1O7J62lpKGijhW8/6eLikFnT3eLSkTF7EM1rYdvhzdA==
X-Received: by 2002:a6b:144b:: with SMTP id 72-v6mr954408iou.218.1530015131335;
        Tue, 26 Jun 2018 05:12:11 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id y62-v6sm902309ioy.88.2018.06.26.05.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 05:12:10 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] remoteproc: Make start and stop in subdev optional
Date:   Tue, 26 Jun 2018 07:11:56 -0500
Message-Id: <20180626121159.7267-3-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626121159.7267-1-elder@linaro.org>
References: <20180626121159.7267-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Some subdevices, such as glink ssr only care about the stop operation,
so make the operations optional to reduce client code.

Tested-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by Alex Elder <elder@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 5dd58e6bea88..981ae6dff145 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -780,16 +780,20 @@ static int rproc_start_subdevices(struct rproc *rproc)
 	int ret;
 
 	list_for_each_entry(subdev, &rproc->subdevs, node) {
-		ret = subdev->start(subdev);
-		if (ret)
-			goto unroll_registration;
+		if (subdev->start) {
+			ret = subdev->start(subdev);
+			if (ret)
+				goto unroll_registration;
+		}
 	}
 
 	return 0;
 
 unroll_registration:
-	list_for_each_entry_continue_reverse(subdev, &rproc->subdevs, node)
-		subdev->stop(subdev, true);
+	list_for_each_entry_continue_reverse(subdev, &rproc->subdevs, node) {
+		if (subdev->stop)
+			subdev->stop(subdev, true);
+	}
 
 	return ret;
 }
@@ -798,8 +802,10 @@ static void rproc_stop_subdevices(struct rproc *rproc, bool crashed)
 {
 	struct rproc_subdev *subdev;
 
-	list_for_each_entry_reverse(subdev, &rproc->subdevs, node)
-		subdev->stop(subdev, crashed);
+	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
+		if (subdev->stop)
+			subdev->stop(subdev, crashed);
+	}
 }
 
 /**
-- 
2.17.1

