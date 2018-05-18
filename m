Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeERHkB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:40:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49384 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbeERHj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:39:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81546602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date: Fri, 18 May 2018 13:09:53 +0530
From: Sahitya Tummala <stummala@codeaurora.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: Fix deadlock in shutdown ioctl
Message-ID: <20180518073953.GC6293@codeaurora.org>
References: <1526544211-26218-1-git-send-email-stummala@codeaurora.org>
 <b7d045f3-f37b-46da-3c1c-2b6d99efc9e7@huawei.com>
 <20180518010826.GC33876@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518010826.GC33876@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 06:08:26PM -0700, Jaegeuk Kim wrote:
> 
> if (in == F2FS_GOING_DOWN_FULLSYNC) {
> 	sb = freeze_bdev();
> 	if (IS_ERR(sb))
> 		return PTR_ERR(sb);
> 	if (unlikely(!sb))
> 		return -EINVAL;
> }
> 
> ret = mnt_want_write_file();

It will be stuck/blocked here as freeze_bdev() now holds the write 
lock for all the cases including SB_FREEZE_WRITE. As freeze_bdev()
holds the write lock, I think f2fs_stop_checkpoint() should be safe
even without mnt_want_write_file().

I have posted v3 as per Chao's comments to exclude mnt_want_write_file()
for F2FS_GOING_DOWN_FULLSYNC case.
Please check and let me know if there are any further comments.

> ...
> switch() {
> case F2FS_GOING_DOWN_FULLSYNC:
> 	f2fs_stop_checkpoint();
> 	dhaw_bdev();
> 	break;
> ...
> }
> 
> drop:
> ...
> 
> 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
