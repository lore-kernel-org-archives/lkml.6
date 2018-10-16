Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB9CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBBD20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EBBD20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJPQaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:30:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:5298 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbeJPQaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:30:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 01:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,387,1534834800"; 
   d="scan'208";a="99587410"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 16 Oct 2018 01:40:51 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 16 Oct 2018 11:40:50 +0300
Date:   Tue, 16 Oct 2018 11:40:50 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
Message-ID: <20181016084050.GF24771@kuha.fi.intel.com>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
 <CACRpkdZddvkgL1qwO=35y_Jps0+=QD3nPKQwgMEH+zcCH2NPdg@mail.gmail.com>
 <CAJZ5v0h3uENUqbcb=0HH1wT_0MYQzcHct2d19tiarvXEdRay+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h3uENUqbcb=0HH1wT_0MYQzcHct2d19tiarvXEdRay+Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 09:36:33AM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 16, 2018 at 9:35 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Fri, Oct 12, 2018 at 1:39 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> >
> > > To continue the discussion started by Dmitry [1], this is my proposal
> > > that I mentioned in my last mail. In short, the idea is that instead
> > > of trying to extend the support for the currently used struct
> > > property_set, I'm proposing that we introduce a completely new,
> > > independent type of fwnode, and replace the struct property_set with
> > > it. I'm calling the type "software node" here.
> >
> > I'm a big fan of this approach.
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > for all patches.
> >
> > I don't know who can finally review and merge this though,
> > I guess Rafael?
> 
> Yes, that would be me. :-)
> 
> I no one speaks up against them, I'll pick them up.

Let me send a final version of these.

I need to add one more patch to the series where I remove an extra
device_remove_properties() call from platform_device_del().

It's unnecessary in any case as device_del() calls
device_remove_properties() for every device, but as the properties are
removed there before the device is removed, we're unable to deduct
the final ref count in the "remove" platform notification since our
node is no longer bind to the device.


Thanks,

-- 
heikki
