Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6AEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A32520870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfAVVS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:18:29 -0500
Received: from mleia.com ([178.79.152.223]:58436 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfAVVS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:18:28 -0500
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 329A543803A;
        Tue, 22 Jan 2019 21:18:27 +0000 (GMT)
From:   Vladimir Zapolskiy <vz@mleia.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Meunier <laurent.meunier@st.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@arm.linux.org.uk>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 1/2] pinctrl: remove pinctrl/machine.h inclusion from pinctrl/pinconf.h
Date:   Tue, 22 Jan 2019 23:18:21 +0200
Message-Id: <20190122211822.7016-2-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122211822.7016-1-vz@mleia.com>
References: <20190122211822.7016-1-vz@mleia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190122_211827_226530_5F9F1459 
X-CRM114-Status: GOOD (  12.94  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change adds explicit inclusion of linux/pinctrl/machine.h header
to the only needed pinctrl-madera-core.c file, and therefore inclusion
of pinctrl/machine.h header from pinctrl/pinconf.h can be removed.

The change is preparatory to a follow-up reversal of commit f07512e615dd
("pinctrl/pinconfig: add debug interface").

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes from v1 to v2:
* new change to mitigate a compile time warning caused by a removal of
  implicit header inclusion, the issue was reported against v1 change.

This change might be percepted as a bit awkward, but I leave a room to
extend it to other drivers, if it becomes needed. However apparently
only pinctrl/cirrus/pinctrl-madera-core.c misses explicit inclusion of
linux/pinctrl/machine.h header.

 drivers/pinctrl/cirrus/pinctrl-madera-core.c | 1 +
 include/linux/pinctrl/pinconf.h              | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-madera-core.c b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
index a5dda832024a..7c9694593f79 100644
--- a/drivers/pinctrl/cirrus/pinctrl-madera-core.c
+++ b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/pinconf.h>
diff --git a/include/linux/pinctrl/pinconf.h b/include/linux/pinctrl/pinconf.h
index 8dd85d302b90..109468d9d849 100644
--- a/include/linux/pinctrl/pinconf.h
+++ b/include/linux/pinctrl/pinconf.h
@@ -14,8 +14,6 @@
 
 #ifdef CONFIG_PINCONF
 
-#include <linux/pinctrl/machine.h>
-
 struct pinctrl_dev;
 struct seq_file;
 
-- 
2.20.1

