Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2FFC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD2520671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD2520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbeGSIdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:33:18 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:42740 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbeGSIdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:33:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 9A8A2201AA;
        Thu, 19 Jul 2018 11:51:10 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wJWzdI0ZEDyx; Thu, 19 Jul 2018 11:51:10 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 4D9BF201A7;
        Thu, 19 Jul 2018 11:51:10 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.399.0; Thu, 19 Jul 2018
 09:51:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 1864B3181DA2;
 Thu, 19 Jul 2018 09:51:25 +0200 (CEST)
Date:   Thu, 19 Jul 2018 09:51:25 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     air icy <icytxw@gmail.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: UBSAN: Undefined behaviour in ./include/net/xfrm.h
Message-ID: <20180719075124.m3evqrlif3ha4ecn@gauss3.secunet.de>
References: <CAAzSK-wP5XZahbzkKjQSDDKQscOMszaj11ti_i7vRsF-CrWErQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAAzSK-wP5XZahbzkKjQSDDKQscOMszaj11ti_i7vRsF-CrWErQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 684AE89D-9B00-4F9F-9BE9-E85F41C784FB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:46:44PM +0800, air icy wrote:
> Hi,
> 
> static inline bool addr4_match(__be32 a1, __be32 a2, u8 prefixlen)
> {
> /* C99 6.5.7 (3): u32 << 32 is undefined behaviour */
> if (sizeof(long) == 4 && prefixlen == 0)
> return true;
> return !((a1 ^ a2) & htonl(~0UL << (32 - prefixlen)));
> }
> 
> 
> $ cat report0
> ================================================================================
> UBSAN: Undefined behaviour in ./include/net/xfrm.h:894:23
> shift exponent -128 is negative

Looks like we don't validate the prefixlen of the address family
in the xfrm_selector.

> This bug can be repro, if you need the repro file, please tell me.

Can you send me your reproducer?
