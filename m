Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A4BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E35121736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="jH7dPwrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfA1Kie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:38:34 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:52590 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1Kid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=ixrm4s1DaB0ZI0uNqxh6q1d7U273FwHADrGMk3qVOUE=;
        b=jH7dPwrJxKJSX1XpupgPYedy+yshWUgD/CvhuKV385jIwWRL4+Rlkp2CJJC+T4mLxE4Lmdz8zJiVv4KGItWfY78VweBU74aZ7Bc4C51iJ7L8icTWlE9ok1EjoBkCfxaEkyvyRzby97g5kDyCWYLqsu+/G1XPkv2itF4iVm0B00S8RfORQES376JiBwvVAFkNZ3Rw/7BLjlw8q5CMQ258pG5qn9ekRoo+kZp8lm1b4oyM5wn5odjlo/e59K/mztgUDiV8/TzXkHtbIFzfFbNfjH4EmQFtmfx1cU3MajsYNDpN9ngbNj6HwAGBDV/kYZSiJ7jWH7k35srP5dm5+23V2g==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:61031 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1go4JD-0007rj-G2; Mon, 28 Jan 2019 11:38:31 +0100
Subject: Re: [PATCH v3 10/23] drm/qxl: move qxl_primary_apply_cursor to
 correct place
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-11-kraxel@redhat.com>
 <b3c756b3-c7b6-f4d3-5208-c8de0168d655@tronnes.org>
 <20190128081005.j6z2ecnytuocfidh@sirius.home.kraxel.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <44e41026-e091-659d-ac9c-fefa47e2335b@tronnes.org>
Date:   Mon, 28 Jan 2019 11:38:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128081005.j6z2ecnytuocfidh@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 28.01.2019 09.10, skrev Gerd Hoffmann:
>>> The cursor must be set again after creating the primary surface.
>>> Also drop the error message.
> 
>>>  	if (!bo->is_primary) {
>>> -		if (!same_shadow)
>>> +		if (!same_shadow) {
>>>  			qxl_io_create_primary(qdev, 0, bo);
>>> +			qxl_primary_apply_cursor(plane);
>>> +		}
>>>  		bo->is_primary = true;
>>>  	}
>>>  
>>>
>>
>> I don't see how the commit message matches what you're doing. It gives
>> the impression that it must be applied under yet another condition, but
>> the condition for applying the cursor is changed from bo_old->is_primary
>> to !bo->is_primary.
> 
> The qxl device ties the cursor to the primary surface.  Therefore
> calling qxl_io_destroy_primary() and qxl_io_create_primary() to switch
> the framebuffer causes the cursor information being lost and the driver
> must re-apply it.
> 
> The correct call order to do that is qxl_io_destroy_primary() +
> qxl_io_create_primary() + qxl_primary_apply_cursor().
> 
> The old code did qxl_io_destroy_primary() + qxl_primary_apply_cursor() +
> qxl_io_create_primary().  Due to qxl_primary_apply_cursor request being
> queued in a ringbuffer and qxl_io_create_primary() trapping to the
> hypervisor instantly there is a high chance that qxl_io_create_primary()
> is processed first even with the wrong call order.  But it's racy and
> thus not reliable.
> 
>> It probably makes sense to someone that knows the driver.
> 
> If the above explains things better to you I should probably replace the
> commit message with that.
> 

This is actually my first review of a driver that I'm not familiar with.
I'm not quite sure how much in depth understanding that is required to
put my ack on it. Going further into the patchset I realised that
there's no way that I can verify the logic without being intimate with
the driver. So I have tried to verify things from a kms point of view.

I liked your expanded explanation better.

Noralf.

>> Acked-by: Noralf Trønnes <noralf@tronnes.org>
> 
> thanks,
>   Gerd
> 
