Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C897DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBFC2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BOWuzG8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBFC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJKBkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:40:41 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7718 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJKBkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:40:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bbe422e0002>; Wed, 10 Oct 2018 11:17:18 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 10 Oct 2018 11:17:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 10 Oct 2018 11:17:20 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 10 Oct
 2018 18:17:19 +0000
Subject: Re: [PATCH] mm: don't clobber partially overlapping VMA with
 MAP_FIXED_NOREPLACE
To:     Jann Horn <jannh@google.com>, Michal Hocko <mhocko@suse.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        <abdhalee@linux.vnet.ibm.com>, <joel@jms.id.au>,
        Kees Cook <keescook@chromium.org>, <jasone@google.com>,
        <davidtgoldblatt@gmail.com>, <trasz@freebsd.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Daniel Micay <danielmicay@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>
References: <20181010152736.99475-1-jannh@google.com>
 <20181010171944.GJ5873@dhcp22.suse.cz>
 <CAG48ez04KK62doMwsTVN4nN8y_wmv7hn+4my2jk5VXKL0wP7Lg@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <419ee581-ad6b-9a1d-ccea-ae63163926d1@nvidia.com>
Date:   Wed, 10 Oct 2018 11:17:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez04KK62doMwsTVN4nN8y_wmv7hn+4my2jk5VXKL0wP7Lg@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539195438; bh=D0i1v2gjIn0S29gaxMQvrsja00mD7Lt2U8VJzuyE6I4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BOWuzG8SqkLT5PePDzkk18HG4voz+I54sOdaKkFnajej7UEdNiTk8RfUIDH+TXhKa
         H/+0EPo0MsyEollGjBu46/ZoTlI8HhLe4XypaymeviFZuodtqYHZel3EDVwCoTXQyp
         CfAbTKSI9JpPzYqBIrN/zM6aGklrfn6GUN4InEgeIjc/fNooqTRL0YuYBFhEugdLwy
         iqvQyZkLYmIWbqDn6j8ZhRAmP8oTv0mwuIqCjs/F65A1JEHZ6cBZqV/XHCeBceMcda
         BwOgjtawMs2Y/pOE83rIGv7wh+sKA3zPkUAnbll4Skrq1AX9bd9XS5xVTBfnaOm2uE
         p0H+n1srML82A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 10:26 AM, Jann Horn wrote:
> On Wed, Oct 10, 2018 at 7:19 PM Michal Hocko <mhocko@suse.com> wrote:
>> On Wed 10-10-18 17:27:36, Jann Horn wrote:
>>> Daniel Micay reports that attempting to use MAP_FIXED_NOREPLACE in an
>>> application causes that application to randomly crash. The existing check
>>> for handling MAP_FIXED_NOREPLACE looks up the first VMA that either
>>> overlaps or follows the requested region, and then bails out if that VMA
>>> overlaps *the start* of the requested region. It does not bail out if the
>>> VMA only overlaps another part of the requested region.
>>
>> I do not understand. Could you give me an example?
> 
> Sure.
> 
> =======
> user@debian:~$ cat mmap_fixed_simple.c
> #include <sys/mman.h>
> #include <errno.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> 
> #ifndef MAP_FIXED_NOREPLACE
> #define MAP_FIXED_NOREPLACE 0x100000
> #endif
> 
> int main(void) {
>   char *p;
> 
>   errno = 0;
>   p = mmap((void*)0x10001000, 0x4000, PROT_NONE,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE, -1, 0);
>   printf("p1=%p err=%m\n", p);
> 
>   errno = 0;
>   p = mmap((void*)0x10000000, 0x2000, PROT_READ,
> MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE, -1, 0);
>   printf("p2=%p err=%m\n", p);
> 
>   char cmd[100];
>   sprintf(cmd, "cat /proc/%d/maps", getpid());
>   system(cmd);
> 
>   return 0;
> }
> user@debian:~$ gcc -o mmap_fixed_simple mmap_fixed_simple.c
> user@debian:~$ ./mmap_fixed_simple
> p1=0x10001000 err=Success
> p2=0x10000000 err=Success
> 10000000-10002000 r--p 00000000 00:00 0
> 10002000-10005000 ---p 00000000 00:00 0
> 564a9a06f000-564a9a070000 r-xp 00000000 fe:01 264004
>   /home/user/mmap_fixed_simple
> 564a9a26f000-564a9a270000 r--p 00000000 fe:01 264004
>   /home/user/mmap_fixed_simple
> 564a9a270000-564a9a271000 rw-p 00001000 fe:01 264004
>   /home/user/mmap_fixed_simple
> 564a9a54a000-564a9a56b000 rw-p 00000000 00:00 0                          [heap]
> 7f8eba447000-7f8eba5dc000 r-xp 00000000 fe:01 405885
>   /lib/x86_64-linux-gnu/libc-2.24.so
> 7f8eba5dc000-7f8eba7dc000 ---p 00195000 fe:01 405885
>   /lib/x86_64-linux-gnu/libc-2.24.so
> 7f8eba7dc000-7f8eba7e0000 r--p 00195000 fe:01 405885
>   /lib/x86_64-linux-gnu/libc-2.24.so
> 7f8eba7e0000-7f8eba7e2000 rw-p 00199000 fe:01 405885
>   /lib/x86_64-linux-gnu/libc-2.24.so
> 7f8eba7e2000-7f8eba7e6000 rw-p 00000000 00:00 0
> 7f8eba7e6000-7f8eba809000 r-xp 00000000 fe:01 405876
>   /lib/x86_64-linux-gnu/ld-2.24.so
> 7f8eba9e9000-7f8eba9eb000 rw-p 00000000 00:00 0
> 7f8ebaa06000-7f8ebaa09000 rw-p 00000000 00:00 0
> 7f8ebaa09000-7f8ebaa0a000 r--p 00023000 fe:01 405876
>   /lib/x86_64-linux-gnu/ld-2.24.so
> 7f8ebaa0a000-7f8ebaa0b000 rw-p 00024000 fe:01 405876
>   /lib/x86_64-linux-gnu/ld-2.24.so
> 7f8ebaa0b000-7f8ebaa0c000 rw-p 00000000 00:00 0
> 7ffcc99fa000-7ffcc9a1b000 rw-p 00000000 00:00 0                          [stack]
> 7ffcc9b44000-7ffcc9b47000 r--p 00000000 00:00 0                          [vvar]
> 7ffcc9b47000-7ffcc9b49000 r-xp 00000000 00:00 0                          [vdso]
> ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0
>   [vsyscall]
> user@debian:~$ uname -a
> Linux debian 4.19.0-rc6+ #181 SMP Wed Oct 3 23:43:42 CEST 2018 x86_64 GNU/Linux
> user@debian:~$
> =======
> 
> As you can see, the first page of the mapping at 0x10001000 was clobbered.

This looks good to me. The short example really helped, thanks for that.

(I think my first reply got bounced, sorry if this ends up as a duplicate email
for anyone.)

thanks,
-- 
John Hubbard
NVIDIA
