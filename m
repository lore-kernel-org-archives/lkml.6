Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 96566C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CD8208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CD8208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755518AbeFNTsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:48:30 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35182 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936120AbeFNTrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:47:36 -0400
Received: by mail-pf0-f194.google.com with SMTP id c22-v6so3741162pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 12:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W7gMkBZ+YLQx2v3DMkvip+RobYFjRgj5Td2HVhtIWJs=;
        b=IHQBIeabsyRs4gvJDiWQINGEnd/H59bXcDB46JOtFicvpgqEGu0LBKVh2vHxvscav1
         qvJXfsTWBtolU+od+i0fYhj+I92LJjCsSd75TRO/JFXZrvfj+Gj/tRdwrO6xvyevEj0r
         cQlM/OXZOfcThYNBaw6encQDSziX0zBJ9icvxAic+VP0/PtMucEyHuP/+Qf2VQko/QcO
         vIIeSZaTQV/bt9HbzepPd1zxEbCMWvqa9q7tO0fSIRANgZoxNElFnNOQ0In8L6TKU2uu
         xa9fNjYne4PDUNzQFF8urnAf3nOcPAW+0wZC8BUiTlMD7ZRTjSfQzYqdgMfy2WRv4Eec
         afnw==
X-Gm-Message-State: APt69E1jlh+VAgsKBB7RqtBKTXX6esUbelLmztUA1T+KiTcLAzlI7sk8
        46/ZZ8Ib5+7VUjrBBwrySwGppw==
X-Google-Smtp-Source: ADUXVKLz7NYYe6x8dRdxto+UQtufnDAG1pe33SpjESfSSneRtKkNvC/g8MwZmWbr4f0EONW9lXHuRA==
X-Received: by 2002:a62:f5da:: with SMTP id b87-v6mr10916245pfm.113.1529005655316;
        Thu, 14 Jun 2018 12:47:35 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id s28-v6sm9955506pfg.89.2018.06.14.12.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 12:47:34 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 09/12] dt-bindings: PM / OPP: add opp-throttlers property
Date:   Thu, 14 Jun 2018 12:47:09 -0700
Message-Id: <20180614194712.102134-10-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180614194712.102134-1-mka@chromium.org>
References: <20180614194712.102134-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The optional opp-throttlers property is used to configure the throttlers
(see drivers/misc/throttler/*) that use a given OPP to throttle the
corresponding device(s).

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- none

Changes in v2:
- patch added to series

 Documentation/devicetree/bindings/opp/opp.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index c396c4c0af92..747e79740c75 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -170,6 +170,9 @@ Optional properties:
   functioning of the current device at the current OPP (where this property is
   present).
 
+- opp-throttlers: Array with phandles of throttlers that use this OPP to
+  throttle the corresponding device(s).
+
 Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
 
 / {
-- 
2.18.0.rc1.242.g61856ae69a-goog

