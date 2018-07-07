Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1773AC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 04:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D142223EC
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 04:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="pjHJWmAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D142223EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbeGGEK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 00:10:26 -0400
Received: from imap.thunk.org ([74.207.234.97]:42160 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbeGGEKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 00:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0g7Fg8uw/4lQG/plZHQOvd5U5LHioe+tUj11+r4r0WY=; b=pjHJWmAGT6VxhdTpDT4iULPXoe
        oy1+cOgGp7oykzf0MP6BngqbCz52VyZhSRyWrptl7X2jh77RTcVQRIeOcHcpv7AwkHZhvOdnBLvhY
        4oShEKyx/3isFlTdBRhzq/cPMDU9Zbo/D9TMrbxdFgoZbLz4QUnYcCP4Edky2oJp1aDs=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fbeY7-00065V-PE; Sat, 07 Jul 2018 04:10:19 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8BBCE7A552B; Sat,  7 Jul 2018 00:10:18 -0400 (EDT)
Date:   Sat, 7 Jul 2018 00:10:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     dann frazier <dann.frazier@canonical.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanaijie@huawei.com, colin.king@canonical.com,
        kamal.mostafa@canonical.com, ike.pan@canonical.com
Subject: Re: [Bisect] ext4_validate_inode_bitmap:98: comm stress-ng: Corrupt
 inode bitmap
Message-ID: <20180707041018.GB3546@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        dann frazier <dann.frazier@canonical.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanaijie@huawei.com, colin.king@canonical.com,
        kamal.mostafa@canonical.com, ike.pan@canonical.com
References: <20180706174324.GA3049@xps13.dannf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706174324.GA3049@xps13.dannf>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 11:43:24AM -0600, dann frazier wrote:
> Hi,
>   We're seeing a regression triggered by the stress-ng[*] "chdir" test
> that I've bisected to:
> 
> 044e6e3d74a3 ext4: don't update checksum of new initialized bitmaps
> 
> So far we've only seen failures on servers based on HiSilicon's family
> of ARM64 SoCs (D05/Hi1616 SoC, D06/Hi1620 SoC). On these systems it is
> very reproducible.

Thanks for the report.  Can you verify whether or not this patch fixes
things for you?

					- Ted

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index da6c10c1e37a..1cfb74bc4dca 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -90,6 +90,8 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 		return -EFSCORRUPTED;
 
 	ext4_lock_group(sb, block_group);
+	if (buffer_verified(bh))
+		goto verified;
 	blk = ext4_inode_bitmap(sb, desc);
 	if (!ext4_inode_bitmap_csum_verify(sb, block_group, desc, bh,
 					   EXT4_INODES_PER_GROUP(sb) / 8)) {
@@ -101,6 +103,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 		return -EFSBADCRC;
 	}
 	set_buffer_verified(bh);
+verified:
 	ext4_unlock_group(sb, block_group);
 	return 0;
 }
