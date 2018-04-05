Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeDEHXO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 03:23:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40301 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeDEHXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 03:23:13 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v2] Bluetooth: Remove VLA usage in aes_cmac
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180321010527.GA16616@embeddedor.com>
Date: Thu, 5 Apr 2018 09:23:10 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3BD15121-532A-45E2-B62E-1008C0289500@holtmann.org>
References: <20180321010527.GA16616@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

> In preparation to enabling -Wvla, remove VLA and replace it
> with dynamic memory allocation instead.
> 
> The use of stack Variable Length Arrays needs to be avoided, as they
> can be a vector for stack exhaustion, which can be both a runtime bug
> or a security flaw. Also, in general, as code evolves it is easy to
> lose track of how big a VLA can get. Thus, we can end up having runtime
> failures that are hard to debug.
> 
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
> Changes in v2:
> - Fix memory leak in previous patch.
> 
> net/bluetooth/smp.c | 17 ++++++++++++-----
> 1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index a2ddae2..0fa7035 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -173,7 +173,7 @@ static int aes_cmac(struct crypto_shash *tfm, const u8 k[16], const u8 *m,
> 		    size_t len, u8 mac[16])
> {
> 	uint8_t tmp[16], mac_msb[16], msg_msb[CMAC_MSG_MAX];
> -	SHASH_DESC_ON_STACK(desc, tfm);
> +	struct shash_desc *shash;

so I took this patch back out of bluetooth-next before sending the pull request. I think the discussion on how to fix SHASH_DESC_ON_STACK macro needs to complete first. Once that has concluded we can revisit if this patch is still needed or if another solution has been found. Same as with WiFi, these are not just one-shot calls where a memory allocation doesn’t matter. We need this for random address resolution and thus there can be many of the aes_cmac calls when seeing neighboring devices.

Regards

Marcel
