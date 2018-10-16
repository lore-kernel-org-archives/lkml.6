Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE43C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B7821476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEhYW1s/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B7821476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbeJQBFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJQBFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4B3D2098A;
        Tue, 16 Oct 2018 17:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710051;
        bh=3mKniZz0VdZ52+ka5ehjdSjAZutOgqjFf+NSzSQf40o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEhYW1s/sZftTql5FW7gptcHfmLRT0v8BxVVk1zRG/6roUD59wMWZxvPEngUgSwqH
         wONN9lcxsVlblx0xfg8M70MngmHf0NhzlF6PhTICw4D6JOYrOOGNFpMPYrY9jZpiSL
         piWOi85270qlOb9HeYGra7rUNzzTNHro4bo4jCbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Yu Zhao <yuzhao@google.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 089/135] sound: enable interrupt after dma buffer initialization
Date:   Tue, 16 Oct 2018 19:05:19 +0200
Message-Id: <20181016170521.518322703@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Zhao <yuzhao@google.com>

[ Upstream commit b61749a89f826eb61fc59794d9e4697bd246eb61 ]

In snd_hdac_bus_init_chip(), we enable interrupt before
snd_hdac_bus_init_cmd_io() initializing dma buffers. If irq has
been acquired and irq handler uses the dma buffer, kernel may crash
when interrupt comes in.

Fix the problem by postponing enabling irq after dma buffer
initialization. And warn once on null dma buffer pointer during the
initialization.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/hda/hdac_controller.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -40,6 +40,8 @@ static void azx_clear_corbrp(struct hdac
  */
 void snd_hdac_bus_init_cmd_io(struct hdac_bus *bus)
 {
+	WARN_ON_ONCE(!bus->rb.area);
+
 	spin_lock_irq(&bus->reg_lock);
 	/* CORB set up */
 	bus->corb.addr = bus->rb.addr;
@@ -479,13 +481,15 @@ bool snd_hdac_bus_init_chip(struct hdac_
 	/* reset controller */
 	azx_reset(bus, full_reset);
 
-	/* initialize interrupts */
+	/* clear interrupts */
 	azx_int_clear(bus);
-	azx_int_enable(bus);
 
 	/* initialize the codec command I/O */
 	snd_hdac_bus_init_cmd_io(bus);
 
+	/* enable interrupts after CORB/RIRB buffers are initialized above */
+	azx_int_enable(bus);
+
 	/* program the position buffer */
 	if (bus->use_posbuf && bus->posbuf.addr) {
 		snd_hdac_chip_writel(bus, DPLBASE, (u32)bus->posbuf.addr);


