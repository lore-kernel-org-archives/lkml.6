Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E63EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECF42229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896977;
	bh=0Cg8m3HF8hJa+hXvfTD1QCZFTmI/PyGXFhhxCNn2KhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rRStzUgLdtTwqxlyUhKvW9W90IAYhOcxp0ZMvpemOsHVvBlk9PgFEzTZUXIRmm0KJ
	 53p+5+pup2Cf/LoP38UxkRVU0mal5zMMvMV1kZA7xmmPB54Upa3f35DI4f/7qoJuzR
	 KokA8zWL4tTbu3P8OoNO/S8w0UbPIkNhGtww5YI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389130AbfBKO4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387999AbfBKO4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:56:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93DB4222A6;
        Mon, 11 Feb 2019 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896968;
        bh=0Cg8m3HF8hJa+hXvfTD1QCZFTmI/PyGXFhhxCNn2KhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=foe47IsAsVeAWEkBNmNklsWlRRfdyPcM5us8H3MW7dnRfJVzeA2Y/QUPF8UEQLrQc
         PkBD7reMcPeycmNAdqIZpUYGbLX8QLetTCFI1mmvPVo4hyab+ePsKNHiTqg43C1xUu
         cGtQkusIbaF8o781mdDlpXJB/73n8RsAaSJ/QrL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 020/205] MIPS: Boston: Disable EG20T prefetch
Date:   Mon, 11 Feb 2019 15:16:58 +0100
Message-Id: <20190211141828.462075576@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index f7aad80c69ab..bebb0fa21369 100644
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



