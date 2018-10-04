Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DFBC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB5C20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB5C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeJDUfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:35:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbeJDUfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:35:20 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 848394628E;
        Thu,  4 Oct 2018 13:41:58 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65FFD9E7C7;
        Thu,  4 Oct 2018 13:41:56 +0000 (UTC)
Subject: Re: [PATCH v9 5/5] lib/dlock-list: Scale dlock_lists_empty()
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
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
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
References: <1536780532-4092-1-git-send-email-longman@redhat.com>
 <1536780532-4092-6-git-send-email-longman@redhat.com>
 <20181004071600.GC29482@quack2.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5bcdf2a2-6d03-df21-934d-6c989549253b@redhat.com>
Date:   Thu, 4 Oct 2018 09:41:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181004071600.GC29482@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 04 Oct 2018 13:41:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2018 03:16 AM, Jan Kara wrote:
> On Wed 12-09-18 15:28:52, Waiman Long wrote:
>> From: Davidlohr Bueso <dave@stgolabs.net>
>>
>> Instead of the current O(N) implementation, at the cost
>> of adding an atomic counter, we can convert the call to
>> an atomic_read(). The counter only serves for accounting
>> empty to non-empty transitions, and vice versa; therefore
>> only modified twice for each of the lists during the
>> lifetime of the dlock (while used).
>>
>> In addition, to be able to unaccount a list_del(), we
>> add a dlist pointer to each head, thus minimizing the
>> overall memory footprint.
>>
>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>> Acked-by: Waiman Long <longman@redhat.com>
> So I was wondering: Is this really worth it? AFAICS we have a single call
> site for dlock_lists_empty() and that happens during umount where we don't
> really care about this optimization. So it seems like unnecessary
> complication to me at this point? If someone comes up with a usecase that
> needs fast dlock_lists_empty(), then sure, we can do this...
>

Yes, that is true. We can skip this patch for the time being until a use
case comes up which requires dlock_lists_empty() to be used in the fast
path.

Cheers,
Longman
