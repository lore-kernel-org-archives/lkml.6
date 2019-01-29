Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C34C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A207C2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfA2Blc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:41:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:9219 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfA2Blc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 20:41:32 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 17:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,535,1539673200"; 
   d="scan'208";a="138674673"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2019 17:41:30 -0800
Date:   Tue, 29 Jan 2019 09:42:34 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] async: Add cmdline option to specify drivers to
 be async probed
Message-ID: <20190129014234.owo3fb6uzaaeufx7@shbuild888>
References: <1548638416-96859-1-git-send-email-feng.tang@intel.com>
 <8a28b7eafc81f693fa1a580c70a1f9465818eb86.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a28b7eafc81f693fa1a580c70a1f9465818eb86.camel@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Thanks for the review.

On Mon, Jan 28, 2019 at 08:31:11AM -0800, Alexander Duyck wrote:
> On Mon, 2019-01-28 at 09:20 +0800, Feng Tang wrote:
> > Asynchronous driver probing can help much on kernel fastboot, and
> > this option can provide a flexible way to optimize and quickly verify
> > async driver probe.
> > 
> > Also it will help in below cases:
> > * Some driver actually covers several families of HWs, some of which
> >   could use async probing while others don't. So we can't simply
> >   turn on the PROBE_PREFER_ASYNCHRONOUS flag in driver, but use this
> >   cmdline option, like igb driver async patch discussed at
> >   https://www.spinics.net/lists/netdev/msg545986.html
> > 
> > * For SOC (System on Chip) with multiple spi or i2c controllers, most
> >   of the slave spi/i2c devices will be assigned with fixed controller
> >   number, while async probing may make those controllers get different
> >   index for each boot, which prevents those controller drivers to be
> >   async probed. For platforms not using these spi/i2c slave devices,
> >   they can use this cmdline option to benefit from the async probing.
> > 
> > Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  drivers/base/dd.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 8ac10af..cfa704a 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -57,6 +57,10 @@ static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
> >  static struct dentry *deferred_devices;
> >  static bool initcalls_done;
> >  
> > +/* Save the async probe drivers' name from kernel cmdline */
> > +#define ASYNC_DRV_NAMES_MAX_LEN	256
> > +static char async_probe_drv_names[ASYNC_DRV_NAMES_MAX_LEN];
> > +
> >  /*
> >   * In some cases, like suspend to RAM or hibernation, It might be reasonable
> >   * to prohibit probing of devices as it could be unsafe.
> > @@ -674,8 +678,27 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
> >  	return ret;
> >  }
> >  
> > +static inline bool cmdline_requested_async_probing(const char *drv_name)
> > +{
> > +	return parse_option_str(async_probe_drv_names, drv_name);
> > +}
> > +
> > +/* The format is like driver_async_probe=drv_name1,drv_name2,drv_name3 */
> > +static int __init save_async_options(char *buf)
> > +{
> > +	if (strlen(buf) >= ASYNC_DRV_NAMES_MAX_LEN)
> > +		printk(KERN_WARNING "Too long list for async_probe_drv_names!");
> > +
> > +	strlcpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN);
> > +	return 0;
> > +}
> > +__setup("driver_async_probe=", save_async_options);
> > +
> >  bool driver_allows_async_probing(struct device_driver *drv)
> >  {
> > +	if (cmdline_requested_async_probing(drv->name))
> > +		return true;
> > +
> 
> This piece still should be moved. Ideally it should be down in the
> "default" case area we use to determine if the module parameter
> async_probe was used or not. Where you currently have this will
> overrride the driver behavior if it absolutely cannot use an
> asynchronous probe.

I thought this option could also be used as a flexible option to
test and try some drivers what we used to think not appropriate
for async probing (including drivers with PROBE_FORCE_SYNCHRONOUS flag).
But if people think we should enforce this PROBE_FORCE_SYNCHRONOUS
check, I can move the cmdline_requested_async_probing() check into
the "default:" segment.

Thanks,
Feng
