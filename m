Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeCNPnS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:43:18 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35759 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeCNPnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:43:15 -0400
X-Google-Smtp-Source: AG47ELsg6T7oZrR2Ixbh/e0aWGYdLla199Ov7iHvlItupXKLQW5faI0rbhgXbtUo2q7+WKbQ2bRVKQ==
Date: Wed, 14 Mar 2018 08:43:12 -0700
From: Tejun Heo <tj@kernel.org>
To: David Chen <tuxoko@gmail.com>
Cc: Shaohua Li <shli@fb.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: blk_mq_freeze_queue hang and possible race in percpu-refcount
Message-ID: <20180314154312.GZ2943022@devbig577.frc2.facebook.com>
References: <CAK1sfuYAQf0irGzGxusNg-PdqLSzJ6tSHMENG2Vp8gH1c0FG9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1sfuYAQf0irGzGxusNg-PdqLSzJ6tSHMENG2Vp8gH1c0FG9w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David.

On Tue, Mar 13, 2018 at 03:50:47PM -0700, David Chen wrote:
> ====
> CPU A                           CPU B
> -----                           -----
> percpu_ref_kill()               percpu_ref_tryget_live()
> {
>                                 if (__ref_is_percpu())
>   set __PERCPU_REF_DEAD;
>   __percpu_ref_switch_mode();
>    ^ sum up current percpu_count
>                                 this_cpu_inc(*percpu_count); <- this
> increment got leaked.
> 
> ====
> 
> So if later CPU B later does percpu_ref_put, it will cause ref->count
> to drop to -1.
> And thus causing the above hung task issue.
> 
> Do you think this theory is correct, or am I missing something?
> Please tell me what do you think.

The switching to atomic mode does something like the following.

1. Mark the refcnt so that __ref_is_percpu() is false.

2. Wait for RCU grace period so that everyone including
   percpu_ref_tryget_live() which has seen true __ref_is_percpu() is
   done with its operation.

3. Now that it knows nobody is operating on the assumption that the
   counter is in percpu mode, it adds up all the percpu counters.

So, provided there aren't some silly bugs, what you described
shouldn't happen.  Can you force the refcnt into atomic mode w/
PERCPU_REF_INIT_ATOMIC and see whether the problem persists?

Thanks.

-- 
tejun
