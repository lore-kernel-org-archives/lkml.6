Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AB1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD0221780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD0221780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbeKNRpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:45:55 -0500
Received: from ms.tdt.de ([195.243.126.94]:57849 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbeKNRpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:45:55 -0500
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id C9083203C7;
        Wed, 14 Nov 2018 07:43:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Nov 2018 08:43:49 +0100
From:   Martin Schiller <ms@dev.tdt.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, davem@davemloft.net
Subject: Re: [PATCH v2] net: phy: mdio-gpio: fix access that may sleep
Organization: TDT GmbH
In-Reply-To: <20181114070528.GD17052@lunn.ch>
References: <20181114061703.11026-1-ms@dev.tdt.de>
 <20181114063703.13379-1-ms@dev.tdt.de> <20181114070528.GD17052@lunn.ch>
Message-ID: <248deac95f412b925b0de44ead2ffec6@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-14 08:05, Andrew Lunn wrote:
> On Wed, Nov 14, 2018 at 07:37:03AM +0100, Martin Schiller wrote:
>> This commit re-enables support for slow GPIO pins. It was initially
>> introduced by commit
>> 	2d6c9091ab7630dfcf34417c6683ce4764d7d40a
>> and got lost by commit
>> 	7e5fbd1e0700f1bdb94508f84ec2aeb01eed7b12
> 
> Hi Martin
> 
> Was it really lost? It looks like _cansleep() just adds an extra check
> might_sleep_if(extra_checks), but it does not change any
> functionality.

Well, you are right, the functionality itself is not broken, but using
the NON _cansleep() functions on GPIOs that have the cansleep flag set,
this leads to a lot of kernel warnings/backtraces which makes the system
in fact useless.

Thats the WARN_ON() here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c?h=v4.20-rc2#n2992

and here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c?h=v4.20-rc2#n3304

> 
> So the change itself is O.K, i'm just not too sure about the commit
> message.
> 
> 	Andrew

Hmm, ok. What would you suggest for a better commit message?

I thought it would be helpful to know that this was already in there
and got (inadvertently?) removed by another commit.

Martin
