Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933413AbeBVRPg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:15:36 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45730 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933298AbeBVRPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:15:32 -0500
X-Google-Smtp-Source: AH8x2249aIOepB2jwXIgnkpDU31aBpD6yeqU9KSjm5FQzjvj9waw2JFY78KW7L642YFERyohSgOkCQ==
Subject: Re: [PATCH 1/4] drm/simple_kms_helper: Add {enable|disable}_vblank
 callback support
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel.vetter@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1518425574-32671-1-git-send-email-andr2000@gmail.com>
 <1518425574-32671-2-git-send-email-andr2000@gmail.com>
 <00b01a2d-ad16-e171-f52f-88fba2896386@gmail.com>
 <20180222165916.GD6419@phenom.ffwll.local>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <14c72176-9547-bbdf-7d7e-695cd9da3e15@gmail.com>
Date: Thu, 22 Feb 2018 19:15:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222165916.GD6419@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 06:59 PM, Daniel Vetter wrote:
> On Mon, Feb 19, 2018 at 11:11:23AM +0200, Oleksandr Andrushchenko wrote:
>> ping
>> On 02/12/2018 10:52 AM, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> If simple_kms_helper based driver needs to work with vblanks,
>>> then it has to provide drm_driver.{enable|disable}_vblank callbacks,
>>> because drm_simple_kms_helper.drm_crtc_funcs does not provide any.
>>> At the same time drm_driver.{enable|disable}_vblank callbacks
>>> are marked as deprecated and shouldn't be used by new drivers.
>>>
>>> Fix this by extending drm_simple_kms_helper.drm_crtc_funcs
>>> to provide the missing callbacks.
>>>
>>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> lgtm, all 4 applied, thanks for your patches.
Thank you, my pleasure
> -Daniel
>
>>> ---
>>>    drivers/gpu/drm/drm_simple_kms_helper.c | 24 ++++++++++++++++++++++++
>>>    include/drm/drm_simple_kms_helper.h     | 18 ++++++++++++++++++
>>>    2 files changed, 42 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
>>> index 9d3f6b70812c..9ca8a4a59b74 100644
>>> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
>>> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
>>> @@ -77,6 +77,28 @@ static const struct drm_crtc_helper_funcs drm_simple_kms_crtc_helper_funcs = {
>>>    	.atomic_disable = drm_simple_kms_crtc_disable,
>>>    };
>>> +static int drm_simple_kms_crtc_enable_vblank(struct drm_crtc *crtc)
>>> +{
>>> +	struct drm_simple_display_pipe *pipe;
>>> +
>>> +	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
>>> +	if (!pipe->funcs || !pipe->funcs->enable_vblank)
>>> +		return 0;
>>> +
>>> +	return pipe->funcs->enable_vblank(pipe);
>>> +}
>>> +
>>> +static void drm_simple_kms_crtc_disable_vblank(struct drm_crtc *crtc)
>>> +{
>>> +	struct drm_simple_display_pipe *pipe;
>>> +
>>> +	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
>>> +	if (!pipe->funcs || !pipe->funcs->disable_vblank)
>>> +		return;
>>> +
>>> +	pipe->funcs->disable_vblank(pipe);
>>> +}
>>> +
>>>    static const struct drm_crtc_funcs drm_simple_kms_crtc_funcs = {
>>>    	.reset = drm_atomic_helper_crtc_reset,
>>>    	.destroy = drm_crtc_cleanup,
>>> @@ -84,6 +106,8 @@ static const struct drm_crtc_funcs drm_simple_kms_crtc_funcs = {
>>>    	.page_flip = drm_atomic_helper_page_flip,
>>>    	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
>>>    	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
>>> +	.enable_vblank = drm_simple_kms_crtc_enable_vblank,
>>> +	.disable_vblank = drm_simple_kms_crtc_disable_vblank,
>>>    };
>>>    static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
>>> diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
>>> index 6d9adbb46293..79567826b099 100644
>>> --- a/include/drm/drm_simple_kms_helper.h
>>> +++ b/include/drm/drm_simple_kms_helper.h
>>> @@ -93,6 +93,24 @@ struct drm_simple_display_pipe_funcs {
>>>    	 */
>>>    	void (*cleanup_fb)(struct drm_simple_display_pipe *pipe,
>>>    			   struct drm_plane_state *plane_state);
>>> +
>>> +	/**
>>> +	 * @enable_vblank:
>>> +	 *
>>> +	 * Optional, called by &drm_crtc_funcs.enable_vblank. Please read
>>> +	 * the documentation for the &drm_crtc_funcs.enable_vblank hook for
>>> +	 * more details.
>>> +	 */
>>> +	int (*enable_vblank)(struct drm_simple_display_pipe *pipe);
>>> +
>>> +	/**
>>> +	 * @disable_vblank:
>>> +	 *
>>> +	 * Optional, called by &drm_crtc_funcs.disable_vblank. Please read
>>> +	 * the documentation for the &drm_crtc_funcs.disable_vblank hook for
>>> +	 * more details.
>>> +	 */
>>> +	void (*disable_vblank)(struct drm_simple_display_pipe *pipe);
>>>    };
>>>    /**
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
