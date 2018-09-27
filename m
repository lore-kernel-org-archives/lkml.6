Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA96C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58F021547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Eh+FXojT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58F021547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeI0HbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:31:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46909 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbeI0HbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=97z9iuw4qeNZ1U6BxcuWueEeH89AVHDxXeL8UVskb1Q=;
        b=Eh+FXojTqMBsmko8hhgbnPtT6MJhRmvPgK435OEPGtiGL+dAwa63/jKEdWcA+Tatnu9jUIOys8cAjGdn4yYUHK2Jkaw9PnRpRDN0lCsAlIiw3RvPs+Rh2rfNrB1ek2XEN5TACnJsdo3VNTKlzE4dPJ78ivMaWugtEJt8D6OU168=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g5Ktq-0003xa-0S; Thu, 27 Sep 2018 03:15:26 +0200
Date:   Thu, 27 Sep 2018 03:15:26 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
Message-ID: <20180927011526.GB1193@lunn.ch>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-24-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925145622.29959-24-Jason@zx2c4.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason

I know you have been concentrating on the crypto code, so i'm not
expecting too many changes at the moment in the network code.

It would be good to further reduce the number of checkpatch warnings.
The biggest problem i have at the moment is that all the trivial to
fix warnings are hiding a few more important warnings. There are a few
like these which are not obvious to see:

WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()
#2984: FILE: drivers/net/wireguard/noise.c:293:
+       BUG_ON(first_len > BLAKE2S_HASH_SIZE || second_len > BLAKE2S_HASH_SIZE ||

WARNING: Macros with flow control statements should be avoided
#5471: FILE: drivers/net/wireguard/selftest/allowedips.h:456:
+#define init_peer(name) do {                                               \
+               name = kzalloc(sizeof(*name), GFP_KERNEL);                 \
+               if (unlikely(!name)) {                                     \
+                       pr_info("allowedips self-test: out of memory\n");  \
+                       goto free;                                         \
+               }                                                          \
+               kref_init(&name->refcount);                                \
+       } while (0)


The namespace pollution also needs to be addresses. You have some
pretty generic named global symbols. I picked out a few examples from
objdump

00002a94 g     F .text	    00000060 peer_put
00003484 g     F .text	    0000004c timers_stop
00003520 g     F .text	    00000114 packet_queue_init
00002640 g     F .text	    00000034 device_uninit
000026bc g     F .text	    00000288 peer_create
000090d4 g     F .text	    000001bc ratelimiter_init

Please make use of a prefix for global symbols, e.g. wg_.

       Andrew
