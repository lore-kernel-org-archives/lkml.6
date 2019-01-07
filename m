Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C25C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEB820665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865634;
	bh=RhKMB/Uq74mN8iTdt+rgI4aeTwRAtxlxwsNy/j25/4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZjzpqxewjvdTPs5Tagzs0jJCaJyM5CZSkeZIkqoOERIqKzx0K6sDkL4R0xi+B5U8h
	 C5J6d9dswef2II4rrJf7WE6Ey1hzTVqfjFfQBvKvPdfkKe69zMLJz0R4ir3vfkYG5J
	 RQgW6z6OU0voLa3H5NyOtIBadSLd/iwqDLNSKxS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfAGMxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:53:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729135AbfAGMxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:53:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9DBB20651;
        Mon,  7 Jan 2019 12:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865629;
        bh=RhKMB/Uq74mN8iTdt+rgI4aeTwRAtxlxwsNy/j25/4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zwo2/9TT657mG8CNq7NhMFetFjMFFYoriyaXy+aOJNFRhn24QvDdr8GoNujTja2fw
         PLir4m05jpIL2dCysvIQieJmufHwSOIMw2EhVMwpDcK+rekidEr6QrmNcb2eb/bw2u
         AzEfawGHhXPb8lC6NNfp8XD/XPaAqr7NUS5DEMSo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 068/170] ALSA: hda: add mute LED support for HP EliteBook 840 G4
Date:   Mon,  7 Jan 2019 13:31:35 +0100
Message-Id: <20190107104501.039367009@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Mantas Mikulėnas <grawity@gmail.com>

commit 40906ebe3af6a48457151b3c6726b480f6a6cb13 upstream.

Tested with 4.19.9.

v2: Changed from CXT_FIXUP_MUTE_LED_GPIO to CXT_FIXUP_HP_DOCK because
    that's what the existing fixups for EliteBooks use.

Signed-off-by: Mantas Mikulėnas <grawity@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_conexant.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -923,6 +923,7 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x103c, 0x8079, "HP EliteBook 840 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83b3, "HP EliteBook 830 G5", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83d3, "HP ProBook 640 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),


