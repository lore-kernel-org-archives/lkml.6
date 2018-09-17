Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06206ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD852088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD852088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeIQSmS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:42:18 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33207 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQSmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:42:18 -0400
Received: by mail-oi0-f67.google.com with SMTP id 8-v6so18892234oip.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 06:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p9PMOYqPrpHyJUT0mhYQxiZ8NhIMBPq/AjMIdWpPYSM=;
        b=WFGKdaLq2h7gH8Y6l2exg64ZLPivqHShyOlaXRligAxCsA7AEXjWR3gzr0q7x8wIb9
         gQdN/FLi1299D3XVKl+Bv12RWPq2RpXpVrX6ud42eixsAwYxw4UcRHOl6wvwX61AId+A
         pO2HBtq4JEDxA7luSbVjfku98EbJV4/vra8Jqqvo1+iYm1I+tIX5D/+bAjjtYDraKdbd
         oZhAOgJcEvHLKvchOr1JVUZqewC6zjWEB6TzjVaImgnXvbhc7WzOOybhfPUucDYz5Gko
         n1xfHjQTvaq09ZJKnNz6pWRIL2x9fiZKGULmsvQD6wbY0IK6F8dtHYtNCJ8QCBAeDKYF
         5sBg==
X-Gm-Message-State: APzg51CGtPTAAx7g06fjnYH2fiHljGUpVSRjYvOY8TaXtFYbqwe+zBfN
        /B7/rBDU57biwYlx1pTLA9rJ8vjm0T68+I8eXYFdHA==
X-Google-Smtp-Source: ANB0Vdb5DAKtPBwLoOq8CQ+NSDWcWmvKKOM3Ckf+W0d8+paPGpzs/wqGoCrNN4MTwNeDs3ofSixqlf0Rh8RVkjkgJ2c=
X-Received: by 2002:aca:a94c:: with SMTP id s73-v6mr16927836oie.68.1537190100562;
 Mon, 17 Sep 2018 06:15:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:554b:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 06:14:59
 -0700 (PDT)
In-Reply-To: <20180917130629.nugwsgcsuoda6qf6@techsingularity.net>
References: <CAE4VaGC+FcE4cTUwzTLuCRd8rnd-=MhSZHfjKstiRTKcYq-39g@mail.gmail.com>
 <20180907125649.GA3995@linux.vnet.ibm.com> <20180907131923.GB24106@hirez.programming.kicks-ass.net>
 <20180907134420.GD3995@linux.vnet.ibm.com> <20180907135235.GE24106@hirez.programming.kicks-ass.net>
 <CAE4VaGBeTy-du_tThkr3w-r2KbYW8m+sRcpDPn9sYeENUy_x4g@mail.gmail.com>
 <CAE4VaGDoxOQEhPYtVzEkNdrnFQ=Lnjj2is71ZYUBn_csUreoNA@mail.gmail.com> <20180917130629.nugwsgcsuoda6qf6@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Mon, 17 Sep 2018 15:14:59 +0200
Message-ID: <CAE4VaGBBR9V1RvM2xXqbkOxA=GVtxV4AgoKs5SG5z0c+8AkMKQ@mail.gmail.com>
Subject: Re: [SCHEDULER] Performance drop in 4.19 compared to 4.18 kernel
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Jakub Ra??ek" <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kkolakow@redhat.com" <kkolakow@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending in the plain text mode.

> I'm travelling at the moment but when I get back, I'll see what's in the
> tip tree with respect to Srikar's patches and then rebase the fast-migration
> patches on top and reconfirm they still behave as expected. Assuming
> they do, I'll resend them.


Sounds great, thank you!

If you want me to retest the rebased patch set, just let me know, we
would be more than happy to run the tests on our side.
￼
Jirka

On Mon, Sep 17, 2018 at 3:06 PM, Mel Gorman <mgorman@techsingularity.net> wrote:
> On Fri, Sep 14, 2018 at 04:50:20PM +0200, Jirka Hladky wrote:
>> Hi Peter and Srikar,
>>
>> > I have bounced the 5 patches to you, (one of the 6 has not been applied by
>> > Peter) so I have skipped that.
>> > They can also be fetched from
>> > http://lore.kernel.org/lkml/1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com
>>
>> I'm sorry for the delay, we have finally the results for the above
>> kernel. The performance results look good compared to 4.19 vanilla and
>> are about the same as Mel's sched-numa-fast-crossnode-v1r12 patch set
>> for 4.18:
>>
>> Compared to kernel-4.19.0-0.rc1.1
>>
>>   * Improvement upto 20% for SPECjbb2005, SPECjvm2008 benchmarks
>>   * Improvement upto 50% for stream benchmark
>>   * Improvement upto 100% for the NAS benchmark (sp_C subtest, 8
>> threads on 4 NUMA system with 4x E5-4610 v2 @ 2.30GHz, 64 cores in
>> total)
>>
>> When I compare it against Mel's patchset
>> (git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git
>> sched-numa-fast-crossnode-v1r12)
>>
>>   * Mel's kernel is about 15% faster for stream benchmarks
>>   * The other benchmarks show very similar results with both kernels
>>
>> Mel's patchset eliminates NUMA migration rate limits, this is
>> presumbly the reason for the good stream results.
>>
>> Do you have any update when the current patchset could be merged into
>> the upstream kernel?
>>
>
> I'm travelling at the moment but when I get back, I'll see what's in the
> tip tree with respect to Srikar's patches and then rebase the fast-migration
> patches on top and reconfirm they still behave as expected. Assuming
> they do, I'll resend them.
