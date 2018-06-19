Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB2EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB96120652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="WJz+D6Pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB96120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967116AbeFSRY0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:24:26 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:53130 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966703AbeFSRYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aoyI3jFh5slogyV6H2FDKWOjfjA6ATksx29dzZNhIf0=; b=WJz+D6PlUq0DQgXNsqqPyCPeyY
        HrQj+A50oKDBowqebc1QIebd0jteFMILz+x9iRF2H4Z/epX34Y89+5Yfsvz2I35TFYQZ7gLDpB/nn
        ZyzynMHvROqbnnd5oWkVn0vFu7OAk48B5omtzL3N4H/kKaCqn/4sGsnQWR6M751JPCD8+KfN27c8s
        D5Znngq+d4LHvC4APGxxK731OMhWjAqmcm2oGf/rxKtGV9KCyBWsugaarqz8vbQl96hAgecYVVUWV
        OJVShiIGAl/zyU61dvIpiuy4UrUYA+oEC77AJlLZJzUnncI12ETAcQKQ4Uf1Xsya0FlU92zX5QAAV
        pQ/4pjxg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:45280 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fVKMh-0057JI-9J; Tue, 19 Jun 2018 17:24:23 +0000
Date:   Tue, 19 Jun 2018 10:24:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] ARM: Use logical or instead of addition for badr
 address calculation
Message-ID: <20180619172422.GB16846@roeck-us.net>
References: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
 <CAKv+Gu8Byj7G3Awnq4Y90Wot=GJTx0gO5A7-960au9ZkBBL2=A@mail.gmail.com>
 <b8bff03d-91a7-0e53-a44e-d1924beb382d@roeck-us.net>
 <CAKv+Gu-T8Fx3Nry7pUdOoOeRU-Ns89w3oo4itmu1q4FzYF5Rag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-T8Fx3Nry7pUdOoOeRU-Ns89w3oo4itmu1q4FzYF5Rag@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 03:35:07PM +0200, Ard Biesheuvel wrote:
> >>
> >> +       /* this needs to be a separate macro or \@ does not work correctly
> >> */
> >> +       .macro  __badr, c, rd, sym
> >> +       .eqv    .Lsym\@, \sym
> >> +       adr\c   \rd, .Lsym\@ + 1
> >
> >
> > Wild shot, but the following works for me.
> >
> >         .eqv    .Lsym\@, \sym + 1
> >         adr\c   \rd, .Lsym\@
> >
> > Does it make sense ?
> >
> 
> Interesting. Do you mean this works with your 2.30 binutils that
> triggers the original issue?
> 

Yes, it does. It is also the solution used for some graphics libraries,
though of course now I don't find the link anymore.

Guess this is going nowhere given Russell's response, so I'll just
live with it, like obviously everyone else does already. I built
a toolchain using gcc 7.3.0 and binutils 2.28.1 which "solves"
the problem for me.

Guenter
