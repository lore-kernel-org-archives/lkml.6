Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFB3C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAC02146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2edDonS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAC02146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeIMDec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 23:34:32 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34311 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeIMDec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 23:34:32 -0400
Received: by mail-yb1-f195.google.com with SMTP id t10-v6so2484313ybb.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DnrbMQY/zGzFjF9mWy2fkS0v7edeFczmBfQNudugy4o=;
        b=G2edDonSJVV1HcL2wFDf+KoKT3V8CVeiH4ycoaxMtjadDaFrJlrVBilc4U4m8L8SS7
         Fxt4p4qS5+c6q+8DfmrEtGaVMwbGWPjalQOVSgyYt6cZUp8ZVw+Du30lirEtHZL/JmxT
         Obp4NZFkwqg+DK/agPSd4H8mvie0ejLKVM8BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DnrbMQY/zGzFjF9mWy2fkS0v7edeFczmBfQNudugy4o=;
        b=CROMwLmWTpuYIKujT085zazDBfqokJVWpV1lQeEKpaDaXUCmbyyKjzUtqWiRxW4ktP
         Gv+MsE/oOQqQ0By2FNR0yqp8CJ66XrDzMsHb4Io9SApzXBtnh8yydGWbvR+3REijjPyB
         J+bCTwb9fCphDUdHtI34QfjW9hO0v5L1I/cxHkQAo0S5qw2NqwAOm05XqRHjIhpNdvx0
         tlOHHYRGMrKOE8HFb7Hww2WHhgw2KYKAGF2gIaAW1eoxaSRMrtnNVNshaNkN0yGz4cJN
         UUCs2I9S1dL92yvoEQAUOxF+194wmTur2lNQEVkWIVWU+eByFMcFfnaMs0PloW9NzwwH
         0p+w==
X-Gm-Message-State: APzg51BUJO6SnWnEf4gubZh4q4te9Fucbmcc7pksR9IPHpygW17btHAQ
        fLFq14t5lO/J4YbR59chO5aJwyhwBY0=
X-Google-Smtp-Source: ANB0VdachNyIJiOJfzy6pPoAFj26UL3DWoKFTZc/PJlznjc3WmtPgdhRttJmYTrFJL5jCNjFtQrHDQ==
X-Received: by 2002:a25:5182:: with SMTP id f124-v6mr2145264ybb.480.1536791276547;
        Wed, 12 Sep 2018 15:27:56 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 203-v6sm872891ywv.34.2018.09.12.15.27.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 15:27:55 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id t71-v6so2460586ybi.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:27:54 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr2111427ybz.410.1536791274293;
 Wed, 12 Sep 2018 15:27:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 15:27:53
 -0700 (PDT)
In-Reply-To: <CAG48ez03ivLr6w+V911V7pqb1o=kcJw4CLEktcSVVE+=hXXP=w@mail.gmail.com>
References: <20180911183909.233413-1-jannh@google.com> <CAG48ez03ivLr6w+V911V7pqb1o=kcJw4CLEktcSVVE+=hXXP=w@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Sep 2018 15:27:53 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKBPh+TSCuaitpPdk89hW=ch+QeRsUfE68pLpzLS=z4Jg@mail.gmail.com>
Message-ID: <CAGXu5jKBPh+TSCuaitpPdk89hW=ch+QeRsUfE68pLpzLS=z4Jg@mail.gmail.com>
Subject: Re: [PATCH] proc: restrict kernel stack dumps to root
To:     Jann Horn <jannh@google.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Ken Chen <kenchen@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Security Officers <security@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 8:29 AM, Jann Horn <jannh@google.com> wrote:
> +linux-api, I guess
>
> On Tue, Sep 11, 2018 at 8:39 PM Jann Horn <jannh@google.com> wrote:
>>
>> Restrict the ability to inspect kernel stacks of arbitrary tasks to root
>> in order to prevent a local attacker from exploiting racy stack unwinding
>> to leak kernel task stack contents.
>> See the added comment for a longer rationale.
>>
>> There don't seem to be any users of this userspace API that can't
>> gracefully bail out if reading from the file fails. Therefore, I believe
>> that this change is unlikely to break things.
>> In the case that this patch does end up needing a revert, the next-best
>> solution might be to fake a single-entry stack based on wchan.
>>
>> Fixes: 2ec220e27f50 ("proc: add /proc/*/stack")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jann Horn <jannh@google.com>
>> ---
>>  fs/proc/base.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index ccf86f16d9f0..7e9f07bf260d 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -407,6 +407,20 @@ static int proc_pid_stack(struct seq_file *m, struct pid_namespace *ns,
>>         unsigned long *entries;
>>         int err;
>>
>> +       /*
>> +        * The ability to racily run the kernel stack unwinder on a running task
>> +        * and then observe the unwinder output is scary; while it is useful for
>> +        * debugging kernel issues, it can also allow an attacker to leak kernel
>> +        * stack contents.
>> +        * Doing this in a manner that is at least safe from races would require
>> +        * some work to ensure that the remote task can not be scheduled; and
>> +        * even then, this would still expose the unwinder as local attack
>> +        * surface.
>> +        * Therefore, this interface is restricted to root.
>> +        */
>> +       if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
>> +               return -EACCES;

In the past, we've avoided hard errors like this in favor of just
censoring the output. Do we want to be more cautious here? (i.e.
return 0 or a fuller seq_printf(m, "[<0>] privileged\n"); return 0;)

>> +
>>         entries = kmalloc_array(MAX_STACK_TRACE_DEPTH, sizeof(*entries),
>>                                 GFP_KERNEL);
>>         if (!entries)
>> --
>> 2.19.0.rc2.392.g5ba43deb5a-goog
>>

-Kees

-- 
Kees Cook
Pixel Security
