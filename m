Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754875AbeDZKGP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:06:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:45318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753942AbeDZKGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:06:08 -0400
Date: Thu, 26 Apr 2018 12:06:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: printk feature for syzbot?
Message-ID: <20180426100603.czif6sat75fjsazp@pathway.suse.cz>
References: <201804232233.CIC65675.OJSOMFQOFFHVtL@I-love.SAKURA.ne.jp>
 <CACT4Y+boyw_Qy=y-iTnsKZrtTgF0Hk3nHN_xtqUdX4etgiYDQw@mail.gmail.com>
 <20180424013336.GA1376@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424013336.GA1376@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-04-24 10:33:36, Sergey Senozhatsky wrote:
> Yes, Tetsuo, we use a bunch of "printk prefix" extensions at Samsung.
> For instance, we prefix printk messages with the CPU number: messages
> sometimes mix up, we also see partial pr_cont flushes, and so on.
> Grep-ping serial logs by CPU number is quite powerful.
> 
> Upstreaming those printk prefixes can be a bit challenging, but may
> be it's not all so bad. I personally think that syzbot, and build-test
> bots in general [like 0day], are helpful indeed, and I don't see why life
> should be any more complex for syzbot/0day guys. If printk prefixes can
> help - then we probably should consider such an extension.
> 
> The main argument from the upstream is that tweaking struct printk_log
> breaks user space (tools like crash, and so on). But I guess we can do
> something about it. E.g. put a PRINTK_CONTEXT_TRACKING_PREFIX kconfig
> option somewhere in "Kernel hacking"->"printk and dmesg options" and
> make available only for DEBUG kernels, or something similar.

> Petr, Steven, Fengguang, what do you think? Do you have any objections?
> Ideas?

I wonder if we could create some mechanism that would help to extend
struct printk_log easier in the future.

I know only about crash tool implementation. It uses information provided
by log_buf_vmcoreinfo_setup(). The size of the structure is already
public. Therefore crash should be able to find all existing information
even if we increase the size of the structure.

log_buf_vmcoreinfo_setup() even allows to inform about newly added
structure items. We could probably extend it to inform also about
the offset of the new optional elements.

I am not sure about other tools. But I think that it should be
doable.

Best Regards,
Petr
