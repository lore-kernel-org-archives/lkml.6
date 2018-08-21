Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D6EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6996421774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6996421774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeHUJl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:41:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54728 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeHUJl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:41:27 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 140D7516;
        Tue, 21 Aug 2018 06:22:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.18 09/35] ALSA: cs5535audio: Fix invalid endian conversion
Date:   Tue, 21 Aug 2018 08:20:35 +0200
Message-Id: <20180821055020.396566221@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055019.954904905@linuxfoundation.org>
References: <20180821055019.954904905@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 69756930f2de0457d51db7d505a1e4f40e9fd116 upstream.

One place in cs5535audio_build_dma_packets() does an extra conversion
via cpu_to_le32(); namely jmpprd_addr is passed to setup_prd() ops,
which writes the value via cs_writel().  That is, the callback does
the conversion by itself, and we don't need to convert beforehand.

This patch fixes that bogus conversion.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/cs5535audio/cs5535audio.h     |    6 +++---
 sound/pci/cs5535audio/cs5535audio_pcm.c |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/sound/pci/cs5535audio/cs5535audio.h
+++ b/sound/pci/cs5535audio/cs5535audio.h
@@ -67,9 +67,9 @@ struct cs5535audio_dma_ops {
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


