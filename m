Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43383C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FFE218AD
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864492;
	bh=RqEXmUJIvIiCV6Yca0AgsJlfMpAViNEyJKUklVq2JAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=peCJZWfxFFH7WpRiB+u+EA4/GdMGEB9NlTH2F6+ZCBDropUtRH0lRK8AvzHNxCBC2
	 dbsBKNwfwIwIBGthzOIk0U1zupSRxjbjfbE3IPc1+XNGt8ej8FI0ziQsQLQ8RoKx17
	 /KdHY+i8i/GeflF4FrpWaH82Q7wZ3yCN7wocbiPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfAGMev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:34:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbfAGMer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:34:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A83E206BB;
        Mon,  7 Jan 2019 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864486;
        bh=RqEXmUJIvIiCV6Yca0AgsJlfMpAViNEyJKUklVq2JAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RmpAn9XuFPxWLTCBF0fKCyHuCiYt68sigb3sYP5FJXXS6Dr6GNdSsxm4jPSx3dLH6
         yazXACOX1PoDn1aY5vbSeHL2qxVQaOxXKSazPrI8WXXb/YT6OLGIFARgdJReYiyQe7
         RMlouu43RNdAT7OYCxM4tHn5xQ4B1voNgvYmlHGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.20 028/145] mtd: rawnand: Fix JEDEC detection
Date:   Mon,  7 Jan 2019 13:31:05 +0100
Message-Id: <20190107104440.986237906@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit b637ef779575a977068025f842ecd480a9671f3f upstream.

nand_jedec_detect() should return 1 when the PARAM page parsing
succeeds, otherwise the core considers JEDEC detection failed and falls
back to ID-based detection.

Fixes: 480139d9229e ("mtd: rawnand: get rid of the JEDEC parameter page in nand_chip")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/nand_jedec.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mtd/nand/raw/nand_jedec.c
+++ b/drivers/mtd/nand/raw/nand_jedec.c
@@ -107,6 +107,8 @@ int nand_jedec_detect(struct nand_chip *
 		pr_warn("Invalid codeword size\n");
 	}
 
+	ret = 1;
+
 free_jedec_param_page:
 	kfree(p);
 	return ret;


