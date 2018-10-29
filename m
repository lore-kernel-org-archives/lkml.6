Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65253ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350B420664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350B420664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeJ3AhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:37:07 -0400
Received: from relay.sw.ru ([185.231.240.75]:46108 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbeJ3AhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:37:06 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <vvs@virtuozzo.com>)
        id 1gH9PX-0006bV-DT; Mon, 29 Oct 2018 18:24:59 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 0/7] ext4 resize long-lived errors
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Message-ID: <9cba7f49-64bb-b7cd-fac0-5be8301ccd17@virtuozzo.com>
Date:   Mon, 29 Oct 2018 18:24:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last week I've investigated the reason of ext4 resize troubles
on RHEL6 and RHEL7 based OpenVZ kernels.
Failed resize generated lot of "access beyond end of device" messages
followed by warning in __brelse.

 EXT4-fs (dm-3): resizing filesystem from 2620416 to 4096256 blocks
 attempt to access beyond end of device
 dm-3: rw=1, want=32770056, limit=32770048
 attempt to access beyond end of device
 dm-3: rw=1, want=32770064, limit=32770048
 ...
 attempt to access beyond end of device
 dm-3: rw=1, want=32776216, limit=32770048
 EXT4-fs (dm-3): resized filesystem to 4096256
 WARNING: CPU: 2 PID: 113370 at fs/buffer.c:1171 __brelse+0x2e/0x50
 VFS: brelse: Trying to free free buffer

"access beyond end of device" was fixed in mainline by recent commit
f0a459dec5495a ("ext4: fix online resize's handling of a too-small final block group")
However fixed error did not affected bh accounting
and should not lead to warning in __brelse.

Then I've reviewed fs/ext4/resize.c and found a number of long-lived errors,
earliest of them was imported from ext3 in 2.6.19.

First patch in this patch-set fixes the observed problem:
sb_issue_zeroout() failed during attempt to write beyond end of device
rollback switched to "goto end" and called brelse(bh).
however bh was not assigned yet in current iteration,
the pointer was not cleaned properly and was inherited from previous iteration.
To fix the problem I've moved brelse() calls in body of the cycle 
to avoid having to call him on rollback.

Other patches fixes visually-found mistakes.

Vasily Averin (7):
  ext4 resise: extra brelse in setup_new_flex_group_blocks()
  ext4 resize: missing brelse() after errors in
    set_flexbg_block_bitmap()
  ext4 resize: missing brelse() in case success in add_new_gdb()
  ext4 resize: brelse() cleanup in add_new_gdb_meta_bg()
  ext4 resize: lost brelse() in update_backups()
  ext4 resize: lost rollback in ext4_resize_fs()
  ext4 resize: lost resize_inode cleanup before retry in
    ext4_resize_fs()

 fs/ext4/resize.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

-- 
2.17.1
