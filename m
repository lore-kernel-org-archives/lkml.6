Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE30C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431DF2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhfogx3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431DF2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeLDK7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:59:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbeLDK7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:59:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A06032087F;
        Tue,  4 Dec 2018 10:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921143;
        bh=rMtY9KdVTzM7W9xrzV54W7Je7e+Xp1RsGNSAtM6sJjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xhfogx3xVPgQWCtGXATylccXK2lhQrEcyHMt83NErviiQKMsNYZsw0VpWWqeynVVF
         67nHdAxdqbxSg1kxUyeSIrWz3cmuYzJns4NUHWt903gkZC5szwVkIFpCdDnZhrf//t
         w07i/VXqJk0VxkTTy1UlUoyYq3YYqUheDdo+D+i0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Girija Kumar Kasinadhuni <gkumar@neverware.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 097/139] ALSA: hda/realtek - Add auto-mute quirk for HP Spectre x360 laptop
Date:   Tue,  4 Dec 2018 11:49:38 +0100
Message-Id: <20181204103654.385182301@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

From: Girija Kumar Kasinadhuni <gkumar@neverware.com>

commit e8ed64b08eddc05043e556832616a478bbe4bb00 upstream.

This device makes a loud buzzing sound when a headphone is inserted while
playing audio at full volume through the speaker.

Fixes: bbf8ff6b1d2a ("ALSA: hda/realtek - Fixup for HP x360 laptops with B&O speakers")
Signed-off-by: Girija Kumar Kasinadhuni <gkumar@neverware.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5509,6 +5509,7 @@ enum {
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
+	ALC295_FIXUP_HP_AUTO_MUTE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -5673,6 +5674,8 @@ static const struct hda_fixup alc269_fix
 	[ALC269_FIXUP_HP_MUTE_LED_MIC3] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_hp_mute_led_mic3,
+		.chained = true,
+		.chain_id = ALC295_FIXUP_HP_AUTO_MUTE
 	},
 	[ALC269_FIXUP_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
@@ -6380,6 +6383,10 @@ static const struct hda_fixup alc269_fix
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_invalidate_dacs,
 	},
+	[ALC295_FIXUP_HP_AUTO_MUTE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_auto_mute_via_amp,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {


