Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeDEIqo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 04:46:44 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55225 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEIqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 04:46:42 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v2] Bluetooth: Remove VLA usage in aes_cmac
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2af25866-4e8a-7f9c-9298-e45abfab20c7@embeddedor.com>
Date: Thu, 5 Apr 2018 10:46:39 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <347FC7F5-4BB3-4477-9EF1-BAAA98F1D107@holtmann.org>
References: <20180321010527.GA16616@embeddedor.com>
 <3BD15121-532A-45E2-B62E-1008C0289500@holtmann.org>
 <2af25866-4e8a-7f9c-9298-e45abfab20c7@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

>> so I took this patch back out of bluetooth-next before sending the pull request. I think the discussion on how to fix SHASH_DESC_ON_STACK macro needs to complete first. Once that has concluded we can revisit if this patch is still needed or if another solution has been found. Same as with WiFi, these are not just one-shot calls where a memory allocation doesn’t matter. We need this for random address resolution and thus there can be many of the aes_cmac calls when seeing neighboring devices.
> 
> Yeah. I agree.
> 
> Based on Herbert's response to the discussion about SHASH_DESC_ON_STACK https://lkml.org/lkml/2018/3/27/300
> 
> it seems it is feasible to fix that macro very easily. I will follow up on this.
> 
> By the way, what is you opinion on replacing crypto_shash_descsize(ctx) with PAGE_SIZE / 8 in SHASH_DESC_ON_STACK?
> 
> Does it work for you?

isn’t that just waste?

The macro itself is this.

#define SHASH_DESC_ON_STACK(shash, ctx)                           \              
        char __##shash##_desc[sizeof(struct shash_desc) +         \              
                crypto_shash_descsize(ctx)] CRYPTO_MINALIGN_ATTR; \              
        struct shash_desc *shash = (struct shash_desc *)__##shash##_desc

For AES-CMAC, we could always do this with a manual macro that gives us the right size. However that is error prone if any internals change. I think what has to happened that crypto_shash_decsize becomes something the compiler can evaluate at compile time.

Regards

Marcel
