Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD94C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5591F208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5591F208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeHUJpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:45:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeHUJpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:45:23 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BF05A516;
        Tue, 21 Aug 2018 06:26:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Park Ju Hyung <qkrwngud825@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 11/29] ALSA: hda - Turn CX8200 into D3 as well upon reboot
Date:   Tue, 21 Aug 2018 08:21:04 +0200
Message-Id: <20180821055108.863307657@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055108.333930282@linuxfoundation.org>
References: <20180821055108.333930282@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Park Ju Hyung <qkrwngud825@gmail.com>

commit d77a4b4a5b0b2ebcbc9840995d91311ef28302ab upstream.

As an equivalent codec with CX20724,
CX8200 is also subject to the reboot bug.

Late 2017 and 2018 LG Gram and some HP Spectre laptops are known victims
to this issue, causing extremely loud noises upon reboot.

Now that we know that this bug is subject to multiple codecs,
fix the comment as well.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_conexant.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -211,6 +211,7 @@ static void cx_auto_reboot_notify(struct
 	struct conexant_spec *spec = codec->spec;
 
 	switch (codec->core.vendor_id) {
+	case 0x14f12008: /* CX8200 */
 	case 0x14f150f2: /* CX20722 */
 	case 0x14f150f4: /* CX20724 */
 		break;
@@ -218,7 +219,7 @@ static void cx_auto_reboot_notify(struct
 		return;
 	}
 
-	/* Turn the CX20722 codec into D3 to avoid spurious noises
+	/* Turn the problematic codec into D3 to avoid spurious noises
 	   from the internal speaker during (and after) reboot */
 	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, false);
 


