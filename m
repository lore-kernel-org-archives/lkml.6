Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0000ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF5420854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF5420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbeGWTlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:41:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56428 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbeGWTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:41:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: padovan)
        with ESMTPSA id 6926B27C8A2
Subject: Re: [RFC RESEND PATCH] drm/rockchip: update cursors asynchronously
 through atomic.
To:     Sean Paul <seanpaul@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>
References: <20180627211447.20927-1-enric.balletbo@collabora.com>
 <20180723143634.GJ20359@art_vandelay>
From:   Gustavo Padovan <gustavo.padovan@collabora.com>
Organization: Collabora Ltd
Message-ID: <621351c6-068e-1317-2571-5c8d1477c2e3@collabora.com>
Date:   Mon, 23 Jul 2018 15:39:06 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723143634.GJ20359@art_vandelay>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 07/23/2018 11:36 AM, Sean Paul wrote:
> On Wed, Jun 27, 2018 at 11:14:47PM +0200, Enric Balletbo i Serra wrote:
>> Add support to async updates of cursors by using the new atomic
>> interface for that.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> LGTM. Given rockchip hasn't weighed in on the patch, and that you've tested it
> on real hardware, let's land it.
> 
> Reviewed-by: Sean Paul <seanpaul@chromium.org>

Your patch don't apply cleanly anymore. Can you rebase it and add the 
r-b to the patch while at it? Thanks!

Gustavo

> 
> 
>> ---
>> I am sending this as RFC because I still don't have a deep knowledge of
>> the hw and I am not sure if the vop_plane_update function can be reused
>> in both cases, atomic_updates and atomic_async_updates. I think that
>> someone with more knowledge should take a look. The patch was tested on
>> a Samsung Chromebook Plus in two ways.
>>
>> 1. Running all igt kms_cursor_legacy and kms_atomic@plane_cursor_legacy
>> tests and see that there is no regression after the patch.
>>
>> 2. Running weston using the atomic API.
>>
>> Best regards,
>>    Enric
>>
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 80 ++++++++++++++++-----
>>   1 file changed, 64 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> index 53d4afe15278..1eb6bda924af 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> @@ -688,8 +688,7 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
>>   	spin_unlock(&vop->reg_lock);
>>   }
>>   
>> -static void vop_plane_atomic_update(struct drm_plane *plane,
>> -		struct drm_plane_state *old_state)
>> +static void vop_plane_update(struct drm_plane *plane)
>>   {
>>   	struct drm_plane_state *state = plane->state;
>>   	struct drm_crtc *crtc = state->crtc;
>> @@ -710,20 +709,6 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>>   	bool rb_swap;
>>   	int format;
>>   
>> -	/*
>> -	 * can't update plane when vop is disabled.
>> -	 */
>> -	if (WARN_ON(!crtc))
>> -		return;
>> -
>> -	if (WARN_ON(!vop->is_enabled))
>> -		return;
>> -
>> -	if (!state->visible) {
>> -		vop_plane_atomic_disable(plane, old_state);
>> -		return;
>> -	}
>> -
>>   	obj = rockchip_fb_get_gem_obj(fb, 0);
>>   	rk_obj = to_rockchip_obj(obj);
>>   
>> @@ -794,10 +779,73 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>>   	spin_unlock(&vop->reg_lock);
>>   }
>>   
>> +static void vop_plane_atomic_update(struct drm_plane *plane,
>> +				    struct drm_plane_state *old_state)
>> +{
>> +	struct drm_plane_state *state = plane->state;
>> +	struct vop *vop = to_vop(state->crtc);
>> +
>> +	/*
>> +	 * can't update plane when vop is disabled.
>> +	 */
>> +	if (WARN_ON(!state->crtc))
>> +		return;
>> +
>> +	if (WARN_ON(!vop->is_enabled))
>> +		return;
>> +
>> +	if (!state->visible) {
>> +		vop_plane_atomic_disable(plane, old_state);
>> +		return;
>> +	}
>> +
>> +	vop_plane_update(plane);
>> +}
>> +
>> +static int vop_plane_atomic_async_check(struct drm_plane *plane,
>> +					struct drm_plane_state *state)
>> +{
>> +	struct drm_crtc_state *crtc_state;
>> +
>> +	crtc_state = drm_atomic_get_existing_crtc_state(state->state,
>> +							state->crtc);
>> +	if (WARN_ON(!crtc_state))
>> +		return -EINVAL;
>> +
>> +	if (!crtc_state->active)
>> +		return -EINVAL;
>> +
>> +	if (plane->state->crtc != state->crtc ||
>> +	    plane->state->src_w != state->src_w ||
>> +	    plane->state->src_h != state->src_h ||
>> +	    plane->state->crtc_w != state->crtc_w ||
>> +	    plane->state->crtc_h != state->crtc_h ||
>> +	    !plane->state->fb ||
>> +	    plane->state->fb != state->fb)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static void vop_plane_atomic_async_update(struct drm_plane *plane,
>> +					  struct drm_plane_state *new_state)
>> +{
>> +	plane->state->src_x = new_state->src_x;
>> +	plane->state->src_y = new_state->src_y;
>> +	plane->state->crtc_x = new_state->crtc_x;
>> +	plane->state->crtc_y = new_state->crtc_y;
>> +	plane->state->fb = new_state->fb;
>> +	*plane->state = *new_state;
>> +
>> +	vop_plane_update(plane);
>> +}
>> +
>>   static const struct drm_plane_helper_funcs plane_helper_funcs = {
>>   	.atomic_check = vop_plane_atomic_check,
>>   	.atomic_update = vop_plane_atomic_update,
>>   	.atomic_disable = vop_plane_atomic_disable,
>> +	.atomic_async_check = vop_plane_atomic_async_check,
>> +	.atomic_async_update = vop_plane_atomic_async_update,
>>   };
>>   
>>   static const struct drm_plane_funcs vop_plane_funcs = {
>> -- 
>> 2.18.0
>>
> 

-- 
Gustavo Padovan
Collabora Ltd
