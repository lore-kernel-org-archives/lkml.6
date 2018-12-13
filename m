Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA862C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F7C20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F7C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbeLMMRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:17:38 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:18812 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbeLMMRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:17:38 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43Ft3h0zlGz9v0cQ;
        Thu, 13 Dec 2018 13:17:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kgbHqzO4B0lF; Thu, 13 Dec 2018 13:17:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43Ft3h0Ny3z9v0ZK;
        Thu, 13 Dec 2018 13:17:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 38FF88B871;
        Thu, 13 Dec 2018 13:17:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DACdrZTjoSEZ; Thu, 13 Dec 2018 13:17:37 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AFDC88B86E;
        Thu, 13 Dec 2018 13:17:36 +0100 (CET)
Subject: Re: [PATCH v1 03/13] powerpc/mm/32s: rework mmu_mapin_ram()
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
 <8835330baa77d88e0267b0b1215b78c991e6d17a.1543517818.git.christophe.leroy@c-s.fr>
 <20181203215558.GK15324@latitude>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <84624899-bbda-9f08-2527-151fddbd1b01@c-s.fr>
Date:   Thu, 13 Dec 2018 12:16:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181203215558.GK15324@latitude>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/03/2018 09:55 PM, Jonathan Neuschäfer wrote:
> Hi,
> 
> On Thu, Nov 29, 2018 at 07:00:16PM +0000, Christophe Leroy wrote:
>> This patch reworks mmu_mapin_ram() to be more generic and map as much
>> blocks as possible. It now supports blocks not starting at address 0.
>>
>> It scans DBATs array to find free ones instead of forcing the use of
>> BAT2 and BAT3.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
> 
> I've just tested this series on my Wii, and starting from this patch
> (03/13), it hangs at the following lines of output:
> 
> [    0.000000] printk: bootconsole [udbg0] enabled
> [    0.000000] Total memory = 319MB; using 1024kB for hash table (at (ptrval))
> 
> Before this patch it looks like this and boots to userspace:
> 
> [    0.000000] printk: bootconsole [udbg0] enabled
> [    0.000000] Total memory = 319MB; using 1024kB for hash table (at (ptrval))
> [    0.000000] Linux version 4.20.0-rc5-wii-00022-gfbb911b84755 (jn@longitude) (gcc version 8.2.0 (Debian 8.2.0-9)) #1337 PREEMPT Mon Dec 3 21:49:02 CET 2018
> ug_udbg_init: early -> final
> usbgecko_udbg: ready
> [    0.000000] Using wii machine description

Can you tell/provide the .config and dts used ?

You seem to have 319MB RAM wherease arch/powerpc/boot/dts/wii.dts only 
has 88MB Memory:

	memory {
		device_type = "memory";
		reg = <0x00000000 0x01800000	/* MEM1 24MB 1T-SRAM */
		       0x10000000 0x04000000>;	/* MEM2 64MB GDDR3 */
	};

Christophe

> ...
> 
> I've tested at patch 1, 2, 3, 4, and 13, so I don't know if it works
> somewhere in the middle, but probably not.
> 
> (And in case you're wondering about the 22 in the version string: Those
> are mostly patches that give me a serial console.)
> 
> I'm not sure what is going on, because I haven't looked closely at the
> patches or tried to debug the problem. If you have some debugging tips,
> I can try them.
> 
> 
> Jonathan Neuschäfer
> 
