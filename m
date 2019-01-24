Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF2C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E9D21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfAXBGt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 20:06:49 -0500
Received: from ozlabs.org ([203.11.71.1]:42993 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfAXBGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 20:06:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43lPBG45Pmz9sCX;
        Thu, 24 Jan 2019 12:06:46 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 00/10] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
In-Reply-To: <2e700e1c-5bd9-652e-b535-68a89dd703a1@c-s.fr>
References: <cover.1547195976.git.christophe.leroy@c-s.fr> <2e700e1c-5bd9-652e-b535-68a89dd703a1@c-s.fr>
Date:   Thu, 24 Jan 2019 12:06:45 +1100
Message-ID: <87y37ax3ru.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 12/01/2019 à 10:55, Christophe Leroy a écrit :
>> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
>> moves the thread_info into task_struct.
>> 
>> Moving thread_info into task_struct has the following advantages:
>> - It protects thread_info from corruption in the case of stack
>> overflows.
>> - Its address is harder to determine if stack addresses are
>> leaked, making a number of attacks more difficult.
>
> I ran null_syscall and context_switch benchmark selftests and the result 
> is surprising. There is slight degradation in context_switch and a 
> significant one on null_syscall:
>
> Without the serie:
>
> ~# chrt -f 98 ./context_switch --no-altivec --no-vector --no-fp
> 55542
> 55562
> 55564
> 55562
> 55568
> ...
>
> ~# ./null_syscall
>     2546.71 ns     336.17 cycles
>
>
> With the serie:
>
> ~# chrt -f 98 ./context_switch --no-altivec --no-vector --no-fp
> 55138
> 55142
> 55152
> 55144
> 55142
>
> ~# ./null_syscall
>     3479.54 ns     459.30 cycles
>
> So 0,8% less context switches per second and 37% more time for one syscall ?
>
> Any idea ?

What platform is that on?

On 64-bit we have to turn one mtmsrd into two and that's obviously a
slow down. But I don't see that you've done anything similar in 32-bit
code.

I assume it's patch 8 that causes the slow down?

cheers
