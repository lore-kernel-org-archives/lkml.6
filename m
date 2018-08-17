Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513B5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 05:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098CF217AE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 05:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098CF217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeHQIGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 04:06:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:41635 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbeHQIGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 04:06:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7H53n92017820;
        Fri, 17 Aug 2018 00:03:50 -0500
Message-ID: <16dc573e5a9add534153b1236d3665b035b8d581.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 0/6] pci: Rework is_added race fix and address
 bridge enable races
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Hari Vyas <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Aug 2018 15:03:49 +1000
In-Reply-To: <20180817044902.31420-1-benh@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-17 at 14:48 +1000, Benjamin Herrenschmidt wrote:
> The second part aims at fixing the enable/disable/set_master races,
> and does so by providing a framework for future device state locking
> issues.
> 
> It introduces a pci_dev->state_mutex which is used at a lower level
> than the device_lock (the device lock isn't suitable, as explained
> in the cset comments) and uses it to protect enablement and set_master.

As discussed in the series, I'm not using the device_lock because I
don't like it creeping out of drivers/base too much unless you
explicitly try to lock against concurrent add/remove.

That being said, if we decided we prefer using it to solve the
enable/disable race, then we have to be careful of a few things:

 - Driver callbacks hold it, so we can't take it from within
pci_enable_device(), pci_set_master() etc... themselves. We'll have to
assume the caller has it

 - The above means auditing callers of these various APIs that might be
calling them from outside of a driver callback and add the necessary
lock

 - We need to take great care about the possibility of the parent
device(s) lock being held. It can happen for USB for example. Now we
don't have USB->PCI adapters that I know of that uses the PCI stack in
Linux but generally assuming your parent lock isn't held is risky. So I
would be a bit weary of walking up the bridge chain and taking it
unconditionally.

Alternatively, we could hijack an existing global lock, for example
mvoe the bridge_mutex outside of ACPI and use it for the upwards bridge
walk, and ignore the other possible races with enable/disable.

Cheers,
Ben.



