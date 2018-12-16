Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BCFC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B43206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbeLPQiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:38:06 -0500
Received: from zimbra.alphalink.fr ([217.15.80.77]:58950 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbeLPQiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 11:38:05 -0500
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Dec 2018 11:38:04 EST
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 831FF2B52035;
        Sun, 16 Dec 2018 17:30:24 +0100 (CET)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MqGsYIYXxy08; Sun, 16 Dec 2018 17:30:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 4A42B2B5208E;
        Sun, 16 Dec 2018 17:30:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zI5nstDccUim; Sun, 16 Dec 2018 17:30:23 +0100 (CET)
Received: from localhost (unknown [82.120.188.200])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTPSA id 0B4B62B52035;
        Sun, 16 Dec 2018 17:30:23 +0100 (CET)
Date:   Sun, 16 Dec 2018 17:30:59 +0100
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] l2tp: Add Protocol field compression
Message-ID: <20181216163059.i5nadsfzyvcwa4o6@kdev>
References: <20181214211242.9721-1-semen.protsenko@linaro.org>
 <20181214211242.9721-2-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214211242.9721-2-semen.protsenko@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:12:42PM +0200, Sam Protsenko wrote:
> When Protocol Field Compression (PFC) is enabled, the "Protocol" field
> in PPP packet should be transmitted without leading 0x00. See section
> 6.5 in RFC 1661 for details. Let's compress protocol field if needed,
> the same way it's done in drivers/net/ppp/pptp.c.
> 
> To actually enable PFC, one should issue corresponding ioctl to L2TP
> driver from user-space, like this:
> 
>     ioctl(fd, PPPIOCGFLAGS, &flags);
>     flags |= SC_COMP_PROT;
>     ioctl(fd, PPPIOCSFLAGS, &flags);
> 
> It can be done e.g. from pppol2tp plugin (pppd), when pcomp option was
> negotiated with peer.
> 
> Of course, we don't compress Protocol field when sending LCP packets. As
> stated in RFC 1661, section 6.5:
> 
>     The Protocol field is never compressed when sending any LCP
>     packet.  This rule guarantees unambiguous recognition of LCP
>     packets.
> 
Again, I'm sorry, but I must oppose this change. Although I'm lacking
time to keep sanitising L2TP, at least I'd like to avoid making the
situation worse.

L2TP's uapi is already messy enough. Please don't add non-L2TP features
there.

Activating PFC should be done on PPP file descriptors, not no L2TP
sockets. We certainly don't want L2TP to snoop on PPP data, much less
modify them.
