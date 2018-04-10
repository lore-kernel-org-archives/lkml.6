Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeDJDMe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 23:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751757AbeDJDMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 23:12:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3E921725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 9 Apr 2018 23:12:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal
 OOM_SCORE_ADJ_MIN
Message-ID: <20180409231230.1ab99e85@vmware.local.home>
In-Reply-To: <CAGWkznEuGCZq600XjCtp3hzgN2LrCgwSAfoLwQR7jTw5p=qHoQ@mail.gmail.com>
References: <1523153783-20579-1-git-send-email-zhaoyang.huang@spreadtrum.com>
        <20180407234812.2bf2b24b@gandalf.local.home>
        <CAGWkznHVGTpvfQOvaOGP6fYDWh0Os0pYXTC3gG_qvW6mCDuybQ@mail.gmail.com>
        <20180408084717.62ee4f9e@gandalf.local.home>
        <CAGWkznEQbaw7HMvE1pbVDMriOL8yW74Ka5UEci4YFRdLnVbFzA@mail.gmail.com>
        <20180409094944.6399b211@gandalf.local.home>
        <CAGWkznEhy7Fard=6E3X_qUezXd33RdKV9CVeONWL=6EQ1bokEw@mail.gmail.com>
        <CAGWkznEuGCZq600XjCtp3hzgN2LrCgwSAfoLwQR7jTw5p=qHoQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 10:32:36 +0800
Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> For bellowing scenario, process A have no intension to exhaust the
> memory, but will be likely to be selected by OOM for we set
> OOM_CORE_ADJ_MIN for it.
> process A(-1000)                                          process B
> 
>   i = si_mem_available();
>        if (i < nr_pages)
>            return -ENOMEM;
>                                                    schedule
>                                                 --------------->  
> allocate huge memory
>                                                 <-------------
> if (user_thread)
>   set_current_oom_origin();
> 
>   for (i = 0; i < nr_pages; i++) {
>          bpage = kzalloc_node

Is this really an issue though?

Seriously, do you think you will ever hit this?

How often do you increase the size of the ftrace ring buffer? For this
to be an issue, the system has to trigger an OOM at the exact moment
you decide to increase the size of the ring buffer. That would be an
impressive attack, with little to gain.

Ask the memory management people. If they think this could be a
problem, then I'll be happy to take your patch.

-- Steve
