Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444AAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F048C20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F048C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966165AbeFSM2h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:28:37 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:60722 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964997AbeFSM2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:28:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 87E9E200A3;
        Tue, 19 Jun 2018 14:28:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OyN4YwYb6K0w; Tue, 19 Jun 2018 14:28:33 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 4801C201C7;
        Tue, 19 Jun 2018 14:28:33 +0200 (CEST)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.399.0; Tue, 19 Jun 2018
 14:28:32 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id E0C2631822FA;
 Tue, 19 Jun 2018 14:28:32 +0200 (CEST)
Date:   Tue, 19 Jun 2018 14:28:32 +0200
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     Jason Litzinger <jlitzingerdev@gmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in xfrm_state_fini (2)
Message-ID: <20180619122832.onqlgn5wqby7ahcu@gauss3.secunet.de>
References: <001a114387b624fb2e0564614477@google.com>
 <001a113f64eedee31b05662594bc@google.com>
 <cf1a05d1-0cb2-4fac-84b0-0efd3e0b12ca@googlegroups.com>
 <CACT4Y+aBhmF=_j95+cOBH+59+HNGcGKToGv0eg6aWsJhuvpUfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACT4Y+aBhmF=_j95+cOBH+59+HNGcGKToGv0eg6aWsJhuvpUfg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 725C9183-93DD-4558-B3C5-2357636311E1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 09:25:31AM +0200, Dmitry Vyukov wrote:
> On Mon, Jun 18, 2018 at 6:14 AM, Jason Litzinger
> <jlitzingerdev@gmail.com> wrote:
> > I've simplified the reproducer provided by syzbot to the included
> > version.  The warning is reproduced 100% using the qemu image in the
> > syzkaller docs running the latest upstream and net.
> >
> > As noted on the dashboard, this is similar to [1], in that an entry
> > remains in the xfrm_state_walk list, but different because the
> > protocol is not 0, it is 43, IPPROTO_ROUTING (and is valid by the fix
> > for [1], see 6a53b7593233).
> >
> > Unfortunately, when a namespace exits, xfrm_state_fini only flushes
> > IPSEC protocols.  I don't have enough experience with the xfrm
> > subsystem to know whether this is correct, however, dc00a525603650a14
> > explicitly allows non ipsec protocols, as well as 0 for "all".
> >
> > Would it be more appropriate for flush to also flush the non ipsec
> > protocols allowed in xfrm_user.c:validate_tmpl (explicitly or with 0)?
> >
> > If someone with more experience with the subsystem believes that to be
> > the case I'm happy to send a patch (against net or ipsec?), otherwise
> > I'm going to keep digging to see if a better option presents itself.
> >
> > Regardless I hope the simplified reproducer might be useful.
> >
> > -Jason
> >
> > [1]
> > https://syzkaller.appspot.com/bug?id=c922592229951800c197ce48a5eaab8877c33723
> >
> > * I wasn't subscribed to the list for the original message, so I'm
> >   using the GUI to reply...apologies if anything is mangled.
> 
> +kernel developers back to CC

Thanks for the info!

I'm traveling currently, so it may take some time
until I can look at it.
