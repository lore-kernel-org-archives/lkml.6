Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5B2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88815216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88815216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeI0ULv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:11:51 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:49216 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeI0ULv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:11:51 -0400
Received: from tux.wizards.de (p3EE2F45F.dip0.t-ipconnect.de [62.226.244.95])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 3508E416063B;
        Thu, 27 Sep 2018 15:53:27 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id D8304F0162C;
        Thu, 27 Sep 2018 15:53:26 +0200 (CEST)
Subject: Re: [PATCH 4.18 74/88] drm/atomic: Use drm_drv_uses_atomic_modeset()
 for debugfs creation
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>
References: <20180927090300.631426620@linuxfoundation.org>
 <20180927090309.614592493@linuxfoundation.org>
 <42cbbf9c-3076-0c49-36c2-b6fd09628694@applied-asynchrony.com>
 <20180927123706.GA23563@kroah.com>
 <f54355c2-4eeb-9b7a-3964-57ca465dae17@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <c3afb9a2-1cd6-b5b9-83ac-eed92fbc066e@applied-asynchrony.com>
Date:   Thu, 27 Sep 2018 15:53:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f54355c2-4eeb-9b7a-3964-57ca465dae17@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/18 15:26, Holger Hoffstätte wrote:
> On 09/27/18 14:37, Greg Kroah-Hartman wrote:
>> On Thu, Sep 27, 2018 at 12:43:33PM +0200, Holger Hoffstätte wrote:
>>> On 09/27/18 11:03, Greg Kroah-Hartman wrote:
>>>> 4.18-stable review patch.  If anyone has any objections, please let me know.
>>>>
>>>> ------------------
>>>>
>>>> From: Lyude Paul <lyude@redhat.com>
>>>>
>>>> commit 3c499ea0c662e2f38aafbd4f516b08aab8cfa0e5 upstream.
>>>>
>>>> As pointed out by Daniel Vetter, we should be usinng
>>>> drm_drv_uses_atomic_modeset() for determining whether or not we want to
>>>> make the debugfs nodes for atomic instead of checking DRIVER_ATOMIC, as
>>>> the former isn't an accurate representation of whether or not the driver
>>>> is actually using atomic modesetting internally (even though it might
>>>> not be exposing atomic capabilities).
>>>>
>>>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>> Cc: stable@vger.kernel.org
>>>> Reviewed-by: Sean Paul <seanpaul@chromium.org>
>>>> Link: https://patchwork.freedesktop.org/patch/msgid/20180917173733.21293-1-lyude@redhat.com
>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> This patch breaks switching the console to high resolution during boot on my
>>> workstation with a Radeon card; it worked fine with 4.18.10 and reverting it
>>> fixes the problem:
>>
>> Is 4.19-rc5 also a problem?
>>
> 
> No, 4.19-rc5 with the same config works fine and properly switches the
> console during boot.
> 
> Interestingly another machine with i915 chip seemed to work fine with this
> patch included (rebooted that one first), so it might well be related to
> different motherboard/chipset or the Radeon card (an admittedly old, but
> otherwise completely functional fanless r600).
> 
> I'll try to find more clues, but for now that's all I got.

Looking at mainline include/drm I see several recent movements and cleanups
related to drm_drv_uses_atomic_modeset(), moving it out of drmP.h and into
drm, changes to atomic modesetting and such, all part of the 4.19 merge
window. I'm reasonably sure some relatred changes went missing here wrt.
this patch.

-h
