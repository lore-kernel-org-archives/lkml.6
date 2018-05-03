Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeECOTh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:19:37 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34713 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeECOTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:19:24 -0400
X-Google-Smtp-Source: AB8JxZoz06FwJNI6MQ4c2WKjKL9TDsMKGtfZADRXocRa+cVRV9jbJh7yB4aSGVgSIXCZp7SdP4K2RPjkwioAfG5Ti64=
MIME-Version: 1.0
In-Reply-To: <69d19601-df56-687d-730e-d043b2cf7161@nextfour.com>
References: <152532351517.17218.3583455156840230837.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152532354268.17218.11923624861859552990.stgit@dwillia2-desk3.amr.corp.intel.com>
 <69d19601-df56-687d-730e-d043b2cf7161@nextfour.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 3 May 2018 07:19:23 -0700
Message-ID: <CAPcyv4gqu-3w+nPrfYPWxWQYOPrHaNzsr=0YSe562Ns-Ygz4bQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] x86, memcpy_mcsafe: add write-protection-fault handling
To: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w43EJgUu023378

On Wed, May 2, 2018 at 10:29 PM, Mika Penttilä
<mika.penttila@nextfour.com> wrote:
> On 05/03/2018 07:59 AM, Dan Williams wrote:
>> In preparation for using memcpy_mcsafe() to handle user copies it needs
>> to be to handle write-protection faults while writing user pages. Add
>> MMU-fault handlers alongside the machine-check exception handlers.
>>
>> Note that the machine check fault exception handling makes assumptions
>> about source buffer alignment and poison alignment. In the write fault
>> case, given the destination buffer is arbitrarily aligned, it needs a
>> separate / additional fault handling approach. The mcsafe_handle_tail()
>> helper is reused. The @limit argument is set to @len since there is no
>> safety concern about retriggering an MMU fault, and this simplifies the
>> assembly.
>>
>
>> diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
>> index 75d3776123cc..9787f5ee0cf9 100644
>> --- a/arch/x86/lib/usercopy_64.c
>> +++ b/arch/x86/lib/usercopy_64.c
>> @@ -75,6 +75,23 @@ copy_user_handle_tail(char *to, char *from, unsigned len)
>>       return len;
>>  }
>>
>> +/*
>> + * Similar to copy_user_handle_tail, probe for the write fault point,
>> + * but reuse __memcpy_mcsafe in case a new read error is encountered.
>> + * clac() is handled in _copy_to_iter_mcsafe().
>> + */
>> +__visible unsigned long
>> +mcsafe_handle_tail(char *to, char *from, unsigned len)
>> +{
>> +     for (; len; --len, to++) {
>> +             unsigned long rem = memcpy_mcsafe(to, from, 1);
>> +
>
>
> Hmm why not
>         for (; len; --len, from++, to++)
>
>

Why not indeed. Great catch, I'll fix this and extend the unit test to
verify the data transfer as well.
