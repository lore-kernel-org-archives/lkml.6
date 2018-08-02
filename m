Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A4AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F92214FA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F92214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbeHBLYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:24:00 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:40038 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbeHBLX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:23:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 79275201C2;
        Thu,  2 Aug 2018 13:33:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rqm2eHblibcQ; Thu,  2 Aug 2018 13:33:23 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 0D8B0201A1;
        Thu,  2 Aug 2018 13:33:23 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.399.0; Thu, 2 Aug 2018
 11:33:38 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id B265E3181801;
 Thu,  2 Aug 2018 11:33:37 +0200 (CEST)
Date:   Thu, 2 Aug 2018 11:33:37 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     air icy <icytxw@gmail.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: UBSAN: Undefined behaviour in ./include/net/xfrm.h
Message-ID: <20180802093337.hyw6jo7z3cy7qr7y@gauss3.secunet.de>
References: <CAAzSK-wP5XZahbzkKjQSDDKQscOMszaj11ti_i7vRsF-CrWErQ@mail.gmail.com>
 <20180719075124.m3evqrlif3ha4ecn@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180719075124.m3evqrlif3ha4ecn@gauss3.secunet.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 52578487-5F96-461E-AC3A-CFB8E371DCBA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 09:51:24AM +0200, Steffen Klassert wrote:
> On Fri, Jun 22, 2018 at 11:46:44PM +0800, air icy wrote:
> > Hi,
> > 
> > static inline bool addr4_match(__be32 a1, __be32 a2, u8 prefixlen)
> > {
> > /* C99 6.5.7 (3): u32 << 32 is undefined behaviour */
> > if (sizeof(long) == 4 && prefixlen == 0)
> > return true;
> > return !((a1 ^ a2) & htonl(~0UL << (32 - prefixlen)));
> > }
> > 
> > 
> > $ cat report0
> > ================================================================================
> > UBSAN: Undefined behaviour in ./include/net/xfrm.h:894:23
> > shift exponent -128 is negative
> 
> Looks like we don't validate the prefixlen of the address family
> in the xfrm_selector.

I plan to fix this with the patch below.

Thanks for the report!

Subject: [PATCH RFC ipsec] xfrm: Validate address prefix lengths in the xfrm selector.

We don't validate the address prefix lengths in the xfrm
selector we got from userspace. This can lead to undefined
behaviour in the address matching functions if the prefix
is too big for the given address family. Fix this by checking
the prefixes and refuse SA/policy insertation when a prefix
is invalid.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Air Icy <icytxw@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_user.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 33878e6e0d0a..5151b3ebf068 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -151,10 +151,16 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 	err = -EINVAL;
 	switch (p->family) {
 	case AF_INET:
+		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32)
+			goto out;
+
 		break;
 
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
+		if (p->sel.prefixlen_d > 128 || p->sel.prefixlen_s > 128)
+			goto out;
+
 		break;
 #else
 		err = -EAFNOSUPPORT;
@@ -1359,10 +1365,16 @@ static int verify_newpolicy_info(struct xfrm_userpolicy_info *p)
 
 	switch (p->sel.family) {
 	case AF_INET:
+		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32)
+			return -EINVAL;
+
 		break;
 
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
+		if (p->sel.prefixlen_d > 128 || p->sel.prefixlen_s > 128)
+			return -EINVAL;
+
 		break;
 #else
 		return  -EAFNOSUPPORT;
-- 
2.14.1

