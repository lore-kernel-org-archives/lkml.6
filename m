Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289C9C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A8C213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A8C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeJJDKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:10:22 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34974 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbeJJDKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:10:22 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w99JpdSG030986;
        Tue, 9 Oct 2018 21:51:39 +0200
Date:   Tue, 9 Oct 2018 21:51:39 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Insanely high baud rates
Message-ID: <20181009195139.GB30972@1wt.eu>
References: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 12:19:04PM -0700, H. Peter Anvin wrote:
> [Resending to a wider audience]
> 
> In trying to get the termios2 interface actually implemented in glibc,
> the question came up if we will ever care about baud rates in excess of
> 4 Gbps, even in the relatively remote future.
> 
> If this is something we care about *at all*, I would like to suggest
> that rather than defining yet another kernel interface, we steal some
> bits from the MSB of the speed fields, alternatively one of the c_cc
> bytes (all  likearchitectures seem to have c_cc[18] free) or some field,
> if we can find them, in c_cflags, to indicate an exponent.
> 
> With 5 bits from the top of the speed fields, the current values would
> be identical up to 248 Gbps, and values up to ~288 Pbps would be
> encodable ±2 ppb.
> 
> In the short term, all we would have to do in the kernel would be
> erroring out on baud rates higher than 0x0fffffff (2^28-1 due to
> implicit one aliasing rhe first bit of a 5-bit exponent - less than 2^27
> are functionally denorms.) However, I'd like to put the glibc
> infrastructure for this now if this is something we may ever be
> interested in.
> 
> Thoughts?

Just my two cents, maybe we can conclude that for now we don't care
thus don't implement anything, but that everything you identified as
a possible place to steal bits should be marked "reserved for future
use, must be sent as zero". This will leave you ample room later to
decide how to proceed (and maybe it will not be the bps that you'll
want to change but the number of lanes, or word size, or bit encoding,
especially at 4 Gbps).

Regards,
Willy
