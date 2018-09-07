Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4785BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E69206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E69206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeIGOO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:14:56 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36493 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbeIGOO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:14:56 -0400
Received: by mail-oi0-f52.google.com with SMTP id r69-v6so26119257oie.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 02:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=11m3f/BtCky/TbBeOnaP6lxX066FZCzmS9D+2/5W5+Q=;
        b=QqfcUwljoSx28Zt9Pl40Kws7xEVkggHectIA7hpFOgqU/oQeD4B6z2rpnYqGA6nGiH
         LMigRwbj3zMT63/4TXtB34laSzB/bi8R9qY0R6vRuIi2SloFIlRIAGH3fQLkyccA4Q6I
         H7Kbc/CafDBPuJlfOiCSp/+QCdwujNktrY4m+swI5I7Sh0BlHpwKJN4oJx51AOF6Jwsj
         vPBS2ZqOWXuT1hy+fKyojTv8WT1pA0OANd1XWrb5pYves3SWkw61LGFZZ4xMXFF9Vzd+
         EvyqfV3GFIwkjXcZFK5SFOPtDbfNuKryFYPlOhKX38dmRjFsEUJrZqcigxzCD3GN5nVO
         0Nng==
X-Gm-Message-State: APzg51A1NfktOiaumSY5U3BhYiT7cs8KnwKjzxbdG6o/7jnBPv29f/Uv
        lpggs0Hf2+j/1/693ktZsm+OrsfPWpz20eHF1cN7lA==
X-Google-Smtp-Source: ANB0VdYVQQzpNaQ7ngJv/r7EkDwnbZc4CApiq6FUR46g+jqZPdVzSDE9w5nrkzLZmGSoWddrpTDFwqeC2nzHxXfrSvc=
X-Received: by 2002:aca:2cd3:: with SMTP id s202-v6mr6665435ois.253.1536312890223;
 Fri, 07 Sep 2018 02:34:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:55cf:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 02:34:49 -0700 (PDT)
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Fri, 7 Sep 2018 11:34:49 +0200
Message-ID: <CAE4VaGC+FcE4cTUwzTLuCRd8rnd-=MhSZHfjKstiRTKcYq-39g@mail.gmail.com>
Subject: [SCHEDULER] Performance drop in 4.19 compared to 4.18 kernel
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        =?UTF-8?B?SmFrdWIgUmHEjWVr?= <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srikar,

I work at Red Hat in the Kernel Performance Team. I would like to ask
you for help.

We have detected a significant performance drop (20% and more) with
4.19rc1 relatively to 4.18 vanilla. We see the regression on different
2 NUMA and 4 NUMA boxes with pretty much all the benchmarks we use -
NAS, Stream, SPECjbb2005, SPECjvm2008.

Mel Gorman has suggested checking
2d4056fafa196e1ab4e7161bae4df76f9602d56d commit - with it reverted we
got some performance back but not entirely:

 * Compared to 4.18, there is still performance regression -
especially with NAS (sp_C_x subtest) and SPECjvm2008. On 4 NUMA
systems, regression is around 10-15%
  * Compared to 4.19rc1 there is a clear gain across all benchmarks, up to 20%.

We are investigating the issue further, Mel has suggested to check
305c1fac3225dfa7eeb89bfe91b7335a6edd5172 as next.

Do you have any further recommendations, which commits have possibly
caused the performance degradation?

I want to discuss with you how can we collaborate on performance
testing for the upstream kernel. Does your testing show as well
performance drop in 4.19? If so, do you have any plans for the fix? If
no, can we send you some more information about our tests so that you
can try to reproduce it?

We would also be more than happy to test the new patches for the
performance - please let us know if you are interested.  We have a
pool of 1 NUMA up to 8 NUMA boxes for that, both AMD and Intel,
covering different CPU generations from Sandy Bridge till Skylake.

I'm looking forward to hearing from you.
Jirka
