Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600B6C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26028214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="myXM9n1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26028214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeLDLBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:01:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeLDLBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 658F22087F;
        Tue,  4 Dec 2018 11:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921264;
        bh=ywzChOnqT3RfbB9tXiNGAC671Jm6Dn91pnw1DSomS6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=myXM9n1IDxd6jI7ed2T8u/j8LzbUR/3bJoFUkdK0pLmSQaqYqJHx0ftOJJRJ5/9Ia
         uKPYxSKm7uTeHXCfBpXccs8kkwXKOO+DnzeeLIhqgEo6cwFltn8RXJF2QE89Yvgrx8
         qeMdedTwe1r0f9/PltNiHesu8aSxiyeV2HBVv2Qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.19 118/139] ext2: fix potential use after free
Date:   Tue,  4 Dec 2018 11:49:59 +0100
Message-Id: <20181204103655.510462440@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Bian <bianpan2016@163.com>

commit ecebf55d27a11538ea84aee0be643dd953f830d5 upstream.

The function ext2_xattr_set calls brelse(bh) to drop the reference count
of bh. After that, bh may be freed. However, following brelse(bh),
it reads bh->b_data via macro HDR(bh). This may result in a
use-after-free bug. This patch moves brelse(bh) after reading field.

CC: stable@vger.kernel.org
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext2/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -612,9 +612,9 @@ skip_replace:
 	}
 
 cleanup:
-	brelse(bh);
 	if (!(bh && header == HDR(bh)))
 		kfree(header);
+	brelse(bh);
 	up_write(&EXT2_I(inode)->xattr_sem);
 
 	return error;


