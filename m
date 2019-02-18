Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6373E21902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498677;
	bh=d8nozL5in4jiV0uR8sRhloYgPPeny4io0wR2zyeTWvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WABcfZtr+ce2OvLo4cW6Jw951Soex6Wi36FAV7Om4E7SFPakmB7n6KqugoIK8kfYM
	 84uxifF5Dp0wOC8dVVh3h56AcaXY3+ovwyUvAVLjVQY/djpBbihOjPBby5lQsQXD8p
	 doclTsl+u7pdaGPZxRK6RstqSrqddSAP5+RBnmdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbfBROEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389331AbfBROEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:04:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEE38204FD;
        Mon, 18 Feb 2019 14:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498672;
        bh=d8nozL5in4jiV0uR8sRhloYgPPeny4io0wR2zyeTWvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cE3lpatRjwMrKRdM7Mcn9sQwng5GVvr7bs/5+/GdzS6VcIdNJn+S7EgJYhGZXBUwN
         D55cyUdBhg9f/r6KWTbbDNdJhhNnnVYGlaLqPq5/6/Em++gnG18YK85Da/QYBVNf8V
         JgMcz1AxPeHsOyv9qp/UR4PeIEkBY4x1PMSyXdII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 084/143] ALSA: hda - Serialize codec registrations
Date:   Mon, 18 Feb 2019 14:43:32 +0100
Message-Id: <20190218133532.140094760@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 305a0ade180981686eec1f92aa6252a7c6ebb1cf upstream.

In the current code, the codec registration may happen both at the
codec bind time and the end of the controller probe time.  In a rare
occasion, they race with each other, leading to Oops due to the still
uninitialized card device.

This patch introduces a simple flag to prevent the codec registration
at the codec bind time as long as the controller probe is going on.
The controller probe invokes snd_card_register() that does the whole
registration task, and we don't need to register each piece
beforehand.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_bind.c  |    3 ++-
 sound/pci/hda/hda_codec.h |    1 +
 sound/pci/hda/hda_intel.c |    2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -109,7 +109,8 @@ static int hda_codec_driver_probe(struct
 	err = snd_hda_codec_build_controls(codec);
 	if (err < 0)
 		goto error_module;
-	if (codec->card->registered) {
+	/* only register after the bus probe finished; otherwise it's racy */
+	if (!codec->bus->bus_probing && codec->card->registered) {
 		err = snd_card_register(codec->card);
 		if (err < 0)
 			goto error_module;
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -68,6 +68,7 @@ struct hda_bus {
 	unsigned int response_reset:1;	/* controller was reset */
 	unsigned int in_reset:1;	/* during reset operation */
 	unsigned int no_response_fallback:1; /* don't fallback at RIRB error */
+	unsigned int bus_probing :1;	/* during probing process */
 
 	int primary_dig_out_type;	/* primary digital out PCM type */
 	unsigned int mixer_assigned;	/* codec addr for mixer name */
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2100,6 +2100,7 @@ static int azx_probe_continue(struct azx
 	int val;
 	int err;
 
+	to_hda_bus(bus)->bus_probing = 1;
 	hda->probe_continued = 1;
 
 	/* Request display power well for the HDA controller or codec. For
@@ -2200,6 +2201,7 @@ i915_power_fail:
 	if (err < 0)
 		hda->init_failed = 1;
 	complete_all(&hda->probe_wait);
+	to_hda_bus(bus)->bus_probing = 0;
 	return err;
 }
 


