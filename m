Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ECAC5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C9C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C9C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeJQKp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:45:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727087AbeJQKp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:45:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C44EAC11;
        Wed, 17 Oct 2018 02:51:57 +0000 (UTC)
Date:   Tue, 16 Oct 2018 19:51:47 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <andi@firstfloor.org>,
        Dave Chinner <dchinner@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH v9 5/5] lib/dlock-list: Scale dlock_lists_empty()
Message-ID: <20181017025147.wfk7cktcn3emlb6b@linux-r8p5>
References: <1536780532-4092-1-git-send-email-longman@redhat.com>
 <1536780532-4092-6-git-send-email-longman@redhat.com>
 <20181004071600.GC29482@quack2.suse.cz>
 <5bcdf2a2-6d03-df21-934d-6c989549253b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5bcdf2a2-6d03-df21-934d-6c989549253b@redhat.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Oct 2018, Waiman Long wrote:

>On 10/04/2018 03:16 AM, Jan Kara wrote:
>> On Wed 12-09-18 15:28:52, Waiman Long wrote:
>>> From: Davidlohr Bueso <dave@stgolabs.net>
>>>
>>> Instead of the current O(N) implementation, at the cost
>>> of adding an atomic counter, we can convert the call to
>>> an atomic_read(). The counter only serves for accounting
>>> empty to non-empty transitions, and vice versa; therefore
>>> only modified twice for each of the lists during the
>>> lifetime of the dlock (while used).
>>>
>>> In addition, to be able to unaccount a list_del(), we
>>> add a dlist pointer to each head, thus minimizing the
>>> overall memory footprint.
>>>
>>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>>> Acked-by: Waiman Long <longman@redhat.com>
>> So I was wondering: Is this really worth it? AFAICS we have a single call
>> site for dlock_lists_empty() and that happens during umount where we don't
>> really care about this optimization. So it seems like unnecessary
>> complication to me at this point? If someone comes up with a usecase that
>> needs fast dlock_lists_empty(), then sure, we can do this...
>>
>
>Yes, that is true. We can skip this patch for the time being until a use
>case comes up which requires dlock_lists_empty() to be used in the fast
>path.

So fyi I ended up porting the epoll ready-list to this api, where
dlock_lists_empty() performance _does_ matter. However, the list
iteration is common enough operation to put perform the benefits of
the percpu add/delete operations. For example, when sending ready
events to userspace (ep_send_events_proc()), each item must drop the
iter lock, and also do a delete operation -- similarly for checking
for ready events (ep_read_events_proc). This ends hurting more than
benefiting workloads.

Anyway, so yeah I have no need for this patch, and the added complexity +
atomics is unjustified.

Thanks,
Davidlohr
