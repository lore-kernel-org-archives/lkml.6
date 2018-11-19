Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEEEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97A92086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4cuF0H2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97A92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbeKTDHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:07:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732866AbeKTDHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:07:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F87521104;
        Mon, 19 Nov 2018 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645788;
        bh=bxsJzvjRR8pyjxLEzgJnYF65ZM/3YJM03cMFLQWNyx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q4cuF0H2vAYLL5683h540hI0nrbafVDmwNiU4DRaL7JNKQd7ahpqVoS5AHyJ7qbL6
         aANjpGjyOzU1T3N/JoY1kxJoJ3+sGgpbk4cKL4BKXzLf9ssR3Z9b3el2/DtJ5QcvwR
         ZcjemX8VkD6p+v0FcRoGS95rTvMjf9wDxTvWvOdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.18 090/171] mtd: nand: Fix nanddev_neraseblocks()
Date:   Mon, 19 Nov 2018 17:28:06 +0100
Message-Id: <20181119162633.618048195@linuxfoundation.org>
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

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit d098093ba06eb032057d1aca1c2e45889e099d00 upstream.

nanddev_neraseblocks() currently returns the number pages per LUN
instead of the total number of eraseblocks.

Fixes: 9c3736a3de21 ("mtd: nand: Add core infrastructure to deal with NAND devices")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mtd/nand.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -324,9 +324,8 @@ static inline unsigned int nanddev_ntarg
  */
 static inline unsigned int nanddev_neraseblocks(const struct nand_device *nand)
 {
-	return (u64)nand->memorg.luns_per_target *
-	       nand->memorg.eraseblocks_per_lun *
-	       nand->memorg.pages_per_eraseblock;
+	return nand->memorg.ntargets * nand->memorg.luns_per_target *
+	       nand->memorg.eraseblocks_per_lun;
 }
 
 /**


