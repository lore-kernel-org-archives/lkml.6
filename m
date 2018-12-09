Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3D8C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988BB20672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988BB20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeLIWE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:04:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36784 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbeLIWEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:04:25 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73L-0002po-I6; Sun, 09 Dec 2018 21:55:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003Hk-KA; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.51103197@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 070/328] ALSA: cs5535audio: Fix invalid endian conversion
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 69756930f2de0457d51db7d505a1e4f40e9fd116 upstream.

One place in cs5535audio_build_dma_packets() does an extra conversion
via cpu_to_le32(); namely jmpprd_addr is passed to setup_prd() ops,
which writes the value via cs_writel().  That is, the callback does
the conversion by itself, and we don't need to convert beforehand.

This patch fixes that bogus conversion.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/cs5535audio/cs5535audio.h     | 6 +++---
 sound/pci/cs5535audio/cs5535audio_pcm.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/sound/pci/cs5535audio/cs5535audio.h
+++ b/sound/pci/cs5535audio/cs5535audio.h
@@ -66,9 +66,9 @@ struct cs5535audio_dma_ops {
 };
 
 struct cs5535audio_dma_desc {
-	u32 addr;
-	u16 size;
-	u16 ctlreserved;
+	__le32 addr;
+	__le16 size;
+	__le16 ctlreserved;
 };
 
 struct cs5535audio_dma {
--- a/sound/pci/cs5535audio/cs5535audio_pcm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pcm.c
@@ -158,8 +158,8 @@ static int cs5535audio_build_dma_packets
 	lastdesc->addr = cpu_to_le32((u32) dma->desc_buf.addr);
 	lastdesc->size = 0;
 	lastdesc->ctlreserved = cpu_to_le16(PRD_JMP);
-	jmpprd_addr = cpu_to_le32(lastdesc->addr +
-				  (sizeof(struct cs5535audio_dma_desc)*periods));
+	jmpprd_addr = (u32)dma->desc_buf.addr +
+		sizeof(struct cs5535audio_dma_desc) * periods;
 
 	dma->substream = substream;
 	dma->period_bytes = period_bytes;

