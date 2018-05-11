Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeEKGV6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 02:21:58 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:41304 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752383AbeEKGV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 02:21:56 -0400
X-Google-Smtp-Source: AB8JxZrHt6EjUhrdKpb3QwnoODrg7gF+upqTlrW0x7ERg2auFdkHNI38XJjLr5i4AaPZVh93jrepdQ==
Date: Fri, 11 May 2018 15:21:51 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, dvyukov@google.com, sergey.senozhatsky@gmail.com,
        syzkaller@googlegroups.com, rostedt@goodmis.org,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org
Subject: Re: printk feature for syzbot?
Message-ID: <20180511062151.GA18160@jagdpanzerIV>
References: <201805102350.JJH73950.tVJHQLFSOMOOFF@I-love.SAKURA.ne.jp>
 <20180511014515.GA895@jagdpanzerIV>
 <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805110238.w4B2cIGH079602@www262.sakura.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (05/11/18 11:38), Tetsuo Handa wrote:
> > 
> > So you basically want to have one more con_msg_format_flags? Do
> > you want to track a context which prints out a messages or the
> > context which "generated" the message? A CPU/task that stores
> > a logbuf entry - vprintk_emit() - is not always the same as the
> > CPU/task that prints it to consoles - console_unlock().
> > 
> 
> Well, below is the (partial) patch.

Hi,

Tetsuo, I will take a look a bit later, but at glance, there are several
ways to achieve what you are trying to do. The first one is the way you
did it - add additional buffer and make that context tracking info part of
the message body. Another one would be to extend struct printk_log and add
pid/cpu/flag there, which you then can convert into text in msg_print_text().
So far we talked about extending printk_log. Yet another one could be - add
vsprintf specifiers that would add pid/cpu/flag to the vsprintf-ed message.
You then can re-define pr_fmt, for instance, in the code you want to track
pr_fmt "%zZ" fmt, or somehow force printk to add that "%zZ" to every
message.

> By the way, when I tried to make similar change for printk_safe_log_store(),
> I noticed that printk_safe_log_store() is not safe because it is reusing
> the va_list variable after "goto again;". We need to use va_copy(), or
> we will get crash like an example shown below.

Oh, right. Can you send a patch?

	-ss
