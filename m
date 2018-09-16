Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78A4ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AA62086E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77AA62086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strongswan.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeIQBVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:21:12 -0400
Received: from sitav-80046.hsr.ch ([152.96.80.46]:52733 "EHLO
        mail.strongswan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbeIQBVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:21:12 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Sep 2018 21:21:10 EDT
Received: from book (unknown [IPv6:2a01:2a8:8506:9001:6fd1:b471:395b:f578])
        by mail.strongswan.org (Postfix) with ESMTPSA id 51D1140196;
        Sun, 16 Sep 2018 21:51:58 +0200 (CEST)
Message-ID: <72e893e7efbef428d4fd23b7332d9e829acd5e7d.camel@strongswan.org>
Subject: Re: [PATCH net-next v4 18/20] crypto: port ChaCha20 to Zinc
From:   Martin Willi <martin@strongswan.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Date:   Sun, 16 Sep 2018 21:51:53 +0200
In-Reply-To: <20180914162240.7925-19-Jason@zx2c4.com>
References: <20180914162240.7925-1-Jason@zx2c4.com>
         <20180914162240.7925-19-Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

> Now that ChaCha20 is in Zinc, we can have the crypto API code simply
> call into it.

>  delete mode 100644 arch/x86/crypto/chacha20-avx2-x86_64.S
>  delete mode 100644 arch/x86/crypto/chacha20-ssse3-x86_64.S

I did some trivial benchmarking with tcrypt for the ChaCha20Poly1305
AEAD as used by IPsec. This is on a box with AVX2, which is probably
the configuration mostly used these days. With Zinc I get:

> testing speed of rfc7539esp(chacha20,poly1305) (rfc7539esp(chacha20-software,poly1305-software)) decryption
> test 0 (288 bit key, 16 byte blocks): 743510 operations in 1 seconds (11896160 bytes)
> test 1 (288 bit key, 64 byte blocks): 743190 operations in 1 seconds (47564160 bytes)
> test 2 (288 bit key, 256 byte blocks): 701461 operations in 1 seconds (179574016 bytes)
> test 3 (288 bit key, 512 byte blocks): 681567 operations in 1 seconds (348962304 bytes)
> test 4 (288 bit key, 1024 byte blocks): 572854 operations in 1 seconds (586602496 bytes)
> test 5 (288 bit key, 2048 byte blocks): 434477 operations in 1 seconds (889808896 bytes)
> test 6 (288 bit key, 4096 byte blocks): 293553 operations in 1 seconds (1202393088 bytes)
> test 7 (288 bit key, 8192 byte blocks): 173351 operations in 1 seconds (1420091392 bytes)

Using the existing implementation, this was:

> testing speed of rfc7539esp(chacha20,poly1305) (rfc7539esp(chacha20-simd,poly1305-simd)) decryption
> test 0 (288 bit key, 16 byte blocks): 1064524 operations in 1 seconds (17032384 bytes)
> test 1 (288 bit key, 64 byte blocks): 1016046 operations in 1 seconds (65026944 bytes)
> test 2 (288 bit key, 256 byte blocks): 829566 operations in 1 seconds (212368896 bytes)
> test 3 (288 bit key, 512 byte blocks): 778912 operations in 1 seconds (398802944 bytes)
> test 4 (288 bit key, 1024 byte blocks): 622331 operations in 1 seconds (637266944 bytes)
> test 5 (288 bit key, 2048 byte blocks): 441790 operations in 1 seconds (904785920 bytes)
> test 6 (288 bit key, 4096 byte blocks): 280616 operations in 1 seconds (1149403136 bytes)
> test 7 (288 bit key, 8192 byte blocks): 158800 operations in 1 seconds (1300889600 bytes)

I've also experimented with the SIMD context save/restore amortization
from patch one on the existing implementation:

> testing speed of rfc7539esp(chacha20,poly1305) (rfc7539esp(chacha20-simd,poly1305-simd)) decryption
> test 0 (288 bit key, 16 byte blocks): 1088215 operations in 1 seconds (17411440 bytes)
> test 1 (288 bit key, 64 byte blocks): 1001788 operations in 1 seconds (64114432 bytes)
> test 2 (288 bit key, 256 byte blocks): 870193 operations in 1 seconds (222769408 bytes)
> test 3 (288 bit key, 512 byte blocks): 822149 operations in 1 seconds (420940288 bytes)
> test 4 (288 bit key, 1024 byte blocks): 647447 operations in 1 seconds (662985728 bytes)
> test 5 (288 bit key, 2048 byte blocks): 454734 operations in 1 seconds (931295232 bytes)
> test 6 (288 bit key, 4096 byte blocks): 286995 operations in 1 seconds (1175531520 bytes)
> test 7 (288 bit key, 8192 byte blocks): 162028 operations in 1 seconds (1327333376 bytes)

For large blocks your implementation is faster; for typical IPsec MTUs
this degrades performance by ~10% and more.

Martin
