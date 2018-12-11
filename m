Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AE0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB2220855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543456;
	bh=1VOOndiWuh2uPhNbcWyPyNPQkpXvLj3dkMS+9ilQ+tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CKX8kc7QsPe1205lnJQKgPB1m9ulL9m2ROuet2D7ARbr5XubQDKIuzuJZ0HKM1gr2
	 jaJUhBEZcyfHohgGyeVYfImzuPxgPx2Re/1P288kq6Mxa6Rb3lPv/wS9pGMwTOmRWM
	 Vg/jaWbracHUqie02NqkfxD5tgoah/Lu1PC1Znuo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB2220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbeLKPuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:50:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbeLKPuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:50:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F338420879;
        Tue, 11 Dec 2018 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543451;
        bh=1VOOndiWuh2uPhNbcWyPyNPQkpXvLj3dkMS+9ilQ+tM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EgL5tYiBjGkFx72vSjvjPyO2AISZHa5W541YZ9T4R1SVBLi9GDhd5zzAC4Dt41yA7
         uX+F3ZX1iHho7hORnhMYt/6J3ZcyNuwQ0tG04tqHEeLFuahBE8eZq7Y+d3+6+cg0QZ
         8TROGlkwmP/NCgjSQBW7oipsGFKUInLI/3eUVd1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH 4.9 29/51] ALSA: hda/realtek - Fix speaker output regression on Thinkpad T570
Date:   Tue, 11 Dec 2018 16:41:37 +0100
Message-Id: <20181211151616.525856490@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 54947cd64c1b8290f64bb2958e343c07270e3a58 upstream.

We've got a regression report for some Thinkpad models (at least
T570s) which shows the too low speaker output volume.  The bisection
leaded to the commit 61fcf8ece9b6 ("ALSA: hda/realtek - Enable Thinkpad
Dock device for ALC298 platform"), and it's basically adding the two
pin configurations for the dock, and looks harmless.

The real culprit seems, though, that the DAC assignment for the
speaker pin is implicitly assumed on these devices, i.e. pin NID 0x14
to be coupled with DAC NID 0x03.  When more pins are configured by the
commit above, the auto-parser changes the DAC assignment, and this
resulted in the regression.

As a workaround, just provide the fixed pin / DAC mapping table for
this Thinkpad fixup function.  It's no generic solution, but the
problem itself is pretty much device-specific, so must be good
enough.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1554304
Fixes: 61fcf8ece9b6 ("ALSA: hda/realtek - Enable Thinkpad Dock device for ALC298 platform")
Cc: <stable@vger.kernel.org>
Reported-and-tested-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4489,9 +4489,18 @@ static void alc_fixup_tpt470_dock(struct
 		{ 0x19, 0x21a11010 }, /* dock mic */
 		{ }
 	};
+	/* Assure the speaker pin to be coupled with DAC NID 0x03; otherwise
+	 * the speaker output becomes too low by some reason on Thinkpads with
+	 * ALC298 codec
+	 */
+	static hda_nid_t preferred_pairs[] = {
+		0x14, 0x03, 0x17, 0x02, 0x21, 0x02,
+		0
+	};
 	struct alc_spec *spec = codec->spec;
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->gen.preferred_dacs = preferred_pairs;
 		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
 		snd_hda_apply_pincfgs(codec, pincfgs);
 	} else if (action == HDA_FIXUP_ACT_INIT) {


