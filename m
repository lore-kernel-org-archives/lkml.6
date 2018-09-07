Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33AEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627C620645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627C620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeIHB7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:59:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42784 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbeIHB7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:59:42 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B9C56F07;
        Fri,  7 Sep 2018 21:16:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lihua Yao <ylhuajnu@163.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.18 089/145] ALSA: ac97: fix device initialization in the compat layer
Date:   Fri,  7 Sep 2018 23:09:15 +0200
Message-Id: <20180907210911.395027770@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lihua Yao <ylhuajnu@163.com>

commit c7b8170790c19293acd835dc50b8247ec207d4a3 upstream.

ac97->dev is an object of 'struct device' type. It should be initialized
via device_initialize() or device_register().

Fixes: 74426fbff66e ("ALSA: ac97: add an ac97 bus")
Signed-off-by: Lihua Yao <ylhuajnu@163.com>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/ac97/snd_ac97_compat.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/sound/ac97/snd_ac97_compat.c
+++ b/sound/ac97/snd_ac97_compat.c
@@ -15,6 +15,11 @@
 
 #include "ac97_core.h"
 
+static void compat_ac97_release(struct device *dev)
+{
+	kfree(to_ac97_t(dev));
+}
+
 static void compat_ac97_reset(struct snd_ac97 *ac97)
 {
 	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
@@ -65,21 +70,31 @@ static struct snd_ac97_bus compat_soc_ac
 struct snd_ac97 *snd_ac97_compat_alloc(struct ac97_codec_device *adev)
 {
 	struct snd_ac97 *ac97;
+	int ret;
 
 	ac97 = kzalloc(sizeof(struct snd_ac97), GFP_KERNEL);
 	if (ac97 == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	ac97->dev = adev->dev;
 	ac97->private_data = adev;
 	ac97->bus = &compat_soc_ac97_bus;
+
+	ac97->dev.parent = &adev->dev;
+	ac97->dev.release = compat_ac97_release;
+	dev_set_name(&ac97->dev, "%s-compat", dev_name(&adev->dev));
+	ret = device_register(&ac97->dev);
+	if (ret) {
+		put_device(&ac97->dev);
+		return ERR_PTR(ret);
+	}
+
 	return ac97;
 }
 EXPORT_SYMBOL_GPL(snd_ac97_compat_alloc);
 
 void snd_ac97_compat_release(struct snd_ac97 *ac97)
 {
-	kfree(ac97);
+	device_unregister(&ac97->dev);
 }
 EXPORT_SYMBOL_GPL(snd_ac97_compat_release);
 


