Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7627BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4AF2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFTfPZmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4AF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeKTC7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbeKTC7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:59:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D355421104;
        Mon, 19 Nov 2018 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645346;
        bh=IaaMxBLF0wIaWO63J/dmYgjGv7+3LOQTfvo4mt1nNZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uFTfPZmoUXUErOAneyHB8fugHSHkRY0+v3u1qYjFuV58dEYBgy/ORZMZZtG0BR8qe
         K7Ra5iFOZMRSjSVnjVoBjOKLfAoFgit1TF4OOfFparHjcHCl19835g0QgoBU+/2RKK
         FBlzVtIPFUTxgS4o2i4zCimDs99v6g9+GkarCzmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 128/205] btrfs: tree-checker: Fix misleading group system information
Date:   Mon, 19 Nov 2018 17:27:15 +0100
Message-Id: <20181119162636.801936953@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shaokun Zhang <zhangshaokun@hisilicon.com>

commit 761333f2f50ccc887aa9957ae829300262c0d15b upstream.

block_group_err shows the group system as a decimal value with a '0x'
prefix, which is somewhat misleading.

Fix it to print hexadecimal, as was intended.

Fixes: fce466eab7ac6 ("btrfs: tree-checker: Verify block_group_item")
CC: stable@vger.kernel.org # 4.19+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-checker.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -440,7 +440,7 @@ static int check_block_group_item(struct
 	    type != (BTRFS_BLOCK_GROUP_METADATA |
 			   BTRFS_BLOCK_GROUP_DATA)) {
 		block_group_err(fs_info, leaf, slot,
-"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llu or 0x%llx",
+"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llx or 0x%llx",
 			type, hweight64(type),
 			BTRFS_BLOCK_GROUP_DATA, BTRFS_BLOCK_GROUP_METADATA,
 			BTRFS_BLOCK_GROUP_SYSTEM,


