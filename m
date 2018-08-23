Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BC8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C0C208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C0C208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbeHWSUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:20:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47440 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730615AbeHWSUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:20:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41x6m135Kfz9ttr9;
        Thu, 23 Aug 2018 16:50:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id r4DBbziYMYgq; Thu, 23 Aug 2018 16:50:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41x6m12R07z9ttr3;
        Thu, 23 Aug 2018 16:50:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B160E8B8C6;
        Thu, 23 Aug 2018 16:50:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0g_GGb2bWzOn; Thu, 23 Aug 2018 16:50:42 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E71B8B8C5;
        Thu, 23 Aug 2018 16:50:41 +0200 (CEST)
Subject: Re: [PATCH v2 3/4] powerpc/mm: fix a warning when a cache is common
 to PGD and hugepages
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <2f96bf1a8df1091c642de099ed07c34b5ab9b90a.1534258290.git.christophe.leroy@c-s.fr>
 <4aaca2d27429e6bdadc340fd3b96e7c350c4b2f4.1534258290.git.christophe.leroy@c-s.fr>
 <6dea8d0c-c4ab-49aa-da26-a729c18fa818@linux.ibm.com>
 <006e5f33-b816-7508-faac-da26a860659c@c-s.fr>
 <3e6412ac-c645-908f-a3bb-c9a2a72f4b68@linux.ibm.com>
 <cb121f38-ac89-4971-fd84-5473e7e9ced5@c-s.fr>
 <20180823103625.GR24439@gate.crashing.org>
 <8ada20e9-3bc1-fdaf-d78f-2f5a317e8216@c-s.fr>
 <87a7pdl2jy.fsf@concordia.ellerman.id.au>
 <d561e11b-b85e-6f6c-0936-4a93cf309915@au1.ibm.com>
 <20180823144118.GU24439@gate.crashing.org>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <118d50a1-ccbf-7a15-a190-ac14f2a50d27@c-s.fr>
Date:   Thu, 23 Aug 2018 16:50:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823144118.GU24439@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 23/08/2018 à 16:41, Segher Boessenkool a écrit :
> On Thu, Aug 23, 2018 at 11:32:16PM +1000, Andrew Donnellan wrote:
>> On 23/08/18 21:56, Michael Ellerman wrote:
>>> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>>>
>>>> Le 23/08/2018 à 12:36, Segher Boessenkool a écrit :
>>>>> On Thu, Aug 23, 2018 at 11:40:22AM +0200, Christophe LEROY wrote:
>>>>>> The only small problème I have is that some version of GCC seems to
>>>>>> complain about big memset() (132k and 256k ones). Is there a way to tell
>>>>>> GCC we really want to do it ?
>>>>>
>>>>> I'm not sure what you mean.  Complain, is that a warning, is that an
>>>>> error?
>>>>> What does it say?  Do you have some example code to reproduce it?  Etc.
>>>>
>>>> I saw the warnings in the checks at
>>>> https://patchwork.ozlabs.org/patch/957566/
>>>> Unfortunatly the link is now broken.
>>>
>>> ruscur/ajd any idea what happened to the snowpatch links here?
>>
>> I think they've disappeared because our log rotation is too fast - I've
>> now upped it to 30 days. I guess over time we'll figure out what we need
>> in this regard, ideally we'd keep logs indefinitely but they're several
>> megs per build.
>>
>> I've kicked off another build for this series and the links in Patchwork
>> should update to point to the new job when it's done (probably in the
>> next couple of hours).
> 
> It's back, thanks Andrew!
> 
> The warnings are not from GCC at all: the warnings are from sparse.

Oh, ok, my mistake, I reminded seeing those warnings without paying much 
attention to them at that time.

Anyway, should we do anything about this warning ? If so, what 
could/should be done ?

Christophe
