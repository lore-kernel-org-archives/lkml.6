Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbeDSGRS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 02:17:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:32248 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbeDSGRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 02:17:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="scan'208";a="33711512"
Date: Thu, 19 Apr 2018 09:17:10 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] perf/core: fix bad use of igrab in
 kernel/event/core.c
Message-ID: <20180419061710.l6sdq3kvricpyjdu@um.fi.intel.com>
References: <20180418062907.3210386-1-songliubraving@fb.com>
 <20180418062907.3210386-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418062907.3210386-2-songliubraving@fb.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 11:29:07PM -0700, Song Liu wrote:
> As Miklos reported and suggested:
> 
>   This pattern repeats two times in trace_uprobe.c and in
>   kernel/events/core.c as well:
> 
>       ret = kern_path(filename, LOOKUP_FOLLOW, &path);
>       if (ret)
>           goto fail_address_parse;
> 
>       inode = igrab(d_inode(path.dentry));
>       path_put(&path);
> 
>   And it's wrong.  You can only hold a reference to the inode if you
>   have an active ref to the superblock as well (which is normally
>   through path.mnt) or holding s_umount.

Oops. I must have snatched it from the uprobe code without thinking.

>   This way unmounting the containing filesystem while the tracepoint is
>   active will give you the "VFS: Busy inodes after unmount..." message
>   and a crash when the inode is finally put.
> 
>   Solution: store path instead of inode.
> 
> This patch fixes the issue in kernel/event/core.c.
> 
> NOTE: Based on my understanding, perf_addr_filter only supports intel_pt.

Coresight too, but that's probably even further away from what you have.

> However, my test system doesn't support address filtering (or I made a
> mistake?). Therefore, I have NOT tested this patch.

Check /sys/devices/intel_pt/caps/num_address_ranges, if it's non-zero,
it's supported.

> Could someone please help test it?

Yes:

Reviewed-and-tested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

The subject line needs a little love to be more like other perf commits, but
other than that, looks good.

Thanks!
