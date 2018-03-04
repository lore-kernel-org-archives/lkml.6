Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbeCDPnd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 10:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752565AbeCDPn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 10:43:27 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A712133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Sun, 4 Mar 2018 10:43:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Qixuan.Wu" <qixuan.wu@linux.alibaba.com>
Cc: "linux-kernel-owner" <linux-kernel-owner@vger.kernel.org>,
        "Petr Mladek" <pmladek@suse.com>, "Jan Kara" <jack@suse.cz>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>,
        "chenggang.qin" <chenggang.qin@linux.alibaba.com>,
        "caijingxian" <caijingxian@linux.alibaba.com>,
        "yuanliang.wyl" <yuanliang.wyl@alibaba-inc.com>
Subject: Re: Would you help to tell why async printk solution was not taken
 to upstream kernel ?
Message-ID: <20180304104324.6bbbaa53@gandalf.local.home>
In-Reply-To: <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>
        <20180304130151.GA483@tigerII.localdomain>
        <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Mar 2018 23:08:23 +0800
"Qixuan.Wu" <qixuan.wu@linux.alibaba.com> wrote:

> Suppose there is one scenario that the system has 100 CPU(0~99). While CPU 0 is 
> calling slow console, CPU 1~99 are calling printk at the same time. And suppose 
> CPU 1 will be waiter, as per the patch, 2~99 will return directly. After CPU 0 finish 
> it's log to console, it will return when it finds CPU 1 are waiting. Then CPU 1 need 
> flush all logs of CPU(1~99) to the console, which may cause  softlockup or rcu 
> stall. Above scenario is very unusual and it's very unlikely to happen. 

Yes, people keep bringing up this scenario.

It would require a single burst of printks to all CPUs. And then no
more printks after that. The last one will end up printing the entire
buffer out the slow console. The thing is, this is a bounded time, and
no printk will print more than one full buffer worth.

If this is a worry, then set the timeouts for the lockup detection to
be longer than the time it takes to print one full buffer with the
slowest console.

-- Steve
