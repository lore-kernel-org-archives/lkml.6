Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1F2C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7CE205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHwEtBON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7CE205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeH3Fsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeH3Fsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:48:41 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D168B204EC;
        Thu, 30 Aug 2018 01:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535593739;
        bh=9KgVuVZljVn3sbtM5uVwQk9hK1miBfeAqjgDVepThwY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=WHwEtBONgTQvqK2V8mJ2rPhsGTgCEPQAqxjR858Cx6qy1j8PMIi8MI15WKTCZKiSs
         +RUO1qGPT7WuU3AV/JvhngvpGgtul96I4mAqZDgk5d7ZEonlSeqgUgs8M/SJcy02Fh
         9S44N8yBVNHWr/ZHKiFfiJ6MZbhG12txMqmi7JRE=
Date:   Wed, 29 Aug 2018 18:48:58 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: avoid wrong decrypted data from disk
Message-ID: <20180830014858.GA91444@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180827225226.14272-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827225226.14272-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Create a file in an encrypted directory
2. Do GC & drop caches
3. Read stale data before its bio for metapage was not issued yet

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
Change log from v1:
 - move to bio != NULL

 fs/f2fs/data.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 382c1ef9a9e4..159e411785e9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1556,6 +1556,12 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 				bio = NULL;
 				goto set_error_page;
 			}
+		} else if (unlikely(f2fs_encrypted_file(inode))) {
+			/*
+			 * If the page is under writeback, we need to wait for
+			 * its completion to see the correct decrypted data.
+			 */
+			f2fs_wait_on_block_writeback(F2FS_I_SB(inode), block_nr);
 		}
 
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
-- 
2.17.0.441.gb46fe60e1d-goog

