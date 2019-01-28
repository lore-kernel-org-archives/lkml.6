Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A154C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1537320855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696375;
	bh=XHvGrq9LUVK3VhEp6c72qxwXepi97IZhYICnHguuWkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WsH5PgWU47HYdrdXxpMsAe5g3IPKwmaWEVYhxvnp5mUxeUMkt20BIUJYmBNi74oz/
	 s9wS+40wnNtCaWIxSeUGhr9vqUOxvLLWqCSh2OkBX0XDtpY/WBIU5uvZbxIUCyigA+
	 KxW3SXMV2es0qUUxR2L5PdkUa4CpyNeYLLGEha1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfA1R0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:26:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730840AbfA1QAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:00:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B593F2175B;
        Mon, 28 Jan 2019 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691245;
        bh=XHvGrq9LUVK3VhEp6c72qxwXepi97IZhYICnHguuWkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHC04QZ/Xt6uiqaYq1+c6ae41+nPvb4rsYdnya/vXNd+X+CXPCWk6qQCJ2uE9J4vW
         NcsWpn0xY14E0CCsm6IooUEWZTU3BViMgciDtGYnnJOhLjdPm4U9Lh7zLoql+/IVf3
         7palLnwIjaUzAScVGPemy7tWj1M1Moe6ND0+lBMM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 031/258] MIPS: Boston: Disable EG20T prefetch
Date:   Mon, 28 Jan 2019 10:55:37 -0500
Message-Id: <20190128155924.51521-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit 5ec17af7ead09701e23d2065e16db6ce4e137289 ]

The Intel EG20T Platform Controller Hub used on the MIPS Boston
development board supports prefetching memory to optimize DMA transfers.
Unfortunately for unknown reasons this doesn't work well with some MIPS
CPUs such as the P6600, particularly when using an I/O Coherence Unit
(IOCU) to provide cache-coherent DMA. In these systems it is common for
DMA data to be lost, resulting in broken access to EG20T devices such as
the MMC or SATA controllers.

Support for a DT property to configure the prefetching was added a while
back by commit 549ce8f134bd ("misc: pch_phub: Read prefetch value from
device tree if passed") but we never added the DT snippet to make use of
it. Add that now in order to disable the prefetching & fix DMA on the
affected systems.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/21068/
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/img/boston.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/img/boston.dts b/arch/mips/boot/dts/img/boston.dts
index 65af3f6ba81c..84328afa3a55 100644
--- a/arch/mips/boot/dts/img/boston.dts
+++ b/arch/mips/boot/dts/img/boston.dts
@@ -141,6 +141,12 @@
 				#size-cells = <2>;
 				#interrupt-cells = <1>;
 
+				eg20t_phub@2,0,0 {
+					compatible = "pci8086,8801";
+					reg = <0x00020000 0 0 0 0>;
+					intel,eg20t-prefetch = <0>;
+				};
+
 				eg20t_mac@2,0,1 {
 					compatible = "pci8086,8802";
 					reg = <0x00020100 0 0 0 0>;
-- 
2.19.1

