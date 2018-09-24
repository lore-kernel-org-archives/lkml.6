Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECFBECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111B52086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111B52086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeIXQbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:31:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:50503 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbeIXQbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:31:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 03:29:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="92720404"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 24 Sep 2018 03:20:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 24 Sep 2018 13:20:20 +0300
Date:   Mon, 24 Sep 2018 13:20:20 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Input <linux-input@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Message-ID: <20180924102020.GJ11965@kuha.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180920135348.GF11965@kuha.fi.intel.com>
 <CACRpkdZtM4G=4r3m6vLTms9MJFkdiOdPFucebO-Z0Kh-3ws3+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZtM4G=4r3m6vLTms9MJFkdiOdPFucebO-Z0Kh-3ws3+g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Sep 21, 2018 at 08:36:53AM -0700, Linus Walleij wrote:
> On Thu, Sep 20, 2018 at 6:53 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> 
> > The child nodes will change the purpose of the build-in property
> > support. Originally the goal was just to support adding of build-in
> > device properties to real firmware nodes, but things have changed
> > quite a bit from that. These child nodes are purely tied to the
> > build-in device property support, so we should be talking about adding
> > pset type child nodes to pset type parent nodes in the API:
> > fwnode_pset_add_child_node(), or something like that.
> >
> > I'm sorry to be a bit of pain in the butt with this. The build-in
> > property support is a hack, it always was. A useful hack, but hack
> > nevertheless. That means we need to be extra careful when expanding
> > it, like here.
> 
> I dunno how we got to here, what I tried to solve and Dmitry tries
> to make more general is converting old boardfiles to use fwnode, because
> I initially tried to just support gpio descriptors from board files.

I understand that, but what I'm trying to say is that the solution for
the child nodes is not generic enough. I'll try to explain below.

> If boardfiles is what you mean with "build-in property support" I don't
> know, it predates both device tree and ACPI and any other hardware
> descriptions on the ARM architecture, from the perspective of these
> systems things are fine and the hardware description languages
> are the novelty...

Rafael talked about "build-in properties" at one point, and I just
started using that expression after that, but it's probable not the
best term to describe this thing.

But please note that we are not talking about only static information
with these property sets. They can be populated dynamically as well,
so this kind of extensions must consider and support that. On top of
board files we need to consider things like glue and probing drivers
and even buses in some cases.

> But I guess you know because you worked with OMAP :)
> 
> So there is something I don't understand here.

Sorry for the poor choice of words on my behalf. I guess I'm not
explaining my point properly. Let me try again.

So I'm seeing a case that this solution does not seem to be able to
support, but ultimately it will need to do so: with USB ports we are
going to need to be able to assign a device to the child nodes that
represent those ports.

To be honest, normally I would not care about that, and I would simply
wait for this to go into mainline, and then propose a modification to
it so it can also support that other case.

However, this time I feel that we should not do that. The solution for
the child nodes should be implemented so that it can support all the
known cases from the beginning. The reason for that is because I fear
that we'll end up having a pile of ad-hoc style solutions, each
solving an individual problem, and a whole lot of duplicated stuff for
these property sets. In the end we will have spaghetti with meatballs
that nobody is able fully understand nor handle. And I really see a
strong possibility for that to happen here.


Thanks,

-- 
heikki
