Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26375C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95F62084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Kt+bScOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfBUHmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:42:24 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55566 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbfBUHmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 02:42:23 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444mdm65P2z9tyFM;
        Thu, 21 Feb 2019 08:42:20 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Kt+bScOe; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wfcoxRKWw_2l; Thu, 21 Feb 2019 08:42:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444mdm4h4Rz9tyF4;
        Thu, 21 Feb 2019 08:42:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550734940; bh=lWdc6nz5IJrMOKAwLhVS/NTvPYy+zFyuoVYBhW7fWHo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Kt+bScOeGKyudtsvAz0yBm1W41cJqRPY2E1Fv5mKxux175NlucQh0F12Jaml3/fmc
         KjNHAPep1+05SM9YZaUDQrHlAoYbi28fvlewdsxeMA6erFFZvrbImmP8ArErl2xfXO
         09D3yjqzrQJYyqru8NNXUuNOtKI5boL45NbCBfJM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 93E2F8B78F;
        Thu, 21 Feb 2019 08:42:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DO_TCIqwh4DS; Thu, 21 Feb 2019 08:42:21 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 263148B75B;
        Thu, 21 Feb 2019 08:42:21 +0100 (CET)
Subject: Re: [PATCH v3 00/16] powerpc/32: Use BATs/LTLBs for STRICT_KERNEL_RWX
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1550648295.git.christophe.leroy@c-s.fr>
 <87mumpx68h.fsf@concordia.ellerman.id.au>
 <82af8805-3e2a-cfb3-9df6-d883b50ff460@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e46cf0f8-6227-bb9c-b435-c5dbc23ce71c@c-s.fr>
Date:   Thu, 21 Feb 2019 08:42:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <82af8805-3e2a-cfb3-9df6-d883b50ff460@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/02/2019 à 07:31, Christophe Leroy a écrit :
> 
> 
> Le 21/02/2019 à 02:47, Michael Ellerman a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> The purpose of this serie is to:
>>> - use BATs with STRICT_KERNEL_RWX on book3s (See patch 13 for details.)
>>> - use LTLBs with STRICT_KERNEL_RWX on 8xx (See patch 15 for a few 
>>> details.)
>>
>> This doesn't boot qemu-mac99 for me:
>>
>>    spawn ~/src/qemu/ppc-softmmu/qemu-system-ppc -nographic -vga none 
>> -M mac99 -m 1G -kernel build/vmlinux -initrd ppc32-initrd.gz -append 
>> console=ttyPZ0 init=/bin/sh
>>    >> =============================================================
>>    >> OpenBIOS 1.1 [Feb 15 2019 10:05]
>>    >> Configuration device id QEMU version 1 machine id 1
>>    >> CPUs: 1
>>    >> Memory: 1024M
>>    >> UUID: 00000000-0000-0000-0000-000000000000
>>    >> CPU type PowerPC,G4
>>    milliseconds isn't unique.
>>    Welcome to OpenBIOS v1.1 built on Feb 15 2019 10:05
>>    >> [ppc] Kernel already loaded (0x01000000 + 0x00c2c338) (initrd 
>> 0x01d2d000 + 0x007e72f0)
>>    >> [ppc] Kernel command line: console=ttyPZ0 init=/bin/sh
>>    >> switching to new context:
>>    OF stdout device is: /pci@f2000000/mac-io@c/escc@13000/ch-a@13020
>>    Preparing to boot Linux version 
>> 5.0.0-rc2-gcc-8.2.0-00125-g4fcb83ca7936 (michael@ka4) (gcc version 
>> 8.2.0 (Buildroot 2018.11-rc2-00003-ga0787e9)) #724 Thu Feb 21 12:03:14 
>> AEDT 2019
>>    Detected machine type: 00000400
>>    command line:
>>    memory layout at init:
>>      memory_limit : 00000000 (16 MB aligned)
>>      alloc_bottom : 02515000
>>      alloc_top    : 30000000
>>      alloc_top_hi : 40000000
>>      rmo_top      : 30000000
>>      ram_top      : 40000000
>>    copying OF device tree...
>>    Building dt strings...
>>    Building dt structure...
>>    Device tree strings 0x02516000 -> 0x025150a4
>>    Device tree struct  0x02517000 -> 0x3fde7eb0
>>    Quiescing Open Firmware ...
>>    Booting Linux via __start() @ 0x01000000 ...
>>    FAIL! Booting BE pmac32
>>
>>
>> That's pmac32 defconfig ish.
>> I haven't had time to debug it further sorry.
>>
> 
> Ok. I boots fine without the '-m 1G'.
> 
> I'll find out why.
> 

Doesn't boot because it maps memory above total_lowmem.

I'll fix it.

Christophe
