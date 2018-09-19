Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3A5ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497F420880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="f/VEo/pB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497F420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbeISOqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:46:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36196 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeISOqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:46:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id v17-v6so573880lfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dnUs+rHf+qRGsytFHQLej747GSU5gZGA2K/FGQBGvGs=;
        b=f/VEo/pB12IXPaBws3yeDH8MgD0sUoEyWuFsyQd+IrsfJvj0BJXyzvKlmq3XkcjYgM
         w50meoBzy2g6UjdOMnvGk7pYm+TNZejNBC3rJOMVjhC3WOmEU65E7mcPKksHjHVc4TZa
         jbh41K/wgOJgInAO9ZvBnN62RMw8B78yVKhrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dnUs+rHf+qRGsytFHQLej747GSU5gZGA2K/FGQBGvGs=;
        b=NQUzYs++NG64TSZ5WuHqgo4rjNthTiK5h1FLtrFBJbl+IKJemyOhPxP/sHMfZTIKUt
         3zghIVrUJlgfHP3JC0JJUBdcDsMCUpsLxBx5VNOVrpdvqZg7+Oe5nQfYvtW4p94rB//b
         JZEU06zQqqPLYqxvF96vd5+asOZljjPlJi/pitET8AAArMvSqyo87s+zaql+n/z3kTlZ
         5AfTh18gsrhU8S5jyP5V2GFnM6v5Ju76aVdcMWmwneQxEd+Zni4xeF0T2ErAH7BeAO6D
         jr/SgNk/5WuQJIezZ6YVQfIKKgXPY6kV+4WJJbB9ZHutHdgkto8gW0glIEofwz6Lb/qH
         8hxg==
X-Gm-Message-State: APzg51D/HOpXkliuQa16LMUsZO9xTzdj9YdK5O47boOR1kUGWLaKnU0v
        y0cNkPuh90zkDvcNy9Zfc6yPqg==
X-Google-Smtp-Source: ANB0VdagPiOA4//D0gwlXwRy3+DowtWL5BavBxD1jrZqa0FQdVLFmJExyV7fIut26GKYChrRUtKe8g==
X-Received: by 2002:a19:7391:: with SMTP id h17-v6mr9826598lfk.140.1537348140792;
        Wed, 19 Sep 2018 02:09:00 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z5-v6sm946497lfg.75.2018.09.19.02.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 02:09:00 -0700 (PDT)
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
References: <20180914125006.349747096@linutronix.de>
 <20180914125118.909646643@linutronix.de>
 <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
 <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
 <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
 <863331ED-B04A-4B94-91A2-D34002C9CCDC@amacapital.net>
 <alpine.DEB.2.21.1809190037570.1468@nanos.tec.linutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <06e91c26-756f-f236-0af2-327e520c3065@rasmusvillemoes.dk>
Date:   Wed, 19 Sep 2018 11:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809190037570.1468@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-19 00:46, Thomas Gleixner wrote:
> On Tue, 18 Sep 2018, Andy Lutomirski wrote:
>>>
>>
>> Do we do better if we use signed arithmetic for the whole calculation?
>> Then a small backwards movement would result in a small backwards result.
>> Or we could offset everything so that we’d have to go back several
>> hundred ms before we cross zero.
> 
> That would be probably the better solution as signed math would be
> problematic when the resulting ns value becomes negative. As the delta is
> really small, otherwise the TSC sync check would have caught it, the caller
> should never be able to observe time going backwards.
> 
> I'll have a look into that. It needs some thought vs. the fractional part
> of the base time, but it should be not rocket science to get that
> correct. Famous last words...

Does the sentinel need to be U64_MAX? What if vgetcyc and its minions
returned gtod->cycle_last-1 (for some value of 1), and the caller just
does "if ((s64)cycles - (s64)last < 0) return fallback; ns +=
(cycles-last)* ...". That should just be a "sub ; js ; ". It's an extra
load of ->cycle_last, but only on the path where we're heading for the
fallback anyway. The value of 1 can be adjusted so that in the "js"
path, we could detect and accept an rdtsc_ordered() call that's just a
few 10s of cycles behind last and treat that as 0 and continue back on
the normal path. But maybe it's hard to get gcc to generate the expected
code.

Rasmus
