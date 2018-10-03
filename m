Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCF2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6031221473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6031221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeJDFRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:17:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35532 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeJDFRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:17:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id 22-v6so4911308oiz.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 15:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yhDr8GpTPG9SCVPhbs7VxthD0v0Nqb319Et9tn5oaRs=;
        b=hu7Fyge4u5iYLzZtn3f9FM8c7NuO9ge210a8f4rN0+Byai2B9Kg3akq5KhlWx7smfP
         vQz79c+1qiy+vn9JmQhBGt6ehRgbz1T8w700YaYPs7aYhovYZUM7bYzhGSwuPc8YE84O
         SlyOjWlCnZb6w1m38BqOBhgz3+KmOV32cIJHcy1Ji2EosFUwi8KB+bpfAzec6uMayCgM
         fv6XXrgahsVm/L0y9SHSn1evjobgNJWhfJpL4i8wFsHLcY3VDkAAKeBFEokKeU8W7IoQ
         PIft4cVkkki5/F+i5VuwOJ+MNjeRhFb1JlhgZ4tB63fNIVWykW304z00XzfHwtNm1fbF
         7OEA==
X-Gm-Message-State: ABuFfog8TxpVY1R5tmi4o7CBfMKP41DF187jEnzPo98oGLEEz8PU0sBc
        RovMrvu51MWoVao+JqqLMYuYkxQduQ==
X-Google-Smtp-Source: ACcGV60NOmcyKC/cSxoUx8s/Sg4K4S2dzUyoHEGcQv4zlRCeKmb7ftl9NMFi/yy6TGvCgyCCzd1prQ==
X-Received: by 2002:aca:5053:: with SMTP id e80-v6mr1632052oib.352.1538605637282;
        Wed, 03 Oct 2018 15:27:17 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j79-v6sm1542469oiy.13.2018.10.03.15.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 15:27:16 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH] Add a skeleton Travis-CI config
Date:   Wed,  3 Oct 2018 17:27:15 -0500
Message-Id: <20181003222715.28667-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's convenient to use Travis-CI for doing kernel builds. Doing so
requires a github repo, Travis-CI enabled for that repo, and a
.travis.yml file in the repository. This commit addresses the last part.
Each repository branch must have a .travis.yml file in order to run
Travis-CI jobs.

Obviously, we can't create a single configuration that works for
everyone as every developer will want to run different configs and
build targets. Therefore, this only adds a skeleton .travis.yml file.
With this a user can either set $CONFIG and $TARGET in their Travis-CI
environment or customized builds can be triggered remotely.

Here's an example of setting up a matrix build of different
architectures:

body='{
  "request": {
    "branch": "master",
    "config" : {
      "env": {
        "global": "CONFIG=defconfig TARGET=all",
        "matrix": [
          "ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-",
          "ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-",
          "ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-"
        ]
      }
    }
  }
}'

curl -s -X POST \
   -H "Content-Type: application/json" \
   -H "Accept: application/json" \
   -H "Travis-API-Version: 3" \
   -H "Authorization: token $TOKEN" \
   -d "$body" \
   https://api.travis-ci.org/repo/robherring%2Flinux/requests

Additionally, it is possible to override 'scripts' or any other part of
the config as well.

Signed-off-by: Rob Herring <robh@kernel.org>
---
I'm wondering if there's other interest in this. If so, please chime in.

Maybe I should be looking at Gitlab CI instead, but Travis I know 
already and Gitlab just seems to be the shiniest new thing. In any case, 
both could coexist.

Rob

 .travis.yml | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 000000000000..ba1e59dd44f6
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,23 @@
+language: c
+
+sudo: false
+dist: trusty
+
+cache:
+  apt: true
+
+env:
+  - CONFIG=allnoconfig TARGET=all
+
+addons:
+  apt:
+    packages:
+      - build-essential
+      - bc
+      - gcc-arm-linux-gnueabihf
+      - gcc-aarch64-linux-gnu
+      - gcc-powerpc-linux-gnu
+
+script:
+  - make $CONFIG
+  - make $TARGET
-- 
2.17.1

