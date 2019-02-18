Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C851C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C21A21906
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497707;
	bh=PuPGrBJzCNvJnrrNSzHWR2kp2tQqAFa4XMoqjEu+Z5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0TI6HnqG5i+/MfZ9Wf4hvuW7QVjSEhLB2KKo8IHrXvZ4pR00IxVLYV+PfBwEtgHCg
	 9i+X8e54AAO8p6QpRqIcyWyCHUzoUmTNcvPrXM9PgcRQzjvbbcwA4WhY2AS7skuHWx
	 3CaYZTOM3vqHHQyxtyntvE+5IGh3Heo/EaA8sKHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbfBRNsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:48:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbfBRNsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:48:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C93D21901;
        Mon, 18 Feb 2019 13:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497701;
        bh=PuPGrBJzCNvJnrrNSzHWR2kp2tQqAFa4XMoqjEu+Z5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lxRSTRsnj76Vu+AXs9e5Dj+bGr6bLa+k41u4x99yAzbpjUJVcscwisxDE2PCJ43xH
         7arp3vYyJCJTD4obWUaIEOZMl+6SR5ZRplSb415W9wu9P3AQILoly5wlerr4Iz7fkw
         kiJK3PPnqQ60/BnbBWWTXeeKL8zPZGtJ8Iwwegqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.20 59/92] ASoC: hdmi-codec: fix oops on re-probe
Date:   Mon, 18 Feb 2019 14:43:02 +0100
Message-Id: <20190218133500.377401228@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

From: Russell King <rmk+kernel@armlinux.org.uk>

commit 0ce23d6d42147a692768e6baaaa3db75c44f4235 upstream.

hdmi-codec oopses the kernel when it is unbound from a successfully
bound audio subsystem, and is then rebound:

Unable to handle kernel NULL pointer dereference at virtual address 0000001c
pgd = ee3f0000
[0000001c] *pgd=3cc59831
Internal error: Oops: 817 [#1] PREEMPT ARM
Modules linked in: ext2 snd_soc_spdif_tx vmeta dove_thermal snd_soc_kirkwood ofpart marvell_cesa m25p80 orion_wdt mtd spi_nor des_generic gpio_ir_recv snd_soc_kirkwood_spdif bmm_dmabuf auth_rpcgss nfsd autofs4 etnaviv thermal_sys hwmon gpu_sched tda9950
CPU: 0 PID: 1005 Comm: bash Not tainted 4.20.0+ #1762
Hardware name: Marvell Dove (Cubox)
PC is at hdmi_dai_probe+0x68/0x80
LR is at find_held_lock+0x20/0x94
pc : [<c04c7de0>]    lr : [<c0063bf4>]    psr: 600f0013
sp : ee15bd28  ip : eebd8b1c  fp : c093b488
r10: ee048000  r9 : eebdab18  r8 : ee048600
r7 : 00000001  r6 : 00000000  r5 : 00000000  r4 : ee82c100
r3 : 00000006  r2 : 00000001  r1 : c067e38c  r0 : ee82c100
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none[  297.318599] Control: 10c5387d  Table: 2e3f0019  DAC: 00000051
Process bash (pid: 1005, stack limit = 0xee15a248)
...
[<c04c7de0>] (hdmi_dai_probe) from [<c04b7060>] (soc_probe_dai.part.9+0x34/0x70)
[<c04b7060>] (soc_probe_dai.part.9) from [<c04b81a8>] (snd_soc_instantiate_card+0x734/0xc9c)
[<c04b81a8>] (snd_soc_instantiate_card) from [<c04b8b6c>] (snd_soc_add_component+0x29c/0x378)
[<c04b8b6c>] (snd_soc_add_component) from [<c04b8c8c>] (snd_soc_register_component+0x44/0x54)
[<c04b8c8c>] (snd_soc_register_component) from [<c04c64b4>] (devm_snd_soc_register_component+0x48/0x84)
[<c04c64b4>] (devm_snd_soc_register_component) from [<c04c7be8>] (hdmi_codec_probe+0x150/0x260)
[<c04c7be8>] (hdmi_codec_probe) from [<c0373124>] (platform_drv_probe+0x48/0x98)

This happens because hdmi_dai_probe() attempts to access the HDMI
codec private data, but this has not been assigned by hdmi_dai_probe()
before it calls devm_snd_soc_register_component().  Move the call to
dev_set_drvdata() before devm_snd_soc_register_component() to avoid
this oops.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/hdmi-codec.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -795,6 +795,8 @@ static int hdmi_codec_probe(struct platf
 	if (hcd->spdif)
 		hcp->daidrv[i] = hdmi_spdif_dai;
 
+	dev_set_drvdata(dev, hcp);
+
 	ret = devm_snd_soc_register_component(dev, &hdmi_driver, hcp->daidrv,
 				     dai_count);
 	if (ret) {
@@ -802,8 +804,6 @@ static int hdmi_codec_probe(struct platf
 			__func__, ret);
 		return ret;
 	}
-
-	dev_set_drvdata(dev, hcp);
 	return 0;
 }
 


