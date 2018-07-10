Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AD0C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098E920877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098E920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933344AbeGJNAB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:00:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59238 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbeGJM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:59:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 960EECFC;
        Tue, 10 Jul 2018 12:59:58 +0000 (UTC)
Date:   Tue, 10 Jul 2018 14:59:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2] driver core: Partially revert "driver core: correct
 device's shutdown order"
Message-ID: <20180710125956.GA25343@kroah.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan>
 <2927655.Y1qg3UnIrE@aspire.rjw.lan>
 <5284251.Resgjlja2Q@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5284251.Resgjlja2Q@aspire.rjw.lan>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:51:33PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 52cdbdd49853 (driver core: correct device's shutdown order)
> introduced a regression by breaking device shutdown on some systems.
> 
> Namely, the devices_kset_move_last() call in really_probe() added by
> that commit is a mistake as it may cause parents to follow children
> in the devices_kset list which then causes shutdown to fail.  For
> example, if a device has children before really_probe() is called
> for it (which is not uncommon), that call will cause it to be
> reordered after the children in the devices_kset list and the
> ordering of that list will not reflect the correct device shutdown
> order any more.
> 
> Also it causes the devices_kset list to be constantly reordered
> until all drivers have been probed which is totally pointless
> overhead in the majority of cases and it only covered an issue
> with system shutdown, while system-wide suspend/resume potentially
> had the same issue on the affected platforms (which was not covered).
> 
> Moreover, the shutdown issue originally addressed by the change in
> really_probe() made by commit 52cdbdd49853 is not present in 4.18-rc
> any more, since dra7 started to use the sdhci-omap driver which
> doesn't disable any regulators during shutdown, so the really_probe()
> part of commit 52cdbdd49853 can be safely reverted.  [The original
> issue was related to the omap_hsmmc driver used by dra7 previously.]
> 
> For the above reasons, revert the really_probe() modifications made
> by commit 52cdbdd49853.
> 
> The other code changes made by commit 52cdbdd49853 are useful and
> they need not be reverted.
> 
> Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
> Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
> Reported-by: Pingfan Liu <kernelfans@gmail.com>
> Tested-by: Pingfan Liu <kernelfans@gmail.com>
> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2: Added information from Kishon on the fact that it should be safe
>        to revert the really_probe() modifications added by the
>        problematic commit.  Also added the Reviewed-by tag from Kishon.

Looks good to me, want me to queue it up in my tree, or are you going to
send it on to Linus?

And shouldn't this have a stable tag as well?

thanks,

greg k-h
