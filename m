Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932917AbeCBF4r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 00:56:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:34143 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932109AbeCBF4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 00:56:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,411,1515484800";
   d="scan'208";a="30877897"
Subject: Re: [LKP] [lkp-robot] [iversion] c0cef30e4f: aim7.jobs-per-min -18.0%
 regression
To: Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@redhat.com>, Ye Xiaolong <xiaolong.ye@intel.com>,
        LKP <lkp@01.org>, LKML <linux-kernel@vger.kernel.org>
References: <20180225150505.GD7144@yexl-desktop>
 <1519573271.4702.10.camel@redhat.com> <20180226083807.GE8942@yexl-desktop>
 <1519645434.4443.15.camel@redhat.com> <1519648433.4443.18.camel@redhat.com>
 <8b48844f-7f9a-a9d7-b5bc-3bc403e0fa78@intel.com>
 <1519738149.4300.45.camel@redhat.com> <666.1519738993@warthog.procyon.org.uk>
 <CA+55aFx+oUB_H4KFTkuT+goMRABkjbdS211Zy2fG96RHuqbhBA@mail.gmail.com>
From: kemi <kemi.wang@intel.com>
Message-ID: <7f1b2159-edc0-57de-eed0-f544d638e8c0@intel.com>
Date: Fri, 2 Mar 2018 13:54:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFx+oUB_H4KFTkuT+goMRABkjbdS211Zy2fG96RHuqbhBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月28日 01:04, Linus Torvalds wrote:
> On Tue, Feb 27, 2018 at 5:43 AM, David Howells <dhowells@redhat.com> wrote:
>> Is it possible there's a stall between the load of RCX and the subsequent
>> instructions because they all have to wait for RCX to become available?
> 
> No. Modern Intel big-core CPU's simply aren't that fragile. All these
> instructions should do OoO fine for trivial sequences like this, and
> as far as I can tell, the new code sequence should be better.
> 
> And even if it were worse for some odd reason, it would be worse by a cycle.
> 
> This kind of 18% change is something else, it is definitely not about
> instruction scheduling.
> 
> Now, if the change to inode_cmp_iversion() causes some actual
> _behavioral_ changes, and we get more IO, that's more like it. But the
> code really does seem to be equivalent. In both cases it is simply
> comparing 63 bits: the high 63 bits of 0x150(%rbp) - inode->i_version
> - with the low 63 bits of 0x20(%rax) - iint->version.
> 
> The only issue would be if the high bit of 0x20(%rax) was somehow set.
> The new code doesn't shift that bit away an more, but it should never
> be set since it comes from
> 
>         i_version = inode_query_iversion(inode);
> ...
>         iint->version = i_version;
> 
> and that inode_query_iversion() will have done the version shift.
> 
>> The interleaving between operating on RSI and RCX in the older code might
>> alleviate that.
>>
>> In addition, the load if the 20(%rax) value is now done in the CMP instruction
>> rather than earlier, so it might not get speculatively loaded in time, whereas
>> the earlier code explicitly loads it up front.
> 
> No again, OoO cores will generally hide details like that.
> 
> You can see effects of it, but it's hard, and it can go both ways.
> 
> Anyway, I think the _real_ change has nothing to with instruction
> scheduling, and everything to do with this:
> 
>     107.62 ± 37%    +139.1%     257.38 ± 16%  vmstat.io.bo
>      48740 ± 36%    +191.4%     142047 ± 16%  proc-vmstat.pgpgout
> 
> (There's fairly big variation in those numbers, but the changes are
> even bigger) or this:
> 
>     258.12          -100.0%       0.00        turbostat.Avg_MHz
>      21.48           -21.5        0.00        turbostat.Busy%
> 

This is caused by a limitation in current turbostat parse script of lkp. It 
treats a string including wildcard character (e.g. 30.**) in the output of turbostat
monitor as an error and set all the stats value as 0.

Turbostat monitor runs successfully during these tests.

> or this:
> 
>      27397 ±194%  +43598.3%   11972338 ±139%
> latency_stats.max.io_schedule.nfs_lock_and_join_requests.nfs_updatepage.nfs_write_end.generic_perform_write.nfs_file_write.__vfs_write.vfs_write.SyS_write.entry_SYSCALL_64_fastpath
>      27942 ±189%  +96489.5%   26989044 ±139%
> latency_stats.sum.io_schedule.nfs_lock_and_join_requests.nfs_updatepage.nfs_write_end.generic_perform_write.nfs_file_write.__vfs_write.vfs_write.SyS_write.entry_SYSCALL_64_fastpath
> 
> but those all sound like something changed in the setup, not in the kernel.
> 
> Odd.
> 
>             Linus
> 
