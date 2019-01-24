Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92B8C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B274218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357876;
	bh=oMBLl3s2k46FW+gc3hldMeLACKoQRU/pyJGSckLMkV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sS9PRKGBaVwHGpIfyTEmLn8wEryoHLZosE6w132q0r/Ag8fcTjrxTwUBBrVmvRYOd
	 +zpgaqirbeMDqa6fktyvSGP8aBo0TWkBSvNz59DORJr1BBSfruOV8bKrn82t7L2M3F
	 de0e6PBGypHPp+arENW3uKV0WXwJYESHn33T1kZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfAXTYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:24:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729596AbfAXTYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:24:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84D08217D7;
        Thu, 24 Jan 2019 19:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357873;
        bh=oMBLl3s2k46FW+gc3hldMeLACKoQRU/pyJGSckLMkV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhX4PR3OlaDvbilPatCMlu/V92OfS4ir4EMqH1nkzQpNR/XjsdYfxhaDIdayznZ7r
         GL8doL1jKFYNm+zqtDemG5PbAbkPQ8S99cVtPAEG7UiNLnDvGoeFLOCqxJdsGhB423
         ekp6DrIfrwMMTGy/KNhQjeo9tFUA0i5rZ4xLF9Bk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 019/104] f2fs: free meta pages if sanity check for ckpt is failed
Date:   Thu, 24 Jan 2019 20:19:08 +0100
Message-Id: <20190124190157.028819474@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit a2125ff7dd1ed3a2a53cdc1f8f9c9cec9cfaa7ab upstream.

This fixes missing freeing meta pages in the error case.

Tested-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/checkpoint.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -708,7 +708,7 @@ int get_valid_checkpoint(struct f2fs_sb_
 
 	/* Sanity checking of checkpoint */
 	if (sanity_check_ckpt(sbi))
-		goto fail_no_cp;
+		goto free_fail_no_cp;
 
 	if (cur_page == cp1)
 		sbi->cur_cp_pack = 1;
@@ -736,6 +736,9 @@ done:
 	f2fs_put_page(cp2, 1);
 	return 0;
 
+free_fail_no_cp:
+	f2fs_put_page(cp1, 1);
+	f2fs_put_page(cp2, 1);
 fail_no_cp:
 	kfree(sbi->ckpt);
 	return -EINVAL;


