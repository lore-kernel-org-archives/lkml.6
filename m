Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EAEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333A720850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfAHMm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:42:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:51466 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727236AbfAHMm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:42:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 791DCAF89;
        Tue,  8 Jan 2019 12:42:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Jan 2019 13:42:25 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Davidlohr Bueso <dbueso@suse.de>, Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] epoll: remove wrong assert that ep_poll_callback is
 always called with irqs off
In-Reply-To: <20190108100121.20247-1-rpenyaev@suse.de>
References: <20190108100121.20247-1-rpenyaev@suse.de>
Message-ID: <f582f40b9697dced81d16b3b35a4b071@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-08 11:01, Roman Penyaev wrote:
> That was wrong assumption that all drivers disable irqs before waking 
> up
> a wait queue.  Even assert line is removed the whole logic stays 
> correct:
> epoll always locks rwlock with irqs disabled and by itself does not 
> call
> from interrupts, thus it is up to driver how to call wake_up_locked(),
> because if driver does not handle any interrupts (like fuse in the the
> report) of course it is safe on its side to take a simple spin_lock.

This is wrong and can lead to dead lock: we always call read_lock(), 
caller
can call us with irqs enabled.  Another driver, which also calls
ep_poll_callback(), can be called from interrupt context (irqs disabled)
thus it can interrupt the one who does not disable irqs.  Even we take
a read_lock() (which should be fine to interrupt), write_lock(), which
comes in the middle, can cause a dead lock:

#CPU0                      #CPU1

task:                      task:                       irq:

                            spin_lock(&wq1->lock);
                            ep_poll_callback():
                            read_lock(&ep->lock)
                            ....
write_lock_irq(&ep->lock)  ....
   #waits reads             ....          >>>>>>>>>>>>>>  IRQ CPU1
                                                       
spin_lock_irqsave(&wq2->lock)
                                                       
ep_poll_callback():
                                                       
read_lock(&ep->lock);
                                                       # to avoid write 
starve should
                                                       # wait writer to 
finish, thus
                                                       # dead lock


What we can do:

a) disable irqs if we are not in interrupt.
b) revert the patch completely.

David, is it really crucial in terms of performance to avoid double
local_irq_save() on Xen on this ep_poll_callback() hot path?

For example why not to do the following:

   if (!in_interrupt())
        local_irq_save(flags);
   read_lock(ep->lock);

with huge comment explaining performance number.

Or just give up and simply revert the original patch completely
and always call read_lock_irqsave().

--
Roman

