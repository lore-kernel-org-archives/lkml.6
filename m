Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18D3C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D19B214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D19B214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJITNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:13:21 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:37786 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeJITNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 15:13:20 -0400
Received: by mail-wr1-f52.google.com with SMTP id y11-v6so1508193wrd.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jrUOVshL93CDxYu7hxuyd4O3cvngTxN/QsenqfI1vv4=;
        b=sT6s5OMtYueaqwvcLJRf2BniZ9LQWzvU1zE3cl0pjFz4aCtb8u74joR9ue5mAJtf1M
         I8la9oX+WLvnU+aAI2J6Ml5G8nXo/w9QbYEIyThZMPvwix9IW4dq18aOK4dCh3lbG25W
         7zVZcsbPtVaQlSD7KOnO8YvAFE+epy3Go9iM3BDdST94I3n4azUzF0kgO0vond0IRZ3Y
         cvgc82us/FrJ8fH20lHJmbT4zmAj3vI7uUBXdbn+7+jBusPtIVfqrRToKK2m8C1Wm5zS
         JUrMKDpvlWINgwqDK2lX9Iuj09vXOU6yzOi1Ooocqu8u3dq3MVy3Ne2Cbj8/RTWiLBg1
         mAEg==
X-Gm-Message-State: ABuFfojFQ+0qMH3cPVSVHwwJLhw21diMiftXmKKi9FWhccm139Xo19gH
        3serlAKmv3ZcL8EEa5uknBWgug==
X-Google-Smtp-Source: ACcGV6362XamdW/AWy1Lpc2N5UEql7O/jIBiZP4ON9/FaCEsTFAXhQRR2UBhCx0WNfuUwWVQQ1FhiQ==
X-Received: by 2002:adf:be07:: with SMTP id n7-v6mr18572708wrh.267.1539086202821;
        Tue, 09 Oct 2018 04:56:42 -0700 (PDT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id 90-v6sm25374867wrg.86.2018.10.09.04.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:56:41 -0700 (PDT)
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        will.deacon@arm.com, andrea.parri@amarulasolutions.com,
        dietmar.eggemann@arm.com, patrick.bellasi@arm.com,
        henrik@austad.us, linux-rt-users@vger.kernel.org
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181009105112.bhqlrabdt5ae5qmm@linutronix.de>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <9837aa4b-1bd4-bc6a-84f7-0b8704995d44@redhat.com>
Date:   Tue, 9 Oct 2018 13:56:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009105112.bhqlrabdt5ae5qmm@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/18 12:51 PM, Sebastian Andrzej Siewior wrote:
>> The main concerns I have with the current approach is that, being based
>> on mutex.c, it's both
>>
>>  - not linked with futexes
>>  - not involving "legacy" priority inheritance (rt_mutex.c)
>>
>> I believe one of the main reasons Peter started this on mutexes is to
>> have better coverage of potential problems (which I can assure everybody
>> it had). I'm not yet sure what should we do moving forward, and this is
>> exactly what I'd be pleased to hear your opinions on.
> wasn't the idea that once it works to get rid of rt_mutex?

As far as I know, it is. But there are some additional complexity
involving a -rt version of this patch, for instance:

What should the protocol do if the thread migrating is with migration
disabled?

The side effects of, for instance, ignoring the migrate_disable() would
add noise for the initial implementation... too much complexity at once.

IMHO, once it works in the non-rt, it will be easier to do the changes
needed to integrate it with -rt.

Thoughts?

-- Daniel

