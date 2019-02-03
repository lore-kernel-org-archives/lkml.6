Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA5C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421CA2082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfBCO10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:27:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55556 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730126AbfBCOUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:47 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIda-0006M5-D2; Sun, 03 Feb 2019 14:20:46 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Z-00070d-HD; Sun, 03 Feb 2019 14:49:45 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Takashi Iwai" <tiwai@suse.de>, "Alex Stanoev" <alex@astanoev.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.9018695@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 121/305] ALSA: ca0106: Disable IZD on SB0570 DAC to
 fix audio pops
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Stanoev <alex@astanoev.com>

commit ac237c28d5ac1b241d58b1b7b4b9fa10efb22fb5 upstream.

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
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/ca0106/ca0106.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

