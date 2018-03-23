Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCWTJu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:09:50 -0400
Received: from gateway24.websitewelcome.com ([192.185.50.45]:23027 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751595AbeCWTJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:09:49 -0400
Subject: [RESEND] SHASH_DESC_ON_STACK macro
References: <f662fa16-2cbb-a484-4efb-68bb3b39a792@embeddedor.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Forwarded-Message-Id: <f662fa16-2cbb-a484-4efb-68bb3b39a792@embeddedor.com>
Message-ID: <bda66faa-f52d-215d-f21b-763593b30f91@embeddedor.com>
Date: Fri, 23 Mar 2018 14:09:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f662fa16-2cbb-a484-4efb-68bb3b39a792@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1ezS4R-002zip-T8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.67]) [189.145.54.187]:43434
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Herbert,

There is an ongoing effort to remove all VLAs from the code base [1] and 
while working on that I came across the following macro at 
include/crypto/hash.h:154:

#define SHASH_DESC_ON_STACK(shash, ctx)                           \
         char __##shash##_desc[sizeof(struct shash_desc) +         \
                 crypto_shash_descsize(ctx)] CRYPTO_MINALIGN_ATTR; \
         struct shash_desc *shash = (struct shash_desc *)__##shash##_desc


Currently, this macro is being used in 46 different places.

I wonder how big can tfm->descsize can get?

Do you think it is feasible to replace the call to crypto_shash_descsize 
with a constant value and get rid of 46 VLA warnings?

I have sent some patches to replace the use of this macro with dynamic 
memory allocation instead, but it seems that this is not a suitable 
solution for all cases due to performance issues.

[1] https://lkml.org/lkml/2018/3/7/621

I'd really appreciate any feedback.
Thanks
--
Gustavo
