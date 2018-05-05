Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeEECdt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 22:33:49 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40626 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbeEECdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 22:33:47 -0400
X-Google-Smtp-Source: AB8JxZrfgaMT53br0KRJn+E9HDKKIJPX99MbhZ4Mo+/pQ6azDtMdYriSFU/4aGa8z45VDVU1vvAQUg==
Subject: Re: [v2 PATCH 1/1] tg3: fix meaningless hw_stats reading after
 tg3_halt memset 0 hw_stats
To: Michael Chan <michael.chan@broadcom.com>
References: <20180502004234.230662-1-zumeng.chen@gmail.com>
 <CACKFLikg+p_1iDQtd0XN8tJaKtAgX0jfxGXuoqxhDJZ922UkUg@mail.gmail.com>
 <5af186f8-9718-c295-4e34-e84dd78ea157@gmail.com>
 <CACKFLinOzi+F9j+gbBHjkGdMdXTqpfMRLUwqx=zUpVg76zGxNA@mail.gmail.com>
 <8f73e98f-0c55-2d96-a1b7-0890bf90bf41@gmail.com>
 <CACKFLi=Rv_+Gig5UpdnpbOPcyLyGr3TYGUbFEmeGcZWAk3YZRQ@mail.gmail.com>
Cc: Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        "prashant.sreedharan@broadcom.com" <prashant@broadcom.com>,
        David Miller <davem@davemloft.net>
From: Zumeng Chen <zumeng.chen@gmail.com>
Message-ID: <38cee318-ef18-18fb-80c2-780718ef12f9@gmail.com>
Date: Sat, 5 May 2018 10:40:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACKFLi=Rv_+Gig5UpdnpbOPcyLyGr3TYGUbFEmeGcZWAk3YZRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2018 01:04 PM, Michael Chan wrote:
> On Wed, May 2, 2018 at 5:30 PM, Zumeng Chen <zumeng.chen@gmail.com> wrote:
>> On 2018年05月03日 01:32, Michael Chan wrote:
>>> On Wed, May 2, 2018 at 3:27 AM, Zumeng Chen <zumeng.chen@gmail.com> wrote:
>>>> On 2018年05月02日 13:12, Michael Chan wrote:
>>>>> On Tue, May 1, 2018 at 5:42 PM, Zumeng Chen <zumeng.chen@gmail.com>
>>>>> wrote:
>>>>>
>>>>>> diff --git a/drivers/net/ethernet/broadcom/tg3.h
>>>>>> b/drivers/net/ethernet/broadcom/tg3.h
>>>>>> index 3b5e98e..c61d83c 100644
>>>>>> --- a/drivers/net/ethernet/broadcom/tg3.h
>>>>>> +++ b/drivers/net/ethernet/broadcom/tg3.h
>>>>>> @@ -3102,6 +3102,7 @@ enum TG3_FLAGS {
>>>>>>            TG3_FLAG_ROBOSWITCH,
>>>>>>            TG3_FLAG_ONE_DMA_AT_ONCE,
>>>>>>            TG3_FLAG_RGMII_MODE,
>>>>>> +       TG3_FLAG_HALT,
>>>>> I think you should be able to use the existing INIT_COMPLETE flag
>>>>
>>>> No,  it will bring the uncertain factors into the existed complicate
>>>> logic
>>>> of INIT_COMPLETE.
>>>> And I think it's very simple logic here to fix the meaningless hw_stats
>>>> reading and the problem
>>>> of commit f5992b72. I even suspect if you have read INIT_COMPLETE related
>>>> codes carefully.
>>>>
>>> We should use an existing flag whenever appropriate
>>
>> I disagree. This is sort of blahblah...
> I don't want to see another flag added that is practically the same as
> !INIT_COMPLETE.  The driver already has close to one hundred flags.
> Adding a new flag that is similar to an existing flag will just make
> the code more difficult to understand and maintain.
>
> If you don't want to fix it the cleaner way, Siva or I will fix it.

Feel free to go, I just take a double look, INIT_COMPLETE can directly 
be used as follows:

diff --git a/drivers/net/ethernet/broadcom/tg3.c 
b/drivers/net/ethernet/broadcom/tg3.c
index 08bbb63..0e04fd7 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -8733,14 +8733,11 @@ static void tg3_free_consistent(struct tg3 *tp)
         tg3_mem_rx_release(tp);
         tg3_mem_tx_release(tp);

-       /* Protect tg3_get_stats64() from reading freed tp->hw_stats. */
-       tg3_full_lock(tp, 0);
         if (tp->hw_stats) {
                 dma_free_coherent(&tp->pdev->dev, sizeof(struct 
tg3_hw_stats),
                                   tp->hw_stats, tp->stats_mapping);
                 tp->hw_stats = NULL;
         }
-       tg3_full_unlock(tp);
  }

  /*
@@ -14178,7 +14175,7 @@ static void tg3_get_stats64(struct net_device *dev,
         struct tg3 *tp = netdev_priv(dev);

         spin_lock_bh(&tp->lock);
-       if (!tp->hw_stats) {
+       if (!tp->hw_stats || tg3_flag(tp, INIT_COMPLETE)) {
                 *stats = tp->net_stats_prev;
                 spin_unlock_bh(&tp->lock);
                 return;

Cheers,
Zumeng
