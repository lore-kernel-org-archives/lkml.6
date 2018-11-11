Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130AFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF87120818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCFbjBtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF87120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387846AbeKLJdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387650AbeKLITT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:19 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D22821582;
        Sun, 11 Nov 2018 22:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975363;
        bh=nkfNguCodCowNbWUKVdlmZ38kVtUg9TErdQsW/+oJ+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCFbjBtWeOxxPjePvUcxp6WOqGw/EC/gwgdE5MsNMZasw6qMwd+mf3N9BlKQoQoRg
         NLZQYaKuFbfkjkRmwcZ2FLgWT9F0NFEiseZUpXqEG5eyuLGfUwd5AH/Khj0CBGPwly
         QerZoGHH/a2CGH36iF7HzhGWp4bkZORsGlx8A+Us=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Stanoev <alex@astanoev.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.18 035/350] ALSA: ca0106: Disable IZD on SB0570 DAC to fix audio pops
Date:   Sun, 11 Nov 2018 14:18:19 -0800
Message-Id: <20181111221708.650214049@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/ca0106/ca0106.h |    2 +-
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


