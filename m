Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A637FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9742133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbfB0OQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:16:03 -0500
Received: from mx1.emlix.com ([188.40.240.192]:58876 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729848AbfB0OQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:16:02 -0500
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2019 09:16:02 EST
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id B64EE60959;
        Wed, 27 Feb 2019 15:10:28 +0100 (CET)
From:   Philipp Puschmann <philipp.puschmann@emlix.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, peter.ujfalusi@ti.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH] ASoC: tlv320aix3x: fix reset gpio reference counting
Date:   Wed, 27 Feb 2019 15:10:19 +0100
Message-Id: <20190227141019.16027-1-philipp.puschmann@emlix.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug that prevents freeing the reset gpio on unloading
the module.

aic3x_i2c_probe is called when loading the module and it calls list_add
with a probably uninitialized list entry aic3x->list (next = prev = NULL)).
So even if list_del is called it does nothing and in the end the gpio_reset
is not freed. Then a repeated module probing fails silently because
gpio_request fails.

When moving INIT_LIST_HEAD to aic3x_i2c_probe we also have to move
list_del to aic3x_i2c_remove because aic3x_remove may be called
multiple times without aic3x_i2c_remove being called which leads to
a NULL pointer dereference.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
---
 sound/soc/codecs/tlv320aic3x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6aa0edf8c5ef..cea3ebecdb12 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1609,7 +1609,6 @@ static int aic3x_probe(struct snd_soc_component *component)
 	struct aic3x_priv *aic3x = snd_soc_component_get_drvdata(component);
 	int ret, i;
 
-	INIT_LIST_HEAD(&aic3x->list);
 	aic3x->component = component;
 
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++) {
@@ -1692,7 +1691,6 @@ static void aic3x_remove(struct snd_soc_component *component)
 	struct aic3x_priv *aic3x = snd_soc_component_get_drvdata(component);
 	int i;
 
-	list_del(&aic3x->list);
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		regulator_unregister_notifier(aic3x->supplies[i].consumer,
 					      &aic3x->disable_nb[i].nb);
@@ -1890,6 +1888,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		goto err_gpio;
 
+	INIT_LIST_HEAD(&aic3x->list);
 	list_add(&aic3x->list, &reset_list);
 
 	return 0;
@@ -1906,6 +1905,8 @@ static int aic3x_i2c_remove(struct i2c_client *client)
 {
 	struct aic3x_priv *aic3x = i2c_get_clientdata(client);
 
+	list_del(&aic3x->list);
+
 	if (gpio_is_valid(aic3x->gpio_reset) &&
 	    !aic3x_is_shared_reset(aic3x)) {
 		gpio_set_value(aic3x->gpio_reset, 0);
-- 
2.20.1

