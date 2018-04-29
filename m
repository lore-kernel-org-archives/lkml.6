Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeD2Gne (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 02:43:34 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33414 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbeD2Gnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 02:43:32 -0400
X-Google-Smtp-Source: AB8JxZoVY6oYW811mpmHjJ+xOTbd1yhm7ic05Yo3/ofxSKimtQtZDDKr1RkyYRAlNQShytV/Sw7CDw==
Subject: Re: [PATCH 1/1] tg3: fix meaningless hw_stats reading after tg3_halt
 memset 0 hw_stats
To: Michael Chan <michael.chan@broadcom.com>
References: <20180428031544.210054-1-zumeng.chen@gmail.com>
 <CACKFLi=UxiSUAx8CoMKpx16d7mVSAbbmhR-m=1W_kzNrePu7XQ@mail.gmail.com>
Cc: Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        "michael.chan@broadcom.com" <mchan@broadcom.com>,
        "prashant.sreedharan@broadcom.com" <prashant@broadcom.com>,
        David Miller <davem@davemloft.net>
From: Zumeng Chen <zumeng.chen@gmail.com>
Message-ID: <eb6f9052-88fc-6b90-2278-88df3b3cccd8@gmail.com>
Date: Sun, 29 Apr 2018 14:43:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <CACKFLi=UxiSUAx8CoMKpx16d7mVSAbbmhR-m=1W_kzNrePu7XQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018年04月29日 02:36, Michael Chan wrote:
> On Fri, Apr 27, 2018 at 8:15 PM, Zumeng Chen <zumeng.chen@gmail.com> wrote:
>
>> diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
>> index 3b5e98e..6727d93 100644
>> --- a/drivers/net/ethernet/broadcom/tg3.h
>> +++ b/drivers/net/ethernet/broadcom/tg3.h
>> @@ -3352,6 +3352,7 @@ struct tg3 {
>>          struct pci_dev                  *pdev_peer;
>>
>>          struct tg3_hw_stats             *hw_stats;
>> +       bool                            hw_stats_flag;
> You can just add another bit to enum TG3_FLAGS for this purpose.

Right, it's a good idea, I didn't notice it, I'll send V2 with that later.

>
> While this scheme will probably work, I think a better and more
> elegant way to fix this is to use RCU.

IMHO, RCU is not necessary for this simple two consumers, and no 
frequent ops
on tg3_halt, plus no new locker involved either.

Cheers,
Zumeng
>
>>          dma_addr_t                      stats_mapping;
>>          struct work_struct              reset_task;
>>
>> --
>> 2.9.3
>>
