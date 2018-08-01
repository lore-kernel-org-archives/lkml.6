Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF9AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926FA20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926FA20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbeHAMdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:33:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39184 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbeHAMdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:33:01 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fkofR-0006WU-GW; Wed, 01 Aug 2018 10:47:45 +0000
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
Subject: [PATCH 5/9] ALSA: sonicvibes: remove redundant pointer 'dir'
Date:   Wed,  1 Aug 2018 11:47:38 +0100
Message-Id: <20180801104742.4328-6-colin.king@canonical.com>
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

Pointer 'dir' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'dir' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/sonicvibes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 7fbdb703bfcd..7218f38b59db 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1433,14 +1433,12 @@ static int snd_sonicvibes_midi(struct sonicvibes *sonic,
 {
 	struct snd_mpu401 * mpu = rmidi->private_data;
 	struct snd_card *card = sonic->card;
-	struct snd_rawmidi_str *dir;
 	unsigned int idx;
 	int err;
 
 	mpu->private_data = sonic;
 	mpu->open_input = snd_sonicvibes_midi_input_open;
 	mpu->close_input = snd_sonicvibes_midi_input_close;
-	dir = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
 	for (idx = 0; idx < ARRAY_SIZE(snd_sonicvibes_midi_controls); idx++)
 		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_sonicvibes_midi_controls[idx], sonic))) < 0)
 			return err;
-- 
2.17.1

