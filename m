Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE2AC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0361206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9S+j84r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0361206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeJDXCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbeJDXCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:02:23 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AA121470
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 16:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538669307;
        bh=jNrCRitcO3wT7VnwH79c3INnhO3XKOC5TGVuaohfz8A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h9S+j84rYz/1pX3G+Mb/lHscdi5VTZg+8Q35lfJ52lhzq77QHKMIU9N6wheVg4yJT
         OgpsHW4etYppfEfBKmFG/HObK8Fg8HzUiYCXBR6mN4Zf01uXhl5smpE1YhVuJbWqSe
         39rfFFhzBUQUQZex+KhEKn5LL5u7Pf4suMUzmkVs=
Received: by mail-wm1-f43.google.com with SMTP id q8-v6so9586607wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:08:27 -0700 (PDT)
X-Gm-Message-State: ABuFfogVt9j1pUSHf7kcqC/RD8SbxAiPjgGBNJMJ/WPDx8TvpVSYOXNk
        +iW8X3sp9oB/fK8wBihT5Wz4q/GMdTz8xx2YfdP/PQ==
X-Google-Smtp-Source: ACcGV63LQvxIjiM/IoS0D3IQrPO2bDkodspDho1w1QbAyA9CPpJX3cQHOZw8oZ1pUr4m4HEADhhXrmD4hx5wxfimkPM=
X-Received: by 2002:a1c:f312:: with SMTP id q18-v6mr5190582wmq.14.1538669305459;
 Thu, 04 Oct 2018 09:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180921150553.21016-1-yu-cheng.yu@intel.com> <20180921150553.21016-7-yu-cheng.yu@intel.com>
 <20181004132811.GJ32759@asgard.redhat.com> <3350f7b42b32f3f7a1963a9c9c526210c24f7b05.camel@intel.com>
In-Reply-To: <3350f7b42b32f3f7a1963a9c9c526210c24f7b05.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Oct 2018 09:08:12 -0700
X-Gmail-Original-Message-ID: <CALCETrWTu-zuSKn6e3=QkP4_ca8PJfuevMD8KJq0VX3nq7Hw8Q@mail.gmail.com>
Message-ID: <CALCETrWTu-zuSKn6e3=QkP4_ca8PJfuevMD8KJq0VX3nq7Hw8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 6/9] x86/cet/ibt: Add arch_prctl functions for IBT
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Eugene Syromiatnikov <esyr@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Oct 4, 2018, at 8:37 AM, Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
>> On Thu, 2018-10-04 at 15:28 +0200, Eugene Syromiatnikov wrote:
>>> On Fri, Sep 21, 2018 at 08:05:50AM -0700, Yu-cheng Yu wrote:
>>> Update ARCH_CET_STATUS and ARCH_CET_DISABLE to include Indirect
>>> Branch Tracking features.
>>>
>>> Introduce:
>>>
>>> arch_prctl(ARCH_CET_LEGACY_BITMAP, unsigned long *addr)
>>>    Enable the Indirect Branch Tracking legacy code bitmap.
>>>
>>>    The parameter 'addr' is a pointer to a user buffer.
>>>    On returning to the caller, the kernel fills the following:
>>>
>>>    *addr = IBT bitmap base address
>>>    *(addr + 1) = IBT bitmap size
>>
>> Again, some structure with a size field would be better from
>> UAPI/extensibility standpoint.
>>
>> One additional point: "size" in the structure from kernel should have
>> structure size expected by kernel, and at least providing there "0" from
>> user space shouldn't lead to failure (in fact, it is possible to provide
>> structure size back to userspace even if buffer is too small, along
>> with error).
>
> This has been in GLIBC v2.28.  We cannot change it anymore.

Sure you can. Just change ARCH_CET_LEGACY_BITMAP to a new number.  You
might need to change all the constants.  And if the ELF note by itself
causes a problem too, you may need to rename it.  And maybe ask glibc
to kindly not enable code that depends on non-upstreamed kernel
features.

There is not, and has never been, any ABI compatibility requirement
that says that, if glibc 2.28 "enables" a feature, that the kernel
will ever enable it in a way that makes glibc 2.28 actually support
it.  All the kernel needs to do is avoid making glibc 2.28 *crash*.
