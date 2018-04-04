Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDDM7H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:59:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbeDDM7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:59:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D84E21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 08:59:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180404085901.5b54fe32@gandalf.local.home>
In-Reply-To: <20180404062039.GC6312@dhcp22.suse.cz>
References: <20180403110612.GM5501@dhcp22.suse.cz>
        <20180403075158.0c0a2795@gandalf.local.home>
        <20180403121614.GV5501@dhcp22.suse.cz>
        <20180403082348.28cd3c1c@gandalf.local.home>
        <20180403123514.GX5501@dhcp22.suse.cz>
        <20180403093245.43e7e77c@gandalf.local.home>
        <20180403135607.GC5501@dhcp22.suse.cz>
        <20180403101753.3391a639@gandalf.local.home>
        <20180403161119.GE5501@dhcp22.suse.cz>
        <20180403185627.6bf9ea9b@gandalf.local.home>
        <20180404062039.GC6312@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 08:20:39 +0200
Michal Hocko <mhocko@kernel.org> wrote:


> > Now can you please explain to me why si_mem_available is not suitable
> > for my purpose.  
> 
> Several problems. It is overly optimistic especially when we are close
> to OOM. The available pagecache or slab reclaimable objects might be pinned
> long enough that your allocation based on that estimation will just make
> the situation worse and result in OOM. More importantly though, your
> allocations are GFP_KERNEL, right, that means that such an allocation
> will not reach to ZONE_MOVABLE or ZONE_HIGMEM (32b systems) while the
> pagecache will. So you will get an overestimate of how much you can
> allocate.
> 
> Really si_mem_available is for proc/meminfo and a rough estimate of the
> free memory because users tend to be confused by seeing MemFree too low
> and complaining that the system has eaten all their memory. I have some
> skepticism about how useful it is in practice apart from showing it in
> top or alike tools. The memory is simply not usable immediately or
> without an overall and visible effect on the whole system.

What you are telling me is that this is perfect for my use case.

I'm not looking for a "if this tells me have enough memory, I then have
enough memory". I'm looking for a "If I screwed up and asked for a
magnitude more than I really need, don't OOM the system".

Really, I don't care if the number is not truly accurate. In fact, what
you tell me above is exactly what I wanted. I'm more worried it will
return a smaller number than what is available. I much rather have an
over estimate.

This is not about trying to get as much memory for tracing as possible.
Where we slowly increase the buffer size till we have pretty much every
page for tracing. If someone does that, then the system should OOM and
become unstable.

This is about doing what I've (and others) have done several times,
which is put in one or two more zeros than I really wanted. Or forgot
that writing in a number to buffer_size_kb is the buffer size for each
CPU. Yes, the number you write in there is multiplied by every CPU on
the system. It is easy to over allocate by mistake.

I'm looking to protect against gross mistakes where it is obvious that
the allocation isn't going to succeed before the allocating begins. I'm
not looking to be perfect here.

As I've stated before, the current method is to say F*ck You to the
rest of the system and OOM anything else.

If you want, I can change the comment above the code to be:

+       /*
+        * Check if the available memory is there first.
+        * Note, si_mem_available() only gives us a rough estimate of available
+        * memory. It may not be accurate. But we don't care, we just want
+        * to prevent doing any allocation when it is obvious that it is
+        * not going to succeed.
+        */
+       i = si_mem_available();
+       if (i < nr_pages)
+               return -ENOMEM;
+

Better?

-- Steve
