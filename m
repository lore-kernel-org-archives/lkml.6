Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B74EC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F98A27AE1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F98A27AE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeF2Gh7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:37:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:31639 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932209AbeF2Gh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:37:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 23:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="63107232"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2018 23:37:44 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        keescook@chromium.org, allen.lkml@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context bugs in init_controller()
In-Reply-To: <87efh0o6f9.fsf@belgarion.home>
References: <20180620035453.7721-1-baijiaju1990@gmail.com> <87efh0o6f9.fsf@belgarion.home>
Date:   Fri, 29 Jun 2018 09:35:10 +0300
Message-ID: <87y3eydrs1.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Jia-Ju Bai <baijiaju1990@gmail.com> writes:
>
>> The driver may sleep with holding a spinlock.
>> The function call paths (from bottom to top) in Linux-4.16.7 are:
>>
>> [FUNC] msleep
>> drivers/usb/gadget/udc/r8a66597-udc.c, 839: 
>> 		msleep in init_controller
>> drivers/usb/gadget/udc/r8a66597-udc.c, 96: 
>> 		init_controller in r8a66597_usb_disconnect
>> drivers/usb/gadget/udc/r8a66597-udc.c, 93: 
>> 		spin_lock in r8a66597_usb_disconnect
>
> That should not happen...
>
> If think the issue you have is that your usb_connect() and usb_disconnect() are
> called from interrupt context. I think the proper fix, as what is done in most
> udc phys, is to schedule a workqueue, see drivers/usb/phy/phy-gpio-vbus-usb.c,
> gpio_vbus_data.vbus.

argh, no. No workqueues needed here. Sorry

-- 
balbi
