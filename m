Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932233AbeDCMfS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:35:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:37393 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932104AbeDCMfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:35:16 -0400
Date: Tue, 3 Apr 2018 14:35:14 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180403123514.GX5501@dhcp22.suse.cz>
References: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com>
 <20180330102038.2378925b@gandalf.local.home>
 <20180403110612.GM5501@dhcp22.suse.cz>
 <20180403075158.0c0a2795@gandalf.local.home>
 <20180403121614.GV5501@dhcp22.suse.cz>
 <20180403082348.28cd3c1c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403082348.28cd3c1c@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-04-18 08:23:48, Steven Rostedt wrote:
> On Tue, 3 Apr 2018 14:16:14 +0200
> Michal Hocko <mhocko@kernel.org> wrote:
> 
> > > This came up because there's scripts or programs that set the size of
> > > the ring buffer. The complaint was that the application would just set
> > > the size to something bigger than what was available and cause an OOM
> > > killing other applications. The final solution is to simply check the
> > > available memory before allocating the ring buffer:
> > > 
> > > 	/* Check if the available memory is there first */
> > > 	i = si_mem_available();
> > > 	if (i < nr_pages)
> > > 		return -ENOMEM;
> > > 
> > > And it works well.  
> > 
> > Except that it doesn't work. si_mem_available is not really suitable for
> > any allocation estimations. Its only purpose is to provide a very rough
> > estimation for userspace. Any other use is basically abuse. The
> > situation can change really quickly. Really it is really hard to be
> > clever here with the volatility the memory allocations can cause.
> 
> OK, then what do you suggest? Because currently, it appears to work. A
> rough estimate may be good enough.
> 
> If we use NORETRY, then we have those that complain that we do not try
> hard enough to reclaim memory. If we use RETRY_MAYFAIL we have this
> issue of taking up all memory before we get what we want.

Just try to do what admin asks for and trust it will not try to shoot
his foot? I mean there are other ways admin can shoot the machine down.
Being clever is OK if it doesn't add a tricky code. And relying on
si_mem_available is definitely tricky and obscure.

> Perhaps I should try to allocate a large group of pages with
> RETRY_MAYFAIL, and if that fails go back to NORETRY, with the thinking
> that the large allocation may reclaim some memory that would allow the
> NORETRY to succeed with smaller allocations (one page at a time)?

That again relies on a subtle dependencies of the current
implementation. So I would rather ask whether this is something that
really deserves special treatment. If admin asks for a buffer of a
certain size then try to do so. If we get OOM then bad luck you cannot
get large memory buffers for free...
-- 
Michal Hocko
SUSE Labs
