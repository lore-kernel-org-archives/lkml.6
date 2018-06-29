Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCDAC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0998227F47
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0998227F47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936547AbeF2NVZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:21:25 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:52334 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753527AbeF2NVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:21:22 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d48 with ME
        id 4dMK1y00A41oiFu03dMKv8; Fri, 29 Jun 2018 15:21:21 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 29 Jun 2018 15:21:21 +0200
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
        <87a7rdlup1.fsf@belgarion.home> <87bmbtetdk.fsf@linux.intel.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 29 Jun 2018 15:21:19 +0200
In-Reply-To: <87bmbtetdk.fsf@linux.intel.com> (Felipe Balbi's message of "Fri,
        29 Jun 2018 14:15:19 +0300")
Message-ID: <876021lods.fsf@belgarion.home>
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
>>>> And as bonus question, why is it better to have mdelay() calls in the driver ?
>>>
>>> As a bugfix, it's the smallest fix possible, right? Ideally, we wouldn't
>>> need either of them. Perhaps there's a bit which can be polled instead?
>> Ideally yes. Do you remember if a "threaded interrupt" might use msleep() ? I
>> seem to remember that they can, so won't that be another alternative ?
>
> yeah, unless, of course, you have a spinlock held. ;-)
Ah yes, unless that :)

I would have proposed to call the disconnect out of the spinlock path, but
looking at the r8a66592_usb_disconnect(), with its spinlock flip-flop, I loose
heart ...

And even if I still think no mdelay() should be used, because of the kernel
stall (and global uniprocessor stall), I won't argue anymore. After all, if you
let in the mdelay(), perhaps the maintainers will agree to review their
architecture and drop the locks or sleeps in interrupt context in a follow-up
patch, who knows ...

Cheers.

-- 
Robert
