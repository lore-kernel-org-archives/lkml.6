Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1821C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586C32147D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipfQpbtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586C32147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbeKTDIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731911AbeKTDIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:08:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C8A20C01;
        Mon, 19 Nov 2018 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645839;
        bh=xggO96KZhu8cz6jBVcH8kGCN9hq63FM1zOXLHLCUge8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ipfQpbtu7KDQWG6Fh1A3Dv0bcikUUOgDo2wTfTWuBW5/OEnXbBvValEblf79Ob5VB
         lF6J5yoyYLbHPMopfxQCTeU/se9O9/mgtfIQIrCjf8cMu9AtT+M1ZaxvUHi0AuItWZ
         8TxUT3DAz3bCeO/ePfhQhqWZfgtEE1/JF5qGsIJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.18 107/171] ext4: add missing brelse() add_new_gdb_meta_bg()s error path
Date:   Mon, 19 Nov 2018 17:28:23 +0100
Message-Id: <20181119162635.828763708@linuxfoundation.org>
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

From: Vasily Averin <vvs@virtuozzo.com>

commit 61a9c11e5e7a0dab5381afa5d9d4dd5ebf18f7a0 upstream.

Fixes: 01f795f9e0d6 ("ext4: add online resizing support for meta_bg ...")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 3.7
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/resize.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -926,6 +926,7 @@ static int add_new_gdb_meta_bg(struct su
 				     sizeof(struct buffer_head *),
 				     GFP_NOFS);
 	if (!n_group_desc) {
+		brelse(gdb_bh);
 		err = -ENOMEM;
 		ext4_warning(sb, "not enough memory for %lu groups",
 			     gdb_num + 1);
@@ -941,8 +942,6 @@ static int add_new_gdb_meta_bg(struct su
 	kvfree(o_group_desc);
 	BUFFER_TRACE(gdb_bh, "get_write_access");
 	err = ext4_journal_get_write_access(handle, gdb_bh);
-	if (unlikely(err))
-		brelse(gdb_bh);
 	return err;
 }
 


