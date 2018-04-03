Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755506AbeDCMXw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755300AbeDCMXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:23:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366342133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 3 Apr 2018 08:23:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180403082348.28cd3c1c@gandalf.local.home>
In-Reply-To: <20180403121614.GV5501@dhcp22.suse.cz>
References: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com>
        <20180330102038.2378925b@gandalf.local.home>
        <20180403110612.GM5501@dhcp22.suse.cz>
        <20180403075158.0c0a2795@gandalf.local.home>
        <20180403121614.GV5501@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018 14:16:14 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> > This came up because there's scripts or programs that set the size of
> > the ring buffer. The complaint was that the application would just set
> > the size to something bigger than what was available and cause an OOM
> > killing other applications. The final solution is to simply check the
> > available memory before allocating the ring buffer:
> > 
> > 	/* Check if the available memory is there first */
> > 	i = si_mem_available();
> > 	if (i < nr_pages)
> > 		return -ENOMEM;
> > 
> > And it works well.  
> 
> Except that it doesn't work. si_mem_available is not really suitable for
> any allocation estimations. Its only purpose is to provide a very rough
> estimation for userspace. Any other use is basically abuse. The
> situation can change really quickly. Really it is really hard to be
> clever here with the volatility the memory allocations can cause.

OK, then what do you suggest? Because currently, it appears to work. A
rough estimate may be good enough.

If we use NORETRY, then we have those that complain that we do not try
hard enough to reclaim memory. If we use RETRY_MAYFAIL we have this
issue of taking up all memory before we get what we want.

Perhaps I should try to allocate a large group of pages with
RETRY_MAYFAIL, and if that fails go back to NORETRY, with the thinking
that the large allocation may reclaim some memory that would allow the
NORETRY to succeed with smaller allocations (one page at a time)?

-- Steve
