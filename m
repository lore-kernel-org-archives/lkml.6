Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D248C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F9D25076
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F9D25076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756112AbeFXPmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:42:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60082 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755637AbeFXPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:42:43 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7944D2C;
        Sun, 24 Jun 2018 15:42:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bo Chen <chenbo@pdx.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.17 31/70] ALSA: hda - Handle kzalloc() failure in snd_hda_attach_pcm_stream()
Date:   Sun, 24 Jun 2018 23:22:23 +0800
Message-Id: <20180624142742.408164561@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bo Chen <chenbo@pdx.edu>

commit a3aa60d511746bd6c0d0366d4eb90a7998bcde8b upstream.

When 'kzalloc()' fails in 'snd_hda_attach_pcm_stream()', a new pcm instance is
created without setting its operators via 'snd_pcm_set_ops()'. Following
operations on the new pcm instance can trigger kernel null pointer dereferences
and cause kernel oops.

This bug was found with my work on building a gray-box fault-injection tool for
linux-kernel-module binaries. A kernel null pointer dereference was confirmed
from line 'substream->ops->open()' in function 'snd_pcm_open_substream()' in
file 'sound/core/pcm_native.c'.

This patch fixes the bug by calling 'snd_device_free()' in the error handling
path of 'kzalloc()', which removes the new pcm instance from the snd card before
returns with an error code.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_controller.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -748,8 +748,10 @@ int snd_hda_attach_pcm_stream(struct hda
 		return err;
 	strlcpy(pcm->name, cpcm->name, sizeof(pcm->name));
 	apcm = kzalloc(sizeof(*apcm), GFP_KERNEL);
-	if (apcm == NULL)
+	if (apcm == NULL) {
+		snd_device_free(chip->card, pcm);
 		return -ENOMEM;
+	}
 	apcm->chip = chip;
 	apcm->pcm = pcm;
 	apcm->codec = codec;


