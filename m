Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BBDECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFEB20684
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFEB20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbeGQRmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 13:42:24 -0400
Received: from smtprelay0226.hostedemail.com ([216.40.44.226]:35437 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729708AbeGQRmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 13:42:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0BDF3100E86CA;
        Tue, 17 Jul 2018 17:08:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boats66_2f8725726b951
X-Filterd-Recvd-Size: 5288
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Jul 2018 17:08:46 +0000 (UTC)
Message-ID: <99f5bcb9b5a3604264d43e7305950dcf7f6cfcc7.camel@perches.com>
Subject: Re: [PATCH] ipv6: sr: fix useless rol32 call on hash
From:   Joe Perches <joe@perches.com>
To:     David Lebrun <dav.lebrun@gmail.com>,
        Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Jul 2018 10:08:45 -0700
In-Reply-To: <6ab9af97-33b6-d5cc-d1e9-6e5fbd9158a8@gmail.com>
References: <20180717155254.30367-1-colin.king@canonical.com>
         <6ab9af97-33b6-d5cc-d1e9-6e5fbd9158a8@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 17:03 +0100, David Lebrun wrote:
> On 07/17/2018 04:52 PM, Colin King wrote:
> > From: Colin Ian King<colin.king@canonical.com>
> > 
> > The rol32 call is currently rotating hash but the rol'd value is
> > being discarded. I believe the current code is incorrect and hash
> > should be assigned the rotated value returned from rol32.
> > 
> > Detected by CoverityScan, CID#1468411 ("Useless call")
> > 
> > Fixes: b5facfdba14c ("ipv6: sr: Compute flowlabel for outer IPv6 header of seg6 encap mode")
> > Signed-off-by: Colin Ian King<colin.king@canonical.com>
> 
> Acked-by: dlebrun@google.com
> 
> Good catch, thanks !
> 
> In that case, the same issue is present in 
> include/net/ipv6.h:ip6_make_flowlabel().

Perhaps all of the ror and rol definitions should add
__must_check

Something like the below and perhaps many more of the
functions that return some value should have __must_chedk
added as well.
---
 include/linux/bitops.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index af419012d77d..3cddde65c8bb 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -67,7 +67,7 @@ static inline __u64 rol64(__u64 word, unsigned int shift)
  * @word: value to rotate
  * @shift: bits to roll
  */
-static inline __u64 ror64(__u64 word, unsigned int shift)
+static inline __must_check __u64 ror64(__u64 word, unsigned int shift)
 {
 	return (word >> shift) | (word << (64 - shift));
 }
@@ -77,7 +77,7 @@ static inline __u64 ror64(__u64 word, unsigned int shift)
  * @word: value to rotate
  * @shift: bits to roll
  */
-static inline __u32 rol32(__u32 word, unsigned int shift)
+static inline __must_check __u32 rol32(__u32 word, unsigned int shift)
 {
 	return (word << shift) | (word >> ((-shift) & 31));
 }
@@ -87,7 +87,7 @@ static inline __u32 rol32(__u32 word, unsigned int shift)
  * @word: value to rotate
  * @shift: bits to roll
  */
-static inline __u32 ror32(__u32 word, unsigned int shift)
+static inline __must_check __u32 ror32(__u32 word, unsigned int shift)
 {
 	return (word >> shift) | (word << (32 - shift));
 }
@@ -97,7 +97,7 @@ static inline __u32 ror32(__u32 word, unsigned int shift)
  * @word: value to rotate
  * @shift: bits to roll
  */
-static inline __u16 rol16(__u16 word, unsigned int shift)
+static inline __must_check __u16 rol16(__u16 word, unsigned int shift)
 {
 	return (word << shift) | (word >> (16 - shift));
 }
@@ -107,7 +107,7 @@ static inline __u16 rol16(__u16 word, unsigned int shift)
  * @word: value to rotate
  * @shift: bits to roll
  */
-static inline __u16 ror16(__u16 word, unsigned int shift)
+static inline __must_check __u16 ror16(__u16 word, unsigned int shift)
 {
 	return (word >> shift) | (word << (16 - shift));
 }
@@ -117,7 +117,7 @@ static inline __u16 ror16(__u16 word, unsigned int shift)
  * @word: value to rotate
  * @shift: bits to roll
  */
-static inline __u8 rol8(__u8 word, unsigned int shift)
+static inline __must_check __u8 rol8(__u8 word, unsigned int shift)
 {
 	return (word << shift) | (word >> (8 - shift));
 }
@@ -127,7 +127,7 @@ static inline __u8 rol8(__u8 word, unsigned int shift)
  * @word: value to rotate
  * @shift: bits to roll
  */
-static inline __u8 ror8(__u8 word, unsigned int shift)
+static inline __must_check __u8 ror8(__u8 word, unsigned int shift)
 {
 	return (word >> shift) | (word << (8 - shift));
 }
@@ -139,7 +139,7 @@ static inline __u8 ror8(__u8 word, unsigned int shift)
  *
  * This is safe to use for 16- and 8-bit types as well.
  */
-static inline __s32 sign_extend32(__u32 value, int index)
+static inline __must_check __s32 sign_extend32(__u32 value, int index)
 {
 	__u8 shift = 31 - index;
 	return (__s32)(value << shift) >> shift;
@@ -150,7 +150,7 @@ static inline __s32 sign_extend32(__u32 value, int index)
  * @value: value to sign extend
  * @index: 0 based bit index (0<=index<64) to sign bit
  */
-static inline __s64 sign_extend64(__u64 value, int index)
+static inline __must_check __s64 sign_extend64(__u64 value, int index)
 {
 	__u8 shift = 63 - index;
 	return (__s64)(value << shift) >> shift;


