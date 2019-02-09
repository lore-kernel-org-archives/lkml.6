Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D675EC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7C721929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfBIXMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 18:12:21 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49710 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfBIXMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 18:12:20 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C9F7D14B3D8EC;
        Sat,  9 Feb 2019 15:12:19 -0800 (PST)
Date:   Sat, 09 Feb 2019 15:12:17 -0800 (PST)
Message-Id: <20190209.151217.175627323493244750.davem@davemloft.net>
To:     marcelo.leitner@gmail.com
Cc:     julien@arista.com, netdev@vger.kernel.org,
        linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org,
        nhorman@tuxdriver.com, vyasevich@gmail.com, lucien.xin@gmail.com
Subject: Re: [PATCH net] sctp: make sctp_setsockopt_events() less strict
 about the option length
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190206203754.GC13621@localhost.localdomain>
References: <20190206201430.18830-1-julien@arista.com>
        <20190206203754.GC13621@localhost.localdomain>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 09 Feb 2019 15:12:20 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Date: Wed, 6 Feb 2019 18:37:54 -0200

> On Wed, Feb 06, 2019 at 12:14:30PM -0800, Julien Gomes wrote:
>> Make sctp_setsockopt_events() able to accept sctp_event_subscribe
>> structures longer than the current definitions.
>> 
>> This should prevent unjustified setsockopt() failures due to struct
>> sctp_event_subscribe extensions (as in 4.11 and 4.12) when using
>> binaries that should be compatible, but were built with later kernel
>> uapi headers.
> 
> Not sure if we support backwards compatibility like this?

What a complete mess we have here.

Use new socket option numbers next time, do not change the size and/or
layout of existing socket options.

This whole thread, if you read it, is basically "if we compatability
this way, that breaks, and if we do compatability this other way oh
shit this other thing doesn't work."

I think we really need to specifically check for the difference sizes
that existed one by one, clear out the part not given by the user, and
backport this as far back as possible in a way that in the older kernels
we see if the user is actually trying to use the new features and if so
error out.

Which, btw, is terrible behavior.  Newly compiled apps should work on
older kernels if they don't try to use the new features, and if they
can the ones that want to try to use the new features should be able
to fall back when that feature isn't available in a non-ambiguous
and precisely defined way.

The fact that the use of the new feature is hidden in the new
structure elements is really rotten.

This patch, at best, needs some work and definitely a longer and more
detailed commit message.
