Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D823EFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C35920873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C35920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbeG3KGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:06:05 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:48531 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeG3KGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:06:05 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id B6EB42800B1CD;
        Mon, 30 Jul 2018 10:32:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 618F22638C; Mon, 30 Jul 2018 10:32:10 +0200 (CEST)
Date:   Mon, 30 Jul 2018 10:32:10 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mayurkumar.patel@intel.com, rajatxjain@gmail.com,
        Richard Hughes <rhughes@redhat.com>,
        Carlos Garnacho <cgarnach@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
Message-ID: <20180730083210.GA9641@wunner.de>
References: <20180508230148.121852-1-rajatja@google.com>
 <20180510233912.96454-1-rajatja@google.com>
 <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 03:26:19PM -0500, Bjorn Helgaas wrote:
> The question is where those sysfs files should be.  Currently they are
> associated with the device at the *upstream* end of the link.  In the
> example above, they're associated with the Root Port:
> 
>   /sys/devices/pci0000:00/0000:00:1c.2/power/link_state
> 
> I don't know if that's the right place, or if they should be
> associated with the device at the *downstream* end of the link, i.e.,
> 04:00.0.  The downstream end might be better because:
> 
>   - It's easier to associate the downstream end with a device the user
>     cares about, e.g., a NIC, GPU, etc.  This is mostly a user-
>     interface issue.
> 
>   - A link can lead to a multi-function device, and the spec allows
>     those functions to have different ASPM settings (see PCIe r4.0,
>     sec 5.4.1).  With the sysfs files at the upstream end of the link,
>     we have no way to configure those functions individually.
> 
> Any thoughts?

Conceivably, could the downstream end not be enumerated at all?
(E.g. a hotplug or rescan is necessary for it to be enumerated?)

If so, the upstream end might be better because the ASPM settings
can be configured in advance, before the downstream end appears.

Thanks,

Lukas
