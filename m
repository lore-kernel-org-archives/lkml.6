Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711E3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416772173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864520;
	bh=FTvbUirvDsDIz2hvqX6aZinOBj+wJrWfwj+zW384bG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S+HOq/FHKTVcuXjMHRmB5IYTI/PYs/+Prm/1r1YMkHNVXQ86Zpy8BPw0GDM+Dy7Q6
	 8p96yBiZUg0MEOqQxXhJYL87YuLVk/BMYCF0NHImdiTwOEsO4TJtOH2/MNPsNNmn/D
	 yoJF+dwLIAqPJrb4iXHgT/laFCHAzfWkwPrEOFR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfAGMfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfAGMfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:35:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA81F206BB;
        Mon,  7 Jan 2019 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864515;
        bh=FTvbUirvDsDIz2hvqX6aZinOBj+wJrWfwj+zW384bG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y1mUDGicrgXU6I3EQsrvbBchj1q3V76K5WmPimUXYmCGTsmO2LFPfkzr01Dj1wy0g
         SHWSi4ohTf+Bo1sD2KYH+SKMfUd9dTflgcPPnDIPUmGvW0JalLNHIyzKOUf869Uf3g
         g8/c/hzQSQ4VIzlNG3x5Vumxhg4pqmoRBTlM5ANU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mohan Kumar <mkumard@nvidia.com>,
        Dara Ramesh <dramesh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 037/145] ALSA: hda/tegra: clear pending irq handlers
Date:   Mon,  7 Jan 2019 13:31:14 +0100
Message-Id: <20190107104442.167120233@linuxfoundation.org>
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

From: Sameer Pujar <spujar@nvidia.com>

commit 63d2a9ec310d8bcc955574220d4631aa55c1a80c upstream.

Even after disabling interrupts on the module, it could be possible
that irq handlers are still running. System hang is seen during
suspend path. It was found that, there were pending writes on the
HDA bus and clock was disabled by that time.

Above mentioned issue is fixed by clearing any pending irq handlers
before disabling clocks and returning from hda suspend.

Suggested-by: Mohan Kumar <mkumard@nvidia.com>
Suggested-by: Dara Ramesh <dramesh@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_tegra.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -233,10 +233,12 @@ static int hda_tegra_suspend(struct devi
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip = card->private_data;
 	struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
+	struct hdac_bus *bus = azx_bus(chip);
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
 	azx_stop_chip(chip);
+	synchronize_irq(bus->irq);
 	azx_enter_link_reset(chip);
 	hda_tegra_disable_clocks(hda);
 


