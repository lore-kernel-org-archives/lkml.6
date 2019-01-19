Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA22C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A092084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfASRVT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:21:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55263 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfASRVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 12:21:19 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43hl2x5BSBz9vCJC;
        Sat, 19 Jan 2019 18:21:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 2B8lMW7w35Gr; Sat, 19 Jan 2019 18:21:13 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43hl2x4D1Kz9vCJ9;
        Sat, 19 Jan 2019 18:21:13 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 25AAE79; Sat, 19 Jan 2019 18:21:13 +0100 (CET)
Received: from 37-170-18-222.coucou-networks.fr
 (37-170-18-222.coucou-networks.fr [37.170.18.222]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sat, 19 Jan 2019 18:21:13 +0100
Date:   Sat, 19 Jan 2019 18:21:13 +0100
Message-ID: <20190119182113.Horde.DK6jqX3cEzsvR0fKFZrY2g4@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v13 00/10] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
References: <cover.1547195976.git.christophe.leroy@c-s.fr>
 <87zhrx2bf1.fsf@concordia.ellerman.id.au>
In-Reply-To: <87zhrx2bf1.fsf@concordia.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> a écrit :

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
>> moves the thread_info into task_struct.
>>
>> Moving thread_info into task_struct has the following advantages:
>> - It protects thread_info from corruption in the case of stack
>> overflows.
>> - Its address is harder to determine if stack addresses are
>> leaked, making a number of attacks more difficult.
>>
>> Changes since v12:
>>  - Patch 1: Taken comment from Mike (re-introduced the 'panic' in  
>> case memblock allocation fails in setup_64.c
>>  - Patch 1: Added alloc_stack() function in setup_32.c to also  
>> panic in case of allocation failure.
>
> Hi Christophe,
>
> I can't get this series to boot on qemu mac99. I'm getting eg:

Problem new with version 13 or it is the first time you test ?

>
> [    0.981514] NFS: Registering the id_resolver key type
> [    0.981752] Key type id_resolver registered
> [    0.981868] Key type id_legacy registered
> [    0.995711] Unrecoverable exception 0 at 0 (msr=0)
> [    0.996091] Oops: Unrecoverable exception, sig: 6 [#1]
> [    0.996314] BE PAGE_SIZE=4K MMU=Hash PowerMac
> [    0.996617] Modules linked in:
> [    0.996869] CPU: 0 PID: 416 Comm: modprobe Not tainted  
> 5.0.0-rc2-gcc-7.3.0-00043-g53f2de798792 #342

Comm:modprobe  ==> Something wrong with modules ? I never tested with  
CONFIG_MODULES.

Christophe

> [    0.997138] NIP:  00000000 LR: 00000000 CTR: 00000000
> [    0.997309] REGS: ef237f50 TRAP: 0000   Not tainted   
> (5.0.0-rc2-gcc-7.3.0-00043-g53f2de798792)
> [    0.997508] MSR:  00000000 <>  CR: 00000000  XER: 00000000
> [    0.997712]
> [    0.997712] GPR00: 00000000 ef238000 00000000 00000000 00000000  
> 00000000 00000000 00000000
> [    0.997712] GPR08: 00000000 00000000 00000000 00000000 00000000  
> 00000000 c006477c ef13d8c0
> [    0.997712] GPR16: 00000000 00000000 00000000 00000000 00000000  
> 00000000 00000000 00000000
> [    0.997712] GPR24: 00000000 00000000 00000000 00000000 00000000  
> 00000000 00000000 00000000
> [    0.998671] NIP [00000000]   (null)
> [    0.998774] LR [00000000]   (null)
> [    0.998895] Call Trace:
> [    0.999030] Instruction dump:
> [    0.999320] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX  
> XXXXXXXX XXXXXXXX
> [    0.999546] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 60000000 XXXXXXXX  
> XXXXXXXX XXXXXXXX
> [    1.000023] ---[ end trace 925ea3419844fe68 ]---
>
> I haven't had time to dig any further.
>
> cheers


