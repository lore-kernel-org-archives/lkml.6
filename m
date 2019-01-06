Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380ADC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 20:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7BC2085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 20:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D980QCW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfAFUYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 15:24:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45431 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfAFUYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 15:24:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so19762571pgc.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 12:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n/2niy8s/oGXU83i7oIRI+wBplxcaYb6TUH0QWCiqJg=;
        b=D980QCW+Z8RLfTqz123iEk2kGy0gDB5dMxc6g+eUmTVKEIbOTLgEKOh0L0Py1x30D1
         I36CySmsUb4Qo3bZ4POge5vnjom9dfQiqi9Z3KBEgwxWrvtfW9cGSz7O4K6+WMtCtBC3
         gOZjjftXPLbTqZcrEhyXT614M9Ey21BPcuBfgckyQuLyH2t0KIkO/G4IIVEhUwT6NotG
         j2r3DJOf8zComdVc/nVyiHbLJY5HMKPtAOzRyr6i1hCJjULsr8KDGkxm4wsXq/3vysgp
         D7f2sNVW9LDwRyElvboZa7BHZqZmZz5C4RCemYOeTcUJA4aXJJdFE9YWF8qZICGyHCL7
         Zbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n/2niy8s/oGXU83i7oIRI+wBplxcaYb6TUH0QWCiqJg=;
        b=ZoLlwsvXQJNeQvnbdocF0JbGl2hOpjkyczPdwLNBrXVGbK7Tzav5pDmPMmnLfXIYKW
         CvOCZ/jV+kGNz6NklwCkN9cOw3CKcOMNgEGhSdbAt3NU2H8bovgS0M1RjscJo/gOemX0
         rataxZmfLnZOuN3HNSbsw0VWo4ayO6BhmbXXYUdidiHJgNmc6+WWAUUf5FZ5EsHWvCDV
         27iRfODCyxH4uMoLoYiQqzGBV+ecSK0f9sxDYnaZ9ttdhv9st1kMcbtFkwPGqXWaZk4b
         SDjOnneumLRllO0kRHUc8dJweG/nJ6Y1lO9JwJ0LEPcpkBKb7t4YcUdI8sj8utIOzHdR
         WAlA==
X-Gm-Message-State: AJcUukdXI7rYZh8VLZ2fR2BxqEh9YjhUF80dd4r2MSbQz2aoVbkJ6XkL
        82zAPHvWQ+Tk5ZvSaEwide/pdNFa
X-Google-Smtp-Source: ALg8bN5QFL5vzg01tnV0Du5WpGs1Qqbgl8JYXMj+VWFtTkqE6ffN8QazksxuEPtkw2Rv0nN1Ks+9fA==
X-Received: by 2002:a63:1157:: with SMTP id 23mr8763556pgr.245.1546806254233;
        Sun, 06 Jan 2019 12:24:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t12sm100700181pfi.45.2019.01.06.12.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 12:24:13 -0800 (PST)
Subject: Re: [PATCH] make 'user_access_begin()' do 'access_ok()'
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Turner <mattst88@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190106180927.GA11993@roeck-us.net>
 <CAHk-=whyNbpBtPyoS=wh4nVgBtUBpihcOT+LFdEw369kYjATaQ@mail.gmail.com>
 <CAHk-=wiHe4dNHKpE4oGhwwmy23jNTuuFQAgWTGCjjxyOVYjG_w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6a4fe075-a644-1b06-305b-9e55b8c9575b@roeck-us.net>
Date:   Sun, 6 Jan 2019 12:24:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiHe4dNHKpE4oGhwwmy23jNTuuFQAgWTGCjjxyOVYjG_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/19 11:18 AM, Linus Torvalds wrote:
> [ Re-sending the message because my first reply bounced - Guenther had
> mis-typed the lkml address ]
> 

Sigh. That _always_ happens to me when typing fast. Sorry.

> On Sun, Jan 6, 2019 at 10:09 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> All alpha and sh4 (big and little endian) images fail to boot in qemu
>> with this patch applied. Reverting it fixes the problem.
> 
> Funky. 99% of that patch is a complete no-op on non-x86.
> 
> The one exception is the strncpy_from_user() and strnlen_user() cases,
> which didn't use to do access_ok() at all, and now essentially do.
> 
> But I think I see what may be the problem. I think the alpha version
> of "access_ok()" is buggy.
> 
> Lookie here:
> 
>    #define __access_ok(addr, size) \
>          ((get_fs().seg & (addr | size | (addr+size))) == 0)
> 
> and what it basically tests is of any of the high bits get set (the
> USER_DS value is 0xfffffc0000000000).
> 
> And that's completely wrong for the "addr+size" check. It's off-by-one
> for the case where we check to the very end of the user address space,
> which is exactly what the strn*_user() functions do.
> 
> Why? Because "addr+size" will be exactly the size of the address
> space, so trying to access the last byte of the user address space
> will *fail* the __access_ok() check, even though it shouldn't.
> 
> So it's not really that that commit is buggy in itself, but it
> triggers that off-by-one error in access_ok().
> 
> Side note: that alpha macro is buggy for another reason too: it
> re-uses the arguments twice.
> 
> And SH has almost the exact same bug:
> 
>    #define __addr_ok(addr) \
>          ((unsigned long __force)(addr) < current_thread_info()->addr_limit.seg)
> 
> so far so good: yes, a user address must be below the limit. But then:
> 
>    #define __access_ok(addr, size)         \
>          (__addr_ok((addr) + (size)))
> 
> is wrong with the exact same off-by-one case: the case when
> "addr+size" is exactly _equal_ to the limit is actually perfectly
> fine.
> 
> The SH version is actually seriously buggy in another way: it doesn't
> actually check for overflow, even though it did copy the _comment_
> that talks about overflow.
> 
> So it turns out that both SH and alpha actually have completely
> buggered implementations of access_ok(), but they happened to work
> (although the SH overflow one is a serious serious security bug, not
> that anybody likely cares about SH security)
> 
> Ho humm.
> 
> Maybe something like the attached patch? Entirely untested, I don't
> have a cross-build environment, much less a boot setup.
> 
> It isn't trying to be clever, the end address is based on this logic:
> 
>          unsigned long __ao_end = __ao_a + __ao_b - !!__ao_b;    \
> 
> which basically says "subtract one unless the length was zero".
> 
> For a lot of access_ok() users the length is a constant, so this isn't
> actually as expensive as it initially looks.
> 
> Does that fix things for you?
> 

Yes, it does, for both alpha and sh (little and big endian).

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
