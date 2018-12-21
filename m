Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF01C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB21206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cE1+93jW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbeLUAbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:31:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35731 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbeLUAbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:31:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so1707493pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 16:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z8IX5khWv6NwCaeddsyQb3gmTaVRx0LhYfdFanUsyfM=;
        b=cE1+93jWliwNGhlYPDAEWMc7vrx2LgcjvWB7bzWGqCfbTIilOB4/8ouHRGONHzkX2f
         iRZw1Btdp5LHCvdHtr74bo0FZvEJs3jWgiUR85qP4uZlUwOD5cEIBnVeYPQJGrthwAqC
         0wwUv1MgMVZANzse9IHtodVKAmGohWY2qDh6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z8IX5khWv6NwCaeddsyQb3gmTaVRx0LhYfdFanUsyfM=;
        b=bSLxOmDBN9DCXfDcpxtLkvYLPXogVkkDK7hmk9ZNMrLEAW4cZ24BGCych7mvPvcpTs
         pY2jlbtVEXo7lXrI1GYiQ5s25TZuDqGThNgyI2hdyE42Jiu0k7108xYMZpnhQ7pPTSKn
         QnjuuqGGOW05xANkOXsOfDxLLDe7VprElB/0NcNpO6YrVNXhdIeN4FJVu19bRIuAxGUP
         mAOscGW+26Btk9DGgghKEsn5UbedKYRtBdhRBi8QtceG4tguP5+G4GR+VRDv/YNZWu24
         WcLUzVueI6NnTgLsiw7KF+kxEHmkLLBUMOWBgXZ+iAXimBSM31oYXX/2lwCp7Cdq6fdk
         Qfmg==
X-Gm-Message-State: AJcUukeKuByo1DrtN8ag/+mGLba083cmpbpXuXN0vK5wBQRuxG/FWghG
        79hxtzNVoAN+ZNs1ugJSnV3mYQ==
X-Google-Smtp-Source: ALg8bN5tjTbW+nAM1EQ1AjO/CUPKBy1g0aF29q7HkVtIfuD4cztvU1V5IcSww19HoYXYwfwfEEQR0w==
X-Received: by 2002:a63:c303:: with SMTP id c3mr342806pgd.268.1545352264917;
        Thu, 20 Dec 2018 16:31:04 -0800 (PST)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:db8d:8e3f:2514:5db8])
        by smtp.gmail.com with ESMTPSA id s21sm36607971pfk.133.2018.12.20.16.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 16:31:04 -0800 (PST)
From:   Derek Basehore <dbasehore@chromium.org>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH] clk: Remove global clk traversal on fetch parent index
Date:   Thu, 20 Dec 2018 16:31:00 -0800
Message-Id: <20181221003100.157581-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not required to traverse the entire clk tree when the parents
array contains a NULL value. You already have the parent clk_core
pointer, so you can just compare the parent->name and parent_names[i]
pointers.

In cases where clk names are never registered, this can be
a substantial power improvement since a mux having an unregistered
parent name will traverse the clk tree on every set_rate. This can
happen hundreds of times a second on CPU clks.

Change-Id: I85499d2e576249568ff508e424ca8d5009e6e2b1
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/clk/clk.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..57a95c713286 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1516,9 +1516,18 @@ static int clk_fetch_parent_index(struct clk_core *core,
 	if (!parent)
 		return -EINVAL;
 
-	for (i = 0; i < core->num_parents; i++)
-		if (clk_core_get_parent_by_index(core, i) == parent)
+	for (i = 0; i < core->num_parents; i++) {
+		if (core->parents[i] == parent)
+			return i;
+
+		if (core->parents[i])
+			continue;
+
+		if (!strcmp(parent->name, core->parent_names[i])) {
+			core->parents[i] = parent;
 			return i;
+		}
+	}
 
 	return -EINVAL;
 }
-- 
2.20.1.415.g653613c723-goog

