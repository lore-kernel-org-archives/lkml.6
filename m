Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9BDC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C9226957
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C9226957
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964976AbeFZKdd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:33:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:27980 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933784AbeFZKda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:33:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 03:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="211233259"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga004.jf.intel.com with SMTP; 26 Jun 2018 03:33:27 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 26 Jun 2018 13:33:26 +0300
Date:   Tue, 26 Jun 2018 13:33:26 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>, n0000b.n000b@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI / ACPI / PM: Resume bridges w/o drivers on
 suspend-to-RAM
Message-ID: <20180626103326.GY2558@lahna.fi.intel.com>
References: <35587465.8Nave9aG7d@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35587465.8Nave9aG7d@aspire.rjw.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 12:06:01PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is reported that commit c62ec4610c40 (PM / core: Fix direct_complete
> handling for devices with no callbacks) introduced a system suspend
> regression on Samsung 305V4A by allowing a PCI bridge (not a PCIe
> port) to stay in D3 over suspend-to-RAM, which is a side effect of
> setting power.direct_complete for the children of that bridge that
> have no PM callbacks.
> 
> On the majority of systems PCI bridges are not allowed to be
> runtime-suspended (the power/control sysfs attribute is set to "on"
> for them by default), but user space can change that setting and if
> it does so and a given bridge has no children with PM callbacks, the
> direct_complete optimization will be applied to it and it will stay
> in suspend over system suspend.  Apparently, that confuses the
> platform firmware on the affected machine and that may very well
> happen elsewhere, so avoid the direct_complete optimization for
> PCI bridges with no drivers (if there is a driver, it should take
> care of the PM handling) on suspend-to-RAM altogether (that should
> not matter for suspend-to-idle as platform firmware is not involved
> in it).
> 
> Fixes: c62ec4610c40 (PM / core: Fix direct_complete handling for devices with no callbacks)
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199941
> Reported-by: n0000b.n000b@gmail.com
> Tested-by: n0000b.n000b@gmail.com
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
