Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD488C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824A92146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6ZeDV4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824A92146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbeK3BhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389206AbeK3BhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:37:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18497213A2;
        Thu, 29 Nov 2018 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501901;
        bh=rwC38LokT2j/t5MyPD8tk08rx2NAheZSSvNKbhmDA+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6ZeDV4FBairP4QPuZQxSXeb70EAit3zu3b1MYf3GSOibAgqLxhxQ8rCSwO7rfSe9
         ZY3mxJt95EGuc0FQ4r/AQ1Aafpbm496UZdQ+/ISofRYswyuzEl5QtjEw+wwzCm4+ky
         l6fU/XggrQDfc8Rdc89pdv0WWNcRPwAdyGPVXKSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Jean Delvare <jdelvare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 086/110] block: copy ioprio in __bio_clone_fast() and bounce
Date:   Thu, 29 Nov 2018 15:12:57 +0100
Message-Id: <20181129135924.729620738@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ca474b73896bf6e0c1eb8787eb217b0f80221610 ]

We need to copy the io priority, too; otherwise the clone will run
with a different priority than the original one.

Fixes: 43b62ce3ff0a ("block: move bio io prio to a new field")
Signed-off-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jean Delvare <jdelvare@suse.de>

Fixed up subject, and ordered stores.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c    | 1 +
 block/bounce.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 41173710430c..c4ef8aa46452 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -605,6 +605,7 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 	if (bio_flagged(bio_src, BIO_THROTTLED))
 		bio_set_flag(bio, BIO_THROTTLED);
 	bio->bi_opf = bio_src->bi_opf;
+	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
diff --git a/block/bounce.c b/block/bounce.c
index 418677dcec60..abb50e7e5fab 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -248,6 +248,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
 		return NULL;
 	bio->bi_disk		= bio_src->bi_disk;
 	bio->bi_opf		= bio_src->bi_opf;
+	bio->bi_ioprio		= bio_src->bi_ioprio;
 	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
-- 
2.17.1



