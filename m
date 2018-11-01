Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0362C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A70E20821
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1Q5BWRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A70E20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeKAJsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:48:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52215 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKAJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:48:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so3762wmc.1;
        Wed, 31 Oct 2018 17:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WXxxxa1VOZ31ZmlZgqX6lLyj4zgqAZ/vMdlhyLpQW9M=;
        b=O1Q5BWRdSrJxotDZFurLaIov6qzgw7GdA0M5vBDNI1bHdVaiQ9cqxqFEFlVjz90DIG
         6F71H9G4d+XG4ThZqkiyRzvLlAM9irf+XHGeLCOEvMxBNpEzud1+1/AyZ+Dz8Fktigk1
         wnnFCEwVMk4Q2LPekwkjullam3njbkER9TD73nnCnIgiPQpvpFF2aC7l4UnHGufxVr83
         05GLeitYU9u4W3iXvyBcj0WHGmhoR8fU6AHXCtORAK8DI0spKXG35LS2OP/QA7ZchWUb
         p8YYwfE5ieaYRflVSmF1RRlAOikbvIxtt7nwTeWr5VB9Or9bQ7iP4rX5nbVCocMeqe5m
         0O2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WXxxxa1VOZ31ZmlZgqX6lLyj4zgqAZ/vMdlhyLpQW9M=;
        b=Z5R2nwW38esJmvz1S3tHEbrFnQJHdzRLhUjAT6/HZ6q+4OfOX6uaSYtrYKfk00bLzo
         j1/hnT8GCYdVcdPZb6lv/7hsXPAJBhUcLmpCPCB7wR5+SAv3R/Ii6BzWBfHotWO4hOmO
         uUuW1ske3Efzqwz1QeZgs7uBR0uz2EI4RIdIKR5gYGYiuDJWNvTvTUovNfUk9K/lxDob
         OpaYfHqC5s6+X/oezEXXoJkdMPY9wksZIVliGRpERPepHBNdPxx2LJRbQanGMAdzX4P0
         gxGeG/DAG1SSLO5pyo25i40qL4ev0eoI3Cd4cMM3VNdFDD5oFGeUvbzcOugH0LqKPAQE
         BcxA==
X-Gm-Message-State: AGRZ1gLxYAYCMKvP8j1MTi+YeefZy2+PwYiig9/+jD4EVkSSLPZsnx86
        PS6At7um41HPRFarL9CQYF8=
X-Google-Smtp-Source: AJdET5fi0txnkQD5Ls1JkYR5EqYHHDrZ+T6EKayKsfwtrvgDb8UR8mi5ShfYTqR6nhb5hF4tBriutw==
X-Received: by 2002:a1c:ab0a:: with SMTP id u10-v6mr3963689wme.55.1541033253381;
        Wed, 31 Oct 2018 17:47:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id u5-v6sm8184091wrm.77.2018.10.31.17.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:47:32 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] pinctrl: bcm2835: Use define directive for BCM2835_PINCONF_PARAM_PULL
Date:   Wed, 31 Oct 2018 17:46:54 -0700
Message-Id: <20181101004653.7552-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another:

drivers/pinctrl/bcm/pinctrl-bcm2835.c:707:40: warning: implicit
conversion from enumeration type 'enum bcm2835_pinconf_param' to
different enumeration type 'enum pin_config_param' [-Wenum-conversion]
        configs[0] = pinconf_to_config_packed(BCM2835_PINCONF_PARAM_PULL, pull);
                     ~~~~~~~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.

It is expected that pinctrl drivers can extend pin_config_param because
of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
isn't an issue. Most drivers that take advantage of this define the
PIN_CONFIG variables as constants, rather than enumerated values. Do the
same thing here so that Clang no longer warns.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index fa530913a2c8..b035c3fc0471 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -72,10 +72,8 @@
 #define GPIO_REG_OFFSET(p)	((p) / 32)
 #define GPIO_REG_SHIFT(p)	((p) % 32)
 
-enum bcm2835_pinconf_param {
-	/* argument: bcm2835_pinconf_pull */
-	BCM2835_PINCONF_PARAM_PULL = (PIN_CONFIG_END + 1),
-};
+/* argument: bcm2835_pinconf_pull */
+#define BCM2835_PINCONF_PARAM_PULL	(PIN_CONFIG_END + 1)
 
 struct bcm2835_pinctrl {
 	struct device *dev;
-- 
2.19.1

