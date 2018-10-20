Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4EEECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E1120843
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=astanoev.com header.i=@astanoev.com header.b="JRykS0Vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E1120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=astanoev.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJTIwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 04:52:09 -0400
Received: from rn-nyc.alexsoft-bg.com ([168.235.91.190]:36744 "EHLO
        rn-nyc.alexsoft-bg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbeJTIwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 04:52:08 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Oct 2018 04:52:08 EDT
Received: from localhost.localdomain (136.198.147.147.dyn.plus.net [147.147.198.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by rn-nyc.alexsoft-bg.com (Postfix) with ESMTPSA id EC5FEEC0068;
        Sat, 20 Oct 2018 03:37:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astanoev.com; s=mail;
        t=1539995834; bh=EuZWTuCdmAyDchnmgRRtyb99OES+QxCvMqOShuTVnsw=;
        h=From:To:Cc:Subject:Date:From;
        b=JRykS0Vfdwf5Jh+gk2HeGFmINYK1DFWu/0pBvAO3PUqsOXKTguOCUUMUn2v6XAY4H
         f3K5h2q22v6VkZCU+ORWYja23DSzfaM+I0KtGe6n38izxQY90MgMq00b/wKBREVmsL
         8kqCOXJ6ryT/nI/CpfoGvAvZrmBiQfCDU823iK0s=
From:   Alex Stanoev <alex@astanoev.com>
To:     tiwai@suse.com
Cc:     Alex Stanoev <alex@astanoev.com>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: ca0106: Disable IZD on SB0570 DAC to fix audio pops
Date:   Sat, 20 Oct 2018 01:33:42 +0100
Message-Id: <20181020003344.18078-1-alex@astanoev.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Creative Audigy SE (SB0570) card currently exhibits an audible pop
whenever playback is stopped or resumed, or during silent periods of an
audio stream. Initialise the IZD bit to the 0 to eliminate these pops.

The Infinite Zero Detection (IZD) feature on the DAC causes the output
to be shunted to Vcap after 2048 samples of silence. This discharges the
AC coupling capacitor through the output and causes the aforementioned
pop/click noise.

The behaviour of the IZD bit is described on page 15 of the WM8768GEDS
datasheet: "With IZD=1, applying MUTE for 1024 consecutive input samples
will cause all outputs to be connected directly to VCAP. This also
happens if 2048 consecutive zero input samples are applied to all 6
channels, and IZD=0. It will be removed as soon as any channel receives
a non-zero input". I believe the second sentence might be referring to
IZD=1 instead of IZD=0 given the observed behaviour of the card.

This change should make the DAC initialisation consistent with
Creative's Windows driver, as this popping persists when initialising
the card in Linux and soft rebooting into Windows, but is not present on
a cold boot to Windows.

Signed-off-by: Alex Stanoev <alex@astanoev.com>
---
 sound/pci/ca0106/ca0106.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ca0106/ca0106.h b/sound/pci/ca0106/ca0106.h
index 04402c14cb23..9847b669cf3c 100644
--- a/sound/pci/ca0106/ca0106.h
+++ b/sound/pci/ca0106/ca0106.h
@@ -582,7 +582,7 @@
 #define SPI_PL_BIT_R_R		(2<<7)	/* right channel = right */
 #define SPI_PL_BIT_R_C		(3<<7)	/* right channel = (L+R)/2 */
 #define SPI_IZD_REG		2
-#define SPI_IZD_BIT		(1<<4)	/* infinite zero detect */
+#define SPI_IZD_BIT		(0<<4)	/* infinite zero detect */
 
 #define SPI_FMT_REG		3
 #define SPI_FMT_BIT_RJ		(0<<0)	/* right justified mode */
-- 
2.19.1

