Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SwSdB7PzG1sTZwAAmS7hNA
	; Sat, 09 Jun 2018 15:35:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4AE4D608B8; Sat,  9 Jun 2018 15:35:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrRSNvVa"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8104F608BF;
	Sat,  9 Jun 2018 15:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8104F608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933014AbeFIPfN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932776AbeFIPfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:35:10 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F8EE208A4;
        Sat,  9 Jun 2018 15:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558510;
        bh=BEOubpUqu/mjoQKNr8qBUh7vMgsVT559R35a+3N0oKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrRSNvVaVR+v13goIYKPLD0p64yzsVMca2oCL7MTNGnnmX6XM/HBhe7WqZoCjo2VJ
         Q2nAV52LpPG99NnOF3sTvyYuNrR0QH94M8qYIcvXPw4wZ2z59yPS2s+LiqowcN7Pfo
         rasl3f0DLSwXUJWr+3h70Hl7Fs7Bs5jCdGAeLnFk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shahed Shaikh <shahed.shaikh@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 25/41] qed: Fix mask for physical address in ILT entry
Date: Sat,  9 Jun 2018 17:29:57 +0200
Message-Id: <20180609152927.786265776@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -77,7 +77,7 @@
 #define ILT_CFG_REG(cli, reg)	PSWRQ2_REG_ ## cli ## _ ## reg ## _RT_OFFSET
 
 /* ILT entry structure */
-#define ILT_ENTRY_PHY_ADDR_MASK		0x000FFFFFFFFFFFULL
+#define ILT_ENTRY_PHY_ADDR_MASK		(~0ULL >> 12)
 #define ILT_ENTRY_PHY_ADDR_SHIFT	0
 #define ILT_ENTRY_VALID_MASK		0x1ULL
 #define ILT_ENTRY_VALID_SHIFT		52
