Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC53C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0171825603
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0171825603
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934020AbeF2Gsv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:48:51 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:25009 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbeF2Gsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:48:50 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d06 with ME
        id 4Won1y00941oiFu03Won1o; Fri, 29 Jun 2018 08:48:49 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 29 Jun 2018 08:48:49 +0200
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
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 29 Jun 2018 08:48:46 +0200
In-Reply-To: <87y3eydrs1.fsf@linux.intel.com> (Felipe Balbi's message of "Fri,
        29 Jun 2018 09:35:10 +0300")
Message-ID: <87efgqkrzl.fsf@belgarion.home>
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
>
>> Jia-Ju Bai <baijiaju1990@gmail.com> writes:
>>
>>> The driver may sleep with holding a spinlock.
>>> The function call paths (from bottom to top) in Linux-4.16.7 are:
>>>
>>> [FUNC] msleep
>>> drivers/usb/gadget/udc/r8a66597-udc.c, 839: 
>>> 		msleep in init_controller
>>> drivers/usb/gadget/udc/r8a66597-udc.c, 96: 
>>> 		init_controller in r8a66597_usb_disconnect
>>> drivers/usb/gadget/udc/r8a66597-udc.c, 93: 
>>> 		spin_lock in r8a66597_usb_disconnect
>>
>> That should not happen...
>>
>> If think the issue you have is that your usb_connect() and usb_disconnect() are
>> called from interrupt context. I think the proper fix, as what is done in most
>> udc phys, is to schedule a workqueue, see drivers/usb/phy/phy-gpio-vbus-usb.c,
>> gpio_vbus_data.vbus.
>
> argh, no. No workqueues needed here. Sorry
Technically why ?

And as bonus question, why is it better to have mdelay() calls in the driver ?

Cheers.

-- 
Robert
