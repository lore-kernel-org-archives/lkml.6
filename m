Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C1BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7139F21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497743;
	bh=ZuYMLIH3N24HJGs/AhdbrAKD8hoer4QPP653H58Yq7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=igmOux1ajbvl2JhHJ1nJ8n8l1ElN9GWX/gxSaP8Dd7ewQPPS0Z/FbgaLQra5G2hZY
	 RTwjoWt/l8ahwPhdvau4d2AetjGMD/F1pSPsNXYv3S1WAWYRBnXj2Q/nCEHtkYpvE+
	 HLvKAOlou7/4c+CF99jTMqO1NXr8ionkXhUzHafA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbfBRNtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:49:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731937AbfBRNs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:48:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 149D8217F5;
        Mon, 18 Feb 2019 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497735;
        bh=ZuYMLIH3N24HJGs/AhdbrAKD8hoer4QPP653H58Yq7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vpsCrj4+3xpR2Z97ahKmSgqrTT0AdN2sh0Eu9ZRgFQnu5TX4SIr0cqRWbEoFYniDd
         zgEuFfjbxNsuq0lrkwy177tel9oR8i02zJfp8chSVdJnJO/Gci++PPm6bRqjLqXH7q
         ku3Gqyu5s74s3xTkHGvlxc5foGWQqzpbC826O2B4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Milan Broz <mbroz@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.20 86/92] dm crypt: dont overallocate the integrity tag space
Date:   Mon, 18 Feb 2019 14:43:29 +0100
Message-Id: <20190218133503.331931319@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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
@@ -932,7 +932,7 @@ static int dm_crypt_integrity_io_alloc(s
 	if (IS_ERR(bip))
 		return PTR_ERR(bip);
 
-	tag_len = io->cc->on_disk_tag_size * bio_sectors(bio);
+	tag_len = io->cc->on_disk_tag_size * (bio_sectors(bio) >> io->cc->sector_shift);
 
 	bip->bip_iter.bi_size = tag_len;
 	bip->bip_iter.bi_sector = io->cc->start + io->sector;


