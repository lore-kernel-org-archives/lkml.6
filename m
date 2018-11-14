Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD2EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E692622419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E692622419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbeKNTj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:39:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:22103 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeKNTj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:39:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 01:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,231,1539673200"; 
   d="scan'208";a="108457865"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 14 Nov 2018 01:36:54 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1gMrbQ-0006uC-H6; Wed, 14 Nov 2018 11:36:52 +0200
Date:   Wed, 14 Nov 2018 11:36:52 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        rogerq@ti.com, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device
 is not found
Message-ID: <20181114093652.GK10650@smile.fi.intel.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
 <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
 <5BE8C821.5080002@samsung.com>
 <5BEB63C3.1020504@samsung.com>
 <CAHp75Vfe586+tr5mUdSHv4ehmpi0KwS_m+UC0tfFHrdXwKhkig@mail.gmail.com>
 <5BEBE741.6050101@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5BEBE741.6050101@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 06:13:37PM +0900, Chanwoo Choi wrote:
> On 2018년 11월 14일 17:35, Andy Shevchenko wrote:
> > On Wed, Nov 14, 2018 at 1:53 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
> > 
> >> I was thinking about again to change from NULL to EPROBE_DEFER.
> >>
> >> extcon_get_extcon_dev() function was almost called in the probe function.
> >> But, this function might be called on other position instead of probe.
> > 
> > *Might be* sounds like a theoretical thing, care to share what is in you mind?
> > Current users and more important the new coming one are *all* doing the same.
> > 
> >> ENODEV is more correct error instead of EPROBE_DEFER.
> > 
> > So, you are proposing to continue duplicating conversion from ENODEV
> > to EPROBE_DEFER in *each* caller?
> 
> The extcon core don't know the caller situation is in either probe() or other position
> in the caller driver. The caller driver should decide the kind of error value
> by using the return value of extcon_get_extcon_dev().
> 
> extcon_get_extcon_dev() function cannot be modified for only one case.
> If some device driver call extcon_get_extcon_dev() out of probe() fuction,
> EPROBE_DEFER is not always correct.

I agree with this, but look at the current state of affairs. All users do the same.
If we need to have another case we may consider this later.

API inside the kernel are not carved in the stone.


-- 
With Best Regards,
Andy Shevchenko


