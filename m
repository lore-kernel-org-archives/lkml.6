Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A0BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34AD20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34AD20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbeHAMdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:33:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39188 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387716AbeHAMdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:33:02 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fkofT-0006Wj-12; Wed, 01 Aug 2018 10:47:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jaya Kumar <jayakumar.alsa@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] ALSA: usb-audio: remove redundant pointer 'urb'
Date:   Wed,  1 Aug 2018 11:47:41 +0100
Message-Id: <20180801104742.4328-9-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'urb' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'urb' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/endpoint.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index c90607ebe155..d86be8bfe412 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -325,7 +325,6 @@ static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
 		unsigned long flags;
 		struct snd_usb_packet_info *uninitialized_var(packet);
 		struct snd_urb_ctx *ctx = NULL;
-		struct urb *urb;
 		int err, i;
 
 		spin_lock_irqsave(&ep->lock, flags);
@@ -345,7 +344,6 @@ static void queue_pending_output_urbs(struct snd_usb_endpoint *ep)
 			return;
 
 		list_del_init(&ctx->ready_list);
-		urb = ctx->urb;
 
 		/* copy over the length information */
 		for (i = 0; i < packet->packets; i++)
-- 
2.17.1

