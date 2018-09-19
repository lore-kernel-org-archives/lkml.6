Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C268C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A930520C01
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A930520C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeITFek convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 01:34:40 -0400
Received: from ozlabs.org ([203.11.71.1]:59979 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725755AbeITFej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 01:34:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42FxXm4zVTz9s89;
        Thu, 20 Sep 2018 09:54:16 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>, segher@kernel.crashing.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] sched: move stack_canary field at the top of task_struct
In-Reply-To: <f6a36d25-ce19-5d56-69d9-198215a7b9e1@c-s.fr>
References: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr> <20180919115836.GE24124@hirez.programming.kicks-ass.net> <f6a36d25-ce19-5d56-69d9-198215a7b9e1@c-s.fr>
Date:   Thu, 20 Sep 2018 09:54:16 +1000
Message-ID: <875zz1avrr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 19/09/2018 à 13:58, Peter Zijlstra a écrit :
>> On Wed, Sep 19, 2018 at 11:14:43AM +0000, Christophe Leroy wrote:
>>> In order to allow the use of non global stack protector canary,
>>> the stack canary needs to be located at a know offset defined
>>> in Makefile via -mstack-protector-guard-offset.
>>>
>>> On powerpc/32, register r2 points to current task_struct at
>>> all time, the stack_canary located inside task_struct can be
>>> used directly if it is located in a known place.
>>>
>>> In order to allow that, this patch moves the stack_canary field
>>> out of the randomized area of task_struct.
>> 
>> And you cannot use something like asm-offsets to extract this?
>
> I have not been able to find a way to define the compilation flags AFTER 
> building asm-offsets.h, see https://patchwork.ozlabs.org/patch/971521/
>
> If you have a suggestion, it is welcomed.

Hmm, that's something of a hard problem.

But the stack canary is one of the things we really *do* want to be
randomised, so we should probably try to come up with a solution.

cheers
