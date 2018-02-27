Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeB0REh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:04:37 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:32914 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751919AbeB0REe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:04:34 -0500
X-Google-Smtp-Source: AG47ELuMzcxTupi1i1GKoDoCwEyfnHWQfTTqdJlBamXndJU/o+z83R5tFQXCk5nuQUm3iaTvjPKoGh8LCjdkjcYR6jY=
MIME-Version: 1.0
In-Reply-To: <666.1519738993@warthog.procyon.org.uk>
References: <20180225150505.GD7144@yexl-desktop> <1519573271.4702.10.camel@redhat.com>
 <20180226083807.GE8942@yexl-desktop> <1519645434.4443.15.camel@redhat.com>
 <1519648433.4443.18.camel@redhat.com> <8b48844f-7f9a-a9d7-b5bc-3bc403e0fa78@intel.com>
 <1519738149.4300.45.camel@redhat.com> <666.1519738993@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2018 09:04:32 -0800
X-Google-Sender-Auth: P_TnJGTGLnryeqR1yuNUXNvtclY
Message-ID: <CA+55aFx+oUB_H4KFTkuT+goMRABkjbdS211Zy2fG96RHuqbhBA@mail.gmail.com>
Subject: Re: [LKP] [lkp-robot] [iversion] c0cef30e4f: aim7.jobs-per-min -18.0% regression
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@redhat.com>, kemi <kemi.wang@intel.com>,
        Ye Xiaolong <xiaolong.ye@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1RH4fCx020640

On Tue, Feb 27, 2018 at 5:43 AM, David Howells <dhowells@redhat.com> wrote:
> Is it possible there's a stall between the load of RCX and the subsequent
> instructions because they all have to wait for RCX to become available?

No. Modern Intel big-core CPU's simply aren't that fragile. All these
instructions should do OoO fine for trivial sequences like this, and
as far as I can tell, the new code sequence should be better.

And even if it were worse for some odd reason, it would be worse by a cycle.

This kind of 18% change is something else, it is definitely not about
instruction scheduling.

Now, if the change to inode_cmp_iversion() causes some actual
_behavioral_ changes, and we get more IO, that's more like it. But the
code really does seem to be equivalent. In both cases it is simply
comparing 63 bits: the high 63 bits of 0x150(%rbp) - inode->i_version
- with the low 63 bits of 0x20(%rax) - iint->version.

The only issue would be if the high bit of 0x20(%rax) was somehow set.
The new code doesn't shift that bit away an more, but it should never
be set since it comes from

        i_version = inode_query_iversion(inode);
...
        iint->version = i_version;

and that inode_query_iversion() will have done the version shift.

> The interleaving between operating on RSI and RCX in the older code might
> alleviate that.
>
> In addition, the load if the 20(%rax) value is now done in the CMP instruction
> rather than earlier, so it might not get speculatively loaded in time, whereas
> the earlier code explicitly loads it up front.

No again, OoO cores will generally hide details like that.

You can see effects of it, but it's hard, and it can go both ways.

Anyway, I think the _real_ change has nothing to with instruction
scheduling, and everything to do with this:

    107.62 ± 37%    +139.1%     257.38 ± 16%  vmstat.io.bo
     48740 ± 36%    +191.4%     142047 ± 16%  proc-vmstat.pgpgout

(There's fairly big variation in those numbers, but the changes are
even bigger) or this:

    258.12          -100.0%       0.00        turbostat.Avg_MHz
     21.48           -21.5        0.00        turbostat.Busy%

or this:

     27397 ±194%  +43598.3%   11972338 ±139%
latency_stats.max.io_schedule.nfs_lock_and_join_requests.nfs_updatepage.nfs_write_end.generic_perform_write.nfs_file_write.__vfs_write.vfs_write.SyS_write.entry_SYSCALL_64_fastpath
     27942 ±189%  +96489.5%   26989044 ±139%
latency_stats.sum.io_schedule.nfs_lock_and_join_requests.nfs_updatepage.nfs_write_end.generic_perform_write.nfs_file_write.__vfs_write.vfs_write.SyS_write.entry_SYSCALL_64_fastpath

but those all sound like something changed in the setup, not in the kernel.

Odd.

            Linus
