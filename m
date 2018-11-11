Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40131C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09072214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T88I7NTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09072214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391024AbeKLIiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:38:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732144AbeKLIXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:22 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221F521780;
        Sun, 11 Nov 2018 22:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975605;
        bh=q79PoP8XtxtznvtnJVQdLX/HnLJpk2ihiSqXUN8kQDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T88I7NTOnWBiizfPAAHwJ0e4F44u9yJnjCUO7cGoDuE9RLqy/BSx+QqkoCHtxZSwZ
         0QbSgviskwYHjg5dwX4KnJsZI2QC9MlQy9Ehmcf740+f1hErLowAoY9f6ty0zLtp4u
         0eVAeX/6uw3WSHBj0eEwbvxwNbEhsSyFV8uwkci4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?H=C3=A5vard?= <hovardslill@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 010/141] ALSA: hda - Fix headphone pin config for ASUS G751
Date:   Sun, 11 Nov 2018 14:24:29 -0800
Message-Id: <20181111221629.107788806@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 5b7c5e1f4c36b99d0f694f38b9ad910f520cb7ef upstream.

BIOS on ASUS G751 doesn't seem to map the headphone pin (NID 0x16)
correctly.  Add a quirk to address it, as well as chaining to the
previous fix for the microphone.

Reported-by: Håvard <hovardslill@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6811,6 +6811,7 @@ enum {
 	ALC662_FIXUP_ASUS_Nx50,
 	ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE,
 	ALC668_FIXUP_ASUS_Nx51,
+	ALC668_FIXUP_MIC_COEF,
 	ALC668_FIXUP_ASUS_G751,
 	ALC891_FIXUP_HEADSET_MODE,
 	ALC891_FIXUP_DELL_MIC_NO_PRESENCE,
@@ -7078,7 +7079,7 @@ static const struct hda_fixup alc662_fix
 		.chained = true,
 		.chain_id = ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE,
 	},
-	[ALC668_FIXUP_ASUS_G751] = {
+	[ALC668_FIXUP_MIC_COEF] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0xc3 },
@@ -7086,6 +7087,15 @@ static const struct hda_fixup alc662_fix
 			{}
 		},
 	},
+	[ALC668_FIXUP_ASUS_G751] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x16, 0x0421101f }, /* HP */
+			{}
+		},
+		.chained = true,
+		.chain_id = ALC668_FIXUP_MIC_COEF
+	},
 	[ALC891_FIXUP_HEADSET_MODE] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_headset_mode,


