Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084D6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A85214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOPD6xKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A85214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbeKTDGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:06:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732956AbeKTDGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:06:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9CF32147D;
        Mon, 19 Nov 2018 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645726;
        bh=CmRlZmAzFOtBjptFIZQBjMrfzNP9aJvGkPUbcf74WcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOPD6xKxo932pvoT/j6C3n0vmfKmPdsA4+N731PBj+XhnJaHwLPnca19UPWBMHT7P
         GkLxc1YJZJ2QlfFlzXntHht+++tydfmEp/I4qotLMzW6PNEodSC4kUlD4CdoIR9qs6
         3TSFO7LX0rWsBSyz+XAM4Tr5vyaOjGpdZTY0QnK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 4.18 065/171] clk: sunxi-ng: h6: fix bus clocks divider position
Date:   Mon, 19 Nov 2018 17:27:41 +0100
Message-Id: <20181119162630.407619408@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
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

From: Icenowy Zheng <icenowy@aosc.io>

commit 2852bfbf4f168fec27049ad9ed20941fc9e84b95 upstream.

The bus clocks (AHB/APB) on Allwinner H6 have their second divider start
at bit 8, according to the user manual and the BSP code. However,
currently the divider offset is incorrectly set to 16, thus the divider
is not correctly read and the clock frequency is not correctly calculated.

Fix this bit offset on all affected bus clocks in ccu-sun50i-h6.

Cc: stable@vger.kernel.org # v4.17.y
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -224,7 +224,7 @@ static SUNXI_CCU_MP_WITH_MUX(psi_ahb1_ah
 			     psi_ahb1_ahb2_parents,
 			     0x510,
 			     0, 5,	/* M */
-			     16, 2,	/* P */
+			     8, 2,	/* P */
 			     24, 2,	/* mux */
 			     0);
 
@@ -233,19 +233,19 @@ static const char * const ahb3_apb1_apb2
 						       "pll-periph0" };
 static SUNXI_CCU_MP_WITH_MUX(ahb3_clk, "ahb3", ahb3_apb1_apb2_parents, 0x51c,
 			     0, 5,	/* M */
-			     16, 2,	/* P */
+			     8, 2,	/* P */
 			     24, 2,	/* mux */
 			     0);
 
 static SUNXI_CCU_MP_WITH_MUX(apb1_clk, "apb1", ahb3_apb1_apb2_parents, 0x520,
 			     0, 5,	/* M */
-			     16, 2,	/* P */
+			     8, 2,	/* P */
 			     24, 2,	/* mux */
 			     0);
 
 static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", ahb3_apb1_apb2_parents, 0x524,
 			     0, 5,	/* M */
-			     16, 2,	/* P */
+			     8, 2,	/* P */
 			     24, 2,	/* mux */
 			     0);
 


