Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1762DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC053214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vqIBTAUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC053214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407141AbeKTDal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:30:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405988AbeKTDal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:30:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10E32214DA;
        Mon, 19 Nov 2018 17:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647183;
        bh=5ILCwxq5CKQSSZs8nm05L/lxMJ8e1hfoB1mSmk6gcmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vqIBTAUb5awvF2zDceLVCbr989+xfG8jFCt099qogJiDfviDF2CP/PnbF8uo6tLd3
         dw5ZydBhw0fNWnefeqncls+x8mA/yJs8v+mGB2sQ1Jazec7AT3gn7iXUW/ISMWas9I
         7GZMHtWK2CvBwtv/F/rc/2IFECU2SyIDAhI+wBic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 3.18 83/90] ext4: fix buffer leak in __ext4_read_dirblock() on error path
Date:   Mon, 19 Nov 2018 17:30:05 +0100
Message-Id: <20181119162633.273599654@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit de59fae0043f07de5d25e02ca360f7d57bfa5866 upstream.

Fixes: dc6982ff4db1 ("ext4: refactor code to read directory blocks ...")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 3.9
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/namei.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -122,6 +122,7 @@ static struct buffer_head *__ext4_read_d
 	if (!is_dx_block && type == INDEX) {
 		ext4_error_inode(inode, __func__, line, block,
 		       "directory leaf block found instead of index block");
+		brelse(bh);
 		return ERR_PTR(-EIO);
 	}
 	if (!ext4_has_metadata_csum(inode->i_sb) ||


