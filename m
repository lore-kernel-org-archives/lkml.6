Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B86C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCFC21582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCFC21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeI0P01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:26:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55030 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeI0P01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:26:27 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 15C2310A4;
        Thu, 27 Sep 2018 09:09:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.18 30/88] ALSA: bebob: fix memory leak for M-Audio FW1814 and ProjectMix I/O at error path
Date:   Thu, 27 Sep 2018 11:03:11 +0200
Message-Id: <20180927090304.224730028@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
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

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit b1fbebd4164b3d170ad916dcd692cf843c9c065d upstream.

After allocating model-dependent data for M-Audio FW1814 and ProjectMix
I/O, ALSA bebob driver has memory leak at error path.

This commit releases the allocated data at the error path.

Fixes: 04a2c73c97eb('ALSA: bebob: delayed registration of sound card')
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/bebob/bebob.c        |    2 ++
 sound/firewire/bebob/bebob_maudio.c |    4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -263,6 +263,8 @@ do_registration(struct work_struct *work
 error:
 	mutex_unlock(&devices_mutex);
 	snd_bebob_stream_destroy_duplex(bebob);
+	kfree(bebob->maudio_special_quirk);
+	bebob->maudio_special_quirk = NULL;
 	snd_card_free(bebob->card);
 	dev_info(&bebob->unit->device,
 		 "Sound card registration failed: %d\n", err);
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -290,10 +290,6 @@ snd_bebob_maudio_special_discover(struct
 		bebob->midi_output_ports = 2;
 	}
 end:
-	if (err < 0) {
-		kfree(params);
-		bebob->maudio_special_quirk = NULL;
-	}
 	mutex_unlock(&bebob->mutex);
 	return err;
 }


