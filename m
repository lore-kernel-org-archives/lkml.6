Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90459C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B642073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B642073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alphalink.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeH3RMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:12:05 -0400
Received: from zimbra.alphalink.fr ([217.15.80.77]:53788 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbeH3RMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:12:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 484862B52057;
        Thu, 30 Aug 2018 15:09:59 +0200 (CEST)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id O7a3SKAnnwGg; Thu, 30 Aug 2018 15:09:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id D366E2B5210F;
        Thu, 30 Aug 2018 15:09:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J8X2HYaTKhGc; Thu, 30 Aug 2018 15:09:57 +0200 (CEST)
Received: from c-dev-0.admin.alphalink.fr (94-84-15-217.reverse.alphalink.fr [217.15.84.94])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 989082B52057;
        Thu, 30 Aug 2018 15:09:57 +0200 (CEST)
Received: by c-dev-0.admin.alphalink.fr (Postfix, from userid 1000)
        id 79CE760228; Thu, 30 Aug 2018 15:09:57 +0200 (CEST)
Date:   Thu, 30 Aug 2018 15:09:57 +0200
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, mitch@sfgoth.com,
        mostrows@earthlink.net, jchapman@katalix.com, xeb@mail.ru,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/5] pppoe: fix PPPOEIOCSFWD compat handling
Message-ID: <20180830130957.GD1473@alphalink.fr>
References: <20180829140409.833488-1-arnd@arndb.de>
 <20180830110453.GC1473@alphalink.fr>
 <CAK8P3a1WSa5yPWXYGieAc0+Xk=CAy_G-RhNNcQBsGQGOU-8WfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1WSa5yPWXYGieAc0+Xk=CAy_G-RhNNcQBsGQGOU-8WfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 01:54:48PM +0200, Arnd Bergmann wrote:
> On Thu, Aug 30, 2018 at 1:04 PM Guillaume Nault <g.nault@alphalink.fr> wrote:
> >
> > On Wed, Aug 29, 2018 at 04:03:26PM +0200, Arnd Bergmann wrote:
> > > Support for handling the PPPOEIOCSFWD ioctl in compat mode was added in
> > > linux-2.5.69 along with hundreds of other commands, but was always broken
> > > sincen only the structure is compatible, but the command number is not,
> > > due to the size being sizeof(size_t), or at first sizeof(sizeof((struct
> > > sockaddr_pppox)), which is different on 64-bit architectures.
> > >
> > And the implementation was broken until 2016 (see 29e73269aa4d ("pppoe:
> > fix reference counting in PPPoE proxy")), and nobody ever noticed. I
> > should probably have removed this ioctl entirely instead of fixing it.
> > Clearly, it has never been used.
> >
> > If you think it's worth fixing (as opposed to dropping this ioctl or
> > its compat mode), then,
> > Acked-by: Guillaume Nault <g.nault@alphalink.fr>
> 
> I don't care much, but fixing it seems seems easier than coming
> up with a convincing rationale for dropping.
> 
> I'll update the changelog text to include your additional background
> information though, unless someone else prefers to have it dropped.
> 
Sounds good. Thanks.
