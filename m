Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F48C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD61821929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfBIX3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 18:29:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:38846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726956AbfBIX3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 18:29:30 -0500
Received: (qmail 7980 invoked by uid 109); 9 Feb 2019 23:29:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Feb 2019 23:29:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1085 invoked by uid 111); 9 Feb 2019 23:29:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 09 Feb 2019 18:29:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Feb 2019 18:29:28 -0500
Date:   Sat, 9 Feb 2019 18:29:28 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
Message-ID: <20190209232928.GA7135@sigill.intra.peff.net>
References: <002501d4bfde$b26e6050$174b20f0$@nexbridge.com>
 <20190208191519.GF27673@sigill.intra.peff.net>
 <002b01d4bfe4$2d617f40$88247dc0$@nexbridge.com>
 <20190208193157.GA30952@sigill.intra.peff.net>
 <20190208220714.GG11927@genre.crustytoothpaste.net>
 <005901d4bffb$6d0c34c0$47249e40$@nexbridge.com>
 <20190208223512.GA2135@sigill.intra.peff.net>
 <006601d4c001$2de3a160$89aae420$@nexbridge.com>
 <20190209042456.GB18286@sigill.intra.peff.net>
 <38f594ed-0787-aeb5-d34f-2f4775243eb7@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38f594ed-0787-aeb5-d34f-2f4775243eb7@kdbg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2019 at 09:39:43AM +0100, Johannes Sixt wrote:

> > Great. Since it sounds like you're preparing some patches to deal with
> > /dev/zero elsewhere, do you want to wrap it up in a patch as part of
> > that?
> 
> Please do not use yes to generate an infinite amount of bytes. Our
> implementation of yes() in test-lib.sh generates only 99 lines.

Ah, thanks. That doesn't matter here, but it would for the other patches
under discussion.

> Perhaps do this.
> [...]
>  	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
> -	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
> +	printf "%0*d" $(($orig_size - $zero_pos)) 0 | tr 0 '\0' |
> +		dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" &&

Using stdin instead of the tmpfile is nice, and shouldn't have any
problems. I do think your printf suggestion looks nice, but I wondered
if it might run into portability issues (not because of anything in
particular, but I often find that the more clever a shell solution, the
more likely we run into obscure problems).

But if it works everywhere, that's fine by me.

-Peff
