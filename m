Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A558C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44E620675
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Y6wBmBrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbeL0Wzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:55:32 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:43316 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbeL0Wzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:55:32 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:34b6::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id A2EB75C0089;
        Thu, 27 Dec 2018 23:55:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1545951330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=R4tg3g4n1RdHsLdfnq8nK362b7ENi8WNhkDpTtH1qCg=;
        b=Y6wBmBrGEvgQyVBnh930CxaxKJH//NVnhW0pskpOVIJ9+9JH91dAnghuGducc9ST+AokPA
        nGCZMejd+5jpxFUa2nzQWAOgvLenerK+B0xd8HI3HNxLTjN6aItL99WrUj3QmievLSWUco
        Cb43Yj5bnPU3/tl9jy4B868OxlC+p4w=
From:   Stefan Agner <stefan@agner.ch>
To:     bjorn.andersson@linaro.org, robdclark@gmail.com
Cc:     jonathan@marek.ca, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] firmware: qcom: scm: add error include
Date:   Thu, 27 Dec 2018 23:55:27 +0100
Message-Id: <1aacb9e81111ce0cb45b95dcbd80b86296484c20.1545950884.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some configurations the preprocessor define ENODEV is missing
leading to compile time errors (e.g. when using imx_v6_v7_defconfig).

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
I noticed while compiling todays master branch with imx_v6_v7_defconfig:

In file included from drivers/gpu/drm/msm/adreno/a5xx_gpu.c:17:
./include/linux/qcom_scm.h:73:10: error: use of undeclared identifier 'ENODEV'
        return -ENODEV;
                ^

I think this only got uncovered due to e6f6d63ed14c ("drm/msm: add headless
gpu device for imx5") but it seems to be a missing include already before that
commit.

--
Stefan


 include/linux/qcom_scm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 06996ad4f2bc..ce5a476fd733 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -13,6 +13,7 @@
 #ifndef __QCOM_SCM_H
 #define __QCOM_SCM_H
 
+#include <linux/err.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
 
-- 
2.20.1

