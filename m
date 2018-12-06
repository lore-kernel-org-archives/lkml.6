Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3C3C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3B920661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107759;
	bh=NEv06SRRRV0tjzGVUocRSiOSfSZpA0Dj7M+hscG+lhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DpMKBFTdkEFQcLGLBDyUILGBu8Dmvfzl7aTuLT78kB5Dx6qWMmYwE/ZJLem7FQVA1
	 17ZEh7TNYkY8W2JLXIaA+xjHw2PeYYelcTZw2lySCFyZ/bnUVJxgKCqxGxeqCinm8J
	 fcx3RfnNRcZ8hZRPNOBwl7psZO1yD7cI6kI754y8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3B920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbeLFOtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731079AbeLFOsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:48:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B591420892;
        Thu,  6 Dec 2018 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107684;
        bh=NEv06SRRRV0tjzGVUocRSiOSfSZpA0Dj7M+hscG+lhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yFBfID8C9i+5e+TBWVtSxrU9LLyEFtZZTbu6PKdCXPNWm2u1Y1KgJ0YgemEAwQFnH
         Kluj7KLarSh2834Bg/q/h9oANb7o8aNZ8W9KnQJMOnVd89r1iSBaWjrUrDDcJzwJhq
         mxByeZ8yEIgIryGf4tL+RSTKmS5y7tJ/JsDebnfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 099/101] f2fs: free meta pages if sanity check for ckpt is failed
Date:   Thu,  6 Dec 2018 15:39:38 +0100
Message-Id: <20181206143018.904616140@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -796,7 +796,7 @@ int get_valid_checkpoint(struct f2fs_sb_
 
 	/* Sanity checking of checkpoint */
 	if (sanity_check_ckpt(sbi))
-		goto fail_no_cp;
+		goto free_fail_no_cp;
 
 	if (cur_page == cp1)
 		sbi->cur_cp_pack = 1;
@@ -824,6 +824,9 @@ done:
 	f2fs_put_page(cp2, 1);
 	return 0;
 
+free_fail_no_cp:
+	f2fs_put_page(cp1, 1);
+	f2fs_put_page(cp2, 1);
 fail_no_cp:
 	kfree(sbi->ckpt);
 	return -EINVAL;


