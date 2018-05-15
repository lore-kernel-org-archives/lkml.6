Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeEOH6B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:58:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeEOH57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:57:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4D99601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date: Tue, 15 May 2018 13:27:47 +0530
From: Sahitya Tummala <stummala@codeaurora.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: Fix deadlock in shutdown ioctl
Message-ID: <20180515075747.GA6293@codeaurora.org>
References: <1525958444-5579-1-git-send-email-stummala@codeaurora.org>
 <de6f040b-81d3-7f52-2482-135d11200788@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de6f040b-81d3-7f52-2482-135d11200788@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:39:42AM +0800, Chao Yu wrote:
> On 2018/5/10 21:20, Sahitya Tummala wrote:
> > f2fs_ioc_shutdown() ioctl gets stuck in the below path
> > when going down with full sync (F2FS_GOING_DOWN_FULLSYNC)
> > option.
> > 
> > __switch_to+0x90/0xc4
> > percpu_down_write+0x8c/0xc0
> > freeze_super+0xec/0x1e4
> > freeze_bdev+0xc4/0xcc
> > f2fs_ioctl+0xc0c/0x1ce0
> > f2fs_compat_ioctl+0x98/0x1f0
> > 
> > Fix this by not holding write access during this ioctl.
> 
> I think we can just remove lock coverage for F2FS_GOING_DOWN_FULLSYNC path, for
> other path, we need to keep as it is.
>

Thanks, I thought about it too but then I checked that XFS shutdown ioctl is
not taking any lock for this ioctl. Hence, I followed the same in F2FS.
Do you know why XFS is not taking any lock? Is it really needed in shutdown
ioctl?

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
