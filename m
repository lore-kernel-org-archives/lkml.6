Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99082C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4C121736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500463;
	bh=MvlxSMLG4IFo1fWp1DFtuhuzHEuCRVOw4iXdIetxS9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z4MEXqMQAdDfjegPIGhFJLN5DrCnp5c5dcbneI8o+el4VjNZ5AL7l7BI+jz8UIGF2
	 gZ+hf6QtuEOEsbOQxuP/91bWtVvdbhxadRIITy+yR7KACDNU6xsAPDIs6eGSgK0c04
	 Ook8nMWAmPQkUgAs4gIMflh8b7XdGbnPBsR9xGdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbfBROeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:34:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387891AbfBRN4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:56:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FC0621900;
        Mon, 18 Feb 2019 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498204;
        bh=MvlxSMLG4IFo1fWp1DFtuhuzHEuCRVOw4iXdIetxS9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFu3Y/GINL5T7TXwRoR48GTPSqI50tdwBSwgBraOOgHn7R2mlAbkIEUvjAgf5AAtK
         aTxwHqFhwoMCiZG1sH7pM2LyFRnjG4oTTP4FLi+Lag1W6Q4J6D/pU7GGlPU8W7c8RA
         UWZ2nP1bFQZt2ZHFCM9rA1T+dIj7W935Y/Axcpbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Milan Broz <mbroz@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 57/62] dm crypt: dont overallocate the integrity tag space
Date:   Mon, 18 Feb 2019 14:44:03 +0100
Message-Id: <20190218133510.639510923@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit ff0c129d3b5ecb3df7c8f5e2236582bf745b6c5f upstream.

bio_sectors() returns the value in the units of 512-byte sectors (no
matter what the real sector size of the device).  dm-crypt multiplies
bio_sectors() by on_disk_tag_size to calculate the space allocated for
integrity tags.  If dm-crypt is running with sector size larger than
512b, it allocates more data than is needed.

Device Mapper trims the extra space when passing the bio to
dm-integrity, so this bug didn't result in any visible misbehavior.
But it must be fixed to avoid wasteful memory allocation for the block
integrity payload.

Fixes: ef43aa38063a6 ("dm crypt: add cryptographic data integrity protection (authenticated encryption)")
Cc: stable@vger.kernel.org # 4.12+
Reported-by: Milan Broz <mbroz@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-crypt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -935,7 +935,7 @@ static int dm_crypt_integrity_io_alloc(s
 	if (IS_ERR(bip))
 		return PTR_ERR(bip);
 
-	tag_len = io->cc->on_disk_tag_size * bio_sectors(bio);
+	tag_len = io->cc->on_disk_tag_size * (bio_sectors(bio) >> io->cc->sector_shift);
 
 	bip->bip_iter.bi_size = tag_len;
 	bip->bip_iter.bi_sector = io->cc->start + io->sector;


