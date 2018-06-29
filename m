Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC1C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036FA27D90
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036FA27D90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935023AbeF2LFD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:05:03 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:50551 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934510AbeF2LFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:05:01 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d15 with ME
        id 4b4y1y00941oiFu03b4y1t; Fri, 29 Jun 2018 13:05:00 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 29 Jun 2018 13:05:00 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, keescook@chromium.org,
        allen.lkml@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context bugs in init_controller()
References: <20180620035453.7721-1-baijiaju1990@gmail.com>
        <87efh0o6f9.fsf@belgarion.home> <87y3eydrs1.fsf@linux.intel.com>
        <87efgqkrzl.fsf@belgarion.home> <87k1qhevpd.fsf@linux.intel.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 29 Jun 2018 13:04:58 +0200
In-Reply-To: <87k1qhevpd.fsf@linux.intel.com> (Felipe Balbi's message of "Fri,
        29 Jun 2018 13:25:02 +0300")
Message-ID: <87a7rdlup1.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Balbi <balbi@kernel.org> writes:

> Hi,
>
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>>>>> The driver may sleep with holding a spinlock.
>>>>> The function call paths (from bottom to top) in Linux-4.16.7 are:
>>>>>
>>>>> [FUNC] msleep
>>>>> drivers/usb/gadget/udc/r8a66597-udc.c, 839: 
>>>>> 		msleep in init_controller
>>>>> drivers/usb/gadget/udc/r8a66597-udc.c, 96: 
>>>>> 		init_controller in r8a66597_usb_disconnect
>>>>> drivers/usb/gadget/udc/r8a66597-udc.c, 93: 
>>>>> 		spin_lock in r8a66597_usb_disconnect
>>>>
>>>> That should not happen...
>>>>
>>>> If think the issue you have is that your usb_connect() and usb_disconnect() are
>>>> called from interrupt context. I think the proper fix, as what is done in most
>>>> udc phys, is to schedule a workqueue, see drivers/usb/phy/phy-gpio-vbus-usb.c,
>>>> gpio_vbus_data.vbus.
>>>
>>> argh, no. No workqueues needed here. Sorry
>> Technically why ?
>
> well, strictly technically there's nothing wrong. But it opens a can of
> worms. We've seen time and time again drivers growing into
> unmaintainable mess because of workqueues being fired in several places.
I see.

>>
>> And as bonus question, why is it better to have mdelay() calls in the driver ?
>
> As a bugfix, it's the smallest fix possible, right? Ideally, we wouldn't
> need either of them. Perhaps there's a bit which can be polled instead?
Ideally yes. Do you remember if a "threaded interrupt" might use msleep() ? I
seem to remember that they can, so won't that be another alternative ?

Cheers.

-- 
Robert
