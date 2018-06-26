Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F619C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584C324E09
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iImAD7be"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584C324E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932786AbeFZROJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752880AbeFZROH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:14:07 -0400
Received: from localhost (unknown [207.160.231.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0113624248;
        Tue, 26 Jun 2018 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530033247;
        bh=ZAqEDXC4a0mxQb7sjJI9TiwUnBb+NjYV2VOyOp1/7og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iImAD7be8Tyvi0ICmPnEaLlsSyt7xWXDHbzn0YoIun153ILXLnw/zprF0JJ7Roavl
         e/oTViHT1kgepu+cnFmL19fg117uzqytE6yy0nDwpPWprxZyvAZTSZVQJcfD8GN1e4
         gq6xS97Evd8ERui+u+LMBlebQL6dH2V5xn3NJD3c=
Date:   Tue, 26 Jun 2018 12:14:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>, n0000b.n000b@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume bridges w/o drivers on
 suspend-to-RAM
Message-ID: <20180626171406.GC146680@bhelgaas-glaptop.roam.corp.google.com>
References: <35587465.8Nave9aG7d@aspire.rjw.lan>
 <20180626140115.GA146680@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0jc5oJzEX6QVDVjsQLmLxXHg3PSyepbh50dLXOtnHPgrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jc5oJzEX6QVDVjsQLmLxXHg3PSyepbh50dLXOtnHPgrA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 04:22:00PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 26, 2018 at 4:01 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jun 26, 2018 at 12:06:01PM +0200, Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> >> +     /*
> >> +      * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend
> >> +      * confuses the platform firmware, so avoid doing that, unless the
> >> +      * bridge has a driver that should take care of PM handling.
> >> +      */
> >> +     if (pci_is_bridge(dev) && !dev->driver)
> >> +             return true;
> >
> > It sounds like the question of whether leaving a bridge in D3 confuses
> > the firmware has a platform-specific answer.
> 
> Well, it may confuse the platform firmware in general.
> 
> > How does the driver PM handling know how to do the right thing?
> 
> For endpoints this is not an issue as they always have been expected
> to be in D3 before passing control to the platform firmware on S3
> entry, but we've never done that for bridges by default, except for
> PCIe ports with PM enabled (in which case the driver decides whether
> or not to enable it).

If there's any spec reference for the expected power states of devices
when entering S3, that would be useful here.  I can't tell if there's
any guidance for this or if it's just figured out experimentally.

> > Does it need to know whether
> > it's safe to put the device in D3?  Or maybe a device is never put in
> > D3 for system suspend if it has a driver?
> 
> As per the above, endpoints should be OK (or they are quirky if not),
> but bridges are sort of a gray area.  PCIe ports for which we enable
> PM should be fine, for the rest it's better to be conservative and
> resume them IMO.
