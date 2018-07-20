Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D0EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55D320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55D320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbeGTTPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:15:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:39400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387994AbeGTTPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:15:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F2F0AD1E;
        Fri, 20 Jul 2018 18:25:43 +0000 (UTC)
Date:   Fri, 20 Jul 2018 11:25:34 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -next] ipc/sem: prevent queue.status tearing in semop
Message-ID: <20180720182534.2u2fh5i2cyhd7owo@linux-r8p5>
References: <20180717052654.676-1-dave@stgolabs.net>
 <7909e12b-6dd7-e28a-010c-003545a8e4b5@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7909e12b-6dd7-e28a-010c-003545a8e4b5@colorfullife.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Manfred Spraul wrote:

>Hello Davidlohr,
>
>On 07/17/2018 07:26 AM, Davidlohr Bueso wrote:
>>In order for load/store tearing to work, _all_ accesses to
>>the variable in question need to be done around READ and
>>WRITE_ONCE() macros. Ensure everyone does so for q->status
>>variable for semtimedop().
>What is the background of the above rule?

The fact that it's done under the ipc lock, doesn't mean that
the compiler won't try to get smart. If we have lockless accesses
we musn't see partial stores/loads.

>
>sma->use_global_lock is sometimes used with smp_load_acquire(), 
>sometimes without.
>So far, I assumed that this is safe.
>
>The same applies for nf_conntrack_locks_all, in nf_conntrack_all_lock()

Oh, yeah I remember _that_ saga. I'll have a look but iirc it
seemd ok back then.

Thanks,
Davidlohr
