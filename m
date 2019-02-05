Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B73CC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C7B217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbfBESnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:43:02 -0500
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:35215 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726731AbfBESm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:42:59 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id A2CAE83777E3;
        Tue,  5 Feb 2019 18:42:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: team78_198465e6d7129
X-Filterd-Recvd-Size: 1752
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Feb 2019 18:42:55 +0000 (UTC)
Message-ID: <8553086eaec167846992f1cff12aa388cee81767.camel@perches.com>
Subject: Re: [PATCH v2 2/2] r8169: Avoid pointer aliasing
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>, thierry.reding@gmail.com
Cc:     hkallweit1@gmail.com, andrew@lunn.ch, nic_swsd@realtek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 05 Feb 2019 10:42:54 -0800
In-Reply-To: <20190204.192040.1074738183781998611.davem@davemloft.net>
References: <20190204164213.30727-1-thierry.reding@gmail.com>
         <20190204164213.30727-2-thierry.reding@gmail.com>
         <20190204.192040.1074738183781998611.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-04 at 19:20 -0800, David Miller wrote:
> From: Thierry Reding <thierry.reding@gmail.com>
> Date: Mon,  4 Feb 2019 17:42:13 +0100
> 
> > @@ -7316,7 +7325,7 @@ static int rtl_get_ether_clk(struct rtl8169_private *tp)
> >  static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  {
> >       const struct rtl_cfg_info *cfg = rtl_cfg_infos + ent->driver_data;
> > -     u8 mac_addr[ETH_ALEN] __aligned(4) = {};
> > +     u8 mac_addr[ETH_ALEN] = {};
> >       struct rtl8169_private *tp;
> 
> I agree with Heiner, you have to provide at least 2 byte alignment for this
> buffer due to the reasons he stated.

It's declared after a pointer so it is already is 2 byte aligned.

A lot of drivers wouldn't work otherwise.


