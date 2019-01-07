Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F7AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891B1206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864790;
	bh=i5n6hfH+NEUfjM5tUfQncxg62BtAo63ja5X0SWWaskk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DOYE9xK+ysM9zMKga79IJ48VHNo8UskPXXxJ+FgZv0D6Ll1GQjD8VJwZZy5aRcizB
	 p6t0j5fKcHqrSS3y92qU9OaKeOzQrKaSBT7PnVRtix/USDjHrX5Q7f/B5eOcvEd8nC
	 GznezxSM1z6Q7yzOobMA1SMvN1F6D/dbtbQK6mkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfAGMjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:39:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbfAGMez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:34:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE55620859;
        Mon,  7 Jan 2019 12:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864495;
        bh=i5n6hfH+NEUfjM5tUfQncxg62BtAo63ja5X0SWWaskk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fE9ekTRNNv3MqC4+v8ewLG/dYda265IrxpXdEfa8/GVwL1DpwbzcAPg+VcVFGwtQ3
         OkvqETe7CWJrtqS1qN8yj8/3/8wUZ10WnlMm3nCFhiqr3G/esUmvjXaobMVSkHuMod
         jzfdFXeDbLccQ3YzC/u3gjU/psVAX/Felrs4D9qw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 030/145] ALSA: hda: add mute LED support for HP EliteBook 840 G4
Date:   Mon,  7 Jan 2019 13:31:07 +0100
Message-Id: <20190107104441.269435209@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


