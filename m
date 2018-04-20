Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754718AbeDTMEc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754591AbeDTMEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:04:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFF021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 20 Apr 2018 08:04:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
Message-ID: <20180420080428.622a8e7f@gandalf.local.home>
In-Reply-To: <20180420091224.cotxcfycmtt2hm4m@pathway.suse.cz>
References: <20180413124704.19335-1-pmladek@suse.com>
        <20180413101233.0792ebf0@gandalf.local.home>
        <20180414023516.GA17806@tigerII.localdomain>
        <20180416014729.GB1034@jagdpanzerIV>
        <20180416042553.GA555@jagdpanzerIV>
        <20180419125353.lawdc3xna5oqlq7k@pathway.suse.cz>
        <20180420021511.GB6397@jagdpanzerIV>
        <20180420091224.cotxcfycmtt2hm4m@pathway.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 11:12:24 +0200
Petr Mladek <pmladek@suse.com> wrote:

> Yes, my number was arbitrary. The important thing is that it was long
> enough. Or do you know about an console that will not be able to write
> 100 lines within one hour?

The problem is the way rate limit works. If you print 100 lines (or
1000) in 5 seconds, then you just stopped printing from that context
for 59 minutes and 55 seconds. That's a long time to block printing.

What happens if you had a couple of NMIs go off that takes up that
time, and then you hit a bug 10 minutes later from that context. You
just lost it.

This is a magnitude larger than any other user of rate limit in the
kernel. The most common time is 5 seconds. The longest I can find is 1
minute. You are saying you want to block printing from this context for
60 minutes!

That is HUGE! I don't understand your rational for such a huge number.
What data do you have to back that up with?

-- Steve
