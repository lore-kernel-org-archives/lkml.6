Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A11C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDF821783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216267;
	bh=OIsowgbriFpDzFUx/E/wBCj243I9ujx5HvZrXopR8Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P8v2X9t9KFvAs6d1AHWHg3Yq/OlTaL2UnLyWgCQjiiOrmwFUVbDJTPcuF5mcfdjiE
	 wEMoOvDF0XUjm0tjFu+ddkJ1h0/a3oILpO/JqOYy/MUv5JOqBD31xUu+WpZ3IXrquA
	 ZUYFpMzQcOuD6Yd7VOMAUPFx4wd3H/EGQb6xX4Wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbfAKORq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731271AbfAKORm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:17:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A5282184A;
        Fri, 11 Jan 2019 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216261;
        bh=OIsowgbriFpDzFUx/E/wBCj243I9ujx5HvZrXopR8Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZU8fgZxMsDcsP698gHGjXqw5hz+7Md1vcYKiqP5QJV8zuW7Z29yTs8Biu0JgskRT
         Ujv43wTtpXTGM1atK0aUIgeGzDwH8Yw+m7+GKixc9TC9THdClZ40csDkPnvyuOBfUd
         aGSQmdql7npfd7f9bZFn2AUgVPFGqZIfTz7osixU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 34/88] ALSA: hda: add mute LED support for HP EliteBook 840 G4
Date:   Fri, 11 Jan 2019 15:08:03 +0100
Message-Id: <20190111131050.973773748@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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
@@ -853,6 +853,7 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x103c, 0x8079, "HP EliteBook 840 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83b3, "HP EliteBook 830 G5", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83d3, "HP ProBook 640 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),


