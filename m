Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082A2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985DF20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="TarmybQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985DF20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbeGXRFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:05:46 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:40933 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388539AbeGXRFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:05:45 -0400
Received: by mail-yb0-f193.google.com with SMTP id y11-v6so1814170ybm.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1HixM+5ULudAYJSpUtJpJEudBqo7w2K0gXdXrRIXYek=;
        b=TarmybQUl9cPow5/ZvWD+JrZXLkqHvRzQm02DewOeeHk8KW1asSeQBlEBnDSC1BpMa
         js1hGK8C2MLyxF/U3yaiIIzbW9+BWxjQgyQaamUCHu1KpboASBXnt+qXxrjhoenx4gX9
         /k/asiQlnbhPto+PZYhPY2sU2pLMfNnzBwB/KJ3VQAJsM+XYYPwb/lHaeF9AnW8yxHTl
         9gxZ7JqByV6uar/rCufAq3+/G25uRqlhfdez/+zuE7L2dZ5NW1y1E2iZTIMQ1MwHlBdm
         ynd1YiHIWg+7iz0elQJsqFq4fFDnbmWVjm7X5f9WzMqlncH3x8OUZz85ftWWV6BgDDhF
         lX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1HixM+5ULudAYJSpUtJpJEudBqo7w2K0gXdXrRIXYek=;
        b=sodZ3bHNMXWgm3QBcIpQEbJ2bRebZ059kDhwyZL6AW9IGEzXEMI9kt4sp6BfOp+ZUN
         F8zpsf2bPd2LEYOFXSH3Pt7cKEu52tDSgEjo+THJ/U12dy4NYCFE3atVOpwQQBQx9TWo
         RvZKwdkEuc3S43vft72P8vsC1PICgRkxvuNf7VLAVCSO5xSrohT9Cc19qQXKVKAMBJDV
         pgYnDBQvl5odAaKKVnksk56HemZqUCUVJDRaEhUolkniJUlkHhEJUKHh38Kv7QJ/i8e4
         50dJo1W+c6dN/iaRnOT6WlnrUINeqUyGUH+OpJfyW/5LYXky7iEKtl46P2hc16NVh62I
         GwQQ==
X-Gm-Message-State: AOUpUlFh2Ox8tWXREXaBIlqG1cv3koI5nLhOeqrJNsr7QhmWUOxNRruF
        u+2yDjRCch8MsBrMKzyNXquAhA==
X-Google-Smtp-Source: AAOMgpd3C+u5HxZ7DzgPVqcVGq43iyFMIGp5/yRjZ4A2SjJ5D7gF9sd0SHEv+vctgtEIMqze+OTJyA==
X-Received: by 2002:a25:d410:: with SMTP id m16-v6mr9294606ybf.398.1532447917120;
        Tue, 24 Jul 2018 08:58:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:c07])
        by smtp.gmail.com with ESMTPSA id 21-v6sm609155ywf.79.2018.07.24.08.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 08:58:35 -0700 (PDT)
Date:   Tue, 24 Jul 2018 12:01:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180724160126.GC11598@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718120318.GC2476@hirez.programming.kicks-ass.net>
 <20180719184740.GA26291@cmpxchg.org>
 <20180719203114.GL2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719203114.GL2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:31:15PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 19, 2018 at 02:47:40PM -0400, Johannes Weiner wrote:
> > On Wed, Jul 18, 2018 at 02:03:18PM +0200, Peter Zijlstra wrote:
> > > On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> > > > +	/* Update task counts according to the set/clear bitmasks */
> > > > +	for (to = 0; (bo = ffs(clear)); to += bo, clear >>= bo) {
> > > > +		int idx = to + (bo - 1);
> > > > +
> > > > +		if (tasks[idx] == 0 && !psi_bug) {
> > > > +			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d idx=%d tasks=[%u %u %u] clear=%x set=%x\n",
> > > > +					cpu, idx, tasks[0], tasks[1], tasks[2],
> > > > +					clear, set);
> > > > +			psi_bug = 1;
> > > > +		}
> > > 
> > > 		WARN_ONCE(!tasks[idx], ...);
> > 
> > It's just open-coded because of the printk_deferred, since this is
> > inside the scheduler.
> 
> Yeah, meh. There's ton of WARNs in the scheduler, WARNs should not
> trigger anyway.

This one in particular gave us quite a runaround. We had a subtle bug
in how psi processed task CPU migration that would only manifest with
hundreds of thousands of machine hours. When it triggered, instead of
the warning, we'd crash on a corrupted stack with a completely useless
crash dump - PC pointing to things that couldn't possibly trap etc.

So printk_deferred has been a lot more useful in those rare but
desparate cases ;-) Plus we keep the machine alive.
