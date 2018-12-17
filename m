Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A382133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbeLQSBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:01:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:55164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727650AbeLQSBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:01:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 814A0AF07;
        Mon, 17 Dec 2018 18:01:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Dec 2018 10:01:19 -0800
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Jason Baron <jbaron@akamai.com>, Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] use rwlock in order to reduce ep_poll_callback()
 contention
Organization: SUSE Labs
In-Reply-To: <73608dd0e5839634966b3b8e03e4b3c9@suse.de>
References: <20181212110357.25656-1-rpenyaev@suse.de>
 <cab90224c6c06dcb2ec728fc9e26ea13@suse.de>
 <73608dd0e5839634966b3b8e03e4b3c9@suse.de>
Message-ID: <275da18a1d286eabf7c9f6588d66baf4@suse.de>
X-Sender: dbueso@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-17 03:49, Roman Penyaev wrote:
> On 2018-12-13 19:13, Davidlohr Bueso wrote:
> Yes, good idea.  But frankly I do not want to bloat epoll-wait.c with
> my multi-writers-single-reader test case, because soon epoll-wait.c
> will become unmaintainable with all possible loads and set of
> different options.
> 
> Can we have a single, small and separate source for each epoll load?
> Easy to fix, easy to maintain, debug/hack.

Yes completely agree; I was actually thinking along those lines.

> 
>> I ran these patches on the 'wait' workload which is a epoll_wait(2)
>> stresser. On a 40-core IvyBridge it shows good performance
>> improvements for increasing number of file descriptors each of the 40
>> threads deals with:
>> 
>> 64   fds: +20%
>> 512  fds: +30%
>> 1024 fds: +50%
>> 
>> (Yes these are pretty raw measurements ops/sec). Unlike your
>> benchmark, though, there is only single writer thread, and therefore
>> is less ideal to measure optimizations when IO becomes available.
>> Hence it would be nice to also have this.
> 
> That's weird. One writer thread does not content with anybody, only 
> with
> consumers, so should not be any big difference.

Yeah so the irq optimization patch, which is known to boost numbers on 
this microbench, plays an important factor. I just put them all together 
when testing.

Thanks,
Davidlohr
