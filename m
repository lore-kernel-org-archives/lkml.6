Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEF8C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093B820879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544548767;
	bh=ZhM7/6kCh1RoccwmFG7O4w9mKgUKd07XiVAE8O09NHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zcU/lskq1LoZLAml7XOrLGbaTsSP8IX98yUoz/b48az7BYFaYQtZ/EFDVOg3ORH3l
	 QUeaeM54I6qRPZ7bbWjbVdjJRUhO0fuwAz7qenq8UOx9r4n2w6sTK09b0MjpAGRdyh
	 B8cc/06Ew8np00+T9pmLe2OktgIso5zmZ2rU1BQs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093B820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeLKRTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:19:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbeLKRTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:19:25 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 848C22086D;
        Tue, 11 Dec 2018 17:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544548764;
        bh=ZhM7/6kCh1RoccwmFG7O4w9mKgUKd07XiVAE8O09NHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NfdOD1ZihMxwM+i06oB7TIbALZwp4jc5fH103XufNwoPhRQia2qJQb11d3qj8AoCr
         TqrTAnQVn85Iic738qxG7X+cElrhVnX/TLA7Gfj68fvvrRCM0rv30YtA6PJgUX+WeK
         m/ll7aXWhkLJCOjeghIaJC7uiWKzpNm0WK03Uu3k=
Date:   Tue, 11 Dec 2018 12:19:23 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, peterz@infradead.org, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v3 05/24] liblockdep: Rename "trywlock" into "trywrlock"
Message-ID: <20181211171923.GO97256@sasha-vm>
References: <20181207011148.251812-1-bvanassche@acm.org>
 <20181207011148.251812-6-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181207011148.251812-6-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 05:11:29PM -0800, Bart Van Assche wrote:
>This patch avoids that the following compiler warning is reported while
>compiling the lockdep unit tests:
>
>include/liblockdep/rwlock.h: In function 'liblockdep_pthread_rwlock_trywlock':
>include/liblockdep/rwlock.h:66:9: warning: implicit declaration of function 'pthread_rwlock_trywlock'; did you mean 'pthread_rwlock_trywrlock'? [-Wimplicit-function-declaration]
>  return pthread_rwlock_trywlock(&lock->rwlock) == 0 ? 1 : 0;
>         ^~~~~~~~~~~~~~~~~~~~~~~
>         pthread_rwlock_trywrlock

Hm, I'm not sure why you're seeing that error (I'm not). We define
pthread_rwlock_trywlock() in:

	include/liblockdep/rwlock.h:static inline int liblockdep_pthread_rwlock_trywlock(liblockdep_pthread_rwlock_t *lock)

All the tests also seem to pass for me. Did you see failures on your
end?

--
Thanks,
Sasha
