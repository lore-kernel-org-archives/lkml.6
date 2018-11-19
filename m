Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40064C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D6721104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/hEXTC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D6721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404463AbeKTDVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:21:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:32770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403835AbeKTDVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:21:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB34206BA;
        Mon, 19 Nov 2018 16:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646628;
        bh=tvqtG4pwdh5SQ2IY8hc6ud0KCL3In7aywCFLHjQlmyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/hEXTC4F/2nOoG0wZAfs161wHqIuHnF/r+NWSYZBP/EcQZmVgKpjF7rOWbQmbc5i
         bsGiFt91hBYN27tFRgeGbnPteW5q+YEg5pGvECFtRVpLzy3LVssZZsoyyKhfMbh7Tr
         Mphpq8c4FOONn9025c6jgnZ+V6lYYFYMawK2H/lQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Stanoev <alex@astanoev.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 009/160] ALSA: ca0106: Disable IZD on SB0570 DAC to fix audio pops
Date:   Mon, 19 Nov 2018 17:27:28 +0100
Message-Id: <20181119162631.148659191@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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


