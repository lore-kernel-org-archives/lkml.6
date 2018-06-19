Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B9DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6442075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6442075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bristot.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966024AbeFSMw3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:52:29 -0400
Received: from smtp-sp200-218.kinghost.net ([177.185.200.218]:39370 "EHLO
        smtp-sp200-218.kinghost.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937711AbeFSMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:52:26 -0400
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 08:52:25 EDT
Received: from smtp200-farm64.kinghost.net (smtp200-farm64 [127.0.0.1])
        (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-sp200-218.kinghost.net (Postfix) with ESMTPS id 8C74F13CC601C;
        Tue, 19 Jun 2018 09:44:10 -0300 (BRT)
Received: from smtpi-sp--242.kinghost.net (smtpi-sp-242.kinghost.net [177.185.201.242])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp200-farm64.kinghost.net (Postfix) with ESMTPS id 7E00260A5471B;
        Tue, 19 Jun 2018 09:44:10 -0300 (BRT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it [193.205.81.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daniel@bristot.eti.br)
        by smtpi-sp--242.kinghost.net (Postfix) with ESMTPSA id BEB0E600320B;
        Tue, 19 Jun 2018 09:44:02 -0300 (-03)
Subject: Re: [PATCH v4 1/2] timers: Don't wake ktimersoftd on every tick
To:     Haris Okanovic <haris.okanovic@ni.com>,
        Mike Galbraith <efault@gmx.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20180306233944.11271-1-haris.okanovic@ni.com>
 <1523332961.4827.1.camel@gmx.de>
 <c2664fbe-52e7-1044-e9f9-de4875047ee8@ni.com>
From:   Daniel Bristot de Oliveira <daniel@bristot.me>
Message-ID: <0c3d5147-a2c2-4773-c4f1-af5745a27384@bristot.me>
Date:   Tue, 19 Jun 2018 14:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c2664fbe-52e7-1044-e9f9-de4875047ee8@ni.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SND-ID: E3DhL4HZvWApxdeEu0+R3k19tF2vhIUMcvigv4x0qidpkEMv/61pVU+Ic2kX
        C2E5z/9xJ4WEtUyKW/eV3FZ7zkN1fvCQFye4Vp0qZLm01piczU3HP74rsPbz
        ZXyFMdLIy0bF624020sdR4sNVdkqDbKvfF0l7vWZD6wrBZpS9WMuto9nHuve
        4sYzXwHb4dnblPCyIo+SeCWeGAROmW2xzx82recItwlrJacw1Hfm4+FEw2F7
        UeZgJXPCOFt40Rma+dDN2WtDrMHkhcPFG1WOneOUb8n+kDDWsF6hVDqpCvO4
        btTm2HCpTHVi10khRnMALkBj9zsVDLZ0VWtmVtf0vnQTRz3BjFoVw7Of7VDp
        W4mqEFFGpGxOYj+xYjZe195+1ZqhqxSfVm6mN8H2tv5AmFcdkVryX5524IBA
        T/Yplimtpd4tuuA5UtiVIa/jl8RMU5N+lILkWzNS4RSx3VNp0+iALZIcLZER
        uubJw9Z7RI/JJQmG/UcMOCJT8ZC3E8bU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2018 05:00 PM, Haris Okanovic wrote:
> Hi Mike,
> 
> I haven't tested the patch with wireshark until now. My system also
> hangs shortly after it starts. I'm pretty sure I hit workqueues in my
> earlier tests via the block driver, but it's clearly not whatever
> wireshark is using. I'll look at it and try to post a fix. CCing the
> list to avoid this patch until then.

Hi Haris,

Do we have any update regarding a newer version of this patch?

-- Daniel

> Thanks,
> Haris
> 
> 
> On 04/09/2018 11:02 PM, Mike Galbraith wrote:
>> Hi,
>>
>> Are these patches dead, or are you planning another submission?  I ask
>> because I discovered that with them applied, firing up wireshark hangs
>> the box 100% repeatably, with wireshark never fully initializing.
>>
>> Applying them to an otherwise virgin 4.14.20-rt17 to be sure...
>>
>> crash> bt 6016PID: 6016   TASK: ffff95dd68572180  CPU: 2   COMMAND:
>> "dumpcap"
>>   #0 [ffffb490094f3bc0] __schedule at ffffffffa56d55b9
>>   #1 [ffffb490094f3c40] schedule at ffffffffa56d5a03
>>   #2 [ffffb490094f3c58] schedule_timeout at ffffffffa56d8467
>>   #3 [ffffb490094f3cd8] wait_for_completion at ffffffffa56d6e34
>>   #4 [ffffb490094f3d18] __wait_rcu_gp at ffffffffa50e59cd
>>   #5 [ffffb490094f3d58] synchronize_rcu at ffffffffa50ec14e
>>   #6 [ffffb490094f3d98] packet_set_ring at ffffffffc0c74da0 [af_packet]
>>   #7 [ffffb490094f3e50] packet_setsockopt at ffffffffc0c75d23 [af_packet]
>>   #8 [ffffb490094f3ef8] sys_setsockopt at ffffffffa558a5e2
>>   #9 [ffffb490094f3f30] do_syscall_64 at ffffffffa5001b05
>> #10 [ffffb490094f3f50] entry_SYSCALL_64_after_hwframe at ffffffffa5800065
>>      RIP: 00007f3107a1cfaa  RSP: 00007ffc9745c2e8  RFLAGS: 00000246
>>      RAX: ffffffffffffffda  RBX: 0000000000000001  RCX: 00007f3107a1cfaa
>>      RDX: 0000000000000005  RSI: 0000000000000107  RDI: 0000000000000003
>>      RBP: 000055ae1d8eb470   R8: 000000000000001c   R9: 0000000000000002
>>      R10: 00007ffc9745c350  R11: 0000000000000246  R12: 00007ffc9745c350
>>      R13: 0000000000000000  R14: 000055ae1d8eb200  R15: 000055ae1d8eb2d0
>>      ORIG_RAX: 0000000000000036  CS: 0033  SS: 002b
>> crash> dmesg
>> ...
>> [  483.808197] BUG: workqueue lockup - pool cpus=2 node=0 flags=0x0
>> nice=0 stuck for 52s!
>> [  483.808204] Showing busy workqueues and worker pools:
>> [  483.808206] workqueue events: flags=0x0
>> [  483.808208]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256
>> [  483.808211]     pending: check_corruption
>> [  492.695124] sysrq: SysRq : Trigger a crash
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe
> linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
