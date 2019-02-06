Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B63C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AF2218D4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfBFHZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:25:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:51382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbfBFHZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:25:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3F1FAFBE;
        Wed,  6 Feb 2019 07:25:31 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id AF9F6E0142; Wed,  6 Feb 2019 08:25:30 +0100 (CET)
Date:   Wed, 6 Feb 2019 08:25:30 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     netdev@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>,
        thierry.reding@gmail.com, hkallweit1@gmail.com, andrew@lunn.ch,
        nic_swsd@realtek.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] r8169: Avoid pointer aliasing
Message-ID: <20190206072530.GH21401@unicorn.suse.cz>
References: <20190204164213.30727-2-thierry.reding@gmail.com>
 <20190204.192040.1074738183781998611.davem@davemloft.net>
 <8553086eaec167846992f1cff12aa388cee81767.camel@perches.com>
 <20190205.111404.1429981997134153696.davem@davemloft.net>
 <143a8f022c73c71f170eb04dc0b763f9ae83f6b5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <143a8f022c73c71f170eb04dc0b763f9ae83f6b5.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 11:19:04AM -0800, Joe Perches wrote:
> On Tue, 2019-02-05 at 11:14 -0800, David Miller wrote:
> > From: Joe Perches <joe@perches.com>
> > Date: Tue, 05 Feb 2019 10:42:54 -0800
> > 
> > > On Mon, 2019-02-04 at 19:20 -0800, David Miller wrote:
> > >> From: Thierry Reding <thierry.reding@gmail.com>
> > >> Date: Mon,  4 Feb 2019 17:42:13 +0100
> > >> 
> > >> > @@ -7316,7 +7325,7 @@ static int rtl_get_ether_clk(struct rtl8169_private *tp)
> > >> >  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> > >> >  {
> > >> >       const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
> > >> > -     u8 mac_addr[ETH_ALEN] __aligned(4) = {};
> > >> > +     u8 mac_addr[ETH_ALEN] = {};
> > >> >       struct rtl8169_private *tp;
> > >> 
> > >> I agree with Heiner, you have to provide at least 2 byte alignment for this
> > >> buffer due to the reasons he stated.
> > > 
> > > It's declared after a pointer so it is already is 2 byte aligned.
> > > 
> > > A lot of drivers wouldn't work otherwise.
> > 
> > That's assuming a lot about what the compiler will do when nit allocates
> > local variables to the stack.
> 
> It's also assuming what a compiler will do when
> it defines a struct.

This is not a structure member, it's a local variable. I'm not aware of
any C norm requirement for ordering of local variables on the stack.
After all, some of them might not be on the stack at all and use only
registers or be optimized out completely.

Michal Kubecek
