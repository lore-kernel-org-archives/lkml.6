Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DF0C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF8C20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF8C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeFTANw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:13:52 -0400
Received: from ozlabs.org ([203.11.71.1]:36487 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751655AbeFTANu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:13:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 419QKm5c8Yz9s47;
        Wed, 20 Jun 2018 10:13:48 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends"
In-Reply-To: <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
References: <20180615185645.8921-1-malat@debian.org> <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
Date:   Wed, 20 Jun 2018 10:13:45 +1000
Message-ID: <87muvqwc06.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <eric.dumazet@gmail.com> writes:

> On 06/15/2018 11:56 AM, Mathieu Malaterre wrote:
>> This reverts commit 88078d98d1bb085d72af8437707279e203524fa5.
>> 
>> It causes regressions for people using chips driven by the sungem
>> driver. Suspicion is that the skb->csum value isn't being adjusted
>> properly.
>> 
>> Symptoms as seen on G4+sungem are:
>> 
>> [   34.023281] eth0: hw csum failure
>> [   34.023438] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #2
>> [   34.023618] Call Trace:
>> [   34.023707] [dffedbd0] [c069ddac] __skb_checksum_complete+0xf0/0x108 (unreliable)
>> [   34.023948] [dffedbf0] [c0777a70] tcp_v4_rcv+0x604/0xe00
>> [   34.024118] [dffedc70] [c0731624] ip_local_deliver_finish+0xa8/0x3c4
>> [   34.024315] [dffedcb0] [c0732430] ip_local_deliver+0xf0/0x154
>> [   34.024493] [dffedcf0] [c07328dc] ip_rcv+0x448/0x774
>> [   34.024653] [dffedd50] [c06aeae0] __netif_receive_skb_core+0x5e8/0x1184
>> [   34.024857] [dffedde0] [c06bba20] napi_gro_receive+0x160/0x22c
>> [   34.025044] [dffede10] [e14b2590] gem_poll+0x7fc/0x1ac0 [sungem]
>> [   34.025228] [dffedee0] [c06bacf0] net_rx_action+0x34c/0x618
>> [   34.025402] [dffedf60] [c07fd27c] __do_softirq+0x16c/0x5f0
>> [   34.025575] [dffedfd0] [c0064c7c] irq_exit+0x110/0x1a8
>> [   34.025738] [dffedff0] [c0016170] call_do_irq+0x24/0x3c
>> [   34.025903] [c0cf7e80] [c0009a84] do_IRQ+0x98/0x1a0
>> [   34.026055] [c0cf7eb0] [c001b474] ret_from_except+0x0/0x14
>> [   34.026225] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
>>                    LR = arch_cpu_idle+0x30/0x78
>> [   34.026510] [c0cf7f70] [c0cf6000] 0xc0cf6000 (unreliable)
>> [   34.026682] [c0cf7f80] [c00a3868] do_idle+0xc4/0x158
>> [   34.026835] [c0cf7fb0] [c00a3ab0] cpu_startup_entry+0x20/0x28
>> [   34.027013] [c0cf7fc0] [c0998820] start_kernel+0x47c/0x490
>> [   34.027181] [c0cf7ff0] [00003444] 0x3444
>> 
>> See commit 7ce5a27f2ef8 ("Revert "net: Handle CHECKSUM_COMPLETE more
>> adequately in pskb_trim_rcsum()."") for previous reference.
>
> This fix seems to hide a bug in csum functions on this architecture.
>
> Or a bug on this NIC when receiving a small packet (less than 60 bytes).
> Maybe the padding bytes are not included in NIC provided csum, and not 0.

Just so I'm clear, this turned out to be a driver/hw problem rather than
the arch csum implementation?

cheers
