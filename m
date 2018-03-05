Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932555AbeCEU6G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752162AbeCEU6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:58:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD4A20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 5 Mar 2018 15:58:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: "Qixuan.Wu" <qixuan.wu@linux.alibaba.com>,
        linux-kernel-owner <linux-kernel-owner@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>, Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "chenggang.qin" <chenggang.qin@linux.alibaba.com>,
        caijingxian <caijingxian@linux.alibaba.com>,
        "yuanliang.wyl" <yuanliang.wyl@alibaba-inc.com>
Subject: Re: Would you help to tell why async printk solution was not taken
 to upstream kernel ?
Message-ID: <20180305155802.5c0f73fc@gandalf.local.home>
In-Reply-To: <20180305021416.GA6202@jagdpanzerIV>
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>
        <20180304130151.GA483@tigerII.localdomain>
        <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>
        <20180304104324.6bbbaa53@gandalf.local.home>
        <20180305021416.GA6202@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2018 11:14:16 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> But I still think that it makes sense to change that "print it all" approach.
> With more clear/explicit watchdog-dependent limits - we do direct printk for
> 1/2 (or 2/3) of a current watchdog threshold value and offload if there is
> more stuff in the logbuf. Implicit "logbuf size * console throughput" is
> harder to understand. Disabling watchdog because of printk is a bit too much
> of a compromise, probably.

If you know the baud rate, logbuf size * console throughput is actually
trivial to calculate.

Let's see. CONFIG_LOG_BUF_SHIFT defaults to 18 (2^18 = 262144).
Lets say we have a slow 9600 baud serial, which would give us:

 262144 * 8 / 9600 = 219 (rounded up).

Thus, the worse case scenario would be 219 seconds to output the entire
buffer. Add 10 seconds more for extra overhead, and then you have 229
second watchdog that should never trigger because of a very slow
console.

(A more common 151200 baud modem would empty the buffer in 14 seconds).

> 
> IOW, is logbuf worth of messages so critically important after all that we
> are ready to jeopardize the system stability?

The stability is only in jeopardy if the watchdogs trigger, right?

-- Steve
