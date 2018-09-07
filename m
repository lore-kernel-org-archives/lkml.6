Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90C0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D582077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D582077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeIGS4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:56:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63813 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbeIGS4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:56:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 426KGV3Jtwz9ttFR;
        Fri,  7 Sep 2018 16:15:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7cFdYDtLfgVw; Fri,  7 Sep 2018 16:15:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 426KGV2k9Hz9ttFK;
        Fri,  7 Sep 2018 16:15:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 095778B950;
        Fri,  7 Sep 2018 16:15:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xPxlKEAtWsoq; Fri,  7 Sep 2018 16:15:33 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CC7758B94C;
        Fri,  7 Sep 2018 16:15:33 +0200 (CEST)
Subject: Re: [PATCH] perf: enum overflow in uapi/linux/perf_event.h
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sparse@vger.kernel.org
References: <a70172863fa7d3c138f788b18d36524bd45b0a73.1536326078.git.christophe.leroy@c-s.fr>
 <20180907134246.GC24106@hirez.programming.kicks-ass.net>
 <ae32181d-37b2-1a13-3c72-66775e05ff88@c-s.fr>
 <20180907135817.GF24106@hirez.programming.kicks-ass.net>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7a086a56-a896-9513-7315-9d0d21b61a44@c-s.fr>
Date:   Fri, 7 Sep 2018 16:15:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907135817.GF24106@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 07/09/2018 à 15:58, Peter Zijlstra a écrit :
> On Fri, Sep 07, 2018 at 01:50:18PM +0000, Christophe Leroy wrote:
>>
>>
>> On 09/07/2018 01:42 PM, Peter Zijlstra wrote:
>>> On Fri, Sep 07, 2018 at 01:27:19PM +0000, Christophe Leroy wrote:
>>>> On PPC32, enums are 32 bits, so __PERF_SAMPLE_CALLCHAIN_EARLY is
>>>> out of scope. The following sparse warning is encountered:
>>>>
>>>>     CHECK   arch/powerpc/kernel/process.c
>>>> ./include/uapi/linux/perf_event.h:147:56: warning: cast truncates bits from constant value (8000000000000000 becomes 0)
>>>
>>> Urgh... what compiler is that? I've not seen anything like that from the
>>> build bots.
>>>
>>
>> [root@pc16082vm linux-powerpc]# sparse --version
>> 0.5.2
>>
>> [root@pc16082vm linux-powerpc]# ppc-linux-gcc --version
>> ppc-linux-gcc (GCC) 5.4.0
> 
> Ah, that's a sparse warning. But does your GCC agree? The thing is,
> sparse uses the C enum spec, but I suspect GCC uses the C++ enum spec
> and it all works fine.
> 

Ah yes, it seems that GCC is happy. So sparse should be fixed instead ?

Anyway, is it really correct to put this constant inside that enum, 
after PERF_SAMPLE_MAX  ?

Christophe
