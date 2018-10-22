Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DA0C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5F520890
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5F520890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeJVVKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:10:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:40892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727210AbeJVVKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:10:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B813AAFC0;
        Mon, 22 Oct 2018 12:51:45 +0000 (UTC)
Date:   Mon, 22 Oct 2018 14:51:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
Message-ID: <20181022125142.GD18839@dhcp22.suse.cz>
References: <20181019173538.590-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019173538.590-1-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I haven't read through the implementation yet but I have say that I
really love this cover letter. It is clear on intetion, it covers design
from high level enough to start discussion and provides a very nice
testing coverage. Nice work!

I also think that we need a better performing vmalloc implementation
long term because of the increasing number of kvmalloc users.

I just have two mostly workflow specific comments.

> A test-suite patch you can find here, it is based on 4.18 kernel.
> ftp://vps418301.ovh.net/incoming/0001-mm-vmalloc-stress-test-suite-v4.18.patch

Can you fit this stress test into the standard self test machinery?

> It is fixed by second commit in this series. Please see more description in
> the commit message of the patch.

Bug fixes should go first and new functionality should be built on top.
A kernel crash sounds serious enough to have a fix marked for stable. If
the fix is too hard/complex then we might consider a revert of the
faulty commit.
> 
> 3) This one is related to PCPU allocator(see pcpu_alloc_test()). In that
> stress test case i see that SUnreclaim(/proc/meminfo) parameter gets increased,
> i.e. there is a memory leek somewhere in percpu allocator. It sounds like
> a memory that is allocated by pcpu_get_vm_areas() sometimes is not freed.
> Resulting in memory leaking or "Kernel panic":
> 
> ---[ end Kernel panic - not syncing: Out of memory and no killable processes...

It would be great to pin point this one down before the rework as well.

Thanks a lot!
-- 
Michal Hocko
SUSE Labs
