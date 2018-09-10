Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82325C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BB42086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BB42086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeIJWLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:11:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:54130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbeIJWLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:11:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7193AF44;
        Mon, 10 Sep 2018 17:15:56 +0000 (UTC)
Date:   Mon, 10 Sep 2018 10:15:50 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/rwsem: Make owner store task pointer of last
 owning reader
Message-ID: <20180910171550.GA3902@linux-r8p5>
References: <1536265114-10842-1-git-send-email-longman@redhat.com>
 <20180910093156.GS24082@hirez.programming.kicks-ass.net>
 <83b333ea-8ef2-84ea-6810-4ab1a67eef88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <83b333ea-8ef2-84ea-6810-4ab1a67eef88@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Waiman Long wrote:

>One major issue with a combined count/owner is that we may have to use
>cmpxchg for reader lock which will certainly impact reader-heavy
>workloads. I have also thought about ways to compress the task pointer
>address so that it can use fewer bits and leave the rests for reader
>count. It is probably doable on 64-bit systems, but likely not on 32-bit
>system given that there are less bits to play around.

Yeah we've discussed this before. As a cleanup it would obviously be good,
but I fear about raw performance loss when using cmpxchg instead of xadd.

Thanks,
Davidlohr
