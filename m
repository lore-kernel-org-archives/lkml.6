Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A208C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B2820873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B2820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbeK0Sww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:52:52 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:59226 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbeK0Sww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:52:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 4A955201C6;
        Tue, 27 Nov 2018 08:55:49 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jVJj1LJKIjWJ; Tue, 27 Nov 2018 08:55:48 +0100 (CET)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 804DA20189;
        Tue, 27 Nov 2018 08:55:48 +0100 (CET)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.408.0; Tue, 27 Nov 2018
 08:55:48 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 18C3D31811F1;
 Tue, 27 Nov 2018 08:55:48 +0100 (CET)
Date:   Tue, 27 Nov 2018 08:55:48 +0100
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Mathias Krause <minipli@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Pan Bian <bianpan2013@163.com>
Subject: Re: [net] xfrm_user: use xfrm_state_put to free xfrm_state_alloc
 return value
Message-ID: <20181127075548.GK3581@gauss3.secunet.de>
References: <1542783468-67482-1-git-send-email-bianpan2016@163.com>
 <20181121080045.4vtozqc6eyeyis2n@gondor.apana.org.au>
 <20181121200923.GA12460@jig.fritz.box>
 <20181122144321.5gmyynui254qfeoq@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181122144321.5gmyynui254qfeoq@gondor.apana.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 580B7939-5C31-4F5A-B070-15A864CF67D0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:43:21PM +0800, Herbert Xu wrote:
> On Wed, Nov 21, 2018 at 09:09:23PM +0100, Mathias Krause wrote:
> > 
> > -- >8 --
> > 
> > Subject: [PATCH] xfrm_user: fix freeing of xfrm states on acquire
> > 
> > Commit 565f0fa902b6 ("xfrm: use a dedicated slab cache for struct
> > xfrm_state") moved xfrm state objects to use their own slab cache.
> > However, it missed to adapt xfrm_user to use this new cache when
> > freeing xfrm states.
> > 
> > Fix this by introducing and make use of a new helper for freeing
> > xfrm_state objects.
> > 
> > Fixes: 565f0fa902b6 ("xfrm: use a dedicated slab cache for struct xfrm_state")
> > Reported-by: Pan Bian <bianpan2016@163.com>
> > Cc: <stable@vger.kernel.org> # v4.18+
> > Signed-off-by: Mathias Krause <minipli@googlemail.com>
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks everyone!
