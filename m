Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512BCC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284A620811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083881;
	bh=/CglSKDfHgZfGZQzKRuUoGvb0kmLeUReacctO3C3b68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gGw8NtXUuPSt21e4GuACagSkVsQ5vp/udaz/xAlfxbELznRElDkQf7Cim7GtwzdsO
	 HzQjjjEJh0OQCWjpgdjJAr99/A0ulTJxcwHDOiRE9dT6yuUZKRyDkow2A8Xtq9yEvU
	 EVTqvg4fH6q4nPqs/WNMncJXLulrt/qrT9RLOCM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390885AbfBMSvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:51:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:42216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405923AbfBMSnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D02D620811;
        Wed, 13 Feb 2019 18:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083417;
        bh=/CglSKDfHgZfGZQzKRuUoGvb0kmLeUReacctO3C3b68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xX2wDWSb3lETQOB/tI4dW++R0QwyXktcopILpXx5fqxebJXsvpJ1mEyhNb0i57Hg2
         9GfinBJIMFtAo7ml5MM/d1/lo/dOBC6LMPbB4iOZAjw7fo0BrbT7BFx6a/2+e2m0Q9
         Veyhp6yo2ByVHrJLtGaIdl3D10dO9GbDJc0Ha5FM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.19 03/44] mtd: spinand: Fix the error/cleanup path in spinand_init()
Date:   Wed, 13 Feb 2019 19:38:04 +0100
Message-Id: <20190213183651.932754797@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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

From: Boris Brezillon <bbrezillon@kernel.org>

commit c3c7dbf4887ab3ed9d611cd1f6e16937f8700743 upstream.

The manufacturer specific initialization has already been done when
block unlocking takes place, and if anything goes wrong during this
procedure we should call spinand_manufacturer_cleanup().

Fixes: 7529df465248 ("mtd: nand: Add core infrastructure to support SPI NANDs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/spi/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1014,11 +1014,11 @@ static int spinand_init(struct spinand_d
 	for (i = 0; i < nand->memorg.ntargets; i++) {
 		ret = spinand_select_target(spinand, i);
 		if (ret)
-			goto err_free_bufs;
+			goto err_manuf_cleanup;
 
 		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
 		if (ret)
-			goto err_free_bufs;
+			goto err_manuf_cleanup;
 	}
 
 	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);


