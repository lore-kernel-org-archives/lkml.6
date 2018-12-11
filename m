Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A5BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5042084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544210;
	bh=oMN39gJY+oW5mJwwdkvf+tU8wHXgMlh4AWt5bQuMe/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rDXZ5uc5SyaHJwRAD/XLRKD6Z7A+Z0LrVwgVK7qXciONKF+O96HZG0oJKrYVg2SYF
	 ZOE+seXwRDHZ8w3rKbwey6vNNy1Vp/Z0M9VFVnUJMvbRgKRQMVjRFYItHF/BDi4c6y
	 710Os1hhew2dn5bO2Ah5lFMN68oc2h73HAYCzNbw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5042084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbeLKQD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:03:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730116AbeLKP4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6E40205C9;
        Tue, 11 Dec 2018 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543796;
        bh=oMN39gJY+oW5mJwwdkvf+tU8wHXgMlh4AWt5bQuMe/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MBHL4qy3UGTsutHj2jbKBNHonEvhl7wncj4UYogngKzzpF2QUPrUCl9m5Rp5McsAp
         Qns6g64TtxFsAUURxNTltKw1msaUzRqmy5Mks8sgnKhQf7c2jB7focQrmJCISReNqU
         8UvKX/xc3kq1bgw7DrxP7PUO9C38WethncmreWI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH 4.19 066/118] ALSA: hda/realtek - Fix speaker output regression on Thinkpad T570
Date:   Tue, 11 Dec 2018 16:41:25 +0100
Message-Id: <20181211151646.901919487@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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
@@ -4988,9 +4988,18 @@ static void alc_fixup_tpt470_dock(struct
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


