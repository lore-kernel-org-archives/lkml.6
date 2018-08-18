Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CCFC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 03:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFDC21477
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 03:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFDC21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeHRGrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 02:47:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:57097 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbeHRGrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 02:47:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7I3f271029088;
        Fri, 17 Aug 2018 22:41:03 -0500
Message-ID: <20490639ea65ae09bec4ed33cf07a69b61935959.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 2/6] pci: Set pci_dev->is_added before calling
 device_add
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Date:   Sat, 18 Aug 2018 13:41:02 +1000
In-Reply-To: <20180817181501.m4j7jibzsrgljmlj@wunner.de>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
         <20180817044902.31420-3-benh@kernel.crashing.org>
         <20180817162534.GD128050@bhelgaas-glaptop.roam.corp.google.com>
         <20180817181501.m4j7jibzsrgljmlj@wunner.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-17 at 20:15 +0200, Lukas Wunner wrote:
> 
> The two steps (enumeration and driver attachment) are protected by
> pci_lock_rescan_remove().  Initially, when a pci_dev is newly allocated
> with kzalloc(), is_added is 0.  The transition from 0 to 1 happens while
> under pci_lock_rescan_remove().  When that lock is released, is_added is
> always 1, barring a device_attach() error, in which case it will remain
> at 0.
> 
> AFAICS, there is no second mutex needed to ensure synchronization of
> is_added, the existing mutex should be sufficient and the only problem
> are RMW races when accessing adjacent flags. Those were correctly addressed
> by Hari's patch.  Benjamin seems to be alleging that concurrency issues
> exist beyond the RMW races, I fail to see them, sorry.

Im saying that fixing those issues using atomic bitops is a generally
unsafe practice even if it happens to work in a specific case.

In this one, I argue that the root problem was simply that is_added was
set in the wrong place. The "fix" from Hari touches 9 files, adds
horrible relative includes to an architecture and generally bloats
things while a single 3 liner would have been sufficient.

The current use of is_added is asymetric (it's cleared during
device_attach but set during detach) which is bogus and the entire race
stems from the fact that it is set after device_attach returns.

So setting it early is, imho, the right fix, is much simpler, and fixes
the odd imbalance we have to begin with.

Ben.


