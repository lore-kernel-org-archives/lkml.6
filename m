Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1187C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853F1217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfBESra convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:47:30 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:41213 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfBESr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:47:29 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BD6B320002;
        Tue,  5 Feb 2019 18:47:24 +0000 (UTC)
Date:   Tue, 5 Feb 2019 19:47:23 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vivien Didelot <vivien.didelot@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Prevent suspend to RAM
Message-ID: <20190205194723.6d567b4e@xps13>
In-Reply-To: <20190205112857.GB13620@t480s.localdomain>
References: <20190205110728.11451-1-miquel.raynal@bootlin.com>
        <20190205112857.GB13620@t480s.localdomain>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivien,

Vivien Didelot <vivien.didelot@gmail.com> wrote on Tue, 5 Feb 2019
11:28:57 -0500:

> Hi Miquel,
> 
> On Tue,  5 Feb 2019 12:07:28 +0100, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > +/* There is no suspend to RAM support at DSA level yet, the switch configuration
> > + * would be lost after a power cycle so prevent it to be suspended.
> > + */
> > +static int __maybe_unused mv88e6xxx_suspend(struct device *dev)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static int __maybe_unused mv88e6xxx_resume(struct device *dev)
> > +{
> > +	return 0;
> > +}  
> 
> The code looks good but my only concern is -EOPNOTSUPP. In this
> context this code is specific to callbacks targeting bridge and
> switchdev, while the dev_pm_ops are completely parallel to DSA.
> 
> It is intuitive but given Documentation/power/runtime_pm.txt, this
> will default to being interpreted as a fatal error, while -EBUSY
> seems to keep the device in an 'active' state in a saner way.
> 
> I don't understand yet how to properly tell PM core that suspend to RAM
> isn't supported. If an error code different from -EAGAIN or -EBUSY
> is the way to go, I'm good with it:

I do share your concern and I went through the Documentation but I did
not find a unified way to tell the PM core the feature is unsupported.

By grepping code, I realized returning -EOPNOTSUPP was a recurrent
alternative so here we are. I also considered -EBUSY but it seems more
like a "I cannot right now" and -EAGAIN which is more a "try again
soon". Anyway, no matter the error code returned, I'm not sure if the PM
core actually cares?
 
> Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
> 
> 
> Thanks,
> 
> 	Vivien


Thanks,
Miquèl
