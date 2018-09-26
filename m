Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EDEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706A121527
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706A121527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeIZWdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:33:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbeIZWdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:33:51 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 723B332B669;
        Wed, 26 Sep 2018 16:20:10 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F16B32010D69;
        Wed, 26 Sep 2018 16:20:08 +0000 (UTC)
Subject: Re: [RFC][PATCH 0/3] locking/qspinlock: Improve determinism for x86
To:     Peter Zijlstra <peterz@infradead.org>, will.deacon@arm.com,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
        tglx@linutronix.de
References: <20180926110117.405325143@infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2c284b6d-99c1-2686-b8c0-fce8987e747f@redhat.com>
Date:   Wed, 26 Sep 2018 12:20:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180926110117.405325143@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 26 Sep 2018 16:20:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 07:01 AM, Peter Zijlstra wrote:
> Back when Will did his qspinlock determinism patches, we were left with one
> cmpxchg loop on x86 due to the use of atomic_fetch_or(). Will proposed a nifty
> trick:
>
>   http://lkml.kernel.org/r/20180409145409.GA9661@arm.com
>
> But at the time we didn't pursue it. This series implements that and argues for
> its correctness. In particular it places an smp_mb__after_atomic() in
> between the two operations, which forces the load to come after the
> store (which is free on x86 anyway).
>
> In particular this ordering ensures a concurrent unlock cannot trigger
> the uncontended handoff. Also it ensures that if the xchg() happens
> after a (successful) trylock, we must observe that LOCKED bit.

When you said "concurrent unlock cannot trigger the uncontended
handoff", are you saying the current code has this uncontended handoff
problem or just when comparing to doing a load first followed by xchg()?

Cheers,
Longman

