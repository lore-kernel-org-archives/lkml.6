Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CCFC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C7C2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761893;
	bh=0ko9jGN0PEpY8Wna3EvTaOtSdk5PeNe87usXm1/cksw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e11ZVDPAzQaqYm46C/3vvdnYDspg80X7bQuYu042Daiy6g+gG0wPnPTu0Z49fBRFZ
	 KGlyt/gdd1TEpX0C/dRlVHSp2DnGT/bVyBASRV6/hiE7L6Nb5h81IcnL47Z2nJgsQM
	 p9C0FBoLTJeHNrU284q9qX3VZ81zbNgH/SGom5n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfA2LiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbfA2LiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B9A20844;
        Tue, 29 Jan 2019 11:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761885;
        bh=0ko9jGN0PEpY8Wna3EvTaOtSdk5PeNe87usXm1/cksw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZknZyTiWmAeVi6ESdouR2oX+2UfLKnuKoRf7rggbHt93FSYvhTx87KxCQ86H+tnW
         JcsazPgZXMU0JDyN/9AhyD3HuuSfWx5ry1Z/NcFxU9PnWQvzj9BXCakxTkRjQPHt9Z
         nM9Lc+a98AYJAH9iTFQ0YtVUh/iCoC+te3xyyRYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.20 035/117] clk: zynqmp: Fix memory allocation in zynqmp_clk_setup
Date:   Tue, 29 Jan 2019 12:34:46 +0100
Message-Id: <20190129113209.365355741@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 4f340efcb21220b7a0afcea3884e66f79e6f2306 upstream.

Fix memory allocation and use struct_size() in kzalloc(). This also
fixes the allocation size to be correct, and smaller, because before we
were allocating a bunch of sizeof(struct clk_hw_onecell_data) structures
for each struct clk_hw we needed.

Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
[sboyd@kernel.org: Expand commit text]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/zynqmp/clkc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -669,8 +669,8 @@ static int zynqmp_clk_setup(struct devic
 	if (ret)
 		return ret;
 
-	zynqmp_data = kzalloc(sizeof(*zynqmp_data) + sizeof(*zynqmp_data) *
-						clock_max_idx, GFP_KERNEL);
+	zynqmp_data = kzalloc(struct_size(zynqmp_data, hws, clock_max_idx),
+			      GFP_KERNEL);
 	if (!zynqmp_data)
 		return -ENOMEM;
 


