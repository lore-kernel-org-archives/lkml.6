Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117ADC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C809B20645
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C809B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeH1Fog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:36 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42944 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeH1Fof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:35 -0400
Received: by mail-oi0-f66.google.com with SMTP id q204-v6so1732153oig.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gK8MM28vtQVhs5d+zMPNeQcZkR43l0qBaO3NRVTRGUM=;
        b=dlFADSRdo1loNoVPcMbEPW3ZtwnAKnxL7StNo+IPivAQOoIxo1hHF6ELnab1A5sLdE
         Yyd0JVahKNBOXKBczPBM5QsD7i4bXXN9pa/XTHNKh6f1fZI0hciW73Ai+GzvZMWGB1NN
         kgPI0PfKfB01uoklqqOF3hZGbg5IQOF1yk0RrC4t8PfwWTDPV4S4J8xQ88RdRZU28D7c
         FUCeLpCsV2wHYd68sVW1dUKecnq75W9T0cSwg1AzxyspPnLcF2tvjxAg31Nse8JSDL6f
         QzH5aQ1EpY789TDSbTvWbLM6q+YfI35qgq+S6vormB21pNsNcRfxN79GRkaLL2y+8BTR
         eRFg==
X-Gm-Message-State: APzg51A4yAR8PfJ7+aqZyVB5nN/qeS6r8l/1G2xS3vzkELiNtG63QST4
        Qj6E2wRRD9YfG2WHEqvR8A3o9WM=
X-Google-Smtp-Source: ANB0VdaEUhcIlZLgO6rkWzzs1mWXpZIAsP/+RweQF4WLLPEGhnhINbMfsnFObROaBKmB9XcCnODKEw==
X-Received: by 2002:aca:d846:: with SMTP id p67-v6mr1181523oig.42.1535421319187;
        Mon, 27 Aug 2018 18:55:19 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:18 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org,
        alsa-devel@alsa-project.org
Subject: [PATCH] sound: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:51 -0500
Message-Id: <20180828015252.28511-50-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/aoa/soundbus/i2sbus/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 000b58522106..bf32e1c74748 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -157,18 +157,19 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 	struct device_node *child = NULL, *sound = NULL;
 	struct resource *r;
 	int i, layout = 0, rlen, ok = force;
-	static const char *rnames[] = { "i2sbus: %s (control)",
-					"i2sbus: %s (tx)",
-					"i2sbus: %s (rx)" };
+	char node_name[6];
+	static const char *rnames[] = { "i2sbus: %pOFn (control)",
+					"i2sbus: %pOFn (tx)",
+					"i2sbus: %pOFn (rx)" };
 	static irq_handler_t ints[] = {
 		i2sbus_bus_intr,
 		i2sbus_tx_intr,
 		i2sbus_rx_intr
 	};
 
-	if (strlen(np->name) != 5)
+	if (snprintf(node_name, sizeof(node_name), "%pOFn", np) != 5)
 		return 0;
-	if (strncmp(np->name, "i2s-", 4))
+	if (strncmp(np, "i2s-", 4))
 		return 0;
 
 	dev = kzalloc(sizeof(struct i2sbus_dev), GFP_KERNEL);
@@ -228,13 +229,13 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 	dev->sound.pcmid = -1;
 	dev->macio = macio;
 	dev->control = control;
-	dev->bus_number = np->name[4] - 'a';
+	dev->bus_number = node_name[4] - 'a';
 	INIT_LIST_HEAD(&dev->sound.codec_list);
 
 	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++) {
 		dev->interrupts[i] = -1;
 		snprintf(dev->rnames[i], sizeof(dev->rnames[i]),
-			 rnames[i], np->name);
+			 rnames[i], np);
 	}
 	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++) {
 		int irq = irq_of_parse_and_map(np, i);
-- 
2.17.1

