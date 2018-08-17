Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A41C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DBB2152C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jyk+yqTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DBB2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeHQGJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeHQGJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:09:21 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5522D20C0A;
        Fri, 17 Aug 2018 03:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534475263;
        bh=RSuTlgKX5d7mz1OxDjtiXVFUe/DBHWiiHjN+mgjIrjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jyk+yqTJ6MuUIm8CnISc7+2IJPzFiubN3PTD5RqoG3dqeZDJV0PtWAyETwOE3a2VV
         og2nfjVLDZtllwYJNFE9K6Sqj+Vpjt2cJBeCpstvuxPFhBTPxFdLQl3JIeG0/wagD2
         4ja2R1P8+DkXfL8zABaukXDt8U7CIDCWx4YBXau0=
Date:   Thu, 16 Aug 2018 22:07:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Hari Vyas <hari.vyas@broadcom.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>
Subject: Re: [RFC PATCH] pci: Proof of concept at fixing
 pci_enable_device/bridge races
Message-ID: <20180817030741.GC10316@bhelgaas-glaptop.roam.corp.google.com>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
 <5e42f7990673d11e3a020e7efcfd333215d48138.camel@kernel.crashing.org>
 <58192cf94de3941f9141aa3203399ae2bcdf6b7a.camel@kernel.crashing.org>
 <08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Srinath, Guenter, Jens, Lukas, Konstantin, Marta, Pierre-Yves]

On Thu, Aug 16, 2018 at 07:50:13AM +1000, Benjamin Herrenschmidt wrote:
> [Note: This isn't meant to be merged, it need splitting at the very
> least, see below]
> 
> This is something I cooked up quickly today to test if that would fix
> my problems with large number of switch and NVME devices on POWER.
> 
> So far it does...
> 
> The issue (as discussed in the Re: PCIe enable device races thread) is
> that pci_enable_device and related functions along with pci_set_master
> and pci_enable_bridge are fundamentally racy.
> 
> There is no lockign protecting the state of the device in pci_dev and
> if multiple devices under the same bridge try to enable it simultaneously
> one some of them will potentially start accessing it before it has actually
> been enabled.
> 
> Now there are a LOT more fields in pci_dev that aren't covered by any
> form of locking.

Most of the PCI core relies on the assumption that only a single
thread touches a device at a time.  This is generally true of the core
during enumeration because enumeration is single-threaded.  It's
generally true in normal driver operation because the core shouldn't
touch a device after a driver claims it.

But there are several exceptions, and I think we need to understand
those scenarios before applying locks willy-nilly.

One big exception is that enabling device A may also touch an upstream
bridge B.  That causes things like your issue and Srinath's issue
where drivers simultaneously enabling two devices below the same
bridge corrupt the bridge's state [1].  Marta reported essentially the
same issue [2].

Hari's issue [3] seems related to a race between a driver work queue
and the core enumerating the device.  I should have pushed harder to
understand this; I feel like we papered over the immediate problem
without clearing up the larger issue of why the core enumeration path
(pci_bus_add_device()) is running at the same time as a driver.

DPC/AER error handling adds more cases where the core potentially
accesses devices asynchronously to the driver.

User-mode sysfs controls like ASPM are also asynchronous to drivers.

Even setpci is a potential issue, though I don't know how far we want
to go to protect it.  I think we should make setpci taint the kernel
anyway.

It might be nice if we had some sort of writeup of the locking
strategy as a whole.

[1] https://lkml.kernel.org/r/1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com
[2] https://lkml.kernel.org/r/744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu
[3] https://lkml.kernel.org/r/1530608741-30664-2-git-send-email-hari.vyas@broadcom.com
