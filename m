Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9D7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93E0222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aMkMSW3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437385AbfBNRgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:36:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39214 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbfBNRgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:36:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id f132so3435473pfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ylrEXYb2RrtRUg8WjKUyI2ifEoHdKrFAjIqfk9zh86o=;
        b=aMkMSW3e56BZlwQqOLMerl+LiZUDV6Rvm+PfawEG6X+SdiN6eKD1FbU5Zk+3T89CGY
         O+93wM1kcvIaLLomwEbCRhDK14s39NShkb7Lv1wZQ6FtwCC/QoxTIRZcJV22R4BywGh1
         LnM5O/PD4SIuzRdbBs6juWJMyrZfpitSMXIZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ylrEXYb2RrtRUg8WjKUyI2ifEoHdKrFAjIqfk9zh86o=;
        b=iB4NITfzGHtu1KRpbdGTUTEoIx6jumg/+Cg14wW6vUAQ97qXMDMxNv5BZ1p20hYUzb
         4ief3mpEMID+SbHQUL2dANJ6U5YwJP/T0qFnsYRV4DXkrEMMgZDvruZFjyy2A2H3eY+H
         T3WoQe13Mh3+FQFsHR+dJdM8YCHz8Tmfe41bVUqVZOLjQ2ty0GfmNNm3sGgz0kQ0ITEA
         8jAztHZGZV/hUAXq+RJwpsrBWmhbzMwAX2VOU2Jr63pjgM7l81MHQG6tFfFBVXnxsujM
         Z9TXVyrIxY7wRovz4H6ikUn4oUyYARpCLwSGqpgwer5rMDKUF8mHfo15zHg5Qz6X87PG
         8mJw==
X-Gm-Message-State: AHQUAuadfSqtAwasWv+I8dXxj8ffr3L6IBJbFr/NivOFEAlj/qaUkTfJ
        tGq6ik1s4ZZRhtBi8IqpHagmrQ==
X-Google-Smtp-Source: AHgI3Ib72prjejBMWCV1UusrijBT8/MogLNJUNDdwIEGmPJA7wlc+RgAoBR17O0NDAyPo9ZyDVHY1A==
X-Received: by 2002:a63:7f46:: with SMTP id p6mr4868262pgn.54.1550165805896;
        Thu, 14 Feb 2019 09:36:45 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p12sm7618529pfj.81.2019.02.14.09.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:36:45 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: rpmhpd: Set 'active_only' for active only power domains
Date:   Thu, 14 Feb 2019 09:36:33 -0800
Message-Id: <20190214173633.211000-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'active_only' attribute was accidentally never set to true for any
power domains meaning that all the code handling this attribute was
dead.

NOTE that the RPM power domain code (as opposed to the RPMh one) gets
this right.

Fixes: 279b7e8a62cc ("soc: qcom: rpmhpd: Add RPMh power domain driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/soc/qcom/rpmhpd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 5741ec3fa814..51850cc68b70 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -93,6 +93,7 @@ static struct rpmhpd sdm845_mx = {
 
 static struct rpmhpd sdm845_mx_ao = {
 	.pd = { .name = "mx_ao", },
+	.active_only = true,
 	.peer = &sdm845_mx,
 	.res_name = "mx.lvl",
 };
@@ -107,6 +108,7 @@ static struct rpmhpd sdm845_cx = {
 
 static struct rpmhpd sdm845_cx_ao = {
 	.pd = { .name = "cx_ao", },
+	.active_only = true,
 	.peer = &sdm845_cx,
 	.parent = &sdm845_mx_ao.pd,
 	.res_name = "cx.lvl",
-- 
2.21.0.rc0.258.g878e2cd30e-goog

