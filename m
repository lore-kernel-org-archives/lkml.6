Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFA4C32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 02:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64942082D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 02:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6x9dKCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64942082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeKCLM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 07:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbeKCLM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 07:12:56 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB43B2082D;
        Sat,  3 Nov 2018 02:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541210600;
        bh=DVyfJiNMPFmLT8oHmrKpLDvgCalTYuZbY1PdPOU5ZLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6x9dKCDo91eUFBHHgZ7V49dpy3SDySQQnMZ0kzIOM2yQQTVkFU502Z3k28Y08H5j
         qMkiiIICk4obeEcmP2e6VQctQoNg0AZVnvH7Ak7NBMZiiJGMLnc8f1HFuyJ4SSYWv8
         Jjyk6fj2o/hw0NQI6Npp96c6P/IRRIQ3X/e67xBE=
Date:   Fri, 2 Nov 2018 22:03:18 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Josh Hunt <joshhunt00@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, stephen@networkplumber.org,
        Eric Dumazet <edumazet@google.com>, soheil@google.com,
        weiwan@google.com, willemb@google.com, cpaasch@apple.com
Subject: Re: [PATCH 4.14 106/143] sch_netem: restore skb->dev after dequeuing
 from the rbtree
Message-ID: <20181103020318.GL194472@sasha-vm>
References: <20181102182857.064326086@linuxfoundation.org>
 <20181102182906.323035183@linuxfoundation.org>
 <CAKA=qzYeSO=aEodWHjJMn1yf-VQUZrfOS95D0H8FcEwUb2Xi+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKA=qzYeSO=aEodWHjJMn1yf-VQUZrfOS95D0H8FcEwUb2Xi+w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:28:04PM -0700, Josh Hunt wrote:
>On Fri, Nov 2, 2018 at 12:00 PM Greg Kroah-Hartman
><gregkh@linuxfoundation.org> wrote:
>>
>> 4.14-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> Upstream commit bffa72cf7f9d ("net: sk_buff rbnode reorg") got
>> backported as commit 6b921536f170 ("net: sk_buff rbnode reorg") into the
>> v4.14.x-tree.
>>
>> However, the backport does not include the changes in sch_netem.c
>>
>> We need these, as otherwise the skb->dev pointer is not set when
>> dequeueing from the netem rbtree, resulting in a panic:
>>
>> [   15.427748] BUG: unable to handle kernel NULL pointer dereference at 00000000000000d0
>> [   15.428863] IP: netif_skb_features+0x24/0x230
>> [   15.429402] PGD 0 P4D 0
>> [   15.429733] Oops: 0000 [#1] SMP PTI
>> [   15.430169] Modules linked in:
>> [   15.430614] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.14.77.mptcp #77
>> [   15.431497] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.5.1 01/01/2011
>> [   15.432568] task: ffff88042db19680 task.stack: ffffc90000070000
>> [   15.433356] RIP: 0010:netif_skb_features+0x24/0x230
>> [   15.433977] RSP: 0018:ffff88043fd83e70 EFLAGS: 00010286
>> [   15.434665] RAX: ffff880429ad80c0 RBX: ffff88042bd0e400 RCX: ffff880429ad8000
>> [   15.435585] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88042bd0e400
>> [   15.436551] RBP: ffff88042bd0e400 R08: ffff88042a4b6c9c R09: 0000000000000001
>> [   15.437485] R10: 0000000000000004 R11: 0000000000000000 R12: ffff88042c700000
>> [   15.438393] R13: ffff88042c700000 R14: ffff88042a4b6c00 R15: ffff88042c6bb000
>> [   15.439315] FS:  0000000000000000(0000) GS:ffff88043fd80000(0000) knlGS:0000000000000000
>> [   15.440314] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   15.441084] CR2: 00000000000000d0 CR3: 000000042c374000 CR4: 00000000000006e0
>> [   15.442016] Call Trace:
>> [   15.442333]  <IRQ>
>> [   15.442596]  validate_xmit_skb+0x17/0x270
>> [   15.443134]  validate_xmit_skb_list+0x38/0x60
>> [   15.443698]  sch_direct_xmit+0x102/0x190
>> [   15.444198]  __qdisc_run+0xe3/0x240
>> [   15.444671]  net_tx_action+0x121/0x140
>> [   15.445177]  __do_softirq+0xe2/0x224
>> [   15.445654]  irq_exit+0xbf/0xd0
>> [   15.446072]  smp_apic_timer_interrupt+0x5d/0x90
>> [   15.446654]  apic_timer_interrupt+0x7d/0x90
>> [   15.447185]  </IRQ>
>> [   15.447460] RIP: 0010:native_safe_halt+0x2/0x10
>> [   15.447992] RSP: 0018:ffffc90000073f10 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff10
>> [   15.449008] RAX: ffffffff816667d0 RBX: ffffffff820946b0 RCX: 0000000000000000
>> [   15.449895] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> [   15.450768] RBP: ffffffff82026940 R08: 00000004e858e5e1 R09: ffff88042a4b6d58
>> [   15.451643] R10: 0000000000000000 R11: 000000d0d56879bb R12: 0000000000000000
>> [   15.452478] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> [   15.453340]  ? __sched_text_end+0x2/0x2
>> [   15.453835]  default_idle+0xf/0x20
>> [   15.454259]  do_idle+0x170/0x200
>> [   15.454653]  cpu_startup_entry+0x14/0x20
>> [   15.455142]  secondary_startup_64+0xa5/0xb0
>> [   15.455715] Code: 1f 84 00 00 00 00 00 55 53 48 89 fd 48 83 ec 08 8b 87 bc 00 00 00 48 8b 8f c0 00 00 00 0f b6 97 81 00 00 00 48 8b 77 10 48 01 c8 <48> 8b 9
>> [   15.458138] RIP: netif_skb_features+0x24/0x230 RSP: ffff88043fd83e70
>> [   15.458933] CR2: 00000000000000d0
>> [   15.459352] ---[ end trace 083925903ae60570 ]---
>>
>> Fixes: 6b921536f170 ("net: sk_buff rbnode reorg")
>> Cc: Stephen Hemminger <stephen@networkplumber.org>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Soheil Hassas Yeganeh <soheil@google.com>
>> Cc: Wei Wang <weiwan@google.com>
>> Cc: Willem de Bruijn <willemb@google.com>
>> Signed-off-by: Christoph Paasch <cpaasch@apple.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  net/sched/sch_netem.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
>> index 2a2ab6bfe5d8..3d325b840802 100644
>> --- a/net/sched/sch_netem.c
>> +++ b/net/sched/sch_netem.c
>> @@ -624,6 +624,10 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
>>                         skb->next = NULL;
>>                         skb->prev = NULL;
>>                         skb->tstamp = netem_skb_cb(skb)->tstamp_save;
>> +                       /* skb->dev shares skb->rbnode area,
>> +                        * we need to restore its value.
>> +                        */
>> +                       skb->dev = qdisc_dev(sch);
>>
>>  #ifdef CONFIG_NET_CLS_ACT
>>                         /*
>> --
>> 2.17.1
>
>I was seeing this crash on 4.14.78 and this patch fixes it.
>
>Thanks!

Thanks for confirming Josh!

--
Thanks,
Sasha
