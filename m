Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbeBTNGD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:06:03 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:52527 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751813AbeBTNF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:05:59 -0500
Subject: Re: [RFCv4 08/21] [WAR] v4l2-ctrls: do not clone non-standard
 controls
To: Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Gustavo Padovan <gustavo.padovan@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180220044425.169493-1-acourbot@chromium.org>
 <20180220044425.169493-9-acourbot@chromium.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <a189a756-d017-deed-e526-a4fc925e6c13@xs4all.nl>
Date: Tue, 20 Feb 2018 14:05:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180220044425.169493-9-acourbot@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfA2Bm3FgDAx3V4TOmlii3ntMTLlTp5yXmYHXCl1Jdg8IdRYygfp4gyzGmlwaLblHJT9tSHV/ZWhchAEpSYFuln1xhrnl0IVvmrh17z7tDiKn3n5iNbq3
 MDvmFNJZDTO+/hd8GnnSsbHgYiO8FoQGCUdEmuqF0SDDhzPn1MHhmYio0Bl/VrhGDruLdFIMNoGxB3Jvon57lwZ+pSRWT+JBZLTB0mlCHZJFOSDOgU+hjhj/
 uXZ3IUJzF5TY4MQj2mMzID8pjNhkI1BWgM/YA1zxPHH0EzPbBM8BAm45kh7f6dyyKJzuI/6Cv/3zm/1wtoXEJgwPWMuGks4bLPvEmaqk4beiqwwSwQXeGNTn
 9ce1GMq8Ja8IkLjwozqWiXl9IHp2WukBexlh3OfcId5a6VM3r02sWQYnq9l0cGhqAeHKi1BIvWlsWsvoTo+LnVMAChQPRhVplvzb9MezGYJo+PwxeQ7lYIUH
 +z38zKxgqIYD/pKLWBMbjwSHGRipubQxiF0QxPBO8td4FmmF7U1XlR8Y0r8G57klLcdFaThFawq+WnPKzIKzargoWWnFAUvZZZHpzxnfREmK3s1q5n/2tpe1
 M8A=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/18 05:44, Alexandre Courbot wrote:
> Only standard controls can be successfully cloned: handler_new_ref, used
> by v4l2_ctrl_request_clone(), forcibly calls v4l2_ctrl_new_std() which
> fails to find custom controls names, and we eventually hit the condition
> that name == NULL in v4l2_ctrl_new().

Hmm, the core reason is that handler_new_ref tries to automatically create
a new control class if it didn't exist yet. Which is OK for standard control
classes but not for non-standard control classes such as is used in vivid.

I will have to think about this.

Regards,

	Hans

> 
> This prevents us from using non-standard controls with requests, but
> that is enough for testing purposes.
> 
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  drivers/media/v4l2-core/v4l2-ctrls.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index 166647817efb..7a81aa5959c3 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -2772,6 +2772,11 @@ int v4l2_ctrl_request_clone(struct v4l2_ctrl_handler *hdl,
>  		if (filter && !filter(ctrl))
>  			continue;
>  		err = handler_new_ref(hdl, ctrl, &new_ref, false);
> +		if (err) {
> +			printk("%s: handler_new_ref on control %x (%s) returned %d\n", __func__, ctrl->id, ctrl->name, err);
> +			err = 0;
> +			continue;
> +		}
>  		if (err)
>  			break;
>  		if (from->is_request)
> 
