Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35BCC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F8D21736
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078441;
	bh=r/O1TWZH5c9f+9x6AzxjbAYmoQmRNamrOmVm2ech1gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1CswsJ+n7TAddXd3+S/eFI/r613KpiSKy4L2Wy47DU+vW92K/p2PrAZDv01BnzBKG
	 AHhr9D2SMU2/JE2R4alNvplfWCQeTsVwZ4tWIlPgLq1efsi1+5OY1bWFHrtdJYgqG6
	 irVUEZwvQQk5DqTevRc18HWIf0UlKtYwLIKIbGpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfAUNrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:47:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbfAUNrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:47:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9C3320861;
        Mon, 21 Jan 2019 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078435;
        bh=r/O1TWZH5c9f+9x6AzxjbAYmoQmRNamrOmVm2ech1gE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unuTBGwox5XLl/KvCToK9u/GJblEcCEuA+A+57sU7iAbqhxeEFoHeoOgTtz/ASsSc
         GQJ6MOUHd1gInAmuijIEPMkhuh/ghuZLwDmg83+ufM3IeTiWsNVxCUMwgf934W5vxI
         d/tsR7IClTXpEbLjXTIoE7Otkmwvte81gv1v8CHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 030/111] r8169: dont try to read counters if chip is in a PCI power-save state
Date:   Mon, 21 Jan 2019 14:42:24 +0100
Message-Id: <20190121122459.169156765@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 10262b0b53666cbc506989b17a3ead1e9c3b43b4 ]

Avoid log spam caused by trying to read counters from the chip whilst
it is in a PCI power-save state.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=107421

Fixes: 1ef7286e7f36 ("r8169: Dereference MMIO address immediately before use")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -1729,11 +1729,13 @@ static bool rtl8169_reset_counters(struc
 
 static bool rtl8169_update_counters(struct rtl8169_private *tp)
 {
+	u8 val = RTL_R8(tp, ChipCmd);
+
 	/*
 	 * Some chips are unable to dump tally counters when the receiver
-	 * is disabled.
+	 * is disabled. If 0xff chip may be in a PCI power-save state.
 	 */
-	if ((RTL_R8(tp, ChipCmd) & CmdRxEnb) == 0)
+	if (!(val & CmdRxEnb) || val == 0xff)
 		return true;
 
 	return rtl8169_do_counters(tp, CounterDump);


