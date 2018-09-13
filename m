Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ACCC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9845E20861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZHF82xJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9845E20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeINDnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:43:17 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:49013 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbeINDnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:43:17 -0400
Received: by mail-pl1-f201.google.com with SMTP id bh1-v6so3296914plb.15
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 15:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=S+oLy1i9WomBzWLyCwBGFOwZ+XnhzaGC5nebu3J/cqI=;
        b=ZHF82xJPrjNVQ5qaoqwMUDqr6EdB+cndsZEWHlrAB6aETmK44XmP7OFf08GYNsUlbe
         Dji42D6nlptLFf1lohqP5KarkrI8ALKA2xgcdLwPlXwIOjfDJsIHwgcomwT727X6d2rf
         LuD1NCo1F7/NLZpHmLkn34zKyKvRqkwWr+y3F3gZ3SJOYpOVoU+iCumsx2cZGyw6qJ++
         MAuYaFmvXyy69vmcROAKnwsQcoQAl+vC74bPSxMH7kyAWJNdE/maIUeUux7i4MXK9O50
         m5svrHSjKugBUoxfraWwHTSRmaw/CCnBDfCIANza21IbZyX2eYyoR+AXGOtW8A49Cnwg
         YpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=S+oLy1i9WomBzWLyCwBGFOwZ+XnhzaGC5nebu3J/cqI=;
        b=HEMN3zKy/DWstMw1LDqjenZQ6TbIikfhN7kpFDSuO0i2XavPohNr8+Jad1p9IKOLyB
         KGdo12kIk4VXZEhkociROksEo4d2uiDIqZJHGfG2ibZU234yPT+l4oH6nVbKCs+QU+fe
         +QrgC8SLUjv5LYyBBGYyQU3Gt1G60hlAdTeJRrpnQNuIiFMpAJyNfItp20e/Nypwr63B
         5tM/D6UW33HTNNmajQwRQh87pVMSyBB8m45DqFvlylvNvLHJhGIAfI15GKDhH618EewO
         66dWv5AjKSsTVg0hTOS2N/iO/zC6ZNAXnWZloc+F0zkV0+TBhuU+Oy+xTgRse7gedEsN
         VPvg==
X-Gm-Message-State: APzg51DLwIFp7DBklUFeLAuEcTesmksDeO7GgVSnoYjexsZ+y5gglAD/
        ckBQKL5JoF+QgXmh+Wbpuu1e8eKa7L+K
X-Google-Smtp-Source: ANB0VdbReS/UgjWcRw5n9KAo6p11Mj1GeCj14mO3qqklLfFwOD42ED5qd2H0QQtKnVIPG0Xl1JHYWcvTdBkD
X-Received: by 2002:a63:2057:: with SMTP id r23-v6mr585534pgm.18.1536877908229;
 Thu, 13 Sep 2018 15:31:48 -0700 (PDT)
Date:   Thu, 13 Sep 2018 15:31:43 -0700
Message-Id: <20180913223143.12664-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH] pinctrl: icelake: Fix the resource number for community-4/5
From:   Rajat Jain <rajatja@google.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rajatxjain@gmail.com, subrata.banik@intel.com,
        aamir.bohra@intel.com, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Icelake does not have a community-3, and the memory resources are
laid out in the following order in the ACPI:

resource-0: community-0 registers
resource-1: community-1 registers
resource-2: community-2 registers
resource-3: community-4 registers
resource-4: community-5 registers

(EDS also describes the communities in the above order).

Since the pinctrl driver exposes communities 0, 1, 4, 5, it needs to get
the corresponding community registers by getting the resourse number right.
Currently the resourse number is not correct for community 4 and 5, thus
fix that.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pinctrl/intel/pinctrl-icelake.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-icelake.c b/drivers/pinctrl/intel/pinctrl-icelake.c
index 630b966ce081..5b4eaf7c90df 100644
--- a/drivers/pinctrl/intel/pinctrl-icelake.c
+++ b/drivers/pinctrl/intel/pinctrl-icelake.c
@@ -331,8 +331,8 @@ static const struct intel_padgroup icllp_community5_gpps[] = {
 static const struct intel_community icllp_communities[] = {
 	ICL_COMMUNITY(0, 0, 58, icllp_community0_gpps),
 	ICL_COMMUNITY(1, 59, 152, icllp_community1_gpps),
-	ICL_COMMUNITY(2, 153, 215, icllp_community4_gpps),
-	ICL_COMMUNITY(3, 216, 240, icllp_community5_gpps),
+	ICL_COMMUNITY(3, 153, 215, icllp_community4_gpps),
+	ICL_COMMUNITY(4, 216, 240, icllp_community5_gpps),
 };
 
 static const unsigned int icllp_spi0_pins[] = { 22, 23, 24, 25, 26 };
-- 
2.19.0.397.gdd90340f6a-goog

