Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB255C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0C820645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0C820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeJLRzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:55:09 -0400
Received: from ozlabs.org ([203.11.71.1]:49823 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbeJLRzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:55:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42WkSV5t9yz9s47;
        Fri, 12 Oct 2018 21:23:22 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jann Horn <jannh@google.com>, Michal Hocko <mhocko@suse.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        abdhalee@linux.vnet.ibm.com, joel@jms.id.au,
        Kees Cook <keescook@chromium.org>, jasone@google.com,
        davidtgoldblatt@gmail.com, trasz@freebsd.org,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Daniel Micay <danielmicay@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: don't clobber partially overlapping VMA with MAP_FIXED_NOREPLACE
In-Reply-To: <CAG48ez04KK62doMwsTVN4nN8y_wmv7hn+4my2jk5VXKL0wP7Lg@mail.gmail.com>
References: <20181010152736.99475-1-jannh@google.com> <20181010171944.GJ5873@dhcp22.suse.cz> <CAG48ez04KK62doMwsTVN4nN8y_wmv7hn+4my2jk5VXKL0wP7Lg@mail.gmail.com>
Date:   Fri, 12 Oct 2018 21:23:21 +1100
Message-ID: <87tvlr1n1i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn <jannh@google.com> writes:
> On Wed, Oct 10, 2018 at 7:19 PM Michal Hocko <mhocko@suse.com> wrote:
>> On Wed 10-10-18 17:27:36, Jann Horn wrote:
>> > Daniel Micay reports that attempting to use MAP_FIXED_NOREPLACE in an
>> > application causes that application to randomly crash. The existing check
>> > for handling MAP_FIXED_NOREPLACE looks up the first VMA that either
>> > overlaps or follows the requested region, and then bails out if that VMA
>> > overlaps *the start* of the requested region. It does not bail out if the
>> > VMA only overlaps another part of the requested region.
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

..

Mind if I turn that into a selftest?

cheers
