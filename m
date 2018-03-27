Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbeC0Hii (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:38:38 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39052 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbeC0Hih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:38:37 -0400
X-Google-Smtp-Source: AG47ELtlIRMU2dmRgzYMJsu+7H9y5/LuOgbqaF6Q9+hcY4UorOb8ZamRLJKHs9Fc81/H2lGLNx3CIQ==
Date: Tue, 27 Mar 2018 10:38:34 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, willy@infradead.org,
        adobriyan@gmail.com, mhocko@kernel.org, mguzik@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
Message-ID: <20180327073834.GI2236@uranus>
References: <1522088439-105930-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180326183725.GB27373@bombadil.infradead.org>
 <20180326192132.GE2236@uranus>
 <0bfa8943-a2fe-b0ab-99a2-347094a2bcec@i-love.sakura.ne.jp>
 <20180326212944.GF2236@uranus>
 <201803270700.IJB35465.HJQFSFMVLFOtOO@I-love.SAKURA.ne.jp>
 <ceaa72ee-a63a-983b-d040-387886f5599c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceaa72ee-a63a-983b-d040-387886f5599c@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 06:12:55PM -0400, Yang Shi wrote:
> > +	if (unlikely(arg_start > arg_end || env_start > env_end)) {
> > +		cond_resched();
> > +		goto retry;
> 
> Can't it trap into dead loop if the condition is always false?

Yes, unfortunately it can.

> > +	}
> > 
> > for reading these fields.
> > 
> > By the way, /proc/pid/ readers are serving as a canary who tells something
> > mm_mmap related problem is happening. On the other hand, it is sad that
> > such canary cannot be terminated by signal due to use of unkillable waits.
> > I wish we can use killable waits.
> 
> I already proposed patches (https://lkml.org/lkml/2018/2/26/1197) to do this
> a few weeks ago. In the review, akpm suggested mitigate the mmap_sem
> contention instead of using killable version workaround. Then the
> preliminary unmaping by section patches
> (https://lkml.org/lkml/2018/3/20/786) were proposed. In the discussion, we
> decided to eliminate the mmap_sem abuse, this is where the patch came from.
