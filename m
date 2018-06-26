Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64ACC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E99A263F0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3W6PbxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E99A263F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935298AbeFZBeS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:34:18 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38468 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935132AbeFZBeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:34:14 -0400
Received: by mail-it0-f65.google.com with SMTP id v83-v6so15180698itc.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kEKesqqo+/X5Y1TJjKx05ALvbSOA18VpVMYr5WHzjvY=;
        b=U3W6PbxJjjMLlWRK/KUHAwp4zTcxydY6ckI2MEkktvhip6QD4rd1bh8wIjQR2cUrO5
         cwlPv27/hrOeOnRTf8RfQTw13aFMy0GZeWQ1749Yg8J+EjnO2olrkOvh47VJS6TGUVfa
         qByDt8iZTsz1cNngVqJwBv1RFgF2PXYkLfXSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kEKesqqo+/X5Y1TJjKx05ALvbSOA18VpVMYr5WHzjvY=;
        b=RzVmNOuD7yW8ok35HwGG1S8gfDB4qbj+PVTVt2xSwD+BSdVmiTJ3HOJnGfna9uUGiv
         vJGmi5u8J6WCBDrh+okL7Rv0AnLydnNLNkaUSxWLE2px9VQXSa2E13XhDnyFlaimrlTw
         iLbKJ6pBu8OqgH0Cnr9b0gc88QcmUoSu+Q4rgcoAvfo9O7nlDA8ZYzNCNCaVEU6jl8NC
         l6eO1jyj1VlBz6AaO44/3x7XNCFRfu61gd1BugSXUvPys4K5jiQysk/cev0M+eA5bdyO
         /auQOqel7D+J4sD57kiEt6VR5ruQIbLVwoKATgtKj11aaMfZ3xrUPoU8UmwhZgxIvX9A
         YB4Q==
X-Gm-Message-State: APt69E1WzxQrKR2mjBULNq7wbFbadjAZ8nUbY+6cUvml7D/ub9p9sXDR
        9vlK7cBzYyoQxR0hp/XsdcwFPQ==
X-Google-Smtp-Source: ADUXVKKAHqpvQwuZ55uQQMSOuQQlQuU6cqBJKqN76R4SxKsUhz/2ID/mfGHGqva5ZXK+Vh3h0rl9cQ==
X-Received: by 2002:a02:a30f:: with SMTP id q15-v6mr9790170jai.66.1529976854238;
        Mon, 25 Jun 2018 18:34:14 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id h62-v6sm184699ioa.22.2018.06.25.18.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 18:34:13 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend 2/5] remoteproc: Make start and stop in subdev optional
Date:   Mon, 25 Jun 2018 20:34:06 -0500
Message-Id: <20180626013409.5125-3-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626013409.5125-1-elder@linaro.org>
References: <20180626013409.5125-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Some subdevices, such as glink ssr only care about the stop operation,
so make the operations optional to reduce client code.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Alex Elder <elder@linaro.org>
Tested-by: Fabien Dessenne <fabien.dessenne@st.com>
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

