Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F875C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D1520870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D1520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932363AbeGCBmH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:42:07 -0400
Received: from ozlabs.org ([203.11.71.1]:51771 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932248AbeGCBmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:42:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41KRgZ4xLhz9s3C;
        Tue,  3 Jul 2018 11:42:02 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Paul Mackerras <paulus@samba.org>,
        Anatolij Gustschin <agust@denx.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: mpc5200: Remove VLA usage
In-Reply-To: <20180702171631.GA16221@gate.crashing.org>
References: <20180629185339.GA37582@beast> <CAK8P3a3zrXii=bxBm1zHWMHWgYLCQ0rpo460zmKyfsf_-nxxhQ@mail.gmail.com> <CAGXu5jJz0zP_DvGqZsBjKZ_vY0=xKoUxCLVxXgUPAbcXS6aMNg@mail.gmail.com> <87fu12mnf7.fsf@concordia.ellerman.id.au> <20180702171631.GA16221@gate.crashing.org>
Date:   Tue, 03 Jul 2018 11:41:59 +1000
Message-ID: <8736x1gkns.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Mon, Jul 02, 2018 at 11:33:32AM +1000, Michael Ellerman wrote:
>> What if we write it:
>> 
>>        char saved_0x500[0x600 - 0x500];
>> 
>> Hopefully the compiler is smart enough not to generate a VLA for that :)
>
> It is a VLA if the array size is not an integer constant expression.  This
> is defined by C; the compiler has nothing to do with it.  0x600-0x500 is
> an integer constant expression, so this is not a VLA.

Thanks.

That wasn't meant as a dig at GCC. Kees had an epic struggle with the
kernel's min/max() macros which were causing expressions that looked
like they should be constant to generate VLAs.

> But if you meant if GCC will ever do a dynamic stack allocation for a fixed
> size local variable: yes indeed, I hope not!

Hey that would be cool, just-in-time local variable allocation :)

cheers
