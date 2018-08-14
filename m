Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D24C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E09A21471
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E09A21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403799AbeHNUfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:35:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390379AbeHNUfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:35:23 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 614ECD08;
        Tue, 14 Aug 2018 17:47:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Egerer <hakke_007@gmx.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Yongqin Liu <yongqin.liu@linaro.org>
Subject: [PATCH 4.4 03/43] ipv4+ipv6: Make INET*_ESP select CRYPTO_ECHAINIV
Date:   Tue, 14 Aug 2018 19:17:39 +0200
Message-Id: <20180814171517.268645279@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171517.014285600@linuxfoundation.org>
References: <20180814171517.014285600@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Egerer <hakke_007@gmx.de>

commit 32b6170ca59ccf07d0e394561e54b2cd9726038c upstream.

The ESP algorithms using CBC mode require echainiv. Hence INET*_ESP have
to select CRYPTO_ECHAINIV in order to work properly. This solves the
issues caused by a misconfiguration as described in [1].
The original approach, patching crypto/Kconfig was turned down by
Herbert Xu [2].

[1] https://lists.strongswan.org/pipermail/users/2015-December/009074.html
[2] http://marc.info/?l=linux-crypto-vger&m=145224655809562&w=2

Signed-off-by: Thomas Egerer <hakke_007@gmx.de>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Yongqin Liu <yongqin.liu@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/Kconfig |    1 +
 net/ipv6/Kconfig |    1 +
 2 files changed, 2 insertions(+)

--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -354,6 +354,7 @@ config INET_ESP
 	select CRYPTO_CBC
 	select CRYPTO_SHA1
 	select CRYPTO_DES
+	select CRYPTO_ECHAINIV
 	---help---
 	  Support for IPsec ESP.
 
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -69,6 +69,7 @@ config INET6_ESP
 	select CRYPTO_CBC
 	select CRYPTO_SHA1
 	select CRYPTO_DES
+	select CRYPTO_ECHAINIV
 	---help---
 	  Support for IPsec ESP.
 


