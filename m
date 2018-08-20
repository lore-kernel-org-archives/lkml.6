Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAE8C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7187B20C03
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7187B20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeHTLgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 07:36:31 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:41507 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeHTLgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 07:36:31 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id B4065100DECB4;
        Mon, 20 Aug 2018 10:21:50 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 694A8240DD7; Mon, 20 Aug 2018 10:21:50 +0200 (CEST)
Date:   Mon, 20 Aug 2018 10:21:50 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] PCI: pciehp: Mask AER surprise link down error if
 hotplug is enabled
Message-ID: <20180820082150.r4q47ppqqclaschd@wunner.de>
References: <20180818065126.77912-1-okaya@kernel.org>
 <20180818065126.77912-2-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818065126.77912-2-okaya@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 11:51:10PM -0700, Sinan Kaya wrote:
> +static int pciehp_control_surprise_error(struct controller *ctrl, bool enable)

The return value isn't checked, so this could return void.


> @@ -280,6 +303,9 @@ static int pciehp_probe(struct pcie_device *dev)
>  
>  	pciehp_check_presence(ctrl);
>  
> +	/* We want exclusive control of link down events in hotplug driver */
> +	pciehp_control_surprise_error(ctrl, false);
> +
>  	return 0;

Hm, if the platform firmware hasn't granted native hotplug control to OSPM,
or if some other hotplug driver than pciehp is used, shouldn't surprise down
be ignored by error recovery as well?  If yes, the mask would have to be set
in generic code somewhere in drivers/pci/probe.c I guess, based on the
is_hotplug_bridge bit in struct pci_dev.

(Interestingly, PCI_ERR_UNCOR_MASK is already changed in probe.c by
program_hpp_type2().  That seems to be ACPI-specific code, which kind
of begs the question why it's not in pci-acpi.c?)

Thanks,

Lukas
