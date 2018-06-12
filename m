Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B3DB2C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6A6208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6A6208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935178AbeFLRCM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:02:12 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35037 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933685AbeFLRCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:02:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 414x4j2svqz9ttFY;
        Tue, 12 Jun 2018 19:01:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id JJT7Sv4aK7K2; Tue, 12 Jun 2018 19:01:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 414x4j2LPzz9ttFW;
        Tue, 12 Jun 2018 19:01:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AB1378B95F;
        Tue, 12 Jun 2018 19:02:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GX9O-VVjFo9g; Tue, 12 Jun 2018 19:02:00 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1481F8B940;
        Tue, 12 Jun 2018 19:02:00 +0200 (CEST)
Subject: Re: [PATCH v6 3/4] powerpc/lib: implement strlen() in assembly
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, wei.guo.simon@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr>
 <8b89f2e21f7e3a865105eeeeda509243db393454.1528791416.git.christophe.leroy@c-s.fr>
 <20180612145315.GJ27520@gate.crashing.org>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <baaf4fa9-ff0b-0bcb-8662-dafb794caab4@c-s.fr>
Date:   Tue, 12 Jun 2018 19:01:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612145315.GJ27520@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/06/2018 à 16:53, Segher Boessenkool a écrit :
> On Tue, Jun 12, 2018 at 09:14:53AM +0000, Christophe Leroy wrote:
>> ---
>> Not tested on PPC64.
> 
> It won't be acceptable until that happens.  It also is likely quite bad
> performance on all 64-bit CPUs from the last fifteen years or so.  Or you
> did nothing to prove otherwise, at least.

Will it be as bad as the generic implementation which does it byte per 
byte ?

I don't have any 64 bits target, can someone test it using the test app 
I have added in selftests ?

Or should I just leave it as is for 64 bits and just do the 
implementation for 32 bits until someone wants to try and do it for PPC64 ?

Christophe

> 
>> + * Algorigthm:
> 
> Typo.
> 
> 
> Segher
> 
