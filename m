Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E85ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0815720821
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCbzQCBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0815720821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeKAJvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:51:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36220 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKAJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:51:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so18431492wrw.3;
        Wed, 31 Oct 2018 17:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=elhL0t24i1GZH+SZfawbIZBbXA5PcdMgeFMS8KsTaO4=;
        b=OCbzQCBCn7InzrybJhEYuTvzd9uvsInIUYuMlu+c270UPLNAP8UwhSYVL3mLeCVnLo
         g6byHqAG1tmKDfPquF69r9kfyFqPS9zhlP5WHuatKWtzDvxFNHrvwBG9QN63MipwB9Hg
         NUxaz00wqBl7PJjWMkgB5cmvJ9kGMlQn4DBz9wyOjbx/3JtR/p+svYHThnd1+8ufqfbG
         81htQzihIniPFOw2qQzNppcG972dXx/IizrQu1nR679JC4aAYxAQy8bGxRuOyLvEWaZh
         Z4WDuGYFjbPwnPsOWfoLWlMpANL+Ehk4JM/HRb1BgOoUX7FIvhhyVacVbRf4tTscnYBr
         Ej4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=elhL0t24i1GZH+SZfawbIZBbXA5PcdMgeFMS8KsTaO4=;
        b=hq2hMtfyh6Wr9y22pE49Cdqoqy38a1LD/75lZ3Es4aj1N1q/qCh/ULCVZ8fbqB4G8h
         KGYhCUPs+gSdZdeC1W8syyl7Pe/D5fDTsycONyB/RzZMDSpXl8KzbRNpkE2bA++Kh0rg
         nYJSCiaN6ClpQfzqRN71C6Gro6OQso8Rzyu9xhhzqqc36bfa+L1dUHdrJXWdMnkrdzES
         tNoDl6ICQy3jQhGqtMGbWxX0Eeh/U/0j1SVyK+RpoZPWu1eLptOuCzDKzVI2mQWMRCf/
         aU19orvHRjEq0IBNZHMfsEmLFHAPiRBCew2PTj1LtVeami6BeZfDbCC1usCDkYpkk/97
         sjig==
X-Gm-Message-State: AGRZ1gLbQSbHX94XH4B5OWQLAhsmqv+60JYApcWogpVQHpsue4nLaHzs
        WOTjHqIsen7H5dCUUG21tl8=
X-Google-Smtp-Source: AJdET5dYq36fk/afA9UKJNJ77wSjCJljh+SIKSn6zYF7KfF0nGh9QI1CRYt8UO5cFUpcc4H3rUwhDA==
X-Received: by 2002:adf:c608:: with SMTP id n8-v6mr4840162wrg.174.1541033469237;
        Wed, 31 Oct 2018 17:51:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id q190-v6sm31915587wmg.40.2018.10.31.17.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:51:08 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] pinctrl: max77620: Use define directive for max77620_pinconf_param values
Date:   Wed, 31 Oct 2018 17:50:21 -0700
Message-Id: <20181101005021.8393-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another:

drivers/pinctrl/pinctrl-max77620.c:56:12: warning: implicit conversion
from enumeration type 'enum max77620_pinconf_param' to different
enumeration type 'enum pin_config_param' [-Wenum-conversion]
                .param = MAX77620_ACTIVE_FPS_SOURCE,
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~

It is expected that pinctrl drivers can extend pin_config_param because
of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
isn't an issue. Most drivers that take advantage of this define the
PIN_CONFIG variables as constants, rather than enumerated values. Do the
same thing here so that Clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/139
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pinctrl/pinctrl-max77620.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-max77620.c b/drivers/pinctrl/pinctrl-max77620.c
index a7f37063518e..3d05bc1937d4 100644
--- a/drivers/pinctrl/pinctrl-max77620.c
+++ b/drivers/pinctrl/pinctrl-max77620.c
@@ -34,14 +34,12 @@ enum max77620_pin_ppdrv {
 	MAX77620_PIN_PP_DRV,
 };
 
-enum max77620_pinconf_param {
-	MAX77620_ACTIVE_FPS_SOURCE = PIN_CONFIG_END + 1,
-	MAX77620_ACTIVE_FPS_POWER_ON_SLOTS,
-	MAX77620_ACTIVE_FPS_POWER_DOWN_SLOTS,
-	MAX77620_SUSPEND_FPS_SOURCE,
-	MAX77620_SUSPEND_FPS_POWER_ON_SLOTS,
-	MAX77620_SUSPEND_FPS_POWER_DOWN_SLOTS,
-};
+#define MAX77620_ACTIVE_FPS_SOURCE		(PIN_CONFIG_END + 1)
+#define MAX77620_ACTIVE_FPS_POWER_ON_SLOTS	(PIN_CONFIG_END + 2)
+#define MAX77620_ACTIVE_FPS_POWER_DOWN_SLOTS	(PIN_CONFIG_END + 3)
+#define MAX77620_SUSPEND_FPS_SOURCE		(PIN_CONFIG_END + 4)
+#define MAX77620_SUSPEND_FPS_POWER_ON_SLOTS	(PIN_CONFIG_END + 5)
+#define MAX77620_SUSPEND_FPS_POWER_DOWN_SLOTS	(PIN_CONFIG_END + 6)
 
 struct max77620_pin_function {
 	const char *name;
-- 
2.19.1

