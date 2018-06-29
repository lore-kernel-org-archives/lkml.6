Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BDFC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B19F27B7E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B19F27B7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935343AbeF2K1k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:27:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:64569 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932468AbeF2K1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:27:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 03:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="62562992"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2018 03:27:37 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, keescook@chromium.org,
        allen.lkml@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context bugs in init_controller()
In-Reply-To: <87efgqkrzl.fsf@belgarion.home>
References: <20180620035453.7721-1-baijiaju1990@gmail.com> <87efh0o6f9.fsf@belgarion.home> <87y3eydrs1.fsf@linux.intel.com> <87efgqkrzl.fsf@belgarion.home>
Date:   Fri, 29 Jun 2018 13:25:02 +0300
Message-ID: <87k1qhevpd.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Robert Jarzmik <robert.jarzmik@free.fr> writes:
>>>> The driver may sleep with holding a spinlock.
>>>> The function call paths (from bottom to top) in Linux-4.16.7 are:
>>>>
>>>> [FUNC] msleep
>>>> drivers/usb/gadget/udc/r8a66597-udc.c, 839: 
>>>> 		msleep in init_controller
>>>> drivers/usb/gadget/udc/r8a66597-udc.c, 96: 
>>>> 		init_controller in r8a66597_usb_disconnect
>>>> drivers/usb/gadget/udc/r8a66597-udc.c, 93: 
>>>> 		spin_lock in r8a66597_usb_disconnect
>>>
>>> That should not happen...
>>>
>>> If think the issue you have is that your usb_connect() and usb_disconnect() are
>>> called from interrupt context. I think the proper fix, as what is done in most
>>> udc phys, is to schedule a workqueue, see drivers/usb/phy/phy-gpio-vbus-usb.c,
>>> gpio_vbus_data.vbus.
>>
>> argh, no. No workqueues needed here. Sorry
> Technically why ?

well, strictly technically there's nothing wrong. But it opens a can of
worms. We've seen time and time again drivers growing into
unmaintainable mess because of workqueues being fired in several places.
>
> And as bonus question, why is it better to have mdelay() calls in the driver ?

As a bugfix, it's the smallest fix possible, right? Ideally, we wouldn't
need either of them. Perhaps there's a bit which can be polled instead?

Looking at the code again, it looks like that's messing with
controller's clock and PLL; seems like it should've been done with CCF
anyway.

-- 
balbi
