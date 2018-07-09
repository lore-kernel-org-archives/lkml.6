Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075E9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12AE2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cRqKSskG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hEIziAdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12AE2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933872AbeGISTU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:19:20 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44928 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933149AbeGISTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:19:18 -0400
Received: by mail-yb0-f195.google.com with SMTP id a2-v6so7553011ybe.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3kh/OCAzCZnBl5E0COSUqI9ALxfAM56GOkV6kA4X4/o=;
        b=cRqKSskGwwILBDwvJ0kzBAfqBWPFvXvtM/gzeVfXdtpMISZql2nfHI5wIUYRS0VqCc
         tiYlxFwhrwXVqPBIzqY1VhqLH3lTVGadWllTrcQWlIvpYbgEkgNL4hfk+AC308sGD3S2
         FYedI4eu/yJSAkUQ+Dt99pcuNXzhcy7E9O6M4IG2cxYr4Zvl5hloeiTfpJW2aKo5hZQd
         iOU5R8/2ECAoaoN0fgknr2jTt7bS7N0qdZc04HJ25qatNf7Diw8oMn8t6W+tnH6ZncR8
         J58xEgG75XD8qvK7o5GvqGuUsLk+biW+ZFJj7lWOoAs5lV+qMIZ0QrJE0Timl551Wg+J
         Gbiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3kh/OCAzCZnBl5E0COSUqI9ALxfAM56GOkV6kA4X4/o=;
        b=hEIziAdz5yNqiTBagSLmrEwu0y7ukqCDuLuyjgYoUy8K1BKx/2gyxvzBOTzxWCA2uF
         aFf/00D2TvdhJFJePgDMvKZKTyj4QOQsUNwjhQ+HAzusd0wOZ8zyPddgWtq8F6qSzvWF
         7xKfYwKnaPWhOEdArhkiAQRXwriUO2m88WEh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=3kh/OCAzCZnBl5E0COSUqI9ALxfAM56GOkV6kA4X4/o=;
        b=pE4S2ontmhWJCzGCLTQ1fIlzmDR9wqixBcHT8qtiEhU0wGvheM09CHURPqdOlxhpGG
         u6JhwIwKho5uZROUO8JR/zJx+P/qKMpuMfXwugdsSjzxqHav2Wp92MrNbvvvvqzO1YJL
         l9GEtNiPKGNGbdP9GNGRMdonj9YJ3n3K/A9Fte6MN3EPqK2pJAQQ0nSU96Rmzu7mU1RF
         0rfIiICGQBzmMaoSfW7vh10yDkZHqw2BqpZaD1wrkQQ34tAq+krMwS2BVtRVxrIk1reZ
         H65K1Yi7ite9nrq1t9DEfWuGPXEofdsCzK7J/fc6LSkjo5S11ujrBtqojoe92tigKlHo
         vjcQ==
X-Gm-Message-State: APt69E1La6m8C2yIMPF9YyZSoADrSojvB7jQjCJkkfXDUZNfRkQdo6rb
        YqauET2uJwpwfv35NRwNnihYAfEEpFAGa5kzL/Zg6w==
X-Google-Smtp-Source: AAOMgpcpfnZdqwcJIyZmQfejt0io14MyjsmZdhOKwXubiUL1agQIA4CKnj0nXXPtUfyeG3C/nYkZP7MRD5SDSxNIUhc=
X-Received: by 2002:a25:3445:: with SMTP id b66-v6mr11758816yba.484.1531160357951;
 Mon, 09 Jul 2018 11:19:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 11:19:17 -0700 (PDT)
In-Reply-To: <3207f3de-0a10-f575-f24f-210a2a926c4c@de.ibm.com>
References: <20180709175550.GA7469@roeck-us.net> <CAGXu5j+rn+69QiLR=Rbd6ys7atL8Z8THyazW_T3Z=CAw0n8xzg@mail.gmail.com>
 <3207f3de-0a10-f575-f24f-210a2a926c4c@de.ibm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 9 Jul 2018 11:19:17 -0700
X-Google-Sender-Auth: weT4TXiK_uOSxb1MaO923bwztU4
Message-ID: <CAGXu5jKyESyPD1MyM7BrVFPKDY9+HqRCpXcKG5ikCZwdGZLaSw@mail.gmail.com>
Subject: Re: Build/qemu test results for v4.18-rc4
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 11:16 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
> On 07/09/2018 08:06 PM, Kees Cook wrote:
>> On Mon, Jul 9, 2018 at 10:55 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>>> s390:allmodconfig:
>>>
>>> arch/s390/kernel/als.o: In function `verify_facilities':
>>> als.c:(.init.text+0x24): undefined reference to `latent_entropy'
>>> als.c:(.init.text+0xae): undefined reference to `latent_entropy'
>>> make[3]: *** [arch/s390/boot/compressed/vmlinux] Error 1
>>> make[2]: *** [arch/s390/boot/compressed/vmlinux] Error 2
>>> make[1]: *** [bzImage] Error 2
>>>
>>> This problem is only seen when using a compiler which has the relevant
>>> plugins enabled. Bisect points to commit 1658dcee3d43ed ("gcc-plugins:
>>> allow to enable GCC_PLUGINS for COMPILE_TEST") as the culprit. I don't
>>> know if a fix for v4.18 has been submitted. The s390 boot code in -next
>>> has been rearranged and the problem is no longer seen there.
>>
>> Hm, that would imply that mm/page_alloc.o wasn't visible during the
>> als.o linking? But ... if the problem is gone, I guess... good?
>
> als.o is used to detect if the kernel was compiled for a newer generation
> than the hardware that we are running on (very early). So it is compiled
> without gcov, kcov,ubsan and with a different march -in other words special.
> In linux-next we moved the als part to the decompressor which avoids all
> these kind of special handling. As this is part of a bigger patch set it
> would be  non-trivial to backport that for 4.18.
> So unless we want to have it fixed for 4.18 I think we are fine.

Okay, cool. If you want to fix it for 4.18, it should just be
something like this in the Makefile:

CFLAGS_als.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)

-Kees

-- 
Kees Cook
Pixel Security
