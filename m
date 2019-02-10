Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E56C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 13:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF32020855
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 13:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=eikelenboom.it header.i=@eikelenboom.it header.b="Cv7CwK5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfBJND6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 08:03:58 -0500
Received: from server.eikelenboom.it ([91.121.65.215]:36716 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfBJND6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 08:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BoqTyQWT424pOkgo4X/RlF42upn7eht6DZEFa5TVwj0=; b=Cv7CwK5+XxZAt6E65hMZJXzmKI
        BsrpgovZWBp6e3S5zVqOUlotgI6QbgzTSf0habko6RzU3/mvjit7/p1Pchb2oubI+eCrUXQiVohUh
        9QQEkYgxmZAQ7rTI2XKGjm34rvo3Qc1sEptcFEDv97KUYD4yvPBs6+a1+3EhiaL3sHwM=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:44782 helo=[172.16.1.50])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@eikelenboom.it>)
        id 1gsom1-0002yd-5e; Sun, 10 Feb 2019 14:03:53 +0100
Subject: Re: Linux 5.0 regression: rtl8169 / kernel BUG at
 lib/dynamic_queue_limits.c:27!
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
References: <6c389fde-4c8d-300b-8c3c-300d6105c30a@eikelenboom.it>
 <0f605e50-56fe-06b5-9b66-6aed89a608ce@gmail.com>
 <471e550b-c227-22e6-19fd-5f9abd450e5f@eikelenboom.it>
 <1265d424-4943-e571-a74b-b1512ebec179@gmail.com>
 <059e59c6-2264-fd5c-068f-3656e39539c1@eikelenboom.it>
 <140d0df7-1775-5457-aa03-b21ece250a72@gmail.com>
 <e6423f51-42cc-e49f-bb48-85ea922f01b6@gmail.com>
 <aa7eb814-ebf7-ffa5-ce61-317b9bbf2394@gmail.com>
 <6b4e8aa0-03c5-c0a8-439e-77daabb07416@eikelenboom.it>
 <70e9a3fe-158a-c3a2-a427-2343bc6c9031@gmail.com>
 <88b80a6b-42e0-ce4e-8aad-4e23a17c7e65@eikelenboom.it>
 <824acd0b-920c-7554-4a63-d80c7de2a8b6@gmail.com>
 <302dd169-d981-9d8d-99a6-9d1462e913f9@eikelenboom.it>
 <6307e338-c2b6-ea87-ce56-2eb9606d3bfa@gmail.com>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <b9c3afa3-7e02-83dd-94f9-c62677e00399@eikelenboom.it>
