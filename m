Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B66C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB0A20866
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956047;
	bh=ds9FF20BnykGRTcmKFayJJvurLLj5+5W+o6tVKpYW9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FU3lJ8tU19BcbIxyGe42bFIpfaJX+5zGfE4od2hBce7fw9jda6aHGvkGIPY33JSp5
	 quhlYnncRt1A9oY+p/2VLPIcUFlhEwKXtTpvzerfgCuVRHSUhlJfqhL8gN/xDRgQBI
	 LTagpaknFpkB3UGt+aqZNz77L/BJMYXC5UVLAERc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfBWVHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbfBWVHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:07:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 160922085A;
        Sat, 23 Feb 2019 21:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956040;
        bh=ds9FF20BnykGRTcmKFayJJvurLLj5+5W+o6tVKpYW9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F3xWg/9BknVk27muK2GWCXQvoJ2byhC0H0ddaMPt3sSEc9ZYWZGIAse0c/51QkXUZ
         XTMVbI+XiBzmLugkIjpqjcl+tc2hgwpSG3RRJ4MTvjiT8Ngb2O9XyVMRc/yRofzJk5
         aAl1ZUvrpIqa25VpQOsDk0QFNcw8qyL3HB1qMW7w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.19 23/65] xtensa: smp_lx200_defconfig: fix vectors clash
Date:   Sat, 23 Feb 2019 16:05:58 -0500
Message-Id: <20190223210640.200911-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit 306b38305c0f86de7f17c5b091a95451dcc93d7d ]

Secondary CPU reset vector overlaps part of the double exception handler
code, resulting in weird crashes and hangups when running user code.
Move exception vectors one page up so that they don't clash with the
secondary CPU reset vector.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/configs/smp_lx200_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/configs/smp_lx200_defconfig b/arch/xtensa/configs/smp_lx200_defconfig
index 11fed6c06a7c6..b5938160fb3dd 100644
--- a/arch/xtensa/configs/smp_lx200_defconfig
+++ b/arch/xtensa/configs/smp_lx200_defconfig
@@ -33,6 +33,7 @@ CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 # CONFIG_INITIALIZE_XTENSA_MMU_INSIDE_VMLINUX is not set
 # CONFIG_PCI is not set
+CONFIG_VECTORS_OFFSET=0x00002000
 CONFIG_XTENSA_PLATFORM_XTFPGA=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=96M@0"
-- 
2.19.1

