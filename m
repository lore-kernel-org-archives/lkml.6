Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F764C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DBE20815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfBCNJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:09:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfBCNJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:09:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4381D8046D;
        Sun,  3 Feb 2019 13:09:43 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9A2A9654C;
        Sun,  3 Feb 2019 13:09:37 +0000 (UTC)
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
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <4adb711f-f81e-31ef-c581-4d5ecc739bd1@redhat.com>
Date:   Sun, 3 Feb 2019 08:09:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190202030240.GA9802@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 03 Feb 2019 13:09:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/19 10:02 PM, Theodore Y. Ts'o wrote:
> On Fri, Feb 01, 2019 at 01:08:31PM -0500, Prarit Bhargava wrote:
>> After 43838a23a05f ("random: fix crng_ready() test") early boot calls to
>> get_random_bytes() will warn on x86 because the crng is not initialized.
>> For example,
>>
>> random: get_random_bytes called from start_kernel+0x8e/0x587 with crng_init=0
>>
>> x86 only uses get_random_bytes() for better randomization of the stack
>> canary value so the warning is of no consequence.
>>
>> Test if the crng is initialized before calling get_random_bytes().  If it
>> is not available then attempt to read from the hardware random generator,
>> before finally using the TSC.
> 
> If you want to trust the CPU's hardware number generator, there is a
> way to do this already.  Simply enable CONFIG_RANDOM_TRUST_CPU, or set
> the boot command line option "random.trust_cpu=on".
> 
Ted, the bug I'm trying to fix is the warning:

random: get_random_bytes called from start_kernel+0x8e/0x587 with crng_init=0

during early boot.  Even with the kernel parameter the warning appears.


> Also, relying on the TSC for entropy is not something we should be
> recommending.

The current code uses the TSC.  It is not something new I'm introducing.

P.

> 
> So, NAK.
> 
> 						- Ted
> 
