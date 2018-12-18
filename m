Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBB7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31615218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeLRSNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:13:39 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:65039 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbeLRSNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:13:39 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43K5k73wCqz9v2lM;
        Tue, 18 Dec 2018 19:13:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id w-Qt37qd1mjo; Tue, 18 Dec 2018 19:13:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43K5k73Cyvz9v2lL;
        Tue, 18 Dec 2018 19:13:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 25E158B85C;
        Tue, 18 Dec 2018 19:13:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nTVlKo6_tCCo; Tue, 18 Dec 2018 19:13:37 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BC7018B754;
        Tue, 18 Dec 2018 19:13:36 +0100 (CET)
Subject: Re: [PATCH v1 03/13] powerpc/mm/32s: rework mmu_mapin_ram()
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
References: <84624899-bbda-9f08-2527-151fddbd1b01@c-s.fr>
 <a253e9f8-1e0a-1596-e0ea-54261ac62212@c-s.fr>
 <20181217012837.GT15324@latitude>
 <18ba3a7c-ebfa-66aa-e231-b56985d0e89a@c-s.fr>
 <20181218030538.GA24278@latitude>
 <9a39d910-2a05-3ce7-c949-296db2d458b9@c-s.fr>
 <20181218140714.GC24278@latitude>
 <96539c09-ea57-43d6-bae9-7371235b175f@c-s.fr>
 <ee4322c4-60e1-94c5-1e55-5d4c3e4de03b@c-s.fr>
 <c1ee5c7f-d683-924f-68cb-43e1fe14363a@c-s.fr>
 <20181218170403.GF24278@latitude>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <9241a3de-c557-1a48-78b3-eb812811b1b0@c-s.fr>
Date:   Tue, 18 Dec 2018 19:13:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181218170403.GF24278@latitude>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/12/2018 à 18:04, Jonathan Neuschäfer a écrit :
> On Tue, Dec 18, 2018 at 04:04:42PM +0100, Christophe Leroy wrote:
>> Stupid of me. In fact at the time being, BATS cover both RO and RW data
>> areas, so it can definitly not be mapped with PAGE_KERNEL_ROX.
>>
>> In fact, as I have CONFIG_BDI_SWITCH in my setup, PAGE_KERNEL_TEXT is
>> PAGE_KERNEL_X on my side. That's the reason why I missed it.
>>
>> With this change being done to patch 3, does the overall serie works for you ?
> 
> Yes, with the PAGE_KERNEL_X change, the whole series boots on the Wii.

That's great, many thanks for testing.

Christophe

> 
> 
> Jonathan
> 
