Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F28C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE07208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE07208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932766AbeGBBdg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:33:36 -0400
Received: from ozlabs.org ([203.11.71.1]:38731 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbeGBBdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:33:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41JqXD5c16z9s1B;
        Mon,  2 Jul 2018 11:33:32 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Anatolij Gustschin <agust@denx.de>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: mpc5200: Remove VLA usage
In-Reply-To: <CAGXu5jJz0zP_DvGqZsBjKZ_vY0=xKoUxCLVxXgUPAbcXS6aMNg@mail.gmail.com>
References: <20180629185339.GA37582@beast> <CAK8P3a3zrXii=bxBm1zHWMHWgYLCQ0rpo460zmKyfsf_-nxxhQ@mail.gmail.com> <CAGXu5jJz0zP_DvGqZsBjKZ_vY0=xKoUxCLVxXgUPAbcXS6aMNg@mail.gmail.com>
Date:   Mon, 02 Jul 2018 11:33:32 +1000
Message-ID: <87fu12mnf7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Fri, Jun 29, 2018 at 2:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Jun 29, 2018 at 8:53 PM, Kees Cook <keescook@chromium.org> wrote:
>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>> switches to using a stack size large enough for the saved routine and
>>> adds a sanity check.
>>>
>>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> This seems particularly nice, not only avoids it the dynamic stack
>> allocation, it
>> also makes sure the new 0x500 handler doesn't overflow into the 0x600
>> exception handler.
>>
>> It would help to explain how you arrived at that '256 byte' number in
>> the changelog though.
>
> Honestly, I just counted instructions, multiplied by 8 and rounded up
> to the next nearest power of 2, and the result felt right for giving
> some level of flexibility for code growth before tripping the WARN. :P
>
> I'm happy to adjust, of course. :)

What if we write it:

       char saved_0x500[0x600 - 0x500];

Hopefully the compiler is smart enough not to generate a VLA for that :)

cheers
