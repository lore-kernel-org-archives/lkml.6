Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4798EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A70320685
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfAHPQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:16:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:59020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727484AbfAHPQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:16:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5AE72AFD8;
        Tue,  8 Jan 2019 15:16:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Jan 2019 07:16:10 -0800
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Jason Baron <jbaron@akamai.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] epoll: remove wrong assert that ep_poll_callback is
 always called with irqs off
Organization: SUSE Labs
In-Reply-To: <f582f40b9697dced81d16b3b35a4b071@suse.de>
References: <20190108100121.20247-1-rpenyaev@suse.de>
 <f582f40b9697dced81d16b3b35a4b071@suse.de>
Message-ID: <725cdce88418c2ec62ef6014d388dbeb@suse.de>
X-Sender: dbueso@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-08 04:42, Roman Penyaev wrote:
> What we can do:
> 
> a) disable irqs if we are not in interrupt.
> b) revert the patch completely.
> 
> David, is it really crucial in terms of performance to avoid double
> local_irq_save() on Xen on this ep_poll_callback() hot path?

Note that such optimizations are also relevant for baremetal, ie: x86 
PUSHF + POPF can be pretty expensive because of insn dependencies.

> 
> For example why not to do the following:
> 
>   if (!in_interrupt())
>        local_irq_save(flags);
>   read_lock(ep->lock);
> 
> with huge comment explaining performance number.
> 
> Or just give up and simply revert the original patch completely
> and always call read_lock_irqsave().

Yeah so the reason why I had done the other epoll lock irq optimizations 
was because they were painfully obvious. ep_poll_callback(), however is 
a different beast, as you've encountered. I vote for not shooting 
ourselves in the foot and just dropping this patch -- most large 
performance benefits will come from microbenches anyway.

Thanks,
Davidlohr
