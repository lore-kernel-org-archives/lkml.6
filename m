Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E571C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67A227ECE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67A227ECE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030264AbeF2VAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:00:14 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:59014 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935985AbeF2VAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:00:09 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fZ0Uu-00046r-Vq; Fri, 29 Jun 2018 23:00:05 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: [RESEND][PATCH v6 4/6] tuner-simple: allow setting mono radio mode
Date:   Fri, 29 Jun 2018 23:00:01 +0200
Message-Id: <74d04548a5c79353d5c5847ea4379dfdbada4ffb.1530305665.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1530305665.git.mail@maciej.szmigiero.name>
References: <cover.1530305665.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some types of tuners (Philips FMD1216ME(X) MK3 currently) we know that
letting TDA9887 output port 1 remain high (inactive) will switch FM radio
to mono mode.
Let's make use of this functionality - nothing changes for the default
stereo radio mode.

Tested on a Medion 95700 board which has a FMD1216ME tuner.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/media/tuners/tuner-simple.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/tuners/tuner-simple.c b/drivers/media/tuners/tuner-simple.c
index 36b88f820239..29c1473f2e9f 100644
--- a/drivers/media/tuners/tuner-simple.c
+++ b/drivers/media/tuners/tuner-simple.c
@@ -670,6 +670,7 @@ static int simple_set_radio_freq(struct dvb_frontend *fe,
 	int rc, j;
 	struct tuner_params *t_params;
 	unsigned int freq = params->frequency;
+	bool mono = params->audmode == V4L2_TUNER_MODE_MONO;
 
 	tun = priv->tun;
 
@@ -736,8 +737,8 @@ static int simple_set_radio_freq(struct dvb_frontend *fe,
 			config |= TDA9887_PORT2_ACTIVE;
 		if (t_params->intercarrier_mode)
 			config |= TDA9887_INTERCARRIER;
-/*		if (t_params->port1_set_for_fm_mono)
-			config &= ~TDA9887_PORT1_ACTIVE;*/
+		if (t_params->port1_set_for_fm_mono && mono)
+			config &= ~TDA9887_PORT1_ACTIVE;
 		if (t_params->fm_gain_normal)
 			config |= TDA9887_GAIN_NORMAL;
 		if (t_params->radio_if == 2)
