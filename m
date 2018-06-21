Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB75BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7400120837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7400120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbeFUBy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:54:59 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37804 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754482AbeFUBxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:53:07 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so757577plc.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 18:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7mLXk9XGcsGFVtc4LKgOH9RyojB6kZ2OEsie7HqwiHI=;
        b=rNnz6PlNFjPHtuCFI4G/4WdH1P1WqgGkkSNuyxIJlU3C6+usJMQzDoOH0vlROK5Qwa
         FOHkuQ3CMutJdvPYNYzBzVcXxOQzGwtPpZuqsT/Mv1O35uaBIr+uIEhxq72OhDAwdAHK
         BXo8YjrNxnKuGdecgkdz4ocCEfPVnSMGBgZylYOuJG8iSf2cM3oW0Bt45kbGdFnfHr2y
         XXMcZdgQ10SXpAvnLIKfxLGWQZ4CE7PYuo/tgQnJIGV7eCOHPqhphI766diTrmKf6ldh
         keZFthBnqj0R/Dc0xO5vEKJ57bbE27lq2HhuxuZwo5kbAoRkodSYMMwjWVDLffztmwt8
         V7kw==
X-Gm-Message-State: APt69E367+59eUqlpthmGAwvAEN4boTXy+RQ/0VgDBXKsXMYJAPh76vT
        yS0k71IYLScmr1MednOKRHy+QA==
X-Google-Smtp-Source: ADUXVKJ1rCaF8GqaE/XjZFRcv1q3S/zE1Ztq7SLQS+J1317A84RYDnG5WZjiAqAvR+in1AO3QEjBIw==
X-Received: by 2002:a17:902:7891:: with SMTP id q17-v6mr26721544pll.186.1529545986654;
        Wed, 20 Jun 2018 18:53:06 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id p12-v6sm6585877pfi.175.2018.06.20.18.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 18:53:05 -0700 (PDT)
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
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 09/12] dt-bindings: PM / OPP: add opp-throttlers property
Date:   Wed, 20 Jun 2018 18:52:34 -0700
Message-Id: <20180621015237.100100-10-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180621015237.100100-1-mka@chromium.org>
References: <20180621015237.100100-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The optional opp-throttlers property is used to configure the throttlers
(see drivers/misc/throttler/*) that use a given OPP to throttle the
corresponding device(s).

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---
Changes in v4:
- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag

Changes in v3:
- none

Changes in v2:
- patch added to series
---
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
2.18.0.rc2.346.g013aa6912e-goog

