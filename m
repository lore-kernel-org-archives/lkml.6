Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43868C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D35205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D35205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeIGBck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:32:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:53388 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727770AbeIGBck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:32:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DD26ABEF;
        Thu,  6 Sep 2018 20:55:25 +0000 (UTC)
Date:   Thu, 6 Sep 2018 13:55:17 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jbaron@akamai.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -next 0/2] fs/epoll: loosen irq safety when possible
Message-ID: <20180906205517.GC31080@linux-r8p5>
References: <20180720172956.2883-1-dave@stgolabs.net>
 <20180720124212.7260d76d83e2b8e5e3349ea5@linux-foundation.org>
 <20180720200559.27nc7j2rrxpy5p3n@linux-r8p5>
 <20180906191140.GA4816@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180906191140.GA4816@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Sep 2018, Peter Zijlstra wrote:

>On Fri, Jul 20, 2018 at 01:05:59PM -0700, Davidlohr Bueso wrote:
>> On Fri, 20 Jul 2018, Andrew Morton wrote:
>
>> >I'm surprised.  Is spin_lock_irqsave() significantly more expensive
>> >than spin_lock_irq()?  Relative to all the other stuff those functions
>> >are doing?  If so, how come?  Some architectural thing makes
>> >local_irq_save() much more costly than local_irq_disable()?
>>
>> For example, if you compare x86 native_restore_fl() to xen_restore_fl(),
>> the cost of Xen is much higher.
>
>Xen is a moot argument. IIRC the point is that POPF (as used by
>*irqrestore()) is a very expensive operation because it changes all
>flags and thus has very 'difficult' instruction dependencies, killing
>the front end reorder and generating a giant bubble in the pipeline.
>
>Similarly, I suppose PUSHF is an expensive instruction because it needs
>all the flags 'stable' and thus needs to wait for a fair number of prior
>instructions to retire before it can get on with it.
>
>Combined the whole PUSHF + POPF is _far_ more expensive than STI + CLI,
>because the latter only has dependencies on instructions that muck about
>with IF -- not that many.

ack.

In fact it turns out that my Xen numbers for this patch were actually
native (popf), and not the xen_restore_fl() as it was using hvm and
not paravirt.

Thanks,
Davidlohr
