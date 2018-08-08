Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9437BC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F60216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F60216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeHHKnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:43:12 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:55791 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHKnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:43:12 -0400
Received: from ravnborg.org (unknown [158.248.196.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5E5BA20034;
        Wed,  8 Aug 2018 10:24:32 +0200 (CEST)
Date:   Wed, 8 Aug 2018 10:24:31 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 2/5] pardata: new bus for parallel data access
Message-ID: <20180808082431.GA29143@ravnborg.org>
References: <20180802193909.GA11443@ravnborg.org>
 <20180802194536.10820-2-sam@ravnborg.org>
 <634ea7d9-7cc1-f404-b072-0bafbc748fb7@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <634ea7d9-7cc1-f404-b072-0bafbc748fb7@tronnes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=8nJEP1OIZ-IA:10 a=7gkXJVJtAAAA:8 a=NEAV23lmAAAA:8
        a=cW4LiGG8rzNfBP2GKeIA:9 a=zXGJP8uy7eB9i7Ui:21 a=i9cDsfZIGXpLSZjh:21
        a=wPNLvfGTeEIA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Noralf.

On Tue, Aug 07, 2018 at 06:40:29PM +0200, Noralf Trønnes wrote:
> Hi Sam,
> 
> Den 02.08.2018 21.45, skrev Sam Ravnborg:
> >The pardata supports implement a simple bus for devices
> >that are connected using a parallel bus driven by GPIOs.
> >The is often used in combination with simple displays
> >that is often seen in older embedded designs.
> >There is a demand for this support also in the linux
> >kernel for HW designs that uses these kind of displays.
> >
> >The pardata bus uses a platfrom_driver that when probed
> >creates devices for all child nodes in the DT,
> >which are then supposed to be handled by pardata_drivers.
> >
> >Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> >---
> 
> From a quick look at this I have these comments:
> 1. There can only be one implementation of this bus, the gpio one.
>    There are SOC's with parallel bus hardware so you need to allow for
>    more implementations.
> 2. The client shouldn't do the bus signaling. This should be hidden
>    behind read and write functions in pardata.
> 3. I would also suggest you add an address bus instead of the RS pin
> 4. I don't think reset belongs in the bus. It's a device thing.

Excellent feedback - I will address this in v2.

> 5. You can use gpiod_set_array_value() in the gpio implementation.
>    Some gpio drivers can set all gpios at once.

Yes, it is already used. But only for DB0 to DB7 as there
are timing constraings for the others.

> 
> I made an attempt at implementing a bus like this a while back:
> https://github.com/notro/fbdbi/tree/master/i80

Thanks, very helpfull.

v2 will take a while as I plan to have something that actually works
before posting next version.

One open question. Miguel Ojeda mentioned that there is already a
limited fbdev driver made on top of parport (part of auxdisplay).
Is it the correct design to come up with a new bus or should this
try to build on top of parport?

I did not check in details if using parport is possible, but from a
quick look it is doable.
But then we use parport for something that it originally was not
designed for and we drag with us a lot of extra functionality.
So I like the slimmer pardata bus.

	Sam
