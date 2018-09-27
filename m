Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B127C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E563215EB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E563215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeI0TfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:35:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:10040 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbeI0TfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:35:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 06:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,310,1534834800"; 
   d="scan'208";a="260771880"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2018 06:15:55 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 2E8662068E; Thu, 27 Sep 2018 16:15:54 +0300 (EEST)
Date:   Thu, 27 Sep 2018 16:15:54 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3.1 1/2] device property: Add device_get_bd_address()
 and fwnode_get_bd_address()
Message-ID: <20180927131553.slg6m3cv77l7b7eu@paasikivi.fi.intel.com>
References: <20180925191014.85573-1-mka@chromium.org>
 <20180925191014.85573-2-mka@chromium.org>
 <20180926113625.GM11965@kuha.fi.intel.com>
 <DCD95AC8-D216-4CCE-B305-605A25B6B23A@holtmann.org>
 <20180927113829.GQ11965@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927113829.GQ11965@kuha.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On Thu, Sep 27, 2018 at 02:38:29PM +0300, Heikki Krogerus wrote:
> Hi Marcel,
> 
> On Thu, Sep 27, 2018 at 12:24:33PM +0200, Marcel Holtmann wrote:
> > > Let's not fill property.c with framework specific helper functions any
> > > more!
> > > 
> > > Those functions are completely bluetooth specific, so they do not
> > > belong here. The fact that some other framework already managed to
> > > slip their helpers in does not justify others to do the same.
> > 
> > so? The firmware guys decided to put MAC addresses and BD addresses into the
> > firmware. So you have to deal with that.
> 
> I think you have misunderstood the point.
> 
> > Moving this into the Bluetooth subsystem is as pointless. I rather keep the
> > accessor function to firmware specific data in one place and not spread around
> > the whole tree. Especially once this is also provided via ACPI or some other
> > means. I assumed that is what the whole device_get part was suppose to
> > abstract.
> 
> Unified device property API defines a _generic_ API that can be used
> by any type of device to access the device properties regardless of
> the way the hardware is described.
> 
> Any device can use device_property_read_u8/u16/u32/u64/string()
> functions, but only bluetooth devices can use device_get_bd_address().
> Therefore that function does not belong to drivers/base/properties.c.

FWIW, what's been relevant for V4L2 devices has always been parsed within
the V4L2 framework. It's way more than needed by BT here though; see:

	drivers/media/v4l2-core/v4l2-fwnode.c

I wouldn't think of putting this under drivers/base.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
