Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CC0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CB52081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896735;
	bh=+urJ1CdXBUS7ExzYJWJyPbWhDidR+1fVQ4XVjo5ZYDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bbZQOHe+gDlB2qRv+OUANAqWXAAimnFQds7uwJ+OIeCVtJ41M5HBZvKPn70JAXFh1
	 IfpvXrbOO7YeMXxH+Kb3wNXe8sIP42xXSpVFjnq/TUR9d6di7cHGI9EtjHIv3hx67U
	 iMjwR3JQ357zIa8FI4KSvKr4tkoXs4QYYSjiJjqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbfBKOwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:52:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731816AbfBKOwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51DB22081B;
        Mon, 11 Feb 2019 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896731;
        bh=+urJ1CdXBUS7ExzYJWJyPbWhDidR+1fVQ4XVjo5ZYDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZY+6aRVu6je0YbVrJlc/kuOIXel2uXKjcb94kiYR8Luc8ksgYvj2a/dpM+l62Xmrp
         MNkZ6YLOWs3Qvd5i5fbiMX0vSzPetH2lmJmfcZxdwXTsK9jXXT4uYtv3E0PVp/3diS
         yHJ+vKKQnfCTRNjcJTsaRc7jZ191caw1dp7MpL7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 281/313] ALSA: hda/realtek - Fix lose hp_pins for disable auto mute
Date:   Mon, 11 Feb 2019 15:19:21 +0100
Message-Id: <20190211141912.006276269@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

From: Kailang Yang <kailang@realtek.com>

commit d561aa0a70bb2e1dd85fde98b6a5561e4175ac3e upstream.

When auto_mute = no or spec->suppress_auto_mute = 1, cfg->hp_pins will
lose value.

Add this patch to find hp_pins value.
I add fixed for ALC282 ALC225 ALC256 ALC294 and alc_default_init()
alc_default_shutup().

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2963,6 +2963,11 @@ static void alc282_init(struct hda_codec
 	bool hp_pin_sense;
 	int coef78;
 
+	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
+		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
+			hp_pin = spec->gen.autocfg.line_out_pins[0];
+	}
+
 	alc282_restore_default_value(codec);
 
 	if (!hp_pin)
@@ -3000,6 +3005,11 @@ static void alc282_shutup(struct hda_cod
 	bool hp_pin_sense;
 	int coef78;
 
+	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
+		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
+			hp_pin = spec->gen.autocfg.line_out_pins[0];
+	}
+
 	if (!hp_pin) {
 		alc269_shutup(codec);
 		return;
@@ -3159,6 +3169,11 @@ static void alc256_init(struct hda_codec
 	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
 	bool hp_pin_sense;
 
+	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
+		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
+			hp_pin = spec->gen.autocfg.line_out_pins[0];
+	}
+
 	if (!hp_pin)
 		return;
 
@@ -3195,6 +3210,11 @@ static void alc256_shutup(struct hda_cod
 	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
 	bool hp_pin_sense;
 
+	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
+		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
+			hp_pin = spec->gen.autocfg.line_out_pins[0];
+	}
+
 	if (!hp_pin) {
 		alc269_shutup(codec);
 		return;
@@ -3231,6 +3251,11 @@ static void alc225_init(struct hda_codec
 	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
 	bool hp1_pin_sense, hp2_pin_sense;
 
+	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
+		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
+			hp_pin = spec->gen.autocfg.line_out_pins[0];
+	}
+
 	if (!hp_pin)
 		return;
 
@@ -3274,6 +3299,11 @@ static void alc225_shutup(struct hda_cod
 	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
 	bool hp1_pin_sense, hp2_pin_sense;
 
+	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
+		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
+			hp_pin = spec->gen.autocfg.line_out_pins[0];
+	}
+
 	if (!hp_pin) {
 		alc269_shutup(codec);
 		return;
@@ -3318,6 +3348,11 @@ static void alc_default_init(struct hda_
 	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
 	bool hp_pin_sense;
 
+	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
+		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
+			hp_pin = spec->gen.autocfg.line_out_pins[0];
+	}
+
 	if (!hp_pin)
 		return;
 
@@ -3347,6 +3382,11 @@ static void alc_default_shutup(struct hd
 	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
 	bool hp_pin_sense;
 
+	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
+		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
+			hp_pin = spec->gen.autocfg.line_out_pins[0];
+	}
+
 	if (!hp_pin) {
 		alc269_shutup(codec);
 		return;
@@ -3379,6 +3419,11 @@ static void alc294_hp_init(struct hda_co
 	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
 	int i, val;
 
+	if (!spec->gen.autocfg.hp_outs && spec->gen.suppress_auto_mute) {
+		if (spec->gen.autocfg.line_out_type == AC_JACK_HP_OUT)
+			hp_pin = spec->gen.autocfg.line_out_pins[0];
+	}
+
 	if (!hp_pin)
 		return;
 


