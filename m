Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D20C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2E9217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866880;
	bh=EzTRVvksDdEx31li63y0GS73ZDwuZ+zcZcNfj0DXa5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EopYWuXnAQAY62k40tmAgRFEE9y6XUVezOulTzUNGEigc9C0vxfZE3ZYyQMBrwqMd
	 CYD2Hx3+TXsqRB8WAiTz7ru+eOHzwSB+DYm8CAYoO8LVPiICXDv6H6UGOuMN2cLahi
	 k6kCoyXqCCnX1madtizE3h2ZHp2NAP4I6JjlJg8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfAGNCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:02:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730831AbfAGNCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:02:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08523206BB;
        Mon,  7 Jan 2019 13:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866156;
        bh=EzTRVvksDdEx31li63y0GS73ZDwuZ+zcZcNfj0DXa5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvu+KusCKl+Z99EwyKWAF5ikAS70eBYGyCRrycQcSHLRbWnjqkOPYjVoyQGJ73CkF
         JbYprYz4/XPpqEA1zDzjxkrk5by0IQSf1qHYB5lp33MRTebFqyfR6Wqmddj/5n8IAb
         uxgISdKGAwlHvnGRay3duXYs61eBhf7CCDvswWrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maurizio Lombardi <mlombard@redhat.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.14 064/101] ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()
Date:   Mon,  7 Jan 2019 13:32:52 +0100
Message-Id: <20190107105336.462666060@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maurizio Lombardi <mlombard@redhat.com>

commit 132d00becb31e88469334e1e62751c81345280e0 upstream.

In case of error, ext4_try_to_write_inline_data() should unlock
and release the page it holds.

Fixes: f19d5870cbf7 ("ext4: add normal write support for inline data")
Cc: stable@kernel.org # 3.8
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inline.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -711,8 +711,11 @@ int ext4_try_to_write_inline_data(struct
 
 	if (!PageUptodate(page)) {
 		ret = ext4_read_inline_page(inode, page);
-		if (ret < 0)
+		if (ret < 0) {
+			unlock_page(page);
+			put_page(page);
 			goto out_up_read;
+		}
 	}
 
 	ret = 1;


