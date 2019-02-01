Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6FFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FCC218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfBAUuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:50:37 -0500
Received: from muru.com ([72.249.23.125]:37252 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbfBAUug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:50:36 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3FCED813A;
        Fri,  1 Feb 2019 20:50:44 +0000 (UTC)
Date:   Fri, 1 Feb 2019 12:50:32 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     ofono@ofono.org, kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Droid 4 modem support in kernel & ofono
Message-ID: <20190201205032.GF5720@atomide.com>
References: <20190201203616.GA2087@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201203616.GA2087@amd>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [190201 20:36]:
> Hi!
> 
> Ok, so I got calls and smses somehow working in kernel&ofono ... which
> is really all I need.

Nice :)

I think the SIM card reading and writing should be doable
using dlci10 /dev/motmdm10 for AT+CRSM calls..

> I pushed the tree to git@github.com:pavelmachek/ofono.git , branch
> d4... But I had to do some "rather interesting" hacks. D4 modem
> expects packets and current kernel drivers rely on write() boundaries
> and flush(). .. which is a bit of problem for in ofonod, as it expects
> to work with bytestream with no explicit packet boundaries.
> 
> However D4 still uses normal AT commands, so... it would be good to be
> able to use AT parsing framework in ofono.
> 
> I believe easiest solution would be to automatically do the packet
> splitting in kernel, it should be as easy as splitting on \r and
> ^Z. (Currently packets are only generated when \r or ^Z is seen on
> write boundary, but that does not work well for ofono).

OK yeah it's worth trying. I hit that issue too with the
flush needed for droid4-sms-tools scripts. And the traffic
we're seeing is minimal and AFAIK there's no network port
for ts27010. And SMS messages are PDU encoded anyways.

Hmm should we do it for \r\n and \r? Otherwise the \n
will be left out of the packet :)

Regards,

Tony
