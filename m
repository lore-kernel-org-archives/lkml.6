Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF412175B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDqofdIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF412175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbeKLITI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730142AbeKLITH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:07 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17E321780;
        Sun, 11 Nov 2018 22:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975351;
        bh=t/ET+aB9VpBhYf1d52B3nbWX4GjxOSDlef7Yix5yDg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDqofdIfnqCvK1cF1XCWv4dtNtteHR3zvAt0r9q/sIZPIEAYW/RHcEf7x3QWsEZdl
         9ig4IjybWoQH1uXHu2S7TJpO/o88ZmR9wjKjOZwc5op1lyxr6ZKwmM/XIp06AuSJn1
         MJUC0ClBuAULXw8ZztZlyW6u2VS+HcOWE+GwSOmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.18 001/350] mtd: rawnand: marvell: fix the IRQ handler complete() condition
Date:   Sun, 11 Nov 2018 14:17:45 -0800
Message-Id: <20181111221707.114515554@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 53c83b59759c1ee213f5ffa194909daee8902a28 upstream.

With the current implementation, the complete() in the IRQ handler is
supposed to be called only if the register status has one or the other
RDY bit set. Other events might trigger an interrupt as well if
enabled, but should not end-up with a complete() call.

For this purpose, the code was checking if the other bits were set, in
this case complete() was not called. This is wrong as two events might
happen in a very tight time-frame and if the NDSR status read reports
two bits set (eg. RDY(0) and RDDREQ) at the same time, complete() was
not called.

This logic would lead to timeouts in marvell_nfc_wait_op() and has
been observed on PXA boards (NFCv1) in the Hamming write path.

Fixes: 02f26ecf8c77 ("mtd: nand: add reworked Marvell NAND controller driver")
Cc: stable@vger.kernel.org
Reported-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/marvell_nand.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -691,7 +691,7 @@ static irqreturn_t marvell_nfc_isr(int i
 
 	marvell_nfc_disable_int(nfc, st & NDCR_ALL_INT);
 
-	if (!(st & (NDSR_RDDREQ | NDSR_WRDREQ | NDSR_WRCMDREQ)))
+	if (st & (NDSR_RDY(0) | NDSR_RDY(1)))
 		complete(&nfc->complete);
 
 	return IRQ_HANDLED;


