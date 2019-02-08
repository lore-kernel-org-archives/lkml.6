Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF03BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97456217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfBHNOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:14:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfBHNOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:14:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C175189AE2;
        Fri,  8 Feb 2019 13:14:47 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B8711001942;
        Fri,  8 Feb 2019 13:14:45 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH v2] x86, random: Fix get_random_bytes() warning in x86
 start_kernel
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20190201180831.19839-1-prarit@redhat.com>
 <20190202030240.GA9802@mit.edu>
 <4adb711f-f81e-31ef-c581-4d5ecc739bd1@redhat.com>
 <20190204155535.GC9802@mit.edu>
Message-ID: <ea4c44c8-a6f1-dac2-7cf8-a1a0443a39f0@redhat.com>
Date:   Fri, 8 Feb 2019 08:14:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204155535.GC9802@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 08 Feb 2019 13:14:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/19 10:55 AM, Theodore Y. Ts'o wrote:
> On Sun, Feb 03, 2019 at 08:09:37AM -0500, Prarit Bhargava wrote:
>> Ted, the bug I'm trying to fix is the warning:
>>
>> random: get_random_bytes called from start_kernel+0x8e/0x587 with crng_init=0
>>
>> during early boot.  Even with the kernel parameter the warning appears.
> 
> Sometimes the warnings are real, and shouldn't be suppressed.  A
> Debian maintainer once tried to suppress a compile-time warning, and
> it was disastrous for security.  :-)
> 
> What line number is that corresponding to?  It sounds like something
> is trying to use get_random_bytes() before the random driver was
> initialized, and so the first question is does it really need to call
> get_random_bytes() then or can it be moved?
> 

Yes, that's exactly the case.  During early boot we initialize the boot cpu's
stack canary at arch/x86/include/asm/stackprotector.h:75 which is well before
the random driver is initialized.  The same code is called for all other cpus,
so perhaps not calling get_random_bytes() for the boot cpu is another option.

>>> Also, relying on the TSC for entropy is not something we should be
>>> recommending.
>>
>> The current code uses the TSC.  It is not something new I'm introducing.
> 
> But we don't *rely* on it.  That's a big difference.

Perhaps I'm confusing you by changing the comment.  I'm not changing any
behaviour wrt TSC.  The current code "relies" on the TSC as much as it did
before (all the way back through the git history).

P.

> 
>        	     	       	    	     - Ted
> 
