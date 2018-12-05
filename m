Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B8EC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673B42133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039514;
	bh=KZwzWcAmUEBgiUYbV0WqyAoYNEIxLO2b0dHjHP6Uz7g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fTtpmQiEyOjj49zIVy0ZiW0Kzp3bIga/eVE13EkZMKY523Hau7ljFYxbR7bA3f/b1
	 UdlYPGUEfDcT2u7Sw5/OrLQBnPksLpw+18XIphpfBhY4kYDGQtVUAa++QnrtI5YG36
	 1NRQIUPLYQSaz3vPmQ8pA2D/4aNavWJQPTd6PMrw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673B42133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbeLETvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:53 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39597 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbeLETv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id i6so18622139oia.6;
        Wed, 05 Dec 2018 11:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMVKbQQ2IkPQlwBHD7jq1zN5axWgXmiq34kQVyq7TYw=;
        b=AnpmeeSCMH+NrlvZY0xDRjXfUFkmNsSRcVGbbWT2XuGm/0lIDt+/fnA1dLI1ZjJhw+
         UeBdbSfKp2U5ggQQILqYlRGiV8pe033NDoXa2Ydpamm6Ils/doTwyGaSQupOogU0mOCr
         pu9SneqtJFSLl+mzD7mXx+V9wpIA4/0pInUczqZEAulZQSCElkJiqvMIS4xm4o3aOV0P
         H+9IIx4+fqvTLVeGMBsmfYGjGnvVUA0dVf864Me8YbAxw852xkGWqliFR9p4Bfy7ATV+
         7vmb4SZoOFco4FSoYASVKz3iRHgud+pcBMFEx7i99FlwcgpLV90D0/MdK2HFdlKTK06W
         JJ0w==
X-Gm-Message-State: AA+aEWa9mu7UTiLJSX6IilZaw2Y1J+PwpKZLU9sx4MrFdo7Q1dWqlLJj
        tNBAl9XPf26FSQx1Zauc4exvsu+tcA==
X-Google-Smtp-Source: AFSGD/WdroYapRHGtB0zgN2RHLmwEfNnpn29lkyPbXz+aqb5/YoJqwR5izMRaf1JxojWo4ircDNR9g==
X-Received: by 2002:aca:b642:: with SMTP id g63mr14811654oif.195.1544039485103;
        Wed, 05 Dec 2018 11:51:25 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:24 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:46 -0600
Message-Id: <20181205195050.4759-30-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

A couple of open coded iterating thru the child node names are converted
to use for_each_child_of_node() instead.

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/aoa/fabrics/layout.c       | 2 +-
 sound/aoa/soundbus/i2sbus/core.c | 6 +++---
 sound/ppc/pmac.c                 | 4 ++--
 sound/ppc/tumbler.c              | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 3a23fd032611..8797d42e2b76 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -776,7 +776,7 @@ static int check_codec(struct aoa_codec *codec,
 	struct codec_connection *cc;
 
 	/* if the codec has a 'codec' node, we require a reference */
-	if (codec->node && (strcmp(codec->node->name, "codec") == 0)) {
+	if (of_node_name_eq(codec->node, "codec")) {
 		snprintf(propname, sizeof(propname),
 			 "platform-%s-codec-ref", codec->name);
 		ref = of_get_property(ldev->sound, propname, NULL);
diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index bd7c5029fc59..c3f57a3fb1a5 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -154,7 +154,7 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 			  struct device_node *np)
 {
 	struct i2sbus_dev *dev;
-	struct device_node *child = NULL, *sound = NULL;
+	struct device_node *child, *sound = NULL;
 	struct resource *r;
 	int i, layout = 0, rlen, ok = force;
 	char node_name[6];
@@ -177,8 +177,8 @@ static int i2sbus_add_dev(struct macio_dev *macio,
 		return 0;
 
 	i = 0;
-	while ((child = of_get_next_child(np, child))) {
-		if (strcmp(child->name, "sound") == 0) {
+	for_each_child_of_node(np, child) {
+		if (of_node_name_eq(child, "sound")) {
 			i++;
 			sound = child;
 		}
diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index 48dd44f8e914..d692e4070167 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -908,7 +908,7 @@ static void detect_byte_swap(struct snd_pmac *chip)
 
 	/* if seems that Keylargo can't byte-swap  */
 	for (mio = chip->node->parent; mio; mio = mio->parent) {
-		if (strcmp(mio->name, "mac-io") == 0) {
+		if (of_node_name_eq(mio, "mac-io")) {
 			if (of_device_is_compatible(mio, "Keylargo"))
 				chip->can_byte_swap = 0;
 			break;
@@ -1313,7 +1313,7 @@ int snd_pmac_new(struct snd_card *card, struct snd_pmac **chip_return)
 	} else if (chip->is_pbook_G3) {
 		struct device_node* mio;
 		for (mio = chip->node->parent; mio; mio = mio->parent) {
-			if (strcmp(mio->name, "mac-io") == 0) {
+			if (of_node_name_eq(mio, "mac-io")) {
 				struct resource r;
 				if (of_address_to_resource(mio, 0, &r) == 0)
 					chip->macio_base =
diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 0779a2912237..6d7ffffcce95 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1365,8 +1365,8 @@ int snd_pmac_tumbler_init(struct snd_pmac *chip)
 	mix->anded_reset = 0;
 	mix->reset_on_sleep = 1;
 
-	for (np = chip->node->child; np; np = np->sibling) {
-		if (!strcmp(np->name, "sound")) {
+	for_each_child_of_node(chip->node, np) {
+		if (of_node_name_eq(np, "sound")) {
 			if (of_get_property(np, "has-anded-reset", NULL))
 				mix->anded_reset = 1;
 			if (of_get_property(np, "layout-id", NULL))
-- 
2.19.1

