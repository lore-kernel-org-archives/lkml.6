Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE75C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE872177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297625;
	bh=m5VRnElgZD02IbEYkpH97zKcnT7UjGYJCUlzfC8nF8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aRGU5LMuSP5ipuKqMwLR7liAGoId5ej1RE2dqt3NJ56ciXQyuT6fxlZ4lUQYN1uBn
	 3hMnhCZKUo6yzNSCNzuYxIhaxZEEpB/8EX1cU1Afts2AxormSnYjEK2feVTRXtd4ZS
	 R/oAEoxe0zRr+2bM9MsZxILZZG1UjpYzA6a5iedk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbeLTJUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:51392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730616AbeLTJUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:20:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C717F21773;
        Thu, 20 Dec 2018 09:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297620;
        bh=m5VRnElgZD02IbEYkpH97zKcnT7UjGYJCUlzfC8nF8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vq+3wMgMDkqkFIASYReWtFcjQ1BfCTAA8Cz9WmnlkNo9qUXDlexNjQlVkKpPE5L+w
         EGGgtMqK8fM4xLLh7MOPmdbCgt297wKiTF+X56ki6JMBj8qYI6ZrS6ByrNixiBnlzC
         J1zry6Fl7TlfMvTIzeAKPZFkb6HixoG49nLWbqpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 3.18 27/31] ALSA: pcm: remove SNDRV_PCM_IOCTL1_INFO internal command
Date:   Thu, 20 Dec 2018 10:18:39 +0100
Message-Id: <20181220085743.670719346@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit e11f0f90a626f93899687b1cc909ee37dd6c5809 upstream.

Drivers can implement 'struct snd_pcm_ops.ioctl' to handle some requests
from ALSA PCM core. These requests are internal purpose in kernel land.
Usually common set of operations are used for it.

SNDRV_PCM_IOCTL1_INFO is one of the requests. According to code comment,
it has been obsoleted in the old days.

We can see old releases in ftp.alsa-project.org. The command was firstly
introduced in v0.5.0 release as SND_PCM_IOCTL1_INFO, to allow drivers to
fill data of 'struct snd_pcm_channel_info' type. In v0.9.0 release,
this was obsoleted by the other commands for ioctl(2) such as
SNDRV_PCM_IOCTL_CHANNEL_INFO.

This commit removes the long-abandoned command, bye.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/sound/pcm.h     |    2 +-
 sound/core/pcm_lib.c    |    2 --
 sound/core/pcm_native.c |    6 +-----
 3 files changed, 2 insertions(+), 8 deletions(-)

--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -98,7 +98,7 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_IOCTL1_TRUE		((void *)1)
 
 #define SNDRV_PCM_IOCTL1_RESET		0
-#define SNDRV_PCM_IOCTL1_INFO		1
+/* 1 is absent slot. */
 #define SNDRV_PCM_IOCTL1_CHANNEL_INFO	2
 #define SNDRV_PCM_IOCTL1_GSTATE		3
 #define SNDRV_PCM_IOCTL1_FIFO_SIZE	4
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1818,8 +1818,6 @@ int snd_pcm_lib_ioctl(struct snd_pcm_sub
 		      unsigned int cmd, void *arg)
 {
 	switch (cmd) {
-	case SNDRV_PCM_IOCTL1_INFO:
-		return 0;
 	case SNDRV_PCM_IOCTL1_RESET:
 		return snd_pcm_lib_ioctl_reset(substream, arg);
 	case SNDRV_PCM_IOCTL1_CHANNEL_INFO:
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -216,11 +216,7 @@ int snd_pcm_info(struct snd_pcm_substrea
 	info->subdevices_avail = pstr->substream_count - pstr->substream_opened;
 	strlcpy(info->subname, substream->name, sizeof(info->subname));
 	runtime = substream->runtime;
-	/* AB: FIXME!!! This is definitely nonsense */
-	if (runtime) {
-		info->sync = runtime->sync;
-		substream->ops->ioctl(substream, SNDRV_PCM_IOCTL1_INFO, info);
-	}
+
 	return 0;
 }
 


