Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0549C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B44824037
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUVjUQ1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B44824037
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753604AbeGENc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:32:27 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38959 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753363AbeGENc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:32:26 -0400
Received: by mail-it0-f66.google.com with SMTP id p185-v6so12334677itp.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXE1rjXVtTn1zOo/ykeJem/1cVXc9We+CnAVWqscHMY=;
        b=HUVjUQ1uStzaKyeScgTG5N9qi0+ifFlqEU2cNYUtEm+3XMhyaWeaFqpNFxmJ36yMuo
         RrEPx/gAKB9L4fKlIyO9ljFUGN0cizwAm+5H6G8hNV26jyTWCIpYgnMwj5gDU+eG735S
         FCF71G5U455pkURYu7lP1wDu1mRCRpVmIw+yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXE1rjXVtTn1zOo/ykeJem/1cVXc9We+CnAVWqscHMY=;
        b=Uu4OEqR89/w2vsVYNIb3vuSSnNERNOaZ2BtWR0w7UJoQPtil6fCs2sUFJZl1cTIgzi
         LrIm2Qtl1ReWvJCMn+onQ5j9jKpTsvwfeb9m8r2ithO+jyi576lIKvJPSLAiOWRWB31K
         S/uKKGz2upljAZc65B8bItP4F9I3vC/uX0F5NVkyICaSy7CPFBhgjxC+iWmanPnNFpQB
         nbP3yR81c2Lt83QdsbrG+BvpcrH3sLjNmEh5+dXpL35qs0yu6HBxRRNIeUnc1mFwViM0
         b3wbVnZxQhph37rqugfSVU6DSLStJjwAidS16qT8S3vVqXfBdcjoVloFTgee6ujYkkEU
         0sAQ==
X-Gm-Message-State: APt69E2TH1WmgYoMHp5j7ry45c5k8W2w9HKqE84WRHvB9kzmSYXPSnYq
        moCbFme+RNDLxRP7G692B5oNxZEr2ZfR/PyrBwUOSg==
X-Google-Smtp-Source: AAOMgpeWC6DxKMvKJFT8Ge2/+Ir6e70G8z+Ews0GsXHbGNfJDPCh/xhalE17u2izohTsrKi6mFvJw59ELXHNynIeiGU=
X-Received: by 2002:a02:4550:: with SMTP id y77-v6mr5083889jaa.12.1530797545341;
 Thu, 05 Jul 2018 06:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org> <20180705123617.GM2458@hirez.programming.kicks-ass.net>
In-Reply-To: <20180705123617.GM2458@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 5 Jul 2018 15:32:14 +0200
Message-ID: <CAKfTPtA_5N_+fiLLcMi7Mx2xDMpxpxZqNdPTWQjZobx5uQ-MtQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] track CPU utilization
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter

On Thu, 5 Jul 2018 at 14:36, Peter Zijlstra <peterz@infradead.org> wrote:
>

>
> OK, this looks good I suppose. Rafael, are you OK with me taking these?
>
> I have the below on top because I once again forgot how it all worked;
> does this work for you Vincent?

Yes looks good to me

Thanks

>
> ---
> Subject: sched/cpufreq: Clarify sugov_get_util()
>
> Add a few comments (hopefully) clarifying some of the magic in
> sugov_get_util().
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  cpufreq_schedutil.c |   69 ++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 51 insertions(+), 18 deletions(-)
>
