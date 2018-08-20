Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28208C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03BA208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03BA208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeHTKbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:31:34 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:39095 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeHTKbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:31:34 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 871AE1030CD10;
        Mon, 20 Aug 2018 09:17:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3B5F57878D; Mon, 20 Aug 2018 09:17:03 +0200 (CEST)
Date:   Mon, 20 Aug 2018 09:17:03 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] Revert "PCI: Fix is_added/is_busmaster race
 condition"
Message-ID: <20180820071703.hnsyhb5pz4svb7jg@wunner.de>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
 <20180817044902.31420-2-benh@kernel.crashing.org>
 <20180817154431.GC128050@bhelgaas-glaptop.roam.corp.google.com>
 <06c1233b71dea08b1fc32334acefc48c32c46557.camel@kernel.crashing.org>
 <20180819022440.GG128050@bhelgaas-glaptop.roam.corp.google.com>
 <4d777ed8c17b479e59b16cc0b4e9a3f6537f9884.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d777ed8c17b479e59b16cc0b4e9a3f6537f9884.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 12:10:59PM +1000, Benjamin Herrenschmidt wrote:
> I chose to create a new mutex which we should be able to address other
> similar races if we find them. The other solutions that I dismissed
> were:
> 
>  - Using the device_lock. A explained previously, this is tricky, I
> prefer not using this for anything other than locking against
> concurrent add/remove. The main issue is that drivers will be sometimes
> called in context where that's already held, so we can't take it inside
> pci_enable_device() and I'd rather not add new constraints such as
> "pci_enable_device() must be only called from probe() unless you also
> take the device lock". It would be tricky to audit everybody...
> 
>  - Using a global mutex. We could move the bridge lock from AER to core
> code for example, and use that. But it doesn't buy us much, and
> slightly redecuces parallelism. It also makes it a little bit more
> messy to walk up the bridge chain, we'd have to do a
> pci_enable_device_unlocked or something, messy.

+1 from my side for adding a struct mutex to struct pci_dev to protect
state changes.

The device_lock() primarily protects binding / unbinding of the device
and pci_dev state may have to be changed while binding / unbinding.

A global lock invites deadlocks if multiple devices are added / removed
concurrently where one is a parent of the other.  (Think hot-removal of
multiple devices on a Thunderbolt daisy-chain.)

As said I'd also welcome folding PCI_DEV_DISCONNECTED into enum
pci_channel_state, either as an additional state or by using
pci_channel_io_perm_failure.

Thanks,

Lukas
