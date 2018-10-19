Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8204ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51AA2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51AA2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJSMWP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 08:22:15 -0400
Received: from ozlabs.org ([203.11.71.1]:47427 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbeJSMWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 08:22:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42bt1c4Qqxz9s8J;
        Fri, 19 Oct 2018 15:17:56 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jann Horn <jannh@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH] seq_buf: Make seq_buf_puts() NULL terminate the buffer
In-Reply-To: <CAG48ez2W8HeJcuPwA25vSqTco3B=CRzycSA0=--pG=7jWi3pPw@mail.gmail.com>
References: <20181017121000.30240-1-mpe@ellerman.id.au> <CAG48ez2W8HeJcuPwA25vSqTco3B=CRzycSA0=--pG=7jWi3pPw@mail.gmail.com>
Date:   Fri, 19 Oct 2018 15:17:48 +1100
Message-ID: <87sh12vac3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> writes:
> On Wed, Oct 17, 2018 at 2:10 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Currently seq_buf_puts() will happily create a non NULL terminated
>> string for you in the buffer. This is particularly dangerous if the
>> buffer is on the stack.
>>
>> For example:
>>
>>   char buf[8];
>>   char secret = "secret";
>>   struct seq_buf s;
>>
>>   seq_buf_init(&s, buf, sizeof(buf));
>>   seq_buf_puts(&s, "foo");
>>   printk("Message is %s\n", buf);
>>
>> Can result in:
>>
>>   Message is fooªªªªªsecret
>>
>> We could require all users to memset() their buffer to NULL before
>> use. But that seems likely to be forgotten and lead to bugs.
>>
>> Instead we can change seq_buf_puts() to always leave the buffer in a
>> NULL terminated state.
>>
>> The only downside is that this makes the buffer 1 character smaller
>> for seq_buf_puts(), but that seems like a good trade off.
>
> After this, you can also simplify rdt_last_cmd_status_show(), right?

Yes.

We also have a seq_buf_printf() in powerpc code that is printing a fixed
string purely to get NULL termination, so that can become a
seq_buf_puts().

>> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
>> index 11f2ae0f9099..b1570204cde3 100644
>> --- a/lib/seq_buf.c
>> +++ b/lib/seq_buf.c
>> @@ -144,9 +144,13 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
>>
>>         WARN_ON(s->size == 0);
>>
>> +       /* Add 1 to len for the trailing NULL which must be there */
>
> Nit: In the comments, I would prefer either "null byte" or "NUL"
> instead of "NULL" when talking about something that is not a pointer.

Hmm yeah I guess. I think of them as being more or less the same thing,
or at least interchangeable, but that's a bit sloppy.

I'll send a v2 with "null byte".

>> +       len += 1;
>
> It looks like you're using an "unsigned int" for the length, meaning
> that this can in theory (e.g. when operating on a string from a big
> vmalloc buffer) overflow. You should be using size_t here.

Yes you're right.

And if len overflows to zero above ..

>>         if (seq_buf_can_fit(s, len)) {

This will return true.

>>                 memcpy(s->buffer + s->len, str, len);
>> -               s->len += len;
>> +               /* Don't count the trailing NULL against the capacity */
>> +               s->len += len - 1;

And then here s->len becomes UINT_MAX.

I think. Which is probably not what we want.

I'll send a patch to switch to size_t in there.

cheers
