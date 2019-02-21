Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8C1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECDC214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxxmxxcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfBUJ5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:57:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43760 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfBUJ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:57:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id d17so14794005wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 01:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8j2ytOrBalE8dCvMN+q0V+h8lDjSPVFNoh2OR47tXqs=;
        b=lxxmxxcNq3rhc0A/JukvbAnDPxZm6EmlfBApLSzmidC8OF73OZpdBLb8kVQm1F3nWF
         bdzaT8Egn2joJ2Er0IT1qgEIoJAXQUfEdkoEFuqQTV1itSZi8OzIDNGxpNLTFvmXnh2h
         SHfZwcjdg8B158y67PufvMpahlt4kvXSK4eitQyy7sp6xIH16hX1vp/n/+T43ElfAfuh
         MBm57iz1lbdXcW/ckORSQtkv4UnTouaSLFoIHnt/HGtcHuOe0l2jlHmMra3mJCju+9ZC
         QV9LaLptIGUXMDYQH5e4sV64YidMh6dDQ0nPqJqskwGMUuG1N06PizE/HqjAGLU4aFm/
         mnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8j2ytOrBalE8dCvMN+q0V+h8lDjSPVFNoh2OR47tXqs=;
        b=AI8MLLIW4OoPDGzEQBjNPOmAbSspHUJzkLq+MLEAeuIIzXL95drcIX3fjLGN5VHOQg
         u6pIgFBGNQb2+qH2n2r+0CL4dCs1EHUbZgYJlVQuej2sVEQVkVhuyrka52xjQmzfLm7g
         sW3dV1YSoNmEAFTpZjyC8ZQ9uVTolMywhcSGlVdmbQVhKDjRmhb7SCOZvmtbIpXv0hXW
         Ij4wksvg4XcgBIoGhpHwtVHFAS62/t4ZT8Q6WbBhQJSZrPJXKCNBJRiaQ52mE5AhhSOO
         H8/Lm3Vl+tA+OXMizw5MRVR3Ge3xAKqcZEGddKXTylPqtZiZFDGWrKeUHXmtI9FKXs+9
         zbOQ==
X-Gm-Message-State: AHQUAuYmwzKVYZGXcSbe4t9WcYi8tCyVT4BMHz2mhauVa9MU3lWFohdQ
        sobfMXRzy/ES/WY5CNTIa5U=
X-Google-Smtp-Source: AHgI3IZXDlaslGuaTI0SsddrV0uDE7ASgumy2D7xi9mwWTjxDPV2svecYJtVx/QpIe3OWXozZToY+A==
X-Received: by 2002:a05:6000:104b:: with SMTP id c11mr26239060wrx.9.1550743020518;
        Thu, 21 Feb 2019 01:57:00 -0800 (PST)
Received: from localhost.localdomain ([2001:470:9e39::64])
        by smtp.gmail.com with ESMTPSA id r6sm8960791wrx.48.2019.02.21.01.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 01:56:59 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] MIPS: BCM63XX: provide DMA masks for ethernet devices
Date:   Thu, 21 Feb 2019 10:56:42 +0100
Message-Id: <20190221095642.26962-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The switch to the generic dma ops made dma masks mandatory, breaking
devices having them not set. In case of bcm63xx, it broke ethernet with
the following warning when trying to up the device:

[    2.633123] ------------[ cut here ]------------
[    2.637949] WARNING: CPU: 0 PID: 325 at ./include/linux/dma-mapping.h:516 bcm_enetsw_open+0x160/0xbbc
[    2.647423] Modules linked in: gpio_button_hotplug
[    2.652361] CPU: 0 PID: 325 Comm: ip Not tainted 4.19.16 #0
[    2.658080] Stack : 80520000 804cd3ec 00000000 00000000 804ccc00 87085bdc 87d3f9d4 804f9a17
[    2.666707]         8049cf18 00000145 80a942a0 00000204 80ac0000 10008400 87085b90 eb3d5ab7
[    2.675325]         00000000 00000000 80ac0000 000022b0 00000000 00000000 00000007 00000000
[    2.683954]         0000007a 80500000 0013b381 00000000 80000000 00000000 804a1664 80289878
[    2.692572]         00000009 00000204 80ac0000 00000200 00000002 00000000 00000000 80a90000
[    2.701191]         ...
[    2.703701] Call Trace:
[    2.706244] [<8001f3c8>] show_stack+0x58/0x100
[    2.710840] [<800336e4>] __warn+0xe4/0x118
[    2.715049] [<800337d4>] warn_slowpath_null+0x48/0x64
[    2.720237] [<80289878>] bcm_enetsw_open+0x160/0xbbc
[    2.725347] [<802d1d4c>] __dev_open+0xf8/0x16c
[    2.729913] [<802d20cc>] __dev_change_flags+0x100/0x1c4
[    2.735290] [<802d21b8>] dev_change_flags+0x28/0x70
[    2.740326] [<803539e0>] devinet_ioctl+0x310/0x7b0
[    2.745250] [<80355fd8>] inet_ioctl+0x1f8/0x224
[    2.749939] [<802af290>] sock_ioctl+0x30c/0x488
[    2.754632] [<80112b34>] do_vfs_ioctl+0x740/0x7dc
[    2.759459] [<80112c20>] ksys_ioctl+0x50/0x94
[    2.763955] [<800240b8>] syscall_common+0x34/0x58
[    2.768782] ---[ end trace fb1a6b14d74e28b6 ]---
[    2.773544] bcm63xx_enetsw bcm63xx_enetsw.0: cannot allocate rx ring 512

Fix this by adding appropriate DMA masks for the platform devices.

Fixes: f8c55dc6e828 ("MIPS: use generic dma noncoherent ops for simple noncoherent platforms")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/dev-enet.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
index 07b4c65a88a4..8e73d65f3480 100644
--- a/arch/mips/bcm63xx/dev-enet.c
+++ b/arch/mips/bcm63xx/dev-enet.c
@@ -70,6 +70,8 @@ static struct platform_device bcm63xx_enet_shared_device = {
 
 static int shared_device_registered;
 
+static u64 enet_dmamask = DMA_BIT_MASK(32);
+
 static struct resource enet0_res[] = {
 	{
 		.start		= -1, /* filled at runtime */
@@ -99,6 +101,8 @@ static struct platform_device bcm63xx_enet0_device = {
 	.resource	= enet0_res,
 	.dev		= {
 		.platform_data = &enet0_pd,
+		.dma_mask = &enet_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
@@ -131,6 +135,8 @@ static struct platform_device bcm63xx_enet1_device = {
 	.resource	= enet1_res,
 	.dev		= {
 		.platform_data = &enet1_pd,
+		.dma_mask = &enet_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
@@ -157,6 +163,8 @@ static struct platform_device bcm63xx_enetsw_device = {
 	.resource	= enetsw_res,
 	.dev		= {
 		.platform_data = &enetsw_pd,
+		.dma_mask = &enet_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
-- 
2.13.2

