Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C85C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232CF21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548832568;
	bh=QCBSRBrcOR6ynntuwIiKaFtPBAGaV86c4F3h+mtBD6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AcMkKIBoD4V7IoikW2DU3S0YrgPk0+PIWZ+P+yaCdA+fPF661UsoMGvE44bjmnIBy
	 jT97LeU73fisP0B6R2I/llcyRxMziSLIV6USn8dcVqMW1fNyVB6uqHyX4RSXEBEUhF
	 qMaw1BNR7KrVue6to06PJLL/LJ7ZtktI56N4lV8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfA3HQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:16:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfA3HQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:16:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE7A21473;
        Wed, 30 Jan 2019 07:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548832565;
        bh=QCBSRBrcOR6ynntuwIiKaFtPBAGaV86c4F3h+mtBD6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9jjOhUiyfEcCp2wA+oHnM7gdnxNWkiNGGVq6OUKTwcwqlI4dLVCqLNPOIaEaawBp
         bhoG+g8gsFIPw3QcEn4Q5oLtcYv0qtbiYkEil79Mr30FhuQLimwnXcpzF1708p/T5L
         TlHAAd9+OHjFHwNMBihUQzRROs36dyGBU+58HNeM=
Date:   Wed, 30 Jan 2019 08:16:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] async: Add cmdline option to specify drivers to be
 async probed
Message-ID: <20190130071602.GB3657@kroah.com>
References: <1548830287-4281-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548830287-4281-1-git-send-email-feng.tang@intel.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 02:38:07PM +0800, Feng Tang wrote:
> Asynchronous driver probing can help much on kernel fastboot, and
> this option can provide a flexible way to optimize and quickly verify
> async driver probe.
> 
> Also it will help in below cases:
> * Some driver actually covers several families of HWs, some of which
>   could use async probing while others don't. So we can't simply
>   turn on the PROBE_PREFER_ASYNCHRONOUS flag in driver, but use this
>   cmdline option, like igb driver async patch discussed at
>   https://www.spinics.net/lists/netdev/msg545986.html
> 
> * For SOC (System on Chip) with multiple spi or i2c controllers, most
>   of the slave spi/i2c devices will be assigned with fixed controller
>   number, while async probing may make those controllers get different
>   index for each boot, which prevents those controller drivers to be
>   async probed. For platforms not using these spi/i2c slave devices,
>   they can use this cmdline option to benefit from the async probing.
> 
> Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  drivers/base/dd.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

This is v3 and yet no change information below the --- line saying what
is different from previous versions at all?

Not good, please fix.

greg k-h
