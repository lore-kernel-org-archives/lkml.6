Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3C4C6778D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84FE22554
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84FE22554
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932163AbeGBVXk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:23:40 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:41400 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753384AbeGBVXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:23:32 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fa6IC-000777-1O; Mon, 02 Jul 2018 23:23:28 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v7 4/6] tuner-simple: allow setting mono radio mode
Date:   Mon,  2 Jul 2018 23:23:24 +0200
Message-Id: <bfaad2366c5adbc663a0f227f34bfc5e0d5d0888.1530565770.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1530565770.git.mail@maciej.szmigiero.name>
References: <cover.1530565770.git.mail@maciej.szmigiero.name>
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
