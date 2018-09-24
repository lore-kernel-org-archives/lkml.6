Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E797ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6BB214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6BB214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389175AbeIXSqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:46:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388717AbeIXSqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:46:33 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 34109109A;
        Mon, 24 Sep 2018 12:44:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Carlo Caione <carlo@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 219/235] ASoC: rt5651: Fix workqueue cancel vs irq free race on remove
Date:   Mon, 24 Sep 2018 13:53:25 +0200
Message-Id: <20180924113125.312769220@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 8d2d7bcdc1645dc243f7735278675b083c0e506c ]

On removal we must free the IRQ *before* cancelling the jack-detect work,
so that the jack-detect work cannot be rescheduled by the IRQ.

Before this commit we were cancelling the jack-detect work from the
driver remove callback, while relying on devm to free the IRQ, which
happens after the remove callback.

This is the wrong order. This commit uses a devm-action to register
a devm callback which cancels the work, before requesting the IRQ
(devm tears things down in reverse order). This also allows us to
remove the now empty remove driver callback.

Cc: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/rt5651.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1696,6 +1696,13 @@ static irqreturn_t rt5651_irq(int irq, v
 	return IRQ_HANDLED;
 }
 
+static void rt5651_cancel_work(void *data)
+{
+	struct rt5651_priv *rt5651 = data;
+
+	cancel_work_sync(&rt5651->jack_detect_work);
+}
+
 static int rt5651_set_jack(struct snd_soc_component *component,
 			   struct snd_soc_jack *hp_jack, void *data)
 {
@@ -2036,6 +2043,11 @@ static int rt5651_i2c_probe(struct i2c_c
 
 	INIT_WORK(&rt5651->jack_detect_work, rt5651_jack_detect_work);
 
+	/* Make sure work is stopped on probe-error / remove */
+	ret = devm_add_action_or_reset(&i2c->dev, rt5651_cancel_work, rt5651);
+	if (ret)
+		return ret;
+
 	ret = devm_snd_soc_register_component(&i2c->dev,
 				&soc_component_dev_rt5651,
 				rt5651_dai, ARRAY_SIZE(rt5651_dai));
@@ -2043,15 +2055,6 @@ static int rt5651_i2c_probe(struct i2c_c
 	return ret;
 }
 
-static int rt5651_i2c_remove(struct i2c_client *i2c)
-{
-	struct rt5651_priv *rt5651 = i2c_get_clientdata(i2c);
-
-	cancel_work_sync(&rt5651->jack_detect_work);
-
-	return 0;
-}
-
 static struct i2c_driver rt5651_i2c_driver = {
 	.driver = {
 		.name = "rt5651",
@@ -2059,7 +2062,6 @@ static struct i2c_driver rt5651_i2c_driv
 		.of_match_table = of_match_ptr(rt5651_of_match),
 	},
 	.probe = rt5651_i2c_probe,
-	.remove   = rt5651_i2c_remove,
 	.id_table = rt5651_i2c_id,
 };
 module_i2c_driver(rt5651_i2c_driver);


