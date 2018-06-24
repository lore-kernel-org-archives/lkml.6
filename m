Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DF0C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189C824FE2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189C824FE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755062AbeFXPdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:33:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59270 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755044AbeFXPdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:33:22 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D01082C;
        Sun, 24 Jun 2018 15:33:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Su Yue <suy.fnst@cn.fujitsu.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.16 22/64] btrfs: return error value if create_io_em failed in cow_file_range
Date:   Sun, 24 Jun 2018 23:22:03 +0800
Message-Id: <20180624142745.113371941@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Yue <suy.fnst@cn.fujitsu.com>

commit 090a127afa8f73e9618d4058d6755f7ec7453dd6 upstream.

In cow_file_range(), create_io_em() may fail, but its return value is
not recorded.  Then return value may be 0 even it failed which is a
wrong behavior.

Let cow_file_range() return PTR_ERR(em) if create_io_em() failed.

Fixes: 6f9994dbabe5 ("Btrfs: create a helper to create em for IO")
CC: stable@vger.kernel.org # 4.11+
Signed-off-by: Su Yue <suy.fnst@cn.fujitsu.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1037,8 +1037,10 @@ static noinline int cow_file_range(struc
 				  ram_size, /* ram_bytes */
 				  BTRFS_COMPRESS_NONE, /* compress_type */
 				  BTRFS_ORDERED_REGULAR /* type */);
-		if (IS_ERR(em))
+		if (IS_ERR(em)) {
+			ret = PTR_ERR(em);
 			goto out_reserve;
+		}
 		free_extent_map(em);
 
 		ret = btrfs_add_ordered_extent(inode, start, ins.objectid,


