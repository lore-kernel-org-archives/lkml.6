Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C341AECDFBE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7132920856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7132920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeGTIrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:47:01 -0400
Received: from mout.perfora.net ([74.208.4.197]:38491 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbeGTIrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:47:00 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MVbnF-1fWtBy0o75-00YzqJ; Fri, 20 Jul 2018 09:54:53 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpiolib: probe deferral error reporting
Date:   Fri, 20 Jul 2018 09:54:49 +0200
Message-Id: <20180720075449.26711-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:JZfsHQH6kQP/23xv3E2RyeDwCS2vqwpf3MGxt/CBAQEX9E7KJWS
 v6jLt7dfX6e0Ei/jGKJu5Rr8NeFbmieCTKwzUqU+eFy4vWs32sc9EKobkAw3pNxCJ2aJIJj
 z+okW5VcZdIEocRj6WWpcAxCqBMdXg3Q4pkDlRlAw9xAeM0pL2ION379AlmWBCr80Tv/4im
 wwivad+LpSXQUh2RxGQ6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k9w3p1WVGcw=:0RWdi+zIUQ1B0+5/ERZgaB
 iCehylk+tRzdmVkg8eLdN13bOohD+2Qg1Euf1vbRu4SKLjPL9mWx65VvIQctyXYGp82rw38RO
 ajeAyzqZnz3owrG0fmujZVluHqWMQUtTlHLTbBEqknwn0G8CsCBL5zI4hWsEii70OkA2zeWKb
 HE9lAAWISYzHx8GI+foRxZNCMDW52Qws6TW/ms/kAsbD5aix4Q+x/Sk3BYMSmRzNlw6oJLiP2
 esMWECEi648/pNcDbC9cVHEe/8WTyfExK/qzcCzu8m4anB9kgElT4rj5QPVGcp70wq1/SzWaZ
 y01Se9kACZflD/RSgIOO+i54RrlBvlHLIQFdFKrhELlXnm3VviFXgsy6SO5loe5gEF1eB78KO
 jmhoqFzsrmhZOCCg07ztE7oEcxhtPIYO83nQw2dJoF4iJPAO289HBBgO8k56sgJAfkzD/oGlf
 CNEFYFoiDYLhJw/EdnMwv6zUDmPCt+WxX8mRMWxy6krnYsh/3AlVYYY19/u0Fp2WZBa/qYWzl
 5dO/M8jk2LNIddG4HPv4XfxPBtguYXSx/4qc8wPAqcw7ubR7Zc8faYobBbkb2NxC+xloliB82
 fZiS6mTXpv3h1yTckhvqSfZ4IK5jWrk89VUfqfMI4rVUP//NeahMIsGGWB/yhojTgj0lxVbBJ
 kvGaGXDDN/QZYmMld+IWHvcOtiduRLOxKbPMS1km1jAwYxaCExPKz2djKfgVoxoPn9hQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Actually report the error code from devm_regulator_get() which may as
well just be a probe deferral.

This is e.g. what one gets upon booting a Colibri T20:

gpiochip_add_data_with_key: GPIOs 0..223 (tegra-gpio) failed to register

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/gpio/gpiolib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 2e2a6f8db405..40c65eb1d97b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1408,9 +1408,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 err_free_gdev:
 	ida_simple_remove(&gpio_ida, gdev->id);
 	/* failures here can mean systems won't boot... */
-	pr_err("%s: GPIOs %d..%d (%s) failed to register\n", __func__,
+	pr_err("%s: GPIOs %d..%d (%s) failed to register, %d\n", __func__,
 	       gdev->base, gdev->base + gdev->ngpio - 1,
-	       chip->label ? : "generic");
+	       chip->label ? : "generic", status);
 	kfree(gdev);
 	return status;
 }
-- 
2.14.4

