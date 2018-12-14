Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3F5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00852080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbeLNWnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:43:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35826 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeLNWnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:43:10 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1717D14E09825;
        Fri, 14 Dec 2018 14:43:10 -0800 (PST)
Date:   Fri, 14 Dec 2018 14:43:09 -0800 (PST)
Message-Id: <20181214.144309.1221577116690535004.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     mcuos.com@gmail.com, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w90p910_ether: remove incorrect __init annotation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAK8P3a3ZC_1C2pVYcLEe1y0=__YsapF+rZWKjLZ9hyUucyLT+A@mail.gmail.com>
References: <20181210204514.2362328-1-arnd@arndb.de>
        <20181214.132300.832860946069084294.davem@davemloft.net>
        <CAK8P3a3ZC_1C2pVYcLEe1y0=__YsapF+rZWKjLZ9hyUucyLT+A@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Dec 2018 14:43:10 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 14 Dec 2018 23:22:10 +0100

> On Fri, Dec 14, 2018 at 10:23 PM David Miller <davem@davemloft.net> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>> Date: Mon, 10 Dec 2018 21:45:07 +0100
>>
>> > The get_mac_address() function is normally inline, but when it is
>> > not, we get a warning that this configuration is broken:
>> >
>> > WARNING: vmlinux.o(.text+0x4aff00): Section mismatch in reference from the function w90p910_ether_setup() to the function .init.text:get_mac_address()
>> > The function w90p910_ether_setup() references
>> > the function __init get_mac_address().
>> > This is often because w90p910_ether_setup lacks a __init
>> >
>> > Remove the __init to make it always do the right thing.
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Actually I think we can validly mark w90p910_ether_setup() and
>> w90p910_probe() with appropriate init tagging.  None of these
>> functions are invoked outside of the probing paths.
> 
> But then we have to change the driver to use
> module_platform_driver_probe(), to ensure we cannot
> unbind/rebind the device. I usually don't like doing that,
> unless the device can never be stopped after it has
> been initialized.

Fair enough, let's go with your simpler fix for now.

Applied.
