Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DEAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B975020892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jC+EF8z2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B975020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeKKEMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:12:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbeKKEMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:12:18 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B4220854;
        Sat, 10 Nov 2018 18:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541874382;
        bh=mx2HYjSCyy4jL++iBsNld7tp450VUBwYwbhx6mcqjGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jC+EF8z2zVBTks9bAZHFRijog0faYGVMxdKIIvNCzq9RxYstMuiweWU4JEqjci7cg
         sr6/UrEwH0U1sb7RFxmAOjb6rwpPagXm3nDUjQLKLgn1B/xlx/PDuoDb+4nlI0V28D
         ZhBDTjzKAu7UbpWb4ceVxEe8HV6yU1U7CWxUkvSk=
Date:   Sat, 10 Nov 2018 10:26:22 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Grant Likely <grant.likely@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
Message-ID: <20181110182622.GA32657@kroah.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 08:10:57PM +0200, Andy Shevchenko wrote:
> Consider the following scenario.
> 
> There are two independent devices coupled together by functional dependencies:
>  - USB OTG (dwc3-pci)
>  - extcon (tested with extcon-intel-mrfld, not yet in upstream)
> 
> Each of the driver services a corresponding device is built as a module. In the
> Buildroot environment the modules are probed by alphabetical ordering of their
> modaliases. The latter comes to the case when USB OTG driver will be probed
> first followed by extcon one.
> 
> So, if the platform anticipates extcon device to be appeared, in the above case
> we will get deferred probe of USB OTG, because of ordering.
> 
> Now, a cherry on top of the cake, the deferred probing list contains
> the only two modules, i.e. USB OTG and extcon. Due to above circumstances,
> values in the local_trigger_count and deferred_trigger_count are not the same,
> and thus provokes deferred probe triggering again and again.
> 
> ...
> [   20.678332] platform dwc3.0.auto: Retrying from deferred list
> [   20.694743] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> [   20.701254] platform dwc3.0.auto: Added to deferred list
> [   20.706620] platform dwc3.0.auto: driver_deferred_probe_add_trigger 1 2
> [   20.713732] platform dwc3.0.auto: Retrying from deferred list
> [   20.730035] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> [   20.736540] platform dwc3.0.auto: Added to deferred list
> [   20.741889] platform dwc3.0.auto: driver_deferred_probe_add_trigger 3 4
> [   20.748991] platform dwc3.0.auto: Retrying from deferred list
> [   20.765416] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> [   20.771914] platform dwc3.0.auto: Added to deferred list
> [   20.777279] platform dwc3.0.auto: driver_deferred_probe_add_trigger 5 6
> ...
> 
> Deeper investigation shows the culprit commit 58b116bce136
> ("drivercore: deferral race condition fix") which was dedicated to fix some
> other issue while bringing a regression.
> 
> This reverts commit 58b116bce13612e5aa6fcd49ecbd4cf8bb59e835 for good until
> we will have better solution.
> 
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/dd.c | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)

Shouldn't there be a "Fixes:" line and cc: stable here?

thanks,

greg k-h
