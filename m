Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26EDECBAF3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA79208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA79208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbeGLTVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:21:25 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:47456 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbeGLTVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:21:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 1C4E62019F;
        Thu, 12 Jul 2018 23:10:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LC_X6-PS7sJx; Thu, 12 Jul 2018 23:10:15 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 9DA7320080;
        Thu, 12 Jul 2018 23:10:15 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.399.0; Thu, 12 Jul 2018
 21:10:30 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 53EBF3180879;
 Thu, 12 Jul 2018 21:10:30 +0200 (CEST)
Date:   Thu, 12 Jul 2018 21:10:30 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] [RESEND, net-next] xfrm: use time64_t for in-kernel
 timestamps
Message-ID: <20180712191030.4chaji3vswtnltdc@gauss3.secunet.de>
References: <20180711101941.4039411-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180711101941.4039411-1-arnd@arndb.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: FD9727BC-5A1E-4785-A40A-500AEC11CF03
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 12:19:13PM +0200, Arnd Bergmann wrote:
> The lifetime managment uses '__u64' timestamps on the user space
> interface, but 'unsigned long' for reading the current time in the kernel
> with get_seconds().
> 
> While this is probably safe beyond y2038, it will still overflow in 2106,
> and the get_seconds() call is deprecated because fo that.
> 
> This changes the xfrm time handling to use time64_t consistently, along
> with reading the time using the safer ktime_get_real_seconds(). It still
> suffers from problems that can happen from a concurrent settimeofday()
> call or (to a lesser degree) a leap second update, but since the time
> stamps are part of the user API, there is nothing we can do to prevent
> that.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to the ipsec-next tree, thanks a lot!
