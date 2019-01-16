Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD032C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B17B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNIX15QM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392057AbfAPMWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:22:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38586 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390019AbfAPMWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:22:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so6695301wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 04:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7GctlGV8jUJf3eugRW/XtYy29XucT+mtv06KetmoIDs=;
        b=bNIX15QMJ3TonchKeP4Oh1h3mxJpTC3AHkJdHuwXeeFjqLYGwFk2ETOk2Mwy+rf9+j
         2wQqmoDYsjdaNkbI1ZMjobJtI4rZJ5XFs5ZoCTk1BzEGyLeqJGgIbU1bbAAidF/9Bf++
         eZNFLQgimlavbWkoUHadUfq0mXQC8zaK4NBBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7GctlGV8jUJf3eugRW/XtYy29XucT+mtv06KetmoIDs=;
        b=G7JGgqJx/CeOVJbe8qC8jKSuyrFSWzJQKrJIIvWV7OpsL/SS+XeRkN05YP9MD7tSXW
         m+DIBm/TXBj7TBw8J2DedRQ3g9v3Y9VwY11rGfoz47WJHSY0rAW4XI7/a6tb7jXJcsM6
         DM07tDIfFd6dMcKG2iiKokdVepK81YLKO7PSEqEBrsuL5y4DOpTZDSw86Y2QuRyVNAjP
         mRDe0mFnCA20e3r5Nz6uchXUowQ6oAMtKz0GKVSWLKAIwqb5c3yxpLe6sk1P5jb+A8ra
         mVvx7PF1CYcJrczFuFoRssAz9ji0nlW/jUH0NEXuS3Nd1v+yEm00T4a9qjttmuOzKHxD
         /ebg==
X-Gm-Message-State: AJcUukcyDs+mBK/bbWAQZYMGomMBlrOEcYKy8LGn+adDlH4+KUU5/gS8
        B4hJfymOahbvjgUd/UIOQm9W6A==
X-Google-Smtp-Source: ALg8bN6VNOGIeAogkAPaj5CdVMgUNJR34s01Tff3Df7CVHQNDyuz2taROL9A5zvpkoOENA1LnuePzw==
X-Received: by 2002:adf:fd50:: with SMTP id h16mr7894474wrs.231.1547641357306;
        Wed, 16 Jan 2019 04:22:37 -0800 (PST)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id x81sm36261009wmg.17.2019.01.16.04.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 04:22:36 -0800 (PST)
Subject: Re: [PATCH v11] cpuidle: New timer events oriented governor for
 tickless systems
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>, "Chen, Hu" <hu1.chen@intel.com>,
        Quentin Perret <quentin.perret@arm.com>
References: <3625809.WY5lk7ujeb@aspire.rjw.lan>
 <2138748.C3tVedyW9D@aspire.rjw.lan>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7ce53e4d-69ca-f7a5-5880-21999d926d3d@linaro.org>
Date:   Wed, 16 Jan 2019 13:22:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2138748.C3tVedyW9D@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2019 13:03, Rafael J. Wysocki wrote:
> On Friday, January 4, 2019 12:30:47 PM CET Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The venerable menu governor does some things that are quite
>> questionable in my view.
>>
>> First, it includes timer wakeups in the pattern detection data and
>> mixes them up with wakeups from other sources which in some cases
>> causes it to expect what essentially would be a timer wakeup in a
>> time frame in which no timer wakeups are possible (because it knows
>> the time until the next timer event and that is later than the
>> expected wakeup time).
>>
>> Second, it uses the extra exit latency limit based on the predicted
>> idle duration and depending on the number of tasks waiting on I/O,
>> even though those tasks may run on a different CPU when they are
>> woken up.  Moreover, the time ranges used by it for the sleep length
>> correction factors depend on whether or not there are tasks waiting
>> on I/O, which again doesn't imply anything in particular, and they
>> are not correlated to the list of available idle states in any way
>> whatever.
>>
>> Also, the pattern detection code in menu may end up considering
>> values that are too large to matter at all, in which cases running
>> it is a waste of time.
>>
>> A major rework of the menu governor would be required to address
>> these issues and the performance of at least some workloads (tuned
>> specifically to the current behavior of the menu governor) is likely
>> to suffer from that.  It is thus better to introduce an entirely new
>> governor without them and let everybody use the governor that works
>> better with their actual workloads.
>>
>> The new governor introduced here, the timer events oriented (TEO)
>> governor, uses the same basic strategy as menu: it always tries to
>> find the deepest idle state that can be used in the given conditions.
>> However, it applies a different approach to that problem.
>>
>> First, it doesn't use "correction factors" for the time till the
>> closest timer, but instead it tries to correlate the measured idle
>> duration values with the available idle states and use that
>> information to pick up the idle state that is most likely to "match"
>> the upcoming CPU idle interval.
>>
>> Second, it doesn't take the number of "I/O waiters" into account at
>> all and the pattern detection code in it avoids taking timer wakeups
>> into account.  It also only uses idle duration values less than the
>> current time till the closest timer (with the tick excluded) for that
>> purpose.
> 
> Given the lack of negative feedback and my confidence in this, I'm
> queuing it up for 5.1.

Yeah, this governor was not proposed in the better moment for review for
me :/

I agree writing a new governor is certainly simpler than revisiting the
menu governor again. That is the advantage of the governors, we can add
more of them suiting the needs.

If you are confident and Doug bench-marked it showing better results
than the menu governor on x86, I don't see any reason to not merge it.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

