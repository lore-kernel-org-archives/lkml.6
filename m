Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F16C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8889F208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq1fszj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8889F208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeGJMiH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:38:07 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34321 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751217AbeGJMiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:38:05 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so42277967ois.1;
        Tue, 10 Jul 2018 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=i0xBFH2J9LrccZdQppOOBeqrC7MaQBF8ukHSRCunG80=;
        b=Hq1fszj8W6Lr+0F0o1evj/yTxqWzrtNfdBGxLY60dtI+uIqSqnSUrnlx5HRxxxeyM/
         ifbweGIZhiAab8sllri0BMbHI4BTr6UPs9hsZwLCwWsD2/oql+Kj40H3+6MCCGA/pDUC
         hrmfS7Yn5LwGv9DyDPk4+kAu08SDKTtl1a/MLMRx+JZELwVNaUY+uLrluI7ZeZbrC8TW
         WGqhaDN5KfazOzq5jNzHMftx6OJSph+qrr0V1g04ft/I1EnFUWttaxEAw163TFRRRGhF
         C2PojvqkA92/MUw7k8q9TlfyqGn1vSej8cGc7XS2xgbR8U0GX21chqLJcDWIpUPrUcPD
         JBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=i0xBFH2J9LrccZdQppOOBeqrC7MaQBF8ukHSRCunG80=;
        b=NhfNuE4EE2KDpfD1EfZCugNjqDsMi2VTvaprk9TkZfsiOBsHKPVYubnaXy4yizqPtx
         bNTqiwd5eEoPbU7EYeCDGa7/pMBCX/J5aTmkJDr6eUWEogvUUhTe5g6PSuXi5jct35K9
         J6i/2fyVPfGiDvBsGam3E04sp0SQxA91HN/nUQArpsywvX3M5CvDkkqcTgYfCf5PpQPO
         0UgBmNLEPvnN3tdjvWzQQVN0VmhlHInRSzLbHVO3zZzMtCd/v/7QzOKgCVl1ldwpwxM0
         /VEjO/HBUXSjzcFUU+LnwHTBFjLxOz03dzEOJBVQWgAnED5QdkRMPxtCDEUOWpyKfNJJ
         VRCQ==
X-Gm-Message-State: APt69E3Vzajlv5merY8Gh1JBoHt5eHCNzUL1OBoGl8Roxr9KcceYmgfP
        3g25qt4yXITkA1mdjKvP7dLEVyoTf3znEY2GLAk=
X-Google-Smtp-Source: AAOMgpeMeu4H7ZEFC0wYA9uCuyG3awVhX9gmXRMXGQ47leTtyfeSHvsOmqJjPMPdG5CNtl0o4QmfchOmGjmpcIuLvXI=
X-Received: by 2002:aca:6910:: with SMTP id e16-v6mr26188566oic.358.1531226284534;
 Tue, 10 Jul 2018 05:38:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 05:38:04
 -0700 (PDT)
In-Reply-To: <aa41cfa9-dedb-5f19-0d85-0d4c19d26ea8@ti.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan> <2927655.Y1qg3UnIrE@aspire.rjw.lan> <aa41cfa9-dedb-5f19-0d85-0d4c19d26ea8@ti.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jul 2018 14:38:04 +0200
X-Google-Sender-Auth: euvW8G9VWguUFh_AdgABm1jyws4
Message-ID: <CAJZ5v0iKQ5pAFSGO56bFzO0299ZEiXFk=TFVoN5_8YYUGS3jVg@mail.gmail.com>
Subject: Re: [PATCH] driver core: Partially revert "driver core: correct
 device's shutdown order"
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 10, 2018 at 2:22 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Tuesday 10 July 2018 05:05 PM, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Commit 52cdbdd49853 (driver core: correct device's shutdown order)
>> introduced a regression by breaking device shutdown on some systems.
>>
>> Namely, the devices_kset_move_last() call in really_probe() added by
>> that commit is a mistake as it may cause parents to follow children
>> in the devices_kset list which then causes shutdown to fail.  For
>> example, if a device has children before really_probe() is called
>> for it (which is not uncommon), that call will cause it to be
>> reordered after the children in the devices_kset list and the
>> ordering of that list will not reflect the correct device shutdown
>> order any more.
>>
>> Also it causes the devices_kset list to be constantly reordered
>> until all drivers have been probed which is totally pointless
>> overhead in the majority of cases and it only covers an issue
>> with system shutdown, while system-wide suspend/resume potentially
>> has the same issue on the affected platforms (which is not covered).
>>
>> For that reason, revert the really_probe() modifications made by
>> commit 52cdbdd49853 which unfortunately will expose the shutdown
>> issue the problematic commit attempted to fix (and which will have
>> to be addressed differently and correctly in the future).
>>
>> The other code changes made by commit 52cdbdd49853 are useful and
>> they need not be reverted.
>>
>> Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
>> Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
>> Reported-by: Pingfan Liu <kernelfans@gmail.com>
>> Tested-by: Pingfan Liu <kernelfans@gmail.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>
> This issue because of which 52cdbdd49853 (driver core: correct device's
> shutdown order) was added is not present from 4.18, since dra7 started using
> sdhci-omap.c driver which doesn't disable regulator during shutdown. (The
> original issue was present in omap_hsmmc driver).
>
> When sdhci-omap driver is modified to disable regulator during shutdown,
> something like device_link_add() can be added in _regulator_get().
>
> Since this doesn't reintroduce the problem that was solved by 52cdbdd49853,
> this can be safely merged.

This is very useful information, let me add it to the patch changelog.

> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>

Thank you!
