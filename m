Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6C8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2752F20870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2752F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJJVLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:11:15 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52150 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJJVLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:11:15 -0400
Received: by mail-wm1-f52.google.com with SMTP id 143-v6so5535068wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 06:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jVHdKFTtIEarHLc52YMft/fzjVHCM93gBc4VfVFwGIQ=;
        b=rMGu/XVlovq0dwsyOZdbxBcOzIGQrHzpNLkEdlcrT4N7d//Oixk9yCBD8vu+Z78hOt
         8z057oqrozipm1txVdH6apzliyqYLXBdzkCiquNQs0/14IEu8npwQlMZg7DMZAisYKxX
         oQW307YIhzuJ/7pAt6hIqUU67bURCXWiOa/Ws4sp/sypYzI7bynk+APmrmhzLNh05VHN
         KWibUCPu/pYSvAfS9tCmrHupswK9iIs85k/pYuD/DzRSbhvYrSjd0g2GpV1UjQ0JQhSI
         zaa9ICgfLNVAXEW0tBLqHZTH60KChy1UR/JlwN4xwu4xnoOYphfExHYtHh4fQdOLG51P
         5Fwg==
X-Gm-Message-State: ABuFfoh8F/i0VQbQdxRn6s37EpvBgBV6rgmHKa7mhVT0ARNJNt7YWrpZ
        jaETEHfH2CQOmhqWD7/U8oVa5A==
X-Google-Smtp-Source: ACcGV62RzJrWNJMKSPOdXM6r1Lu8mFO90+y5NvtJ+eAn5ZLzn9QCrY/yxX2pUCxiiyXm5gMmoZfcKA==
X-Received: by 2002:a1c:4385:: with SMTP id q127-v6mr966571wma.111.1539179338119;
        Wed, 10 Oct 2018 06:48:58 -0700 (PDT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id 126-v6sm19437345wme.48.2018.10.10.06.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 06:48:57 -0700 (PDT)
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
To:     Peter Zijlstra <peterz@infradead.org>,
        Henrik Austad <henrik@austad.us>
Cc:     Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, linux-rt-users@vger.kernel.org
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181010115639.GA25534@sisyphus.home.austad.us>
 <20181010122454.GR5663@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <ae2fb170-1414-abea-25e1-7a790dff3eb8@redhat.com>
Date:   Wed, 10 Oct 2018 15:48:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181010122454.GR5663@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 2:24 PM, Peter Zijlstra wrote:
>> I believe there were some papers circulated last year that looked at 
>> something similar to this when you had overlapping or completely disjoint 
>> CPUsets I think it would be nice to drag into the discussion. Has this been 
>> considered? (if so, sorry for adding line-noise!)
> Hurm, was that one of Bjorn's papers? Didn't that deal with AC of
> disjoint/overlapping sets?
> 

This paper:
https://people.mpi-sws.org/~bbb/papers/pdf/rtsj14.pdf

But, unless I am wrong, there were findings after this paper that shows
some imprecision on it.

Anyway, it does not analyse the locking properties, only scheduler of
independent tasks - it is a start, but far from what we do here.

(btw this paper is really complex...)

The locking problem for such case: APA with the nesting of different
locks in the locking implementation (we use raw spin lock on this, and
this method could also be used in the rw lock/sem in the future, nesting
rw_lock(mutex_proxy(raw_spinlock())) is an open problem from the
academic point of view.

I explained these things (nested lock and the need of APA for locking)
as "Open Problems" at the RTSOPs (part of the ECRTS) earlier this year:

http://rtsops2018.loria.fr/wp-content/uploads/2018/07/RTSOPS18_proceedings_final.pdf

Bjorn were there, but not only him... Baruah, Davis, Alan Burns were there.

There are some works being done for more complex locking in academy, like:

https://www.cs.unc.edu/~jarretc/papers/ecrts18b_long.pdf

But still, the task model used on these implementations are not the
Linux one.

-- Daniel
