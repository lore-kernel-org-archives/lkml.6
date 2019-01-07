Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785A3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4708D20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865374;
	bh=Zf0YJNJfw8vJuglDu84YQkYtML+aTifV2690ti2lDqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SVhMubI7omnsWsuJJ+0ztUKMXaSFN4Ahv6c5AeMvE+tO2+n98H7NVbqf0mwySi0O2
	 9ZJjrdVVjNX9IUtD5+di5UpM39W3nFSm7VBDrgj0rVLk5V1NaGWzsUMRgtHR/ukLg4
	 120mANZmxGDcyPlXcRvwsBXP0z1PFVPY98uiSAt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfAGMtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:49:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729498AbfAGMt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:49:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 235DA20651;
        Mon,  7 Jan 2019 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865367;
        bh=Zf0YJNJfw8vJuglDu84YQkYtML+aTifV2690ti2lDqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0VRuQ0zR4AvjyxSXTswOFwj4gLJCWOQGroIYFUVCMYEbfaffyzkb5aEj3hTS0MzbR
         ENmDbDtc9LUiAVVSnpz5QVbChcXwwBTOQeQmxKp+VqYXGDSN/AdiMMoMEKcQ6AGHm+
         jpFKNBJ5jgHVZikueCH53swWKjJ57/0TFDG0mQuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 061/170] ALSA: emu10k1: Fix potential Spectre v1 vulnerabilities
Date:   Mon,  7 Jan 2019 13:31:28 +0100
Message-Id: <20190107104500.239343946@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 5ae4f61f012a097df93de2285070ec8e34716d29 upstream.

ipcm->substream is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

sound/pci/emu10k1/emufx.c:1031 snd_emu10k1_ipcm_poke() warn: potential spectre issue 'emu->fx8010.pcm' [r] (local cap)
sound/pci/emu10k1/emufx.c:1075 snd_emu10k1_ipcm_peek() warn: potential spectre issue 'emu->fx8010.pcm' [r] (local cap)

Fix this by sanitizing ipcm->substream before using it to index emu->fx8010.pcm

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/emu10k1/emufx.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -36,6 +36,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/moduleparam.h>
+#include <linux/nospec.h>
 
 #include <sound/core.h>
 #include <sound/tlv.h>
@@ -1026,6 +1027,8 @@ static int snd_emu10k1_ipcm_poke(struct
 
 	if (ipcm->substream >= EMU10K1_FX8010_PCM_COUNT)
 		return -EINVAL;
+	ipcm->substream = array_index_nospec(ipcm->substream,
+					     EMU10K1_FX8010_PCM_COUNT);
 	if (ipcm->channels > 32)
 		return -EINVAL;
 	pcm = &emu->fx8010.pcm[ipcm->substream];
@@ -1072,6 +1075,8 @@ static int snd_emu10k1_ipcm_peek(struct
 
 	if (ipcm->substream >= EMU10K1_FX8010_PCM_COUNT)
 		return -EINVAL;
+	ipcm->substream = array_index_nospec(ipcm->substream,
+					     EMU10K1_FX8010_PCM_COUNT);
 	pcm = &emu->fx8010.pcm[ipcm->substream];
 	mutex_lock(&emu->fx8010.lock);
 	spin_lock_irq(&emu->reg_lock);


