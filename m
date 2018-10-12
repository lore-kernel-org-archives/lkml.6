Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472A8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B8E20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B8E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeJLT5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:57:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:40816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727816AbeJLT5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:57:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53839AE86;
        Fri, 12 Oct 2018 12:24:45 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 0448FA0ED9; Fri, 12 Oct 2018 14:24:44 +0200 (CEST)
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH ipsec-next] xfrm: use complete IPv6 addresses for hash
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <20181012122444.0448FA0ED9@unicorn.suse.cz>
Date:   Fri, 12 Oct 2018 14:24:44 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some environments it is common that many hosts share the same lower half
of their IPv6 addresses (in particular ::1). As __xfrm6_addr_hash() and
__xfrm6_daddr_saddr_hash() calculate the hash only from the lower halves,
as much as 1/3 of the hosts ends up in one hashtable chain which harms the
performance.

Use complete IPv6 addresses when calculating the hashes. Rather than just
adding two more words to the xor, use jhash2() for consistency with
__xfrm6_pref_hash() and __xfrm6_dpref_spref_hash().

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 net/xfrm/xfrm_hash.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_hash.h b/net/xfrm/xfrm_hash.h
index 61be810389d8..ce66323102f9 100644
--- a/net/xfrm/xfrm_hash.h
+++ b/net/xfrm/xfrm_hash.h
@@ -13,7 +13,7 @@ static inline unsigned int __xfrm4_addr_hash(const xfrm_address_t *addr)
 
 static inline unsigned int __xfrm6_addr_hash(const xfrm_address_t *addr)
 {
-	return ntohl(addr->a6[2] ^ addr->a6[3]);
+	return jhash2((__force u32 *)addr->a6, 4, 0);
 }
 
 static inline unsigned int __xfrm4_daddr_saddr_hash(const xfrm_address_t *daddr,
@@ -26,8 +26,7 @@ static inline unsigned int __xfrm4_daddr_saddr_hash(const xfrm_address_t *daddr,
 static inline unsigned int __xfrm6_daddr_saddr_hash(const xfrm_address_t *daddr,
 						    const xfrm_address_t *saddr)
 {
-	return ntohl(daddr->a6[2] ^ daddr->a6[3] ^
-		     saddr->a6[2] ^ saddr->a6[3]);
+	return __xfrm6_addr_hash(daddr) ^ __xfrm6_addr_hash(saddr);
 }
 
 static inline u32 __bits2mask32(__u8 bits)
-- 
2.19.1

