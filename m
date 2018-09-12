Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECCCC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876922133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876922133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeIMDyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 23:54:41 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35747 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeIMDyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 23:54:40 -0400
Received: by mail-qt0-f173.google.com with SMTP id j7-v6so3642100qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DhZWKCwcDIRnGqisvI8oCZU7ZEe8XSr9ewbBkRfDdUs=;
        b=kBodQSJhccTZciU0oNRPtYmoIaHZuFVD3GUn0GHtuHP52UinhdGAz9YQiWok9xmjmb
         hrpY6+0Ye+3KN0NxPYNqKjcKT3OJ4cqS1SuxH0Fa1wwGtIHI4Mv/WNiDmtVBgWObHHVl
         eaFwS35N2Y3c0Yi4e3z4dOjFz6o+PWkGV1RFWEzKI1ZabYE36/im65uTeDBD9aAYyg9d
         8tMDQifqnMBUv1u3ZiFqdtXqY4uqyHPMWMCR50C9J3bwHj5/5eUWlbkH9HzmC7kdr5uB
         /zwerpVTE5TzlJn2FOGTzf8elKioVHHLDicu6iq4vOnpgLxna3V3P5xjwJQwWaI5YRkk
         adDA==
X-Gm-Message-State: APzg51DRpYuuVQK6+OPxsgXYXQs+FfrYP80U1a2/IwcRjF8I9muE1/vC
        51b1HA3lAwer+wxHrluc359H1w==
X-Google-Smtp-Source: ANB0VdYMj8xs1ykC1OppO5mZ+slvZ8K547Dp3isFqG+JhibMaeIW12f1nl7HtW8Aop91D+4ySUJPWg==
X-Received: by 2002:a0c:d2ba:: with SMTP id q55-v6mr3169524qvh.150.1536792481916;
        Wed, 12 Sep 2018 15:48:01 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::42c3? ([2601:602:9802:a8dc::42c3])
        by smtp.gmail.com with ESMTPSA id u86-v6sm1483241qkl.93.2018.09.12.15.47.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 15:48:00 -0700 (PDT)
Subject: Re: [PATCH] proc: restrict kernel stack dumps to root
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Ken Chen <kenchen@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Security Officers <security@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>
References: <20180911183909.233413-1-jannh@google.com>
 <CAG48ez03ivLr6w+V911V7pqb1o=kcJw4CLEktcSVVE+=hXXP=w@mail.gmail.com>
 <CAGXu5jKBPh+TSCuaitpPdk89hW=ch+QeRsUfE68pLpzLS=z4Jg@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <4ceb318d-9af6-7a78-db6a-cfe9dd8a0823@redhat.com>
Date:   Wed, 12 Sep 2018 15:47:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKBPh+TSCuaitpPdk89hW=ch+QeRsUfE68pLpzLS=z4Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 03:27 PM, Kees Cook wrote:
> On Wed, Sep 12, 2018 at 8:29 AM, Jann Horn <jannh@google.com> wrote:
>> +linux-api, I guess
>>
>> On Tue, Sep 11, 2018 at 8:39 PM Jann Horn <jannh@google.com> wrote:
>>>
>>> Restrict the ability to inspect kernel stacks of arbitrary tasks to root
>>> in order to prevent a local attacker from exploiting racy stack unwinding
>>> to leak kernel task stack contents.
>>> See the added comment for a longer rationale.
>>>
>>> There don't seem to be any users of this userspace API that can't
>>> gracefully bail out if reading from the file fails. Therefore, I believe
>>> that this change is unlikely to break things.
>>> In the case that this patch does end up needing a revert, the next-best
>>> solution might be to fake a single-entry stack based on wchan.
>>>
>>> Fixes: 2ec220e27f50 ("proc: add /proc/*/stack")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Jann Horn <jannh@google.com>
>>> ---
>>>   fs/proc/base.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>>> index ccf86f16d9f0..7e9f07bf260d 100644
>>> --- a/fs/proc/base.c
>>> +++ b/fs/proc/base.c
>>> @@ -407,6 +407,20 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
>>>          unsigned long *entries;
>>>          int err;
>>>
>>> +       /*
>>> +        * The ability to racily run the kernel stack unwinder on a running task
>>> +        * and then observe the unwinder output is scary; while it is useful for
>>> +        * debugging kernel issues, it can also allow an attacker to leak kernel
>>> +        * stack contents.
>>> +        * Doing this in a manner that is at least safe from races would require
>>> +        * some work to ensure that the remote task can not be scheduled; and
>>> +        * even then, this would still expose the unwinder as local attack
>>> +        * surface.
>>> +        * Therefore, this interface is restricted to root.
>>> +        */
>>> +       if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
>>> +               return -EACCES;
> 
> In the past, we've avoided hard errors like this in favor of just
> censoring the output. Do we want to be more cautious here? (i.e.
> return 0 or a fuller seq_printf(m, "[<0>] privileged\n"); return 0;)
> 

The -EACCES is a strong hint to run with root privileges which is
nice from an end user perspective. If we don't want to return an
actual error, I think the "privileged" message would be okay.

Laura

>>> +
>>>          entries = kmalloc_array(MAX_STACK_TRACE_DEPTH, sizeof(*entries),
>>>                                  GFP_KERNEL);
>>>          if (!entries)
>>> --
>>> 2.19.0.rc2.392.g5ba43deb5a-goog
>>>
> 
> -Kees
> 

