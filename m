Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724BCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A64214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="f3Q9FZoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfAJLKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:10:03 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:47389 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfAJLKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=3M3rnuoFyFqK2PfNTqTRZ9iVr4ClUSVBwQzVAPXmtG4=;
        b=f3Q9FZoJxW5JvsjheKBCq4Y5CuJI/GOIUQ8FevipPxErGFnhlkfYZyQxm6+QyLCjmBfFp2NSuQLaXzS5SptM9Gcel0ZzX6/1wdAC6VHqnsod1wGOyExL8+ETfGiDBtosnAT3/ZaP3gr3peKdZQl2wCYLTtipSUAN1YZLkdhsWRzHW2xyYpZ/IVKcNdBVg2YsCcq05pji2/ZWCcUZjZL7OEtt/RIBzBflkkZOhlfTxBShlMWq0Bq4t32cciDNj2CElQSNysV5ZVsB3c6V5oHlkIRwjm7XQEvdfwPBLUk/0BrgUdhcOG6DPc3rrRjdkbIZNn2CB3EfomKT/OlZ9lvHXw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58113 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1ghYDp-0003t1-Id; Thu, 10 Jan 2019 12:10:01 +0100
Subject: Re: [PATCH v3 14/15] drm/bochs: drop old fbdev emulation code
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        andr2000@gmail.com, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20190110082845.3453-1-kraxel@redhat.com>
 <20190110082845.3453-15-kraxel@redhat.com>
 <faf265e5-8f47-f652-5b19-d55fd4ed7d67@tronnes.org>
 <20190110101613.yo4ewkhy3nxs3do3@sirius.home.kraxel.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <c9190d7a-6549-2a10-9fbe-a2080a689686@tronnes.org>
Date:   Thu, 10 Jan 2019 12:09:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190110101613.yo4ewkhy3nxs3do3@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 10.01.2019 11.16, skrev Gerd Hoffmann:
>   Hi,
> 
>>> -	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 1);
>>
>> The generic fbdev emulation doesn't take care of suspend/resume. You
>> could do this:
>> drm_fb_helper_set_suspend_unlocked(drm_dev->fb_helper, 1);
> 
> Additional to drm_mode_config_helper_suspend() I assume?

No, sorry for the confusion. I didn't know if you could use
drm_mode_config_helper_suspend() or not. That function takes care of
fbdev suspend as well:

int drm_mode_config_helper_suspend(struct drm_device *dev)
{
<...>
	drm_kms_helper_poll_disable(dev);
	drm_fb_helper_set_suspend_unlocked(dev->fb_helper, 1);
	state = drm_atomic_helper_suspend(dev);
<...>
}


> Does the call order matter?
> 
>>>  	drm_helper_resume_force_mode(drm_dev);
>>
>> The docs for this function has this to say:
>> * This function is deprecated. New drivers should implement atomic mode-
>> * setting and use the atomic suspend/resume helpers.
>>
>> Maybe you can use drm_mode_config_helper_suspend/resume() instead like
>> suggested in the drm_fbdev_generic_setup() docs.
> 
> That should work, yes.  The driver is simple enough ;)
> 
> cheers,
>   Gerd
> 
