Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ED5C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463C420882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463C420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJHWzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:55:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbeJHWzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:55:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A31FDAF58;
        Mon,  8 Oct 2018 15:43:18 +0000 (UTC)
Date:   Mon, 8 Oct 2018 17:43:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20181008154317.2owdxq7y6kie5sxh@pathway.suse.cz>
References: <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
 <20180928090939.GE1160@jagdpanzerIV>
 <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
 <20180929105151.GA1392@tigerII.localdomain>
 <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
 <20181001023721.GA6409@jagdpanzerIV>
 <880ef52f-dff7-af91-5353-f63513265ffe@i-love.sakura.ne.jp>
 <20181002063851.GF598@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002063851.GF598@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-10-02 15:38:51, Sergey Senozhatsky wrote:
> On (10/01/18 20:21), Tetsuo Handa wrote:
> > Maybe "struct printk_buffer" after all becomes identical to "struct cont". But
> > I guess that even 16 printk_buffer-s is practically sufficient for 1024 CPUs
> > system, and allocating NR_CPUS printk_buffer-s will be too wasteful.
> 
> NR_CPUS buffers is quite a lot, indeed. Maybe we can do something like
> NR_CPUS/4 + 1, etc. Kconfig option will be super hard to get right for
> distributions. If people who wrote the code didn't agree on the correct
> number of buffers and passed it to the distributions, then it's a good
> sign than distributions will have problems picking up the good number as
> well.

I am afraid that only some testing or real life experience might tell
us what number is good enough.

The good thing is that it could only be better than the current
state when we have only one cont buffer.

Also I would not be so much afraid of the per-cpu buffer. We already
use 16kB per-CPU for printk_safe and printk_nmi. One more kB should
no be that big deal.

Best Regards,
Petr
