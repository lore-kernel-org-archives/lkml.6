Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B043C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8E320821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfBLMnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:43:37 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:50019 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfBLMng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:43:36 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 102CE100D940B;
        Tue, 12 Feb 2019 13:43:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AE1F5160E18; Tue, 12 Feb 2019 13:43:33 +0100 (CET)
Date:   Tue, 12 Feb 2019 13:43:33 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 12/28] thunderbolt: Add functions for allocating and
 releasing hop IDs
Message-ID: <20190212124333.hgrnm6owtuqzp4iu@wunner.de>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-13-mika.westerberg@linux.intel.com>
 <20190210121353.fw7gj4pm7ce3flvf@wunner.de>
 <20190211083043.GT7875@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211083043.GT7875@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:30:43AM +0200, Mika Westerberg wrote:
> On Sun, Feb 10, 2019 at 01:13:53PM +0100, Lukas Wunner wrote:
> > If there are two Macs at the ends of the daisy-chain with Thunderbolt
> > devices in-between, the other Mac may already have established tunnels
> > to some of the devices and therefore has occupied hop entries in the
> > devices' path config space.  How do you ensure that you don't allocate
> > the same entries and overwrite the other Mac's hop entries, thereby
> > breaking its tunnels?
> 
> If the other Mac has enumerated the device (set the upstream port,
> route, depth) then the other Mac cannot access the device. You get an
> error (we deal with that in the later patch in the series when we
> identify XDomain connections). The Hop ID allocation is only relevant in
> a single domain.  Crossing one needs to have protocol such as we have in
> case of ThunderboltIP to negotiate Hop IDs used in the link between two
> domains.

Understood now, thanks.  (Well, in part at least.)

It looks like there's a race condition currently in tb_switch_configure()
wherein two machines on the daisy chain may write the config simultaneously
and overwrite each other's changes.  Isn't there some kind of synchonization
mechanism available to prevent such an outcome?

Thanks,

Lukas
