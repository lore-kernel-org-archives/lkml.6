Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED285C04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD3C2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD3C2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbeI1TTs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:19:48 -0400
Received: from ozlabs.org ([203.11.71.1]:58005 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbeI1TTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:19:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42MBWC4FJHz9s4Z;
        Fri, 28 Sep 2018 22:56:07 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] powerpc/32: add stack protector support
In-Reply-To: <28451b6a-e302-691e-ee28-16521997fb07@c-s.fr>
References: <d6c43ab708bf9ae1266c745fece457ed2da43d7c.1537961921.git.christophe.leroy@c-s.fr> <20180926191615.GO23155@gate.crashing.org> <220fbef8-429c-9485-d10e-c1eaa989918d@c-s.fr> <20180927074525.GQ23155@gate.crashing.org> <28451b6a-e302-691e-ee28-16521997fb07@c-s.fr>
Date:   Fri, 28 Sep 2018 22:56:07 +1000
Message-ID: <8736ttu6fs.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 27/09/2018 à 09:45, Segher Boessenkool a écrit :
>> On Thu, Sep 27, 2018 at 08:20:00AM +0200, Christophe LEROY wrote:
...
>> 
>>> However this is the canary for initial startup only. Only idle() still
>>> uses this canary once the system is running. A new canary is set for any
>>> new forked task.
>> 
>> Ah, that makes things a lot better!  Do those new tasks get a canary
>> from something with sufficient entropy though?
>
> For the kernel threads that are started early, probably not. For the 
> ones started a bit later, and for user processes, I believe they have 
> better entropy. Anyway, all this is handled by the kernel core and is 
> out of control of individual arches, as its done in kernel/fork.c in 
> function dup_task_struct(). However this function is declared as
> static __latent_entropy struct task_struct *copy_process(). This 
> __latent_entropy attibute must help in a way.
>
>> 
>>> Maybe should the idle canary be updated later once there is more entropy
>> 
>> That is tricky to do, but sure, if you can, that should help.
>> 
>>> ? Today there is a new call to boot_init_stack_canary() in
>>> cpu_startup_entry(), but it is enclosed inside #ifdef CONFIG_X86.
>> 
>> It needs to know the details of how ssp works on each platform.
>
> Well, that could be for another patch in the future. That's probably 
> feasible on x86 and PPC because they both use TLS guard, but not for 
> other arches where the guard is global at the moment. So we'll have to 
> do it carefully.
>
> I agree with you that we may not for the time being get all the expected 
> security against hackers out of it due to that little entropy, but my 
> main concern at the time being is to deter developper's bugs clobbering 
> the stack, and for that any non trivial canary should make it, shouldn't 
> it ?

Yes.

The problem of low entropy at boot on systems without a good hardware
source is sort of unsolvable.

As you say it's up to the core kernel/random code, we shouldn't be
trying to do anything tricky in the arch code.

You don't want your system to take 3 hours to boot because it's waiting
for entropy for the stack canary.

If we can update the canary later once the entropy pool is setup that
would be ideal.

cheers
