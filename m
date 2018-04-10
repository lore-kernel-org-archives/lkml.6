Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeDJTRr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:17:47 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37337 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeDJTRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:17:45 -0400
X-Google-Smtp-Source: AIpwx49TFnrEaUozlqif1UpQFdDPI+x03I+mdJICWnYRXKWMXkXpLz3yTXxTet8KYrIHlZijH035lw==
Date: Tue, 10 Apr 2018 22:17:42 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Michal Hocko <mhocko@kernel.org>, adobriyan@gmail.com,
        willy@infradead.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180410191742.GE2041@uranus.lan>
References: <1523310774-40300-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180410090917.GZ21835@dhcp22.suse.cz>
 <20180410094047.GB2041@uranus.lan>
 <20180410104215.GB21835@dhcp22.suse.cz>
 <20180410110242.GC2041@uranus.lan>
 <20180410111001.GD21835@dhcp22.suse.cz>
 <20180410122804.GD2041@uranus.lan>
 <097488c7-ab18-367b-c435-7c26d149c619@linux.alibaba.com>
 <8c19f1fb-7baf-fef3-032d-4e93cfc63932@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c19f1fb-7baf-fef3-032d-4e93cfc63932@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 11:28:13AM -0700, Yang Shi wrote:
> > 
> > At the first glance, it looks feasible to me. Will look into deeper
> > later.
> 
> A further look told me this might be *not* feasible.
> 
> It looks the new lock will not break check_data_rlimit since in my patch
> both start_brk and brk is protected by mmap_sem. The code flow might look
> like below:
> 
> CPU A                             CPU B
> --------                       --------
> prctl                               sys_brk
>                                       down_write
> check_data_rlimit           check_data_rlimit (need mm->start_brk)
>                                       set brk
> down_write                    up_write
> set start_brk
> set brk
> up_write
> 
> If CPU A gets the mmap_sem first, it will set start_brk and brk, then CPU B
> will check with the new start_brk. And, prctl doesn't care if sys_brk is run
> before it since it gets the new start_brk and brk from parameter.
> 
> If we protect start_brk and brk with the new lock, sys_brk might get old
> start_brk, then sys_brk might break rlimit check silently, is that right?
> 
> So, it looks using new lock in prctl and keeping mmap_sem in brk path has
> race condition.

I fear so. The check_data_rlimit implies that all elements involved into
validation (brk, start_brk, start_data, end_data) are not changed unpredicably
until written back into mm. In turn if we guard start_brk,brk only (as
it is done in the patch) the check_data_rlimit may pass on wrong data
I think. And as you mentioned the race above exact the example of such
situation. I think for prctl case we can simply left use of mmap_sem
as it were before the patch, after all this syscall is really in cold
path all the time.

	Cyrill
