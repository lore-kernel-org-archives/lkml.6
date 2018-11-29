Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1325BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A0F20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijjxN5c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A0F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbeK3AgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:36:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbeK3AgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:36:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FE77208E7;
        Thu, 29 Nov 2018 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543498253;
        bh=82UEa3U3cTJixzFdVrFjusBvn9Pw0eysLdvnCcfHtCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ijjxN5c7AJ7B3YsqDa9HvwNAa749v64tyWvKnXZmSejBUQeD6y70QL4HeUmTF2kEo
         13wCEBC87CQ2JrzGpNm5J7cPDbrOoKwe3eOGUbUbul9xrpdSdbEEgamK7Da3/rdF93
         ZOi1bKJHbkt8+kf8ryxEtVieEwdvaBxLl4sRCycM=
Date:   Thu, 29 Nov 2018 14:30:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Paolo Pisati <p.pisati@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [stable, netdev 4.4+] lan78xx: make sure RX_ADDRL &
 RX_ADDRH regs are always up to date
Message-ID: <20181129133051.GA11799@kroah.com>
References: <1541609457-28725-1-git-send-email-p.pisati@gmail.com>
 <20181108001751.GA8097@sasha-vm>
 <20181108110127.GA8415@harukaze>
 <20181108154904.GD8097@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108154904.GD8097@sasha-vm>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 10:49:04AM -0500, Sasha Levin wrote:
> On Thu, Nov 08, 2018 at 12:01:27PM +0100, Paolo Pisati wrote:
> > On Wed, Nov 07, 2018 at 07:17:51PM -0500, Sasha Levin wrote:
> > > So why not just take 760db29bdc completely? It looks safer than taking a
> > > partial backport, and will make applying future patches easier.
> > > 
> > > I tried to do it and it doesn't look like there are any dependencies
> > > that would cause an issue.
> > 
> > Somehow i was convinced it didn't build on 4.4.x... can you pick it up?
> > 
> > commit 760db29bdc97b73ff60b091315ad787b1deb5cf5
> > Author: Phil Elwell <phil@raspberrypi.org>
> > Date:   Thu Apr 19 17:59:38 2018 +0100
> > 
> >    lan78xx: Read MAC address from DT if present
> > 
> >    There is a standard mechanism for locating and using a MAC address from
> >    the Device Tree. Use this facility in the lan78xx driver to support
> >    applications without programmed EEPROM or OTP. At the same time,
> >    regularise the handling of the different address sources.
> > 
> >    Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> >    Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> Can you confirm it actually works on 4.4?

It does not build on 4.4, so I'm dropping it :(

greg k-h
