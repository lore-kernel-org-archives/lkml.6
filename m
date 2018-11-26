Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF5DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D0C20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 01:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D0C20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeKZM0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 07:26:33 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:21779 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726060AbeKZM0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 07:26:33 -0500
X-UUID: 2c6daa12a1994c90b4f11052d27b84ff-20181126
X-UUID: 2c6daa12a1994c90b4f11052d27b84ff-20181126
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1517893924; Mon, 26 Nov 2018 09:33:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 26 Nov 2018 09:33:24 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 26 Nov 2018 09:33:24 +0800
Message-ID: <1543196004.21289.1.camel@mtkswgap22>
Subject: Re: [RFC PATCH] of: make MAX_RESERVED_REGIONS configurable
From:   Miles Chen <miles.chen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 26 Nov 2018 09:33:24 +0800
In-Reply-To: <CAL_Jsq+O1YDP1yiHZpcxUaFG1LYDqi74D_kEnErP+cwGDppVWQ@mail.gmail.com>
References: <1542787873-8429-1-git-send-email-miles.chen@mediatek.com>
         <CAL_JsqLGvUYQmCGXLgSO+6kFj2i87dpaTbMGbyu5oMt=eeu35A@mail.gmail.com>
         <1542855088.15789.6.camel@mtkswgap22>
         <CAL_Jsq+O1YDP1yiHZpcxUaFG1LYDqi74D_kEnErP+cwGDppVWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 41420FF2AE2873810A499AC0100BA0E77266485F093476C8D88BE13CC359F63C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-24 at 14:56 -0600, Rob Herring wrote:
> On Wed, Nov 21, 2018 at 8:51 PM Miles Chen <miles.chen@mediatek.com> wrote:
> >
> > On Wed, 2018-11-21 at 10:39 -0600, Rob Herring wrote:
> > > On Wed, Nov 21, 2018 at 2:11 AM <miles.chen@mediatek.com> wrote:
> > > >
> > > > From: Miles Chen <miles.chen@mediatek.com>
> > > >
> > > > When we use more than 32 entries in /resered-memory,
> > > > there will be an error message: "not enough space all defined regions.".
> > > > We can increase MAX_RESERVED_REGIONS to fix this.
> > > >
> > > > commit 22f8cc6e3373 ("drivers: of: increase MAX_RESERVED_REGIONS to 32")
> > > > increased MAX_RESERVED_REGIONS to 32 but I'm not sure if increasing
> > > > MAX_RESERVED_REGIONS to 64 is suitable for everyone.
> > > >
> > > > In this RFC patch, CONFIG_MAX_OF_RESERVED_REGIONS is added and used as
> > > > MAX_RESERVED_REGIONS. Add a sanity test to make sure that
> > > > MAX_RESERVED_REGIONS is less than INIT_MEMBLOCK_REGIONS.
> > > > Users can configure CONFIG_MAX_OF_RESERVED_REGIONS according to their
> > > > need.
> > >
> > > I don't want a kconfig option for this. I think it should be dynamic instead.
> > >
> > > The current flow is like this:
> > >
> > > for each reserved node:
> > >   - call memblock_reserve
> > >   - Add info to reserved_mem array
> > >
> > > I think we should change it to:
> > >
> > > for each reserved node:
> > >   - call memblock_reserve
> > >   - count number of nodes
> > >
> > > Alloc array using memblock_alloc
> > >
> > > for each reserved node:
> > >    - Add info to reserved_mem array
> > >
> >
> > thanks for your comment.
> >
> > I reviewed the flow and it might be easier to count the
> > nodes and setup array first:
> >
> > for each reserved node:
> >     - count number of nodes
> >
> > Alloc array using memblock_alloc
> >
> >
> > for each reserved node:
> >    - call memblock_reserve
> 
> The order here is wrong. It is important that you reserve the memory
> blocks before doing any allocations.

thanks for pointing that out. You are right. I'll follow your
suggestion.

> 
> >    - Add info to reserved_mem array
> >
> > What do you think?
> >
> > > Rob
> >
> >


