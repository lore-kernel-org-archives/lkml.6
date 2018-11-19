Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F54C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AFF2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="otYy1kce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AFF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeKTBey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:34:54 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:40574 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729392AbeKTBey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=PW/karcgM4kSkrrHapxyj81pv+/jN6zfGatvHa6BB10=;
        b=otYy1kceijuuvHxbonE0R+8aFp3ktP9qvcJSemxyUknPEqIQ8WKlYmFr7+CyDTe+tPs05Fo6m11/4/YBfoEYl9pSF4MESC2+M8mAX0BU5A6Ypu/6+rQqp+BVA5KbQSA8IxUGUo09JSch823P0Ti9bJNh9rmUF/SOm0V5T748nec=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gOlCT-0007eG-5E; Mon, 19 Nov 2018 16:10:57 +0100
Date:   Mon, 19 Nov 2018 16:10:57 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>, davem@davemloft.net,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/6] net: phy: mscc: migrate to
 phy_select/restore_page functions
Message-ID: <20181119151057.GC26852@lunn.ch>
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
 <20181008100728.24959-2-quentin.schulz@bootlin.com>
 <mvm8t1pazea.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvm8t1pazea.fsf@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 03:57:17PM +0100, Andreas Schwab wrote:
> On Okt 08 2018, Quentin Schulz <quentin.schulz@bootlin.com> wrote:
> 
> > The Microsemi PHYs have multiple banks of registers (called pages).
> > Registers can only be accessed from one page, if we need a register from
> > another page, we need to switch the page and the registers of all other
> > pages are not accessible anymore.
> >
> > Basically, to read register 5 from page 0, 1, 2, etc., you do the same
> > phy_read(phydev, 5); but you need to set the desired page beforehand.
> >
> > In order to guarantee that two concurrent functions do not change the
> > page, we need to do some locking per page. This can be achieved with the
> > use of phy_select_page and phy_restore_page functions but phy_write/read
> > calls in-between those two functions shall be replaced by their
> > lock-free alternative __phy_write/read.
> >
> > Let's migrate this driver to those functions.
> 
> This has some serious locking problem.

Hi Andreas

Could you be more specific. Are you getting a deadlock? A WARN_ON?

Thanks,
	Andrew
