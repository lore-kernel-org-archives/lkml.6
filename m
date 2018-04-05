Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeDEOXC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:23:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDEOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:23:01 -0400
Date: Thu, 5 Apr 2018 07:22:58 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Joel Fernandes <joelaf@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180405142258.GA28128@bombadil.infradead.org>
References: <20180403123514.GX5501@dhcp22.suse.cz>
 <20180403093245.43e7e77c@gandalf.local.home>
 <20180403135607.GC5501@dhcp22.suse.cz>
 <CAGWkznH-yfAu=fMo1YWU9zo-DomHY8YP=rw447rUTgzvVH4RpQ@mail.gmail.com>
 <20180404062340.GD6312@dhcp22.suse.cz>
 <20180404101149.08f6f881@gandalf.local.home>
 <20180404142329.GI6312@dhcp22.suse.cz>
 <20180404114730.65118279@gandalf.local.home>
 <20180405025841.GA9301@bombadil.infradead.org>
 <CAJWu+oqP64QzvPM6iHtzowek6s4p+3rb7WDXs1z51mwW-9mLbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqP64QzvPM6iHtzowek6s4p+3rb7WDXs1z51mwW-9mLbA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 09:12:52PM -0700, Joel Fernandes wrote:
> On Wed, Apr 4, 2018 at 7:58 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > On Wed, Apr 04, 2018 at 11:47:30AM -0400, Steven Rostedt wrote:
> >> I originally was going to remove the RETRY_MAYFAIL, but adding this
> >> check (at the end of the loop though) appears to have OOM consistently
> >> kill this task.
> >>
> >> I still like to keep RETRY_MAYFAIL, because it wont trigger OOM if
> >> nothing comes in and tries to do an allocation, but instead will fail
> >> nicely with -ENOMEM.
> >
> > I still don't get why you want RETRY_MAYFAIL.  You know that tries
> > *harder* to allocate memory than plain GFP_KERNEL does, right?  And
> > that seems like the exact opposite of what you want.
> 
> No. We do want it to try harder but not if its already setup for failure.

I understand you don't want GFP_NORETRY.  But why is it more important for
this allocation to succeed than other normal GFP_KERNEL allocations?
