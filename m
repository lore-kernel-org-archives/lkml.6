Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbeBHQEf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:04:35 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:22463 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeBHQEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:04:33 -0500
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix net watchdog timeout
To: David Miller <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20180207011706.13393-1-grygorii.strashko@ti.com>
 <20180207.215735.1518454397358783732.davem@davemloft.net>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <e1ef5d15-91f9-c4ad-9a85-cc360a0b425a@ti.com>
Date: Thu, 8 Feb 2018 10:04:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207.215735.1518454397358783732.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.247.59.147]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/2018 08:57 PM, David Miller wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> Date: Tue, 6 Feb 2018 19:17:06 -0600
> 
>> It was discovered that simple program which indefinitely sends 200b UDP
>> packets and runs on TI AM574x SoC (SMP) under RT Kernel triggers network
>> watchdog timeout in TI CPSW driver (<6 hours run). The network watchdog
>> timeout is triggered due to race between cpsw_ndo_start_xmit() and
>> cpsw_tx_handler() [NAPI]
>>
>> cpsw_ndo_start_xmit()
>> 	if (unlikely(!cpdma_check_free_tx_desc(txch))) {
>> 		txq = netdev_get_tx_queue(ndev, q_idx);
>> 		netif_tx_stop_queue(txq);
>>
>> ^^ as per [1] barier has to be used after set_bit() otherwise new value
>> might not be visible to other cpus
>> 	}
>>
>> cpsw_tx_handler()
>> 	if (unlikely(netif_tx_queue_stopped(txq)))
>> 		netif_tx_wake_queue(txq);
>>
>> and when it happens ndev TX queue became disabled forever while driver's HW
>> TX queue is empty.
>>
>> Fix this, by adding smp_mb__after_atomic() after netif_tx_stop_queue()
>> calls and double check for free TX descriptors after stopping ndev TX queue
>> - if there are free TX descriptors wake up ndev TX queue.
>>
>> [1] https://www.kernel.org/doc/html/latest/core-api/atomic_ops.html
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Applied, thanks.
> 

Thank you David.

Could this be marked as stable material 4.9+?

-- 
regards,
-grygorii
