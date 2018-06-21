Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC62C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4790220883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4790220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932798AbeFUJGG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:06:06 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:30357 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932636AbeFUJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:06:04 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d76 with ME
        id 1M621y00641oiFu03M6285; Thu, 21 Jun 2018 11:06:03 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 21 Jun 2018 11:06:03 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, keescook@chromium.org,
        allen.lkml@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context bugs in init_controller()
References: <20180620035453.7721-1-baijiaju1990@gmail.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Thu, 21 Jun 2018 11:06:02 +0200
In-Reply-To: <20180620035453.7721-1-baijiaju1990@gmail.com> (Jia-Ju Bai's
        message of "Wed, 20 Jun 2018 11:54:53 +0800")
Message-ID: <87efh0o6f9.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jia-Ju Bai <baijiaju1990@gmail.com> writes:

> The driver may sleep with holding a spinlock.
> The function call paths (from bottom to top) in Linux-4.16.7 are:
>
> [FUNC] msleep
> drivers/usb/gadget/udc/r8a66597-udc.c, 839: 
> 		msleep in init_controller
> drivers/usb/gadget/udc/r8a66597-udc.c, 96: 
> 		init_controller in r8a66597_usb_disconnect
> drivers/usb/gadget/udc/r8a66597-udc.c, 93: 
> 		spin_lock in r8a66597_usb_disconnect

That should not happen...

If think the issue you have is that your usb_connect() and usb_disconnect() are
called from interrupt context. I think the proper fix, as what is done in most
udc phys, is to schedule a workqueue, see drivers/usb/phy/phy-gpio-vbus-usb.c,
gpio_vbus_data.vbus.

Cheers.

--
Robert
