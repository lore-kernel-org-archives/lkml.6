Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07170C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C147720870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544730107;
	bh=W2l3wYEXQLmwmXot/aRkXqMGblh6omnHAc9NNLQ/1u8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W4UXGzGnW9G5ELarhwE+6d9U8ZyRbmIY6Pz9jQ4fcNjqSgUEw2fj+jYl+uKs3ByhF
	 85Tx7HOMIEZhpXbueXLOxWfkse0n8qur7v9r13eHlgGij2lSa1raiyB9+1JbJ4Macv
	 khuCEfYGI5mTxTclDqo4YFt9hSxjYiSfYTMkLBKc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C147720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeLMTlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:41:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbeLMTlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:41:46 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A672086D;
        Thu, 13 Dec 2018 19:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544730105;
        bh=W2l3wYEXQLmwmXot/aRkXqMGblh6omnHAc9NNLQ/1u8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7NlNWe1ajBT57DHYtABjzR05aE1RH7LNSQaD8uMlaayj7u2xt7bWR5cZURtxXzpW
         GKfb20rNv1O/6Enrw3O6Ejd5I4gkP18Hhhhxdl4zWxBZAlP9BuQHE2DUEEVgj9XKth
         htbdFbwVdI5bOqCrsA/glM6P25tqE0ckUZxIZoEY=
Date:   Thu, 13 Dec 2018 14:41:43 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, peterz@infradead.org, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v3 05/24] liblockdep: Rename "trywlock" into "trywrlock"
Message-ID: <20181213194143.GK2746@sasha-vm>
References: <20181207011148.251812-1-bvanassche@acm.org>
 <20181207011148.251812-6-bvanassche@acm.org>
 <20181211171923.GO97256@sasha-vm>
 <1544549911.185366.384.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1544549911.185366.384.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 09:38:31AM -0800, Bart Van Assche wrote:
>On Tue, 2018-12-11 at 12:19 -0500, Sasha Levin wrote:
>> On Thu, Dec 06, 2018 at 05:11:29PM -0800, Bart Van Assche wrote:
>> > This patch avoids that the following compiler warning is reported while
>> > compiling the lockdep unit tests:
>> >
>> > include/liblockdep/rwlock.h: In function 'liblockdep_pthread_rwlock_trywlock':
>> > include/liblockdep/rwlock.h:66:9: warning: implicit declaration of function 'pthread_rwlock_trywlock'; did you mean 'pthread_rwlock_trywrlock'? [-Wimplicit-function-declaration]
>> >  return pthread_rwlock_trywlock(&lock->rwlock) == 0 ? 1 : 0;
>> >         ^~~~~~~~~~~~~~~~~~~~~~~
>> >         pthread_rwlock_trywrlock
>>
>> Hm, I'm not sure why you're seeing that error (I'm not). We define
>> pthread_rwlock_trywlock() in:
>>
>> 	include/liblockdep/rwlock.h:static inline int liblockdep_pthread_rwlock_trywlock(liblockdep_pthread_rwlock_t *lock)
>>
>> All the tests also seem to pass for me. Did you see failures on your
>> end?
>
>What I saw is that due to the typo that is fixed by this patch that linking
>of the tests failed and that the error message that was reported because
>starting the tests failed made the tests pass due to the following line in
>run_tests.sh:
>
>if [ $(timeout 1 ./lockdep ./tests/$testname 2>&1 | wc -l) -gt 0 ]; then

Ah, I see. Thank you!

--
Thanks,
Sasha
