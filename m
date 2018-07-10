Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA30C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E6220883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RC8F4LKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E6220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933293AbeGJMW7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:22:59 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49308 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753275AbeGJMW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:22:57 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6ACMWZD122173;
        Tue, 10 Jul 2018 07:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531225353;
        bh=uJ507R84Xt3W5o9Pkyn0fon8FDpGq97Xuu6z1pb6AjY=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=RC8F4LKwdPWJJsGX/G9gd0lXuCDqf3sQ6BF3QuKiYRWDqXMhJMSEOA00XPh8gnCi7
         XOvWvjl33MctvBVcTRcqwj4oBwGpzsVWUWbXPtufRpg9GNW1zVVSYWgk05ZekEkmQP
         Fa4CFyoUuslgr4TEvQUirmi6LJdyJCk7DHBeVJKw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6ACMWvE015851;
        Tue, 10 Jul 2018 07:22:32 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 10
 Jul 2018 07:22:32 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 10 Jul 2018 07:22:32 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6ACMS2i022797;
        Tue, 10 Jul 2018 07:22:29 -0500
Subject: Re: [PATCH] driver core: Partially revert "driver core: correct
 device's shutdown order"
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan> <2927655.Y1qg3UnIrE@aspire.rjw.lan>
CC:     Pingfan Liu <kernelfans@gmail.com>, <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PM <linux-pm@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <aa41cfa9-dedb-5f19-0d85-0d4c19d26ea8@ti.com>
Date:   Tue, 10 Jul 2018 17:52:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <2927655.Y1qg3UnIrE@aspire.rjw.lan>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 10 July 2018 05:05 PM, Rafael J. Wysocki wrote:
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
> overhead in the majority of cases and it only covers an issue
> with system shutdown, while system-wide suspend/resume potentially
> has the same issue on the affected platforms (which is not covered).
> 
> For that reason, revert the really_probe() modifications made by
> commit 52cdbdd49853 which unfortunately will expose the shutdown
> issue the problematic commit attempted to fix (and which will have
> to be addressed differently and correctly in the future).
> 
> The other code changes made by commit 52cdbdd49853 are useful and
> they need not be reverted.
> 
> Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
> Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
> Reported-by: Pingfan Liu <kernelfans@gmail.com>
> Tested-by: Pingfan Liu <kernelfans@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

This issue because of which 52cdbdd49853 (driver core: correct device's
shutdown order) was added is not present from 4.18, since dra7 started using
sdhci-omap.c driver which doesn't disable regulator during shutdown. (The
original issue was present in omap_hsmmc driver).

When sdhci-omap driver is modified to disable regulator during shutdown,
something like device_link_add() can be added in _regulator_get().

Since this doesn't reintroduce the problem that was solved by 52cdbdd49853,
this can be safely merged.

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
