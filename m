Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED705C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05AB214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqKeEpsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05AB214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeLDLAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:00:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbeLDLAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:00:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BA6B214C1;
        Tue,  4 Dec 2018 11:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921215;
        bh=QEDQt/mEAZWbSJFu/Cp6VZN1D9a8JUx07Pf3kB9Jn1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqKeEpsQ0FkLCTpXLF+YxD65Gr2zMK602wbO+C3GyhW6PkgdNg09DaK3sWW1Be2TX
         JK8vlh6bXV0x3BKe8T2boAGfFdZ/fUA5wYwBRFrgbaLxWQZSLdELqOdSvnPGoXZAHK
         iECIaOH8K66GKEe3yZly0edupmvvM5T4NdjrQlJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Subject: [PATCH 4.19 126/139] staging: mt7621-dma: fix potentially dereferencing uninitialized tx_desc
Date:   Tue,  4 Dec 2018 11:50:07 +0100
Message-Id: <20181204103655.905702538@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergio Paracuellos <sergio.paracuellos@gmail.com>

commit 354e379684fcc70ab8d5450b4d57bd92b5294dfd upstream.

Function 'mtk_hsdma_start_transfer' uses 'tx_desc' pointer which can be
dereferenced before it is initializated. Initializate pointer before
avoiding the problem.

Fixes: 0853c7a53eb3 ("staging: mt7621-dma: ralink: add rt2880 dma engine")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/mt7621-dma/mtk-hsdma.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -335,6 +335,8 @@ static int mtk_hsdma_start_transfer(stru
 	/* tx desc */
 	src = sg->src_addr;
 	for (i = 0; i < chan->desc->num_sgs; i++) {
+		tx_desc = &chan->tx_ring[chan->tx_idx];
+
 		if (len > HSDMA_MAX_PLEN)
 			tlen = HSDMA_MAX_PLEN;
 		else
@@ -344,7 +346,6 @@ static int mtk_hsdma_start_transfer(stru
 			tx_desc->addr1 = src;
 			tx_desc->flags |= HSDMA_DESC_PLEN1(tlen);
 		} else {
-			tx_desc = &chan->tx_ring[chan->tx_idx];
 			tx_desc->addr0 = src;
 			tx_desc->flags = HSDMA_DESC_PLEN0(tlen);
 


