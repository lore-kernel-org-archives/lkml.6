Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC7BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445BD21855
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866405;
	bh=pMpeoezp/GEILklmnZWSnU2Vg/WC3omOpGwKR7jb2vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NVRXHO1BqjiyjznkOKnMRhiiCGlyrc7WaWOtLqcyYkgSAHrDE1MnDp3ALoniL73Yz
	 bz+mwqh9fCioNEfVhR2235CHhKY8cfPBzjnJQ+Ci+8zrnFHe/ZUv6YrBMmGUKDI/nl
	 VR/e488GOyf/zVMt4PcN4rfyF6ON/b1mwAL9XzQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfAGNGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:06:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfAGNGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:06:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B4422089F;
        Mon,  7 Jan 2019 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866401;
        bh=pMpeoezp/GEILklmnZWSnU2Vg/WC3omOpGwKR7jb2vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/cIq3q5qA4AZEVyqpRwCsSlDHSiqWRUqSRJom79RK2zaWUWdu+kSk2SXXNUXYBSb
         amrpN35OTRN7FE1jp8HLpGHT6Qj/renv0WN0s7SyUujRUbVVHewuE2W7zA3NNR/Jv7
         ZQYGkVAgKi2rmRTy1l8PU8qnQvDplfsflMKJppDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 30/71] ALSA: rme9652: Fix potential Spectre v1 vulnerability
Date:   Mon,  7 Jan 2019 13:32:59 +0100
Message-Id: <20190107105334.474006236@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 0b84304ef5da92add8dc75a1b07879c5374cdb05 upstream.

info->channel is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

sound/pci/rme9652/hdsp.c:4100 snd_hdsp_channel_info() warn: potential spectre issue 'hdsp->channel_map' [r] (local cap)

Fix this by sanitizing info->channel before using it to index hdsp->channel_map

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

Also, notice that I refactored the code a bit in order to get rid of the
following checkpatch warning:

ERROR: do not use assignment in if condition
FILE: sound/pci/rme9652/hdsp.c:4103:
	if ((mapped_channel = hdsp->channel_map[info->channel]) < 0)

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/rme9652/hdsp.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -30,6 +30,7 @@
 #include <linux/math64.h>
 #include <linux/vmalloc.h>
 #include <linux/io.h>
+#include <linux/nospec.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -4065,15 +4066,16 @@ static int snd_hdsp_channel_info(struct
 				    struct snd_pcm_channel_info *info)
 {
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	int mapped_channel;
+	unsigned int channel = info->channel;
 
-	if (snd_BUG_ON(info->channel >= hdsp->max_channels))
+	if (snd_BUG_ON(channel >= hdsp->max_channels))
 		return -EINVAL;
+	channel = array_index_nospec(channel, hdsp->max_channels);
 
-	if ((mapped_channel = hdsp->channel_map[info->channel]) < 0)
+	if (hdsp->channel_map[channel] < 0)
 		return -EINVAL;
 
-	info->offset = mapped_channel * HDSP_CHANNEL_BUFFER_BYTES;
+	info->offset = hdsp->channel_map[channel] * HDSP_CHANNEL_BUFFER_BYTES;
 	info->first = 0;
 	info->step = 32;
 	return 0;


