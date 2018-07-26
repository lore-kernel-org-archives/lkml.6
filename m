Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C72C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C042083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk8lKpIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C042083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbeGZLSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:18:50 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44686 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbeGZLSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:18:49 -0400
Received: by mail-qt0-f196.google.com with SMTP id b15-v6so931249qtp.11;
        Thu, 26 Jul 2018 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=+l4N+8XMsUpTjyeaa7Rb4jNrTinAoo7ABLvgThOwkmk=;
        b=Qk8lKpIOWMJV0YELyQslG1COUv8gWv5PKHyfXGHUHTrsY0atwrbYelpInlsJtryAiq
         47Z1AuDRaEQmBMEi1a/ONcr9VyscrgBSx0M4V3YgCaYCPKJkEHpRtV/jl/UKAEfjSSyY
         /wEZAlSXu2rXBYZ+/dxstIbIYUbBCvMbge0HFo2LjytkhrwNTViZvZoXwZyLigza8dhe
         RjW89dY80M0AXvmeeoW64Xri8l0OCGjDH3JvXjkLzuP7rhDzDYMXMhCz9mw4Y3vU0je6
         BJBe9ML0Ncq7psp/gLKGqEXoHSZbJKZeT07c5OcCZ2YYDG7UNeNDLJS74ZxX12xv8joM
         CjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=+l4N+8XMsUpTjyeaa7Rb4jNrTinAoo7ABLvgThOwkmk=;
        b=TCar1oggk5MnfRPEXqimQY9zdwpFp0eZ9Fw2zqtygemU0BTRXgjihPCDMKTxPoZJG6
         PXNsOF6OWMsxubq2VL0VwbxzOfReV0KRapviho6+TEhIQlku3cLI5SoFTdXwJcx0Ojoy
         Jv0lvjtnY98laOk7Wi2jaSiuaQvvK1zDIINdmdDqKWKwDpM/f6xKTjXJNq+OFmhnQbRI
         oZ4mSAm5rsqqqRyH3bFGsnpA0JSJ2p8/n1oWYam5CheevsQyTOAzt228VG9vOxWCHFfl
         LUaIOgs+NokyV/7qdr8qeKfAHzFjSxnpD074jJ+00ob5C5KvcweIeOb9d/tggP3+9VWO
         wpTw==
X-Gm-Message-State: AOUpUlFOYD+xC7mHGwypYZHW5Wn2nJvXgRkEyPU1ONFLPe7r3lvC7L4y
        vJdlpWQo5r0TWNVjQ6Kh1W9Bu2JZLTJuSFjRN9k=
X-Google-Smtp-Source: AAOMgpf7MyUD1bRwdOn30fVEDz/B6KGbU4+NLM3FT5464j3blqwwUv0/Fn2L3anKQjNIS/t4RC7yMIqgsu7rxf6JQtE=
X-Received: by 2002:ac8:3676:: with SMTP id n51-v6mr1065865qtb.163.1532599362544;
 Thu, 26 Jul 2018 03:02:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 03:02:42
 -0700 (PDT)
In-Reply-To: <20180726092231.GA6916@kroah.com>
References: <20180726081358.3829157-1-arnd@arndb.de> <20180726092231.GA6916@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 26 Jul 2018 12:02:42 +0200
X-Google-Sender-Auth: 1DeTFFt6FUZ3G7eahmY0YURo5OA
Message-ID: <CAK8P3a3g7VSu3W0DiMcUdLB0b1fmUaHJxEyC30K8EfP5a9T1ig@mail.gmail.com>
Subject: Re: [PATCH] [stable 4.14] turn off -Wattribute-alias
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "# 3.4.x" <stable@vger.kernel.org>, Michal Marek <mmarek@suse.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 11:22 AM, Greg KH <gregkh@linuxfoundation.org> wrot=
e:
> On Thu, Jul 26, 2018 at 10:13:22AM +0200, Arnd Bergmann wrote:
>> Starting with gcc-8.1, we get a warning about all system call definition=
s,
>> which use an alias between functions with incompatible prototypes, e.g.:
>>
>> In file included from ../mm/process_vm_access.c:19:
>> ../include/linux/syscalls.h:211:18: warning: 'sys_process_vm_readv' alia=
s between functions of incompatible types 'long int(pid_t,  const struct io=
vec *, long unsigned int,  const struct iovec *, long unsigned int,  long u=
nsigned int)' {aka 'long int(int,  const struct iovec *, long unsigned int,=
  const struct iovec *, long unsigned int,  long unsigned int)'} and 'long =
int(long int,  long int,  long int,  long int,  long int,  long int)' [-Wat=
tribute-alias]
>>   asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
>>                   ^~~
>> ../include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCAL=
L_DEFINEx'
>>   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>   ^~~~~~~~~~~~~~~~~
>> ../include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL=
_DEFINEx'
>>  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARG=
S__)
>>                                     ^~~~~~~~~~~~~~~
>> ../mm/process_vm_access.c:300:1: note: in expansion of macro 'SYSCALL_DE=
FINE6'
>>  SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user=
 *, lvec,
>>  ^~~~~~~~~~~~~~~
>> ../include/linux/syscalls.h:215:18: note: aliased declaration here
>>   asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
>>                   ^~~
>> ../include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCAL=
L_DEFINEx'
>>   __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>   ^~~~~~~~~~~~~~~~~
>> ../include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL=
_DEFINEx'
>>  #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARG=
S__)
>>                                     ^~~~~~~~~~~~~~~
>> ../mm/process_vm_access.c:300:1: note: in expansion of macro 'SYSCALL_DE=
FINE6'
>>  SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user=
 *, lvec,
>>
>> This is really noisy and does not indicate a real problem. In the latest
>> mainline kernel, this was addressed by commit bee20031772a ("disable
>> -Wattribute-alias warning for SYSCALL_DEFINEx()"), which seems too invas=
ive
>> to backport.
>
> Too invasive?
>
> Here's the diffstat:
>          include/linux/compat.h   |    8 +++++++-
>          include/linux/syscalls.h |    4 ++++
>          2 files changed, 11 insertions(+), 1 deletion(-)
>
> That seems almost trivial to backport.  Did you try it and it caused
> other problems?
>
> Where ever possible, I always want to use the upstream commits.

I forward ported that patch a few times across kernels when that macro
changed in subtle ways. This was particularly tricky as some using the
new macro inside of another macro sometimes has different effects
based on seemingly unrelated changes: in particular the addition of
__MAP() in COMPAT_SYSCALL_DEFINEx that I had to do to work
around gcc pr83256 can easily break.

It also depends on commit 8793bb7f4a9d ("kbuild: add macro for
controlling warnings to linux/compiler.h") before it, which is not long
but does add new infrastructure.

      Arnd
