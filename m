Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D50C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DD3208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bv/hDACp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DD3208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391023AbeKTDSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:18:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390256AbeKTDSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:18:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 032DA21104;
        Mon, 19 Nov 2018 16:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646480;
        bh=ze2P7T2+Jak2fg+1iXQ6Cw2htekvZw67FNoU9g74OJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bv/hDACpsaQwMr2bZ14LbhNpOA3YQP4hKRYEidIcTEq8ALTxJQNaOdZ4+RMZUX10Z
         JWdwDJFHvvwjgEON+FgmZZKkI3JmbYiGEHSpAcbdIz+IOIsoRo2hNoO4FjO0R0iUqo
         d7zE7VB1wv72eqg01/W5/vXm96+DqNyfhEWFFk9o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.9 57/83] ext4: fix possible inode leak in the retry loop of ext4_resize_fs()
Date:   Mon, 19 Nov 2018 17:29:23 +0100
Message-Id: <20181119162623.606475040@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit db6aee62406d9fbb53315fcddd81f1dc271d49fa upstream.

Fixes: 1c6bd7173d66 ("ext4: convert file system to meta_bg if needed ...")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 3.7
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/resize.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -2026,6 +2026,10 @@ retry:
 		n_blocks_count_retry = 0;
 		free_flex_gd(flex_gd);
 		flex_gd = NULL;
+		if (resize_inode) {
+			iput(resize_inode);
+			resize_inode = NULL;
+		}
 		goto retry;
 	}
 


