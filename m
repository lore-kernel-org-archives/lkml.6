Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5102DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0893E2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0893E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeIFP4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:56:03 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:49861 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeIFP4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:56:02 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id EC8B1100DEC8A;
        Thu,  6 Sep 2018 13:21:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9DC3E44FAAB; Thu,  6 Sep 2018 13:21:01 +0200 (CEST)
Date:   Thu, 6 Sep 2018 13:21:01 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/2] thunderbolt: Initialize after IOMMUs
Message-ID: <20180906112101.qmhkcqx73zmmko3q@wunner.de>
References: <20180903132012.23531-1-mika.westerberg@linux.intel.com>
 <20180903132012.23531-2-mika.westerberg@linux.intel.com>
 <20180905084746.xmckzskxzsdliz3e@wunner.de>
 <20180905094602.GH2283@lahna.fi.intel.com>
 <20180906081337.3mosfpfggfmoj633@wunner.de>
 <20180906103602.GV2283@lahna.fi.intel.com>
 <20180906110049.gfdhurvkvvdjw7zh@wunner.de>
 <20180906110756.GY2283@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906110756.GY2283@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 02:07:56PM +0300, Mika Westerberg wrote:
> On Thu, Sep 06, 2018 at 01:00:49PM +0200, Lukas Wunner wrote:
> > On Thu, Sep 06, 2018 at 01:36:02PM +0300, Mika Westerberg wrote:
> > > On Thu, Sep 06, 2018 at 10:13:37AM +0200, Lukas Wunner wrote:
> > > > So with this patch, you rely on the linker ordering nhi_init() after
> > > > ir_dev_scope_init(), however to the best of my knowledge the link
> > > > order is not guaranteed.
> > > 
> > > What says that?
> > 
> > Within the same initcall level, the ordering is determined by the Makefile
> > AFAIK.  Someone changes the Makefile, your dependency scheme falls apart.
> 
> There are other drivers doing the same so they would fail as well. It is
> common practice AFAIK.

That doesn't make it a *good* practice.


> > > > Looking at commit acb40d841257, which started this, I'm wondering
> > > > why you did not simply export tbnet_init() and call it from the
> > > > thunderbolt driver after the property stuff has been fully set up?
> > > > After all, thunderbolt-net is useless without thunderbolt or am I
> > > > missing something?  Then you could revert back to module_init().
> > > 
> > > The same reason you don't call PCI driver functions from PCI core. It
> > > makes absolutely zero sense.
> > > 
> > > Thunderbolt is bus and provides driver API to drivers. We hopefully are
> > > getting other service drivers (say SCSI over TBT) that are going to be
> > > use the same interfaces.
> > 
> > Then add a blocking notifier chain into which these service drivers can
> > hook.  Other buses have that as well.
> 
> It is really too complex to add notifier just for that. This works fine
> and is not against any kernel principles I am aware of.

Well, there's a difference between "it works and gets the job done,
let's move on" and "let's try to find a solution that fixes not just
this use case but potentially benefits others as well".

FWIW, what I had in mind is a blocking notifier chain that gets called
when a bus registers or unregisters.  TB service drivers would then check
if it's tb_bus_type and start initialization.

Thanks,

Lukas