Date:   Sun, 10 Feb 2019 14:05:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <6307e338-c2b6-ea87-ce56-2eb9606d3bfa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2019 12:44, Heiner Kallweit wrote:
> On 10.02.2019 10:16, Sander Eikelenboom wrote:
>> On 09/02/2019 12:50, Heiner Kallweit wrote:
>>> On 09.02.2019 11:07, Sander Eikelenboom wrote:
>>>> On 09/02/2019 10:59, Heiner Kallweit wrote:
>>>>> On 09.02.2019 10:34, Sander Eikelenboom wrote:
>>>>>> On 09/02/2019 10:02, Heiner Kallweit wrote:
>>>>>>> On 09.02.2019 00:09, Eric Dumazet wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 02/08/2019 01:50 PM, Heiner Kallweit wrote:
>>>>>>>>> On 08.02.2019 22:45, Sander Eikelenboom wrote:
>>>>>>>>>> On 08/02/2019 22:22, Heiner Kallweit wrote:
>>>>>>>>>>> On 08.02.2019 21:55, Sander Eikelenboom wrote:
>>>>>>>>>>>> On 08/02/2019 19:52, Heiner Kallweit wrote:
>>>>>>>>>>>>> On 08.02.2019 19:29, Sander Eikelenboom wrote:
>>>>>>>>>>>>>> L.S.,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> While testing a linux 5.0-rc5 kernel (with some patches on top but they don't seem related) under Xen i the nasty splat below, 
>>>>>>>>>>>>>> that I haven encountered with Linux 4.20.x.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Unfortunately I haven't got a clear reproducer for this and bisecting could be nasty due to another (networking related) kernel bug.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> If you need more info, want me to run a debug patch etc., please feel free to ask.
>>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks for the report. However I see no change in the r8169 driver between
>>>>>>>>>>>>> 4.20 and 5.0 with regard to BQL code. Having said that the root cause could
>>>>>>>>>>>>> be somewhere else. Therefore I'm afraid a bisect will be needed.
>>>>>>>>>>>>
>>>>>>>>>>>> Hmm i did some diging and i think:
>>>>>>>>>>>> bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 r8169: remove unneeded mmiowb barriers
>>>>>>>>>>>> 2e6eedb4813e34d8d84ac0eb3afb668966f3f356 r8169: make use of xmit_more and __netdev_sent_queue
>>>>>>>>>>>> 620344c43edfa020bbadfd81a144ebe5181fc94f net: core: add __netdev_sent_queue as variant of __netdev_tx_sent_queue
>>>>>>>>>>>>
>>>>>>>>>>> You're right. Thought this was added in 4.20 already.
>>>>>>>>>>> The BQL code pattern I copied from the mlx4 driver and so far I haven't heard about
>>>>>>>>>>> this issue from any user of physical hw. And due to the fact that a lot of mainboards
>>>>>>>>>>> have onboard Realtek network I have quite a few testers out there.
>>>>>>>>>>> Does the issue occur under specific circumstances like very high load?
>>>>>>>>>>
>>>>>>>>>> Yep, the box is already quite contented with the Xen VM's and if I remember correctly it occurred while kernel compiling
>>>>>>>>>> on the host.
>>>>>>>>>>
>>>>>>>>>>> If indeed the xmit_more patch causes the issue, I think we have to involve Eric Dumazet
>>>>>>>>>>> as author of the underlying changes.
>>>>>>>>>>
>>>>>>>>>> It could also be the barriers weren't that unneeded as assumed.
>>>>>>>>>
>>>>>>>>> The barriers were removed after adding xmit_more handling. Therefore it would be good to
>>>>>>>>> test also with only 
>>>>>>>>> bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 r8169: remove unneeded mmiowb barriers
>>>>>>>>> removed.
>>>>>>>>>
>>>>>>>>>> Since we are almost at RC6 i took the liberty to CC Eric now.
>>>>>>>>>>
>>>>>>>>> Sure, thanks.
>>>>>>>>>
>>>>>>>>>> BTW am i correct these patches are merely optimizations ?
>>>>>>>>>
>>>>>>>>> Yes
>>>>>>>>>
>>>>>>>>>> If so and concluding they revert cleanly, perhaps it should be considered at this point in the RC's
>>>>>>>>>> to revert them for 5.0 and try again for 5.1 ?
>>>>>>>>>>
>>>>>>>>> Before removing both it would be good to test with only the barrier-removal removed.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Commit 2e6eedb4813e34d8d84ac0eb3afb668966f3f356 r8169: make use of xmit_more and __netdev_sent_queue
>>>>>>>> looks buggy to me, since the skb might have been freed already on another cpu when you call
>>>>>>>>
>>>>>>>> You could try :
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
>>>>>>>> index 3624e67aef72c92ed6e908e2c99ac2d381210126..f907d484165d9fd775e81bf2bfb9aa4ddedb1c93 100644
>>>>>>>> --- a/drivers/net/ethernet/realtek/r8169.c
>>>>>>>> +++ b/drivers/net/ethernet/realtek/r8169.c
>>>>>>>> @@ -6070,6 +6070,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>>>>>>>>         dma_addr_t mapping;
>>>>>>>>         u32 opts[2], len;
>>>>>>>>         bool stop_queue;
>>>>>>>> +       bool door_bell;
>>>>>>>>         int frags;
>>>>>>>>  
>>>>>>>>         if (unlikely(!rtl_tx_slots_avail(tp, skb_shinfo(skb)->nr_frags))) {
>>>>>>>> @@ -6116,6 +6117,8 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>>>>>>>>         /* Force memory writes to complete before releasing descriptor */
>>>>>>>>         dma_wmb();
>>>>>>>>  
>>>>>>>> +       door_bell = __netdev_sent_queue(dev, skb->len, skb->xmit_more);
>>>>>>>> +
>>>>>>>>         txd->opts1 = rtl8169_get_txd_opts1(opts[0], len, entry);
>>>>>>>>  
>>>>>>>>         /* Force all memory writes to complete before notifying device */
>>>>>>>> @@ -6127,7 +6130,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>>>>>>>>         if (unlikely(stop_queue))
>>>>>>>>                 netif_stop_queue(dev);
>>>>>>>>  
>>>>>>>> -       if (__netdev_sent_queue(dev, skb->len, skb->xmit_more)) {
>>>>>>>> +       if (door_bell) {
>>>>>>>>                 RTL_W8(tp, TxPoll, NPQ);
>>>>>>>>                 mmiowb();
>>>>>>>>         }
>>>>>>>>
>>>>>>> Thanks a lot for checking and for the proposed fix.
>>>>>>> Sander, can you try with this patch on top of 5.0-rc5 w/o removing two two commits?
>>>>>>
>>>>>> I have done that already during the night .. the results:
>>>>>> - I can confirm 2e6eedb4813e34d8d84ac0eb3afb668966f3f356 is the first commit which causes hitting the BUG_ON in lib/dynamic_queue_limits.c.
>>>>>>   (in other word, with only reverting bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 it still blows up).
>>>>>>
>>>>>> - The Eric's patch only applies cleanly with bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 reverted, so that's what I tested.
>>>>>>   The patch seems to prevent hitting the BUG_ON in lib/dynamic_queue_limits.c, it has run this night and I gave done a few kernel compiles
>>>>>>   this morning. How ever during these kernel compiles i'm getting a transmit queue timeout which i haven't seen with 4.20.x, although i regularly
>>>>>>   compile kernels in the same way as I do now. The only thing I can't say if that is due to this change, or if it's again something else.
>>>>>>   Which makes me somewhat inclined to go testing the complete revert some more and see if I can trigger the queue timeout on that or not.
>>>>>>
>>>>>>   If I can, it is a separate issue.
>>>>>>   If I can't it seems even with a patch it still seems as a regression in comparison with 4.20.x, for which
>>>>>>   a revert would be the right thing to do (since as you indicated these are merely optimizations), 
>>>>>>   which would give us more time for 5.1 to try to solve things on top of the 5.0-release-to-be.
>>>>>>   (especially since I seem to still have other issues which need to be sorted out and time is limited)
>>>>>>
>>>>>>   The timeout in question:
>>>>>>         [28336.869479] NETDEV WATCHDOG: eth1 (r8169): transmit queue 0 timed out
>>>>>>         [28336.881498] WARNING: CPU: 0 PID: 6925 at net/sched/sch_generic.c:461 dev_watchdog+0x20b/0x210
>>>>>>         [28336.893358] Modules linked in:
>>>>>>         [28336.904106] CPU: 0 PID: 6925 Comm: cc1 Tainted: G      D           5.0.0-rc5-20190208-thp-net-florian-rtl8169-eric-doflr+ #1
>>>>>>         [28336.917385] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
>>>>>>         [28336.928988] RIP: e030:dev_watchdog+0x20b/0x210
>>>>>>         [28336.940623] Code: 00 49 63 4e e0 eb 90 4c 89 e7 c6 05 ad d8 f1 00 01 e8 a9 32 fd ff 89 d9 48 89 c2 4c 89 e6 48 c7 c7 50 59 89 82 e8 e5 92 4d ff <0f> 0b eb c0 90 48 c7 47 08 00 00 00 00 48 c7 07 00 00 00 00 0f b7
>>>>>>         [28336.965265] RSP: e02b:ffff88807d403ea0 EFLAGS: 00010286
>>>>>>         [28336.977465] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82a69db8
>>>>>>         [28336.991265] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 0000000000000200
>>>>>>         [28337.008865] RBP: ffff88807936e41c R08: 0000000000000000 R09: 0000000000000819
>>>>>>         [28337.022250] R10: 0000000000000202 R11: ffffffff8247ca80 R12: ffff88807936e000
>>>>>>         [28337.035204] R13: 0000000000000000 R14: ffff88807936e440 R15: 0000000000000001
>>>>>>         [28337.049832] FS:  00007f53e9bf3840(0000) GS:ffff88807d400000(0000) knlGS:0000000000000000
>>>>>>         [28337.062524] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>>         [28337.075086] CR2: 00007f53e60c4000 CR3: 000000001a0be000 CR4: 0000000000000660
>>>>>>         [28337.090052] Call Trace:
>>>>>>         [28337.103615]  <IRQ>
>>>>>>         [28337.116587]  ? qdisc_destroy+0x120/0x120
>>>>>>         [28337.128905]  call_timer_fn+0x19/0x90
>>>>>>         [28337.141892]  expire_timers+0x8b/0xa0
>>>>>>         [28337.153354]  run_timer_softirq+0x7e/0x160
>>>>>>         [28337.165931]  ? handle_irq_event_percpu+0x4c/0x70
>>>>>>         [28337.176548]  ? handle_percpu_irq+0x32/0x50
>>>>>>         [28337.186734]  __do_softirq+0xed/0x229
>>>>>>         [28337.196404]  ? hypervisor_callback+0xa/0x20
>>>>>>         [28337.207822]  irq_exit+0xb7/0xc0
>>>>>>         [28337.218978]  xen_evtchn_do_upcall+0x27/0x40
>>>>>>         [28337.230763]  xen_do_hypervisor_callback+0x29/0x40
>>>>>>         [28337.241261]  </IRQ>
>>>>>>         [28337.253283] RIP: e033:0xff7e62
>>>>>>         [28337.264899] Code: 35 43 0f c7 00 4c 89 ef e8 8b 6d 67 ff 0f 1f 00 44 89 e0 44 89 e2 c1 e8 06 83 e2 3f 48 8b 0c c5 40 8d c6 01 48 0f a3 d1 72 0e <48> 8b 04 c5 50 8d c6 01 48 0f a3 d0 73 0b 44 89 e6 4c 89 ef e8 b5
>>>>>>         [28337.288677] RSP: e02b:00007fff0fc6a340 EFLAGS: 00000202
>>>>>>         [28337.299234] RAX: 0000000000000000 RBX: 00007f53e60c3580 RCX: 0000000000000000
>>>>>>         [28337.309577] RDX: 0000000000000034 RSI: 0000000001e71a98 RDI: 00007fff0fc6a538
>>>>>>         [28337.320724] RBP: 00007fff0fc6a4b0 R08: 0000000000000000 R09: 0000000000000000
>>>>>>         [28337.331829] R10: 0000000000000001 R11: 00000000020cb3d0 R12: 0000000000000034
>>>>>>         [28337.343900] R13: 00007fff0fc6a538 R14: 0000000000000000 R15: 0000000000000001
>>>>>>         [28337.353977] ---[ end trace 6ff49f09286816b7 ]---
>>>>>>
>>>>> Thanks for your efforts. As usual this tx timeout trace says basically nothing except
>>>>> "timeout" and root cause could be anything. Earlier you reported a memory allocation error,
>>>>> did that occur again?
>>>>> If we decide to revert, I'd leave removal of the memory barriers in (as it doesn't seem to
>>>>> contribute to the issue) and just submit a patch to effectively revert
>>>>> 2e6eedb4813e34d8d84ac0eb3afb668966f3f356.
>>>>
>>>> I can't say if that is correct, because i haven't tested that.
>>>>
>>>> Another thing I could test is:
>>>>  - putting all the r8169 patches (and prerequisites) that went into 5.0 
>>>>    up to bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3, onto 4.20.7 and see what that does.
>>>>    If that would be feasible (not too many needed prerequisites out of r8169) and if 
>>>>    you could spare me some time and prep such a branch somewhere so i can pull and compile that,
>>>>    that would be great.
>>>>
>>>
>>> Unfortunately there's quite a number of changes. Regarding __netdev_tx_sent_queue()
>>> and watchdog timeout I found the following comment in drivers/net/ethernet/sfc/tx.c,
>>> efx_enqueue_skb():
>>>
>>> 	if (__netdev_tx_sent_queue(tx_queue->core_txq, skb_len, xmit_more)) {
>>> 		struct efx_tx_queue *txq2 = efx_tx_queue_partner(tx_queue);
>>>
>>> 		/* There could be packets left on the partner queue if those
>>> 		 * SKBs had skb->xmit_more set. If we do not push those they
>>> 		 * could be left for a long time and cause a netdev watchdog.
>>> 		 */
>>> 		if (txq2->xmit_more_available)
>>> 			efx_nic_push_buffers(txq2);
>>>
>>> But I'm not sure whether the situation in r8169 is comparable. The following patch
>>> implements what I mentioned earlier: It leaves all other 5.0 changes in place and
>>> effectively reverts 2e6eedb4813e34d8d84ac0eb3afb668966f3f356. Would be great if
>>> you could give it a try.
>>
>> Hi Heiner,
>>
>> It took some time to respond, because I had another issue with 5.0 which intervened with proper testing, 
>> but fortunately I could pinpoint without doing a full bisect and revert that commit for further testing.
>>
>> So there is still time left and I could do a more proper run with your patch below.
>> Unfortunately i still get a splat (see below) with this, although i'm not sure it is related, 
>> just that I can't tell.
>>
> I checked further and there's a handful of network drivers using __napi_alloc_skb() with __GFP_NOWARN,
> maybe to avoid such splats. Did the splat impact functionality? When checking the code in r8169 the
> affected packet would just be dropped.

It doesn't permanently or noticeably impact functionality, and indeed seems to drop packets:

eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.16.1.1  netmask 255.255.0.0  broadcast 172.16.255.255
        ether 40:61:86:f4:67:d8  txqueuelen 1000  (Ethernet)
        RX packets 11563913  bytes 16724445852 (15.5 GiB)
        RX errors 0  dropped 6  overruns 0  frame 0
        TX packets 4301515  bytes 1210966808 (1.1 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

Reverting 5317d5c6d47e ("r8169: use napi_consume_skb where possible") doesn't suffice still gives the page allocation failure.

I think at this point in time we should at least get the
reverts into 5.0 (probably to late for rc-6 since DaveM's pull request is already in) for:
    bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 r8169: remove unneeded mmiowb barriers
    2e6eedb4813e34d8d84ac0eb3afb668966f3f356 r8169: make use of xmit_more and __netdev_sent_queue

Commit 2e6eedb4813e34d8d84ac0eb3afb668966f3f356 is the one which caused the BUG_ON() to be hit.

While we could use your patch to revert only 2e6eedb4813e34d8d84ac0eb3afb668966f3f356 and leave
bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 in:
    - I haven't been able to test it properly.
    - It's dealing with barriers, which can be tedious and give subtle breakage.
    - I don't see any compelling argument to keep it in (it's no fix).
    - It's RC-6 time ...

So we then we can focus on the page allocation issue and hopefully find some stable
baseline before 5.0-final is cut. While I appreciate having a forward looking approach,
I think we are at the point in time, were we should revert when in doubt 
(and it doesn't clearly fix an other issue).

After establishing a stable baseline again, we can start incrementally re-applying and test stuff.

--
Sander



>> Perhaps Linus as Oops-decoding-guru has an idea ?
>>
>> --
>> Sander
>>
>> [39041.689007] dpkg-deb: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0
>> [39041.689016] CPU: 4 PID: 14078 Comm: dpkg-deb Not tainted 5.0.0-rc5-20190209-kallweit+ #1
>> [39041.689017] Hardware name: MSI MS-7640/890FXA-GD70 (MS-7640)  , BIOS V1.8B1 09/13/2010
>> [39041.689018] Call Trace:
>> [39041.689022]  <IRQ>
>> [39041.689030]  dump_stack+0x5c/0x7b
>> [39041.689033]  warn_alloc+0x103/0x190
>> [39041.689036]  __alloc_pages_nodemask+0xe3d/0xe80
>> [39041.689039]  ? ip_rcv+0x48/0xc0
>> [39041.689040]  ? ip_rcv_finish_core.isra.0+0x360/0x360
>> [39041.689042]  page_frag_alloc+0x117/0x150
>> [39041.689044]  __napi_alloc_skb+0x83/0xd0
>> [39041.689048]  rtl8169_poll+0x210/0x640
>> [39041.689051]  net_rx_action+0x23d/0x370
>> [39041.689054]  __do_softirq+0xed/0x229
>> [39041.689058]  irq_exit+0xb7/0xc0
>> [39041.689061]  xen_evtchn_do_upcall+0x27/0x40
>> [39041.689063]  xen_do_hypervisor_callback+0x29/0x40
>> [39041.689064]  </IRQ>
>> [39041.689066] RIP: e030:_atomic_dec_and_lock+0x2/0x40
>> [39041.689068] Code: ff 39 05 c5 c1 c9 00 89 c7 89 c6 76 0f 83 eb 01 83 fb ff 75 d9 5b 89 f8 5d 41 5c c3 0f 0b 90 90 90 90 90 90 90 90 90 90 8b 07 <83> f8 01 74 0c 8d 50 ff f0 0f b1 17 75 f2 31 c0 c3 55 53 48 89 fb
>> [39041.689069] RSP: e02b:ffffc9000705b990 EFLAGS: 00000246
>> [39041.689071] RAX: 0000000000000001 RBX: ffff888017082640 RCX: 0000000000000000
>> [39041.689071] RDX: 0000000000000000 RSI: ffff8880170826c0 RDI: ffff888017082788
>> [39041.689072] RBP: ffff8880170826c0 R08: ffffc9000705bb00 R09: ffffc9000705bb00
>> [39041.689073] R10: ffffc9000705bb58 R11: ffff88807fc17000 R12: ffff888017082788
>> [39041.689073] R13: ffff88806cc8cf58 R14: ffff888017082640 R15: ffff888009990240
>> [39041.689077]  iput+0x63/0x1a0
>> [39041.689079]  __dentry_kill+0xc5/0x170
>> [39041.689080]  shrink_dentry_list+0x93/0x1c0
>> [39041.689082]  prune_dcache_sb+0x4d/0x70
>> [39041.689084]  super_cache_scan+0x104/0x190
>> [39041.689087]  do_shrink_slab+0x12c/0x1e0
>> [39041.689089]  shrink_slab+0xdf/0x2b0
>> [39041.689091]  shrink_node+0x158/0x470
>> [39041.689093]  do_try_to_free_pages+0xd1/0x380
>> [39041.689095]  try_to_free_pages+0xb2/0xe0
>> [39041.689097]  __alloc_pages_nodemask+0x603/0xe80
>> [39041.689099]  ? __pagevec_lru_add_fn+0x1b1/0x290
>> [39041.689102]  alloc_pages_vma+0x7b/0x1c0
>> [39041.689106]  __handle_mm_fault+0xdb3/0x1060
>> [39041.689109]  ? xen_mc_flush+0xc0/0x190
>> [39041.689110]  handle_mm_fault+0xf8/0x200
>> [39041.689113]  __do_page_fault+0x231/0x4a0
>> [39041.689115]  ? page_fault+0x8/0x30
>> [39041.689116]  page_fault+0x1e/0x30
>> [39041.689118] RIP: e033:0x7fb9851d012e
>> [39041.689119] Code: 29 c2 48 3b 15 7b a3 31 00 0f 87 af 00 00 00 0f 10 01 0f 10 49 f0 0f 10 51 e0 0f 10 59 d0 48 83 e9 40 48 83 ea 40 41 0f 29 01 <41> 0f 29 49 f0 41 0f 29 51 e0 41 0f 29 59 d0 49 83 e9 40 48 83 fa
>> [39041.689119] RSP: e02b:00007fb958b36d38 EFLAGS: 00010202
>> [39041.689120] RAX: 00007fb97a617f0e RBX: 000000000000f004 RCX: 00007fb948008be3
>> [39041.689121] RDX: 00000000000080c2 RSI: 00007fb948000b31 RDI: 00007fb97a617f0e
>> [39041.689122] RBP: 00000000000ff062 R08: 0000000000000002 R09: 00007fb97a620000
>> [39041.689123] R10: 0000000000000004 R11: 00007fb97a626f02 R12: 000000000000f005
>> [39041.689123] R13: 00007fb948000b28 R14: 0000562d76b63710 R15: 0000000000000003
>> [39041.689125] Mem-Info:
>> [39041.689130] active_anon:78775 inactive_anon:49211 isolated_anon:0
>>                 active_file:106409 inactive_file:107531 isolated_file:0
>>                 unevictable:552 dirty:175 writeback:0 unstable:0
>>                 slab_reclaimable:13739 slab_unreclaimable:16454
>>                 mapped:1605 shmem:23 pagetables:2900 bounce:0
>>                 free:3681 free_pcp:935 free_cma:0
>> [39041.689132] Node 0 active_anon:315100kB inactive_anon:196844kB active_file:425636kB inactive_file:430124kB unevictable:2208kB isolated(anon):0kB isolated(file):0kB mapped:6420kB dirty:700kB writeback:0kB shmem:92kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
>> [39041.689133] Node 0 DMA free:7480kB min:44kB low:56kB high:68kB active_anon:0kB inactive_anon:7832kB active_file:472kB inactive_file:4kB unevictable:0kB writepending:0kB present:15956kB managed:15872kB mlocked:0kB kernel_stack:0kB pagetables:12kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
>> [39041.689136] lowmem_reserve[]: 0 1865 1865 1865
>> [39041.689138] Node 0 DMA32 free:7244kB min:19472kB low:21380kB high:23288kB active_anon:315360kB inactive_anon:188144kB active_file:425164kB inactive_file:430120kB unevictable:2208kB writepending:700kB present:2080768kB managed:1674968kB mlocked:2208kB kernel_stack:9632kB pagetables:11588kB bounce:0kB free_pcp:3740kB local_pcp:528kB free_cma:0kB
>> [39041.689140] lowmem_reserve[]: 0 0 0 0
>> [39041.689142] Node 0 DMA: 6*4kB (UME) 6*8kB (UE) 7*16kB (UME) 6*32kB (ME) 5*64kB (UME) 3*128kB (UE) 5*256kB (UME) 2*512kB (ME) 2*1024kB (UE) 1*2048kB (M) 0*4096kB = 7480kB
>> [39041.689148] Node 0 DMA32: 69*4kB (U) 315*8kB (UE) 138*16kB (UE) 70*32kB (UE) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 7244kB
>> [39041.689153] 214701 total pagecache pages
>> [39041.689155] 273 pages in swap cache
>> [39041.689156] Swap cache stats: add 100978, delete 100706, find 1158/1257
>> [39041.689156] Free swap  = 3790588kB
>> [39041.689157] Total swap = 4194300kB
>> [39041.689157] 524181 pages RAM
>> [39041.689158] 0 pages HighMem/MovableOnly
>> [39041.689158] 101471 pages reserved
>> [39041.689159] 0 pages cma reserved
>>
>>
>>
>>
>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
>>> index e8a112149..3cca2ffb2 100644
>>> --- a/drivers/net/ethernet/realtek/r8169.c
>>> +++ b/drivers/net/ethernet/realtek/r8169.c
>>> @@ -6192,7 +6192,6 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>>>  	struct device *d = tp_to_dev(tp);
>>>  	dma_addr_t mapping;
>>>  	u32 opts[2], len;
>>> -	bool stop_queue;
>>>  	int frags;
>>>  
>>>  	if (unlikely(!rtl_tx_slots_avail(tp, skb_shinfo(skb)->nr_frags))) {
>>> @@ -6234,6 +6233,8 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>>>  
>>>  	txd->opts2 = cpu_to_le32(opts[1]);
>>>  
>>> +	netdev_sent_queue(dev, skb->len);
>>> +
>>>  	skb_tx_timestamp(skb);
>>>  
>>>  	/* Force memory writes to complete before releasing descriptor */
>>> @@ -6246,14 +6247,14 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>>>  
>>>  	tp->cur_tx += frags + 1;
>>>  
>>> -	stop_queue = !rtl_tx_slots_avail(tp, MAX_SKB_FRAGS);
>>> -	if (unlikely(stop_queue))
>>> -		netif_stop_queue(dev);
>>> -
>>> -	if (__netdev_sent_queue(dev, skb->len, skb->xmit_more))
>>> -		RTL_W8(tp, TxPoll, NPQ);
>>> +	RTL_W8(tp, TxPoll, NPQ);
>>>  
>>> -	if (unlikely(stop_queue)) {
>>> +	if (!rtl_tx_slots_avail(tp, MAX_SKB_FRAGS)) {
>>> +		/* Avoid wrongly optimistic queue wake-up: rtl_tx thread must
>>> +		 * not miss a ring update when it notices a stopped queue.
>>> +		 */
>>> +		smp_wmb();
>>> +		netif_stop_queue(dev);
>>>  		/* Sync with rtl_tx:
>>>  		 * - publish queue status and cur_tx ring index (write barrier)
>>>  		 * - refresh dirty_tx ring index (read barrier).
>>>
>>
>>
> 

