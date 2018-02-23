Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754966AbeBWTpz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:45:55 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43224 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754827AbeBWTpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:45:51 -0500
X-Google-Smtp-Source: AH8x227DrlxBp/9vQi1KGVsy28aG2osuflRR9zAMEmS2+Tx6uLhWWbAmjr42qRU+VFCqVUZzuALmVA==
Date: Fri, 23 Feb 2018 22:45:47 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: akpm@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: proc: use down_read_killable in
 proc_pid_cmdline_read()
Message-ID: <20180223194547.GC5708@avx2>
References: <1519156169-11883-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180220223825.GA6705@avx2>
 <fa1e9b6b-efaf-79c5-00ea-1f58d5078c2d@linux.alibaba.com>
 <20180221195720.GA639@avx2>
 <b82e9c62-0c8d-205b-9887-8ea2c18eaccb@linux.alibaba.com>
 <20180223193338.GA5708@avx2>
 <e8cdbc7d-45ef-ab1f-6df0-1d8ef1d4f1eb@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8cdbc7d-45ef-ab1f-6df0-1d8ef1d4f1eb@linux.alibaba.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 11:42:34AM -0800, Yang Shi wrote:
> 
> 
> On 2/23/18 11:33 AM, Alexey Dobriyan wrote:
> > On Wed, Feb 21, 2018 at 03:13:10PM -0800, Yang Shi wrote:
> >
> >>>>> 2) access_remote_vm() et al will do the same ->mmap_sem, and
> >>>> Yes, it does. But, __access_remote_vm() is called by access_process_vm()
> >>>> too, which is used by much more places, i.e. ptrace, so I was not sure
> >>>> if it is preferred to convert to killable version. So, I leave it untouched.
> >>> Yeah, but ->mmap_sem is taken 3 times per /proc/*/cmdline read
> >>> and your scalability tests should trigger next backtrace right away.
> >> Yes, however, I didn't run into it if mmap_sem is acquired earlier.
> >>
> >> How about defining a killable version, like
> >> __access_remote_vm_killable() which use down_read_killable(), then the
> >> killable version can be used by proc/*/cmdline? There might be other
> >> users in the future.
> > It would be a disaster as interfaces multiply.
> 
> Might be not that bad.

Maybe.

But you need to explain why there is no backtrace several lines later:

	access_remote_vm
	__access_remote_vm
	down_read(&mm->mmap_sem)
