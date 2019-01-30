Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810B7C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAE620989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548860780;
	bh=91akihFMRrpe92l8fZfX0HpMGtuRJLFm6w4kozyFT+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aNAg6wi7Lkw6o7GVtBzBAB+/tX8ZYiOp3a5ET6McfbakxeYdqOQx4+pU63CcsBmGy
	 edMVNLJAnpbyJ48ujxNWJxr4jmPUOFAu4y2FTgN3InI1YpLYxClB24qwrCjXit9Q3w
	 QTlBAgRJAl5AII6wruj8kXaGbVkgMCrOiBwuR1/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbfA3PGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:06:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfA3PGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:06:18 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BAA320989;
        Wed, 30 Jan 2019 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548860777;
        bh=91akihFMRrpe92l8fZfX0HpMGtuRJLFm6w4kozyFT+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yXKB+PgbsRlZT5qKMU0kzrB4s++v2Q0IV1KgiXJnwMDQ+qLZzVGgAKWtUOltYniMX
         aK8PIecB8TH5fqOUXyztBsTK3DlfLtdAZSuY4N9uogcbf6TymsFIE5o0Wqy8AKphCU
         sax+m47zvcxyoW4UlApEP/wWrnJf+JVMDMYSq5tw=
Date:   Wed, 30 Jan 2019 09:06:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aleksey Makarov <aleksey.makarov@cavium.com>
Cc:     netdev@vger.kernel.org, Robert Richter <rric@kernel.org>,
        "Goutham, Sunil" <Sunil.Goutham@cavium.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Joe Perches <joe@perches.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v6 1/2] net: add support for Cavium PTP
 coprocessor
Message-ID: <20190130150614.GA229773@google.com>
References: <20180115124500.14872-1-aleksey.makarov@cavium.com>
 <20180115124500.14872-2-aleksey.makarov@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115124500.14872-2-aleksey.makarov@cavium.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2018 at 06:44:56PM +0600, Aleksey Makarov wrote:
> +++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* cavium_ptp.c - PTP 1588 clock on Cavium hardware
> + * Copyright (c) 2003-2015, 2017 Cavium, Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/timecounter.h>
> +#include <linux/pci.h>
> +
> +#include "cavium_ptp.h"
> +
> +#define DRV_NAME	"Cavium PTP Driver"

This is also unconventional and looks funny, e.g., here:

  $ ls /sys/bus/pci/drivers/
   8250_mid/             exar_serial/         mei_me/       snd_hda_intel/
   agpgart-intel/        i801_smbus/          parport_pc/   snd_soc_skl/
   agpgart-sis/          i915/                pcieport/     xen-platform-pci/
   agpgart-via/          intel_ish_ipc/       rtsx_pci/     xhci_hcd/
   ahci/                 intel_pch_thermal/   serial/
  'Cavium PTP Driver'/   iosf_mbi_pci/        shpchp/
   e1000e/               iwlwifi/             skl_uncore/
