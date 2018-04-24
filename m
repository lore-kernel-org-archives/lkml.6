Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932716AbeDXBdm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 21:33:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44594 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932652AbeDXBdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 21:33:41 -0400
X-Google-Smtp-Source: AIpwx49B9rC2QEwBuSbfLJknBh2U/ojwMwJ+Hc3vdXVNhhfaycPTI1KOizD8Bg8I7SVkUf3KdPjDag==
Date: Tue, 24 Apr 2018 10:33:36 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: printk feature for syzbot?
Message-ID: <20180424013336.GA1376@jagdpanzerIV>
References: <201804232233.CIC65675.OJSOMFQOFFHVtL@I-love.SAKURA.ne.jp>
 <CACT4Y+boyw_Qy=y-iTnsKZrtTgF0Hk3nHN_xtqUdX4etgiYDQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+boyw_Qy=y-iTnsKZrtTgF0Hk3nHN_xtqUdX4etgiYDQw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let me Cc Petr, Steven and Fengguang on this

On (04/23/18 15:40), Dmitry Vyukov wrote:
> On Mon, Apr 23, 2018 at 3:33 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > Hello, Sergey.
> >
> > Recently I'm fixing bugs reported by syzbot ( https://syzkaller.appspot.com/ ).
> >
> > Since syzbot frequently makes printk() flooding (e.g. memory allocation fault
> > injection), it is always difficult to distinguish which line is from which event.
> >
> > I wish printk() can prefix context identifier.
> > If I recall correctly, you are using some extra output for debugging, aren't you?
> 
> +syzkaller mailing list for history
> 
> Hi Tetsuo, Sergey,
> 
> Something like TID prefix would be useful. Potentially it would allow
> us to untangle multiple intermixed crash reports.

Hello,

Yes, Tetsuo, we use a bunch of "printk prefix" extensions at Samsung.
For instance, we prefix printk messages with the CPU number: messages
sometimes mix up, we also see partial pr_cont flushes, and so on.
Grep-ping serial logs by CPU number is quite powerful.

Upstreaming those printk prefixes can be a bit challenging, but may
be it's not all so bad. I personally think that syzbot, and build-test
bots in general [like 0day], are helpful indeed, and I don't see why life
should be any more complex for syzbot/0day guys. If printk prefixes can
help - then we probably should consider such an extension.

The main argument from the upstream is that tweaking struct printk_log
breaks user space (tools like crash, and so on). But I guess we can do
something about it. E.g. put a PRINTK_CONTEXT_TRACKING_PREFIX kconfig
option somewhere in "Kernel hacking"->"printk and dmesg options" and
make available only for DEBUG kernels, or something similar.

Petr, Steven, Fengguang, what do you think? Do you have any objections?
Ideas?

	-ss
