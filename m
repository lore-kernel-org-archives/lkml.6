Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344F4C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8363240B0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8363240B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754025AbeGEPD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:03:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:51896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753655AbeGEPD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:03:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA8F1AD12;
        Thu,  5 Jul 2018 15:03:26 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ufs: Fix memory leak in the unlink path
Date:   Thu,  5 Jul 2018 16:04:15 +0100
Message-Id: <20180705150415.25070-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running generic xfstests against ufs (ufstype=44bsd), a lot of memory
leaks were reported by kmemleak (in particular with generic/074).  It is
easily reproducible by simply doing:

  dd if=/dev/zero of=test bs=1024 count=1024
  unlink test

which will result in having kmemleak reporting:

unreferenced object 0xffff8800623f8980 (size 96):
  comm "unlink", pid 172, jiffies 4294905029 (age 60.804s)
  hex dump (first 32 bytes):
    e0 06 00 00 00 00 00 00 08 00 00 00 00 00 00 00  ................
    50 51 df 59 00 88 ff ff a8 50 df 59 00 88 ff ff  PQ.Y.....P.Y....
  backtrace:
    [<00000000ceff4f7a>] free_full_branch+0xdc/0x6b0
    [<0000000085b47ac6>] ufs_truncate_blocks+0x1532/0x19f0
    [<000000008edf50d0>] ufs_evict_inode+0xa5/0xe0
    [<00000000561ed122>] evict+0x384/0x530
    [<0000000082158199>] iput+0x407/0x5f0
    [<00000000a3a41e2b>] do_unlinkat+0x470/0x4d0
    [<0000000006651ccb>] do_syscall_64+0x21e/0x580
    [<000000008771be7f>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [<000000005a459012>] 0xffffffffffffffff

Fix this by kfree'ing the ufs_buffer_head allocated through ubh_bread in
free_full_branch.  While there, drop the NULL check as this is already done
in bforget.

Cc: stable@vger.kernel.org
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ufs/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index 4fa633f84274..76df052701b0 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -131,8 +131,9 @@ void ubh_bforget (struct ufs_buffer_head * ubh)
 	unsigned i;
 	if (!ubh) 
 		return;
-	for ( i = 0; i < ubh->count; i++ ) if ( ubh->bh[i] ) 
+	for ( i = 0; i < ubh->count; i++ )
 		bforget (ubh->bh[i]);
+	kfree (ubh);
 }
  
 int ubh_buffer_dirty (struct ufs_buffer_head * ubh)
