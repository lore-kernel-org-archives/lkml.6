Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5F6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B556A2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1S4+nAmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B556A2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbeJQBKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbeJQBKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:10:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FAF521479;
        Tue, 16 Oct 2018 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710359;
        bh=rEBxJVp3zZjG+D8gXixClXDeB6ADdpmCK57rIFXeG8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1S4+nAmzStXZjoDbY900NvjBqDYdbqYfjAz/+3qZdueM5iKdnLwGe1DO1x4ix5zH3
         2lR3wlcRKOnxUqiaHRM0wk1BIykqdbhmZl9u+tAIOIavqZFHb0aiSq4tMeplxXjLok
         lOz+h8TTNXhzjegSMy0ypIP7a1Q7D6+dM7oyO5Cs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Yu Zhao <yuzhao@google.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 051/109] sound: dont call skl_init_chip() to reset intel skl soc
Date:   Tue, 16 Oct 2018 19:05:19 +0200
Message-Id: <20181016170527.713322162@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Zhao <yuzhao@google.com>

[ Upstream commit 75383f8d39d4c0fb96083dd460b7b139fbdac492 ]

Internally, skl_init_chip() calls snd_hdac_bus_init_chip() which
1) sets bus->chip_init to prevent multiple entrances before device
is stopped; 2) enables interrupt.

We shouldn't use it for the purpose of resetting device only because
1) when we really want to initialize device, we won't be able to do
so; 2) we are ready to handle interrupt yet, and kernel crashes when
interrupt comes in.

Rename azx_reset() to snd_hdac_bus_reset_link(), and use it to reset
device properly.

Fixes: 60767abcea3d ("ASoC: Intel: Skylake: Reset the controller in probe")
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/sound/hdaudio.h       |    1 +
 sound/hda/hdac_controller.c   |    7 ++++---
 sound/soc/intel/skylake/skl.c |    2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -357,6 +357,7 @@ void snd_hdac_bus_init_cmd_io(struct hda
 void snd_hdac_bus_stop_cmd_io(struct hdac_bus *bus);
 void snd_hdac_bus_enter_link_reset(struct hdac_bus *bus);
 void snd_hdac_bus_exit_link_reset(struct hdac_bus *bus);
+int snd_hdac_bus_reset_link(struct hdac_bus *bus, bool full_reset);
 
 void snd_hdac_bus_update_rirb(struct hdac_bus *bus);
 int snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned int status,
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -384,7 +384,7 @@ void snd_hdac_bus_exit_link_reset(struct
 EXPORT_SYMBOL_GPL(snd_hdac_bus_exit_link_reset);
 
 /* reset codec link */
-static int azx_reset(struct hdac_bus *bus, bool full_reset)
+int snd_hdac_bus_reset_link(struct hdac_bus *bus, bool full_reset)
 {
 	if (!full_reset)
 		goto skip_reset;
@@ -409,7 +409,7 @@ static int azx_reset(struct hdac_bus *bu
  skip_reset:
 	/* check to see if controller is ready */
 	if (!snd_hdac_chip_readb(bus, GCTL)) {
-		dev_dbg(bus->dev, "azx_reset: controller not ready!\n");
+		dev_dbg(bus->dev, "controller not ready!\n");
 		return -EBUSY;
 	}
 
@@ -424,6 +424,7 @@ static int azx_reset(struct hdac_bus *bu
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_hdac_bus_reset_link);
 
 /* enable interrupts */
 static void azx_int_enable(struct hdac_bus *bus)
@@ -478,7 +479,7 @@ bool snd_hdac_bus_init_chip(struct hdac_
 		return false;
 
 	/* reset controller */
-	azx_reset(bus, full_reset);
+	snd_hdac_bus_reset_link(bus, full_reset);
 
 	/* clear interrupts */
 	azx_int_clear(bus);
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -698,7 +698,7 @@ static int skl_first_init(struct hdac_ex
 		return -ENXIO;
 	}
 
-	skl_init_chip(bus, true);
+	snd_hdac_bus_reset_link(bus, true);
 
 	snd_hdac_bus_parse_capabilities(bus);
 


