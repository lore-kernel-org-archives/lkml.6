Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6791AC2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7D72084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="NZMD3/2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfAUNNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:13:11 -0500
Received: from mail.nic.cz ([217.31.204.67]:57928 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfAUNNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:13:11 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTPS id BE31C6261A;
        Mon, 21 Jan 2019 14:13:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1548076388; bh=oeM2EsRdZsjuI3jq5tqzcAQLdHs3WbSo4XO46y4H1qo=;
        h=Date:From:To;
        b=NZMD3/2KtqWc3AoCBVkpGfJr6jVbT81cN5fhXwhgZslivp0o3D5v11g4lTwg6POIe
         ISkZe6Y4gsPyzvIYDkyO9yrILKK+lnbfGxRQDWzjRpyrjz1BWPPsbbKsBc0TZkupK6
         BusmNQ4fVXcMvXO/J172LRcivARTcoq/CIQbXP54=
Date:   Mon, 21 Jan 2019 14:12:54 +0100
From:   Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC] ARM64: dts: marvell: Add DTS file for Turris Mox
Message-ID: <20190121141254.3208d949@dellmb.labs.office.nic.cz>
In-Reply-To: <87lg3im3t4.fsf@FE-laptop>
References: <20181113134408.5681-1-marek.behun@nic.cz>
        <87lg3im3t4.fsf@FE-laptop>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 15:35:35 +0100
Gregory CLEMENT <gregory.clement@bootlin.com> wrote:

> > The basic module can be extended by different modules.
> > When those modules are connected, U-Boot has to let kernel know via
> > device-tree. Since modules can be connected in different order and
> > some modules can be connected multiple times (up to three 8-port
> > switch modules can be connected), using dtb overlays would result in
> > too files.  
> 
> What do you mean by too many files?
> 
> The dtb overlays seems really matches your situation.
> Usually we have one dtb part by module and then we mix them together.
> 
> Gregory

Hi Gregory,

the problem is that in some cases here some even if you have the same
module, some parameters have to be different depending on which
position the module is in the topology and what type of module is
before it.

For example up to three switch modules can be connected one after
another, and although physically they are the same, their dtb
parameters (MDIO address and whether they are connected to CPU or
another switch module) are different. So if I wanter to use overlays
without dtb modification from u-boot, I would have to have three
overlays for Peridot module, for topologies:
  peridot
  peridot-peridot
  peridot-peridot-peridot

three for Topaz module:
  topaz
  peridot-topaz
  peridot-peridot-topaz

and four for SFP module:
  sfp
  peridot-sfp
  peridot-peridot-sfp
  peridot-peridot-peridot-sfp

For the PCIe and USB module this is not the case, only one overlay for
each. But I thought (and still think) that in this case it is more
elegant to just enable the modules in U-Boot than to use so many
different overlays. And since I already thought up this solution for
SFP and switch modules, I used it for the PCIe and USB modules as well,
instead of mixing overlays there.

I am of course willing to rewrite this to use overlays, if you guys are
unwilling to merge it done this way, but I think this solution is
better.

Also, I would like to have the dts definitions for all modules
officially supported by Mox to have in the kernel, and if this was done
via overlays, it would not be merged, or am I wrong? Are there overlay
dts sources for some device in the kernel?

Marek
