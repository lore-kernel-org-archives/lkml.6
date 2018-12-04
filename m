Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9856C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD222087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JepZnja5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD222087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbeLDLP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:15:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbeLDLG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:06:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFFE42087F;
        Tue,  4 Dec 2018 11:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921587;
        bh=OEUjJZTk6J7zqX/8ikeYGKOT9dUxBRJlClymZt0e5jY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JepZnja5JDW+6+EXRBsTU9NEeAgAiAdbo9yd5cR83d0SCxkV6xNd9nSxaIkkB7uh/
         nVDBjvitW6W9AKM+le7iOykVrXmeDneQGkQ6jMFDHYYtVejOPr4Dq4CtbJ6DIewlmK
         GRd4nl2sb9VVwvojfzySfZItvZk3WR29F2vsxth0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 129/146] ALSA: hda/realtek - Support ALC300
Date:   Tue,  4 Dec 2018 11:50:15 +0100
Message-Id: <20181204103732.021639644@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit 1078bef0cd9291355a20369b21cd823026ab8eaa upstream.

This patch will enable ALC300.

[ It's almost equivalent with other ALC269-compatible ones, and
  apparently has no loopback mixer -- tiwai ]

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -343,6 +343,7 @@ static void alc_fill_eapd_coef(struct hd
 	case 0x10ec0285:
 	case 0x10ec0298:
 	case 0x10ec0289:
+	case 0x10ec0300:
 		alc_update_coef_idx(codec, 0x10, 1<<9, 0);
 		break;
 	case 0x10ec0275:
@@ -2758,6 +2759,7 @@ enum {
 	ALC269_TYPE_ALC215,
 	ALC269_TYPE_ALC225,
 	ALC269_TYPE_ALC294,
+	ALC269_TYPE_ALC300,
 	ALC269_TYPE_ALC700,
 };
 
@@ -2792,6 +2794,7 @@ static int alc269_parse_auto_config(stru
 	case ALC269_TYPE_ALC215:
 	case ALC269_TYPE_ALC225:
 	case ALC269_TYPE_ALC294:
+	case ALC269_TYPE_ALC300:
 	case ALC269_TYPE_ALC700:
 		ssids = alc269_ssids;
 		break;
@@ -7089,6 +7092,10 @@ static int patch_alc269(struct hda_codec
 		spec->gen.mixer_nid = 0; /* ALC2x4 does not have any loopback mixer path */
 		alc_update_coef_idx(codec, 0x6b, 0x0018, (1<<4) | (1<<3)); /* UAJ MIC Vref control by verb */
 		break;
+	case 0x10ec0300:
+		spec->codec_variant = ALC269_TYPE_ALC300;
+		spec->gen.mixer_nid = 0; /* no loopback on ALC300 */
+		break;
 	case 0x10ec0700:
 	case 0x10ec0701:
 	case 0x10ec0703:
@@ -8160,6 +8167,7 @@ static const struct hda_device_id snd_hd
 	HDA_CODEC_ENTRY(0x10ec0295, "ALC295", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0298, "ALC298", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0299, "ALC299", patch_alc269),
+	HDA_CODEC_ENTRY(0x10ec0300, "ALC300", patch_alc269),
 	HDA_CODEC_REV_ENTRY(0x10ec0861, 0x100340, "ALC660", patch_alc861),
 	HDA_CODEC_ENTRY(0x10ec0660, "ALC660-VD", patch_alc861vd),
 	HDA_CODEC_ENTRY(0x10ec0861, "ALC861", patch_alc861),


