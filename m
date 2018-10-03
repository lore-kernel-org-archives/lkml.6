Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF61BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A46620878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A46620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeJCMrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:47:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:58252 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbeJCMrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:47:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42Q53q1Cj4z9ttBf;
        Wed,  3 Oct 2018 08:00:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id URNktn2kN_6n; Wed,  3 Oct 2018 08:00:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42Q53b4F02z9ttBW;
        Wed,  3 Oct 2018 08:00:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D7BFE8B8B5;
        Wed,  3 Oct 2018 08:00:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PN9OyHphuYnA; Wed,  3 Oct 2018 08:00:43 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A0C2B8B74C;
        Wed,  3 Oct 2018 08:00:43 +0200 (CEST)
Subject: Re: [RFC PATCH v3 5/7] powerpc: 'current_set' is now a table of
 task_struct pointers
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <acc40cfa715e398d578371857dbf65882ad72c0f.1538396659.git.christophe.leroy@c-s.fr>
 <20181003154101.0b46956d@roar.ozlabs.ibm.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <0336ff43-55ac-067b-23a9-4cb4b2fd38f3@c-s.fr>
Date:   Wed, 3 Oct 2018 08:00:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003154101.0b46956d@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/10/2018 à 07:41, Nicholas Piggin a écrit :
> On Mon,  1 Oct 2018 12:30:27 +0000 (UTC)
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> The table of pointers 'current_set' has been used for retrieving
>> the stack and current. They used to be thread_info pointers as
>> they were pointing to the stack and current was taken from the
>> 'task' field of the thread_info.
>>
>> Now, the pointers of 'current_set' table are now both pointers
>> to task_struct and pointers to thread_info.
>>
>> As they are used to get current, and the stack pointer is
>> retrieved from current's stack field, this patch changes
>> their type to task_struct, and renames secondary_ti to
>> secondary_current.
> 
> I'm not sure if current_set is actually needed is it? Because
> 64-bit already initializes paca->ksave / PACAKSAVE. That might
> be a cleanup to do after your series.

head_64.S contains:

__secondary_start:
	/* Set thread priority to MEDIUM */
	HMT_MEDIUM

	/* Initialize the kernel stack */
	LOAD_REG_ADDR(r3, current_set)
	sldi	r28,r24,3		/* get current_set[cpu#]	 */
	ldx	r14,r3,r28
	addi	r14,r14,THREAD_SIZE-STACK_FRAME_OVERHEAD
	std	r14,PACAKSAVE(r13)


32-bit doesn't seem to use it, it only uses secondary_ti it seems.

> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 

Christophe
