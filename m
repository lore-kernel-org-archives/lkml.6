Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D476FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742C320659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742C320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeLELZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:25:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:59564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbeLELZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:25:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 036C1B002;
        Wed,  5 Dec 2018 11:25:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Dec 2018 12:25:39 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
In-Reply-To: <20181204235907.GA5388@andrea>
References: <20181203110237.14787-1-rpenyaev@suse.de>
 <CAHk-=wiQX4HnBpyrxCwJmhBRff0GG65tOhsRnA=2KdYL=PBdyg@mail.gmail.com>
 <83edf06ce9db540495b53527eca3248c@suse.de> <20181204235907.GA5388@andrea>
Message-ID: <51e8202b163d7522efb18aa2ca79d952@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-05 00:59, Andrea Parri wrote:
> Hi Roman,
> 
> On Tue, Dec 04, 2018 at 12:50:58PM +0100, Roman Penyaev wrote:
>> On 2018-12-03 18:34, Linus Torvalds wrote:
> 
>> > This also ends up making the memory ordering of "xchg()" very very
>> > important. Yes, we've documented it as being an ordering op, but I'm
>> > not sure we've relied on it this directly before.
>> 
>> Seems exit_mm() does exactly the same, the following chunk:
>> 
>> 		up_read(&mm->mmap_sem);
>> 
>> 		self.task = current;
>> 		self.next = xchg(&core_state->dumper.next, &self);
>> 
>> 
>> At least code pattern looks similar.
> 
> Maybe add a comment on top of (your) xchg() to note/justify these 
> memory
> ordering requirements?  As Paul said: "if there are races, this would
> help force them to happen" (and simplify the review, this/future).

Hi Andrea,

Sure, this path is tricky, so will I cook something up.

--
Roman
