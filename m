Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E62ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A390520854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A390520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeGRTK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:10:26 -0400
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:44180 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726158AbeGRTK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:10:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id EF136837F24D;
        Wed, 18 Jul 2018 18:31:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: beam05_624e55fca5a33
X-Filterd-Recvd-Size: 2494
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Jul 2018 18:31:15 +0000 (UTC)
Message-ID: <4dbef38e6020d6cb78e860a9f01fcd1de9f0fb52.camel@perches.com>
Subject: make sure swap arguments are the same type? (was: Re: [PATCH]
 crypto: rmd320 - use swap macro in rmd320_transform)
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Wed, 18 Jul 2018 11:31:13 -0700
In-Reply-To: <20180718171908.GA22962@embeddedor.com>
References: <20180718171908.GA22962@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 12:19 -0500, Gustavo A. R. Silva wrote:
> swap

Perhaps the swap macro should verify that the
swap(a, b) arguments are the same type.

Something like the patch below, but this patch
causes a compilation failure on at least a couple
cases that aren't obviously correct in

net/netfilter/ipset/ip_set_bitmap_port.c
	where a u16 is swapped with a u32.

and

net/netfilter/ipset/ip_set_hash_netport.c
	where a single bit bitfield is swapped with a u8
---
 include/linux/kernel.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6aac75b51ba..506b59e0da24 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -969,14 +969,19 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
  */
 #define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
 
-
 /**
  * swap - swap values of @a and @b
  * @a: first value
  * @b: second value
+ * @a and @b must be the same type
  */
-#define swap(a, b) \
-	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
+#define swap(a, b)							\
+do {									\
+	typeof(a) __tmp = (a);						\
+	BUILD_BUG_ON(!__same_type(typeof(a), typeof(b)));		\
+	(a) = (b);							\
+	(b) = __tmp;							\
+} while (0)
 
 /* This counts to 12. Any more, it will return 13th argument. */
 #define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
