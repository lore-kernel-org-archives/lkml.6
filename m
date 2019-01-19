Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D46C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8592084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfASKXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 05:23:51 -0500
Received: from ozlabs.org ([203.11.71.1]:34757 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbfASKXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 05:23:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43hYnH30Dqz9sBQ;
        Sat, 19 Jan 2019 21:23:47 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v13 00/10] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
In-Reply-To: <cover.1547195976.git.christophe.leroy@c-s.fr>
References: <cover.1547195976.git.christophe.leroy@c-s.fr>
Date:   Sat, 19 Jan 2019 21:23:46 +1100
Message-ID: <87zhrx2bf1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
> moves the thread_info into task_struct.
>
> Moving thread_info into task_struct has the following advantages:
> - It protects thread_info from corruption in the case of stack
> overflows.
> - Its address is harder to determine if stack addresses are
> leaked, making a number of attacks more difficult.
>
> Changes since v12:
>  - Patch 1: Taken comment from Mike (re-introduced the 'panic' in case memblock allocation fails in setup_64.c
>  - Patch 1: Added alloc_stack() function in setup_32.c to also panic in case of allocation failure.

Hi Christophe,

I can't get this series to boot on qemu mac99. I'm getting eg:

[    0.981514] NFS: Registering the id_resolver key type
[    0.981752] Key type id_resolver registered
[    0.981868] Key type id_legacy registered
[    0.995711] Unrecoverable exception 0 at 0 (msr=0)
[    0.996091] Oops: Unrecoverable exception, sig: 6 [#1]
[    0.996314] BE PAGE_SIZE=4K MMU=Hash PowerMac
[    0.996617] Modules linked in:
[    0.996869] CPU: 0 PID: 416 Comm: modprobe Not tainted 5.0.0-rc2-gcc-7.3.0-00043-g53f2de798792 #342
[    0.997138] NIP:  00000000 LR: 00000000 CTR: 00000000
[    0.997309] REGS: ef237f50 TRAP: 0000   Not tainted  (5.0.0-rc2-gcc-7.3.0-00043-g53f2de798792)
[    0.997508] MSR:  00000000 <>  CR: 00000000  XER: 00000000
[    0.997712] 
[    0.997712] GPR00: 00000000 ef238000 00000000 00000000 00000000 00000000 00000000 00000000 
[    0.997712] GPR08: 00000000 00000000 00000000 00000000 00000000 00000000 c006477c ef13d8c0 
[    0.997712] GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
[    0.997712] GPR24: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
[    0.998671] NIP [00000000]   (null)
[    0.998774] LR [00000000]   (null)
[    0.998895] Call Trace:
[    0.999030] Instruction dump:
[    0.999320] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
[    0.999546] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 60000000 XXXXXXXX XXXXXXXX XXXXXXXX 
[    1.000023] ---[ end trace 925ea3419844fe68 ]---

I haven't had time to dig any further.

cheers
