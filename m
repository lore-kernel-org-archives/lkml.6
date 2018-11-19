Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394F0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0328F2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRrCJa4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0328F2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404734AbeKTDWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:22:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403845AbeKTDWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:22:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581F52146D;
        Mon, 19 Nov 2018 16:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646687;
        bh=hpoJpTo0R5gLnZWRfyHnTWl91v2URxlPYGVwWx6awys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRrCJa4QzM1V6rZQemRJSigaVWisF5v3HjcpOZi/d8uzqyvmOaqzsldMjYwogJ0hN
         Gn60yXohT48Fei+y3zX5qDXsGFtrgO4ptLLIbn/bzvL9mbqs9ilOgtNefIF/h2pSEx
         0WdzA275JDQFBoqa/Z1hRvumZOOnYKZvnZjeCJLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.4 052/160] ext4: initialize retries variable in ext4_da_write_inline_data_begin()
Date:   Mon, 19 Nov 2018 17:28:11 +0100
Message-Id: <20181119162636.581810156@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Czerner <lczerner@redhat.com>

commit 625ef8a3acd111d5f496d190baf99d1a815bd03e upstream.

Variable retries is not initialized in ext4_da_write_inline_data_begin()
which can lead to nondeterministic number of retries in case we hit
ENOSPC. Initialize retries to zero as we do everywhere else.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Fixes: bc0ca9df3b2a ("ext4: retry allocation when inline->extent conversion failed")
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inline.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -859,7 +859,7 @@ int ext4_da_write_inline_data_begin(stru
 	handle_t *handle;
 	struct page *page;
 	struct ext4_iloc iloc;
-	int retries;
+	int retries = 0;
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)


