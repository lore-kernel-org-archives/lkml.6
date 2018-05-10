Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757014AbeEJLbC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:31:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:37257 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756832AbeEJLbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:31:01 -0400
Date: Thu, 10 May 2018 13:30:58 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: printk feature for syzbot?
Message-ID: <20180510113058.q6d7apmih5sdmlba@pathway.suse.cz>
References: <201804232233.CIC65675.OJSOMFQOFFHVtL@I-love.SAKURA.ne.jp>
 <CACT4Y+boyw_Qy=y-iTnsKZrtTgF0Hk3nHN_xtqUdX4etgiYDQw@mail.gmail.com>
 <20180424013336.GA1376@jagdpanzerIV>
 <20180426100603.czif6sat75fjsazp@pathway.suse.cz>
 <20180510042206.GA3426@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510042206.GA3426@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-05-10 13:22:06, Sergey Senozhatsky wrote:
> On (04/26/18 12:06), Petr Mladek wrote:
> > 
> > > Petr, Steven, Fengguang, what do you think? Do you have any objections?
> > > Ideas?
> > 
> > I wonder if we could create some mechanism that would help to extend
> > struct printk_log easier in the future.
> 
> Hm, interesting idea.
> 
> > I know only about crash tool implementation. It uses information provided
> > by log_buf_vmcoreinfo_setup(). The size of the structure is already
> > public. Therefore crash should be able to find all existing information
> > even if we increase the size of the structure.
> > 
> > log_buf_vmcoreinfo_setup() even allows to inform about newly added
> > structure items. We could probably extend it to inform also about
> > the offset of the new optional elements.
> 
> I vaguely remember that the last time Thomas Gleixner modified
> printk_log you managed to find a case that broke crash tool.
> ... Or may be I'm mistaken.

I guess that you are talking about the patchset adding possibility
to use different time-stamps[1]. It changed the semantic of the
timestamp. All the tools needed an update to show the timestamp
correctly.

The patchset was rejected by Linus because it would broke some
userspace tool, e.g. systemd, that depend on the format and semantic
provided by /dev/kmsg[2].

By other words, we must not change /dev/kmsg format. But it should
be acceptable to change/extend the internal format and eventually
extend the format used on consoles.

Anyway, we need to be careful and test makedumpfile and crash tools
and eventually provide patches for them.

Reference:
[0] https://lkml.kernel.org/r/20160419085613.GJ6862@pathway.suse.cz
[1] https://lkml.kernel.org/r/CA+55aFzLH9crdMtUFkD-PtNGuxu_fsG5GH2ACni69ug9iM=09g@mail.gmail.com

Best Regards,
Petr
