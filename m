Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933448AbeBVRQG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:16:06 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32909 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933400AbeBVRQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:16:04 -0500
X-Google-Smtp-Source: AH8x227Lr9/2YjhWIt+nW5WW7ehDEIW+7gXK9cl2gn5Ppn+F4pSo15qvVrnFbyeXQ3ORSkmBqq032w==
Subject: Re: [PATCH v1] drm/simple_kms_helper: Fix NULL pointer dereference
 with no active CRTC
To: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@intel.com, airlied@linux.ie
References: <1519279759-7803-1-git-send-email-andr2000@gmail.com>
 <1f051697-468d-76b9-a2be-16a281f57249@epam.com>
 <20180222161128.GC6419@phenom.ffwll.local>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <fb0576bd-67d9-e28f-4916-78e014ce49db@gmail.com>
Date: Thu, 22 Feb 2018 19:16:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222161128.GC6419@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 06:11 PM, Daniel Vetter wrote:
> On Thu, Feb 22, 2018 at 08:12:48AM +0200, Oleksandr Andrushchenko wrote:
>> On 02/22/2018 08:09 AM, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> It is possible that drm_simple_kms_plane_atomic_check called
>>> with no CRTC set, e.g. when user-space application sets CRTC_ID/FB_ID
>>> to 0 before doing any actual drawing. This leads to NULL pointer
>>> dereference because in this case new CRTC state is NULL and must be
>>> checked before accessing.
>>>
>>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>>
>>> ---
>>> Changes since initial:
>>> - re-worked checks for null CRTC as suggested by Daniel Vetter
>>> ---
>>>    drivers/gpu/drm/drm_simple_kms_helper.c | 10 +++-------
>>>    1 file changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
>>> index 9ca8a4a59b74..4a1dbd88b1ec 100644
>>> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
>>> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
>>> @@ -121,12 +121,6 @@ static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
>>>    	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
>>>    	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
>>>    						   &pipe->crtc);
>>> -	if (!crtc_state->enable)
>>> -		return 0; /* nothing to check when disabling or disabled */
>>> -
>>> -	if (crtc_state->enable)
>>> -		drm_mode_get_hv_timing(&crtc_state->mode,
>>> -				       &clip.x2, &clip.y2);
>>>    	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
>>>    						  &clip,
>>> @@ -137,7 +131,9 @@ static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
>>>    		return ret;
>>>    	if (!plane_state->visible)
>>> -		return -EINVAL;
>> Daniel, I have put your R-b tag, but I had removed suggested
>> "WARN_ON(crtc_state && crtc_state->enable);"
>> here as it fires each time when crtc_state is not NULL.
>> Please let me know if this is not ok and you want me to remove
>> your R-b tag.
> I'm a bit confused why that fires, but oh well. Applied, thanks for your
> patch.
Thank you
> -Daniel
>
>>> +		return 0;
>>> +
>>> +	drm_mode_get_hv_timing(&crtc_state->mode, &clip.x2, &clip.y2);
>>>    	if (!pipe->funcs || !pipe->funcs->check)
>>>    		return 0;
>> Thank you,
>> Oleksandr
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
