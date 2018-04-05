Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeDEJvr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:51:47 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.77]:29804 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752460AbeDEJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:51:39 -0400
Subject: Re: [PATCH v2] Bluetooth: Remove VLA usage in aes_cmac
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20180321010527.GA16616@embeddedor.com>
 <3BD15121-532A-45E2-B62E-1008C0289500@holtmann.org>
 <2af25866-4e8a-7f9c-9298-e45abfab20c7@embeddedor.com>
 <347FC7F5-4BB3-4477-9EF1-BAAA98F1D107@holtmann.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <b6336234-7eaa-27d6-3424-665f78033d9b@embeddedor.com>
Date: Thu, 5 Apr 2018 04:51:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <347FC7F5-4BB3-4477-9EF1-BAAA98F1D107@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f41YQ-003IPA-EU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.54.187]:54592
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/05/2018 03:46 AM, Marcel Holtmann wrote:

>> By the way, what is you opinion on replacing crypto_shash_descsize(ctx) with PAGE_SIZE / 8 in SHASH_DESC_ON_STACK?
>>
>> Does it work for you?
> 
> isn’t that just waste?
> 

Agree.

> The macro itself is this.
> 
> #define SHASH_DESC_ON_STACK(shash, ctx)                           \
>          char __##shash##_desc[sizeof(struct shash_desc) +         \
>                  crypto_shash_descsize(ctx)] CRYPTO_MINALIGN_ATTR; \
>          struct shash_desc *shash = (struct shash_desc *)__##shash##_desc
> 
> For AES-CMAC, we could always do this with a manual macro that gives us the right size. However that is error prone if any internals change. I think what has to happened that crypto_shash_decsize becomes something the compiler can evaluate at compile time.
> 

Yeah. That would imply an analysis of the algorithm each of the callers 
use. In the case of AES-CMAC, what is the maximum digest size?

I tried to find a fixed-length value for AES-CMAC but I didn't get any 
output with git grep -n _DIGEST_SIZE | grep AES

Thanks
--
Gustavo
