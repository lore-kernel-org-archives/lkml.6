Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DDC0DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DCF208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="asrL56Kw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DCF208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935112AbeFLQxQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754343AbeFLQxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:53:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35967208BA;
        Tue, 12 Jun 2018 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822388;
        bh=ka5Ym23zn3/4xWhph80MyzDON/TUTgyRgTmHX9+WiAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=asrL56KwYB4SfXDHdJMp3mDVfvYEG+3TH1UX7/AJLFcPzpe4bieukK4onNl8hUXSW
         Gdghl2ueTdajeXLZ6akB1vm83EFdH+W6x0gfXeeuuQuquxmDmPbiODPD6MK2DzlUIV
         a188mazk+2RRuuSqjiy9Die3Cjbk621V0q2vnGnA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shahed Shaikh <shahed.shaikh@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 19/24] qed: Fix mask for physical address in ILT entry
Date:   Tue, 12 Jun 2018 18:52:03 +0200
Message-Id: <20180612164817.625996766@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164816.587001852@linuxfoundation.org>
References: <20180612164816.587001852@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shahed Shaikh <shahed.shaikh@cavium.com>

[ Upstream commit fdd13dd350dda1826579eb5c333d76b14513b812 ]

ILT entry requires 12 bit right shifted physical address.
Existing mask for ILT entry of physical address i.e.
ILT_ENTRY_PHY_ADDR_MASK is not sufficient to handle 64bit
address because upper 8 bits of 64 bit address were getting
masked which resulted in completer abort error on
PCIe bus due to invalid address.

Fix that mask to handle 64bit physical address.

Fixes: fe56b9e6a8d9 ("qed: Add module with basic common support")
Signed-off-by: Shahed Shaikh <shahed.shaikh@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -43,7 +43,7 @@
 #define ILT_CFG_REG(cli, reg)	PSWRQ2_REG_ ## cli ## _ ## reg ## _RT_OFFSET
 
 /* ILT entry structure */
-#define ILT_ENTRY_PHY_ADDR_MASK		0x000FFFFFFFFFFFULL
+#define ILT_ENTRY_PHY_ADDR_MASK		(~0ULL >> 12)
 #define ILT_ENTRY_PHY_ADDR_SHIFT	0
 #define ILT_ENTRY_VALID_MASK		0x1ULL
 #define ILT_ENTRY_VALID_SHIFT		52


