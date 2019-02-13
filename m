Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EC9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA8320821
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="XFvnLqDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403904AbfBMLUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:20:17 -0500
Received: from mout01.posteo.de ([185.67.36.65]:43305 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbfBMLUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:20:16 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id CF41E160067
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 12:20:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1550056813; bh=zyNtugu09Cir8nAdzxml8i5heMXlpldt05kZODO2jr0=;
        h=From:To:Cc:Subject:Date:From;
        b=XFvnLqDTbzPwSCRahGdP7PCyjs88iggf5HPmGDqeSYPJp3BC8LFu45Ln1yBLeiglH
         1yCr2wFBSCwfGEfrwDkVzwuZbTZifyE58Zfsp9wRv2MSw9HzF2s37BnTkiIdneOBAL
         RLgq9cQns02vwztHH151RJCpwSU6otWWdkS7kKjjokKOqtFzhLddTlxTOv4z+pFn/Q
         9PdC+kT+pziXnuAun8ObqsMFREA50XbAdPT7tiUPiEkil7bjnReozK9ioBq9OjIBGA
         IWbLYn4Q6iQr6P14sgmnsht8Zhq/SbwGiTixUQmIqKtt/JOj2KgjKPrwnpDl1ffXkb
         ZPVjHalk5vPfQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43zxrr4Jcbz6tmK;
        Wed, 13 Feb 2019 12:20:12 +0100 (CET)
From:   Martin Kepplinger <martink@posteo.de>
To:     dmitry.torokhov@gmail.com, kuninori.morimoto.gx@renesas.com,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] Input: st1232 - include gpio/consumer.h header for gpiod_set_value_cansleep()
Date:   Wed, 13 Feb 2019 12:19:58 +0100
Message-Id: <20190213111958.9031-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <201902131841.xHSZ8Cvm%fengguang.wu@intel.com>
References: <201902131841.xHSZ8Cvm%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gpiod_set_value_cansleep() needs it's declaration in the corresponding
header. This fixes build errors like

   drivers/input/touchscreen/st1232.c: In function 'st1232_ts_power':
>> drivers/input/touchscreen/st1232.c:146:3: error: implicit declaration of
   function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'?
   [-Werror=implicit-function-declaration]
      gpiod_set_value_cansleep(ts->reset_gpio, !poweron);
      ^~~~~~~~~~~~~~~~~~~~~~~~
      gpio_set_value_cansleep

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

 drivers/input/touchscreen/st1232.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index 1fbc0847416b..f4b7a4f1c366 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-- 
2.20.1

