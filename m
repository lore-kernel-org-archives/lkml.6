Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933168AbeCNCay (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 22:30:54 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:49785 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932809AbeCNCax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 22:30:53 -0400
Subject: Re: [PATCH v8 01/13] [media] xilinx: regroup caps on querycap
To: Gustavo Padovan <gustavo@padovan.org>, linux-media@vger.kernel.org
Cc: kernel@collabora.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, Pawel Osciak <pawel@osciak.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Brian Starkey <brian.starkey@arm.com>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>
References: <20180309174920.22373-1-gustavo@padovan.org>
 <20180309174920.22373-2-gustavo@padovan.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <60eb65ce-e7dd-49ec-ffeb-dfd0a438f8d2@xs4all.nl>
Date: Tue, 13 Mar 2018 19:30:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180309174920.22373-2-gustavo@padovan.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD7VJVmbk8vonKk24lZwwbe8r04gxs4UzMgz6QeBGedyuTC3n1R/iQzFVtASeR1vg3w2gJc7p2QQboDVaGInflwBNk+DCCziySUVE3cIUI21yRGm9ei9
 MFHMjDS4JwYKwzaQvQ1e8WJpWrEq8UN1XhC0FJE4ZTOTZ3Zzf14FStCknjgyXuecCqJFU1U9o0KSatdWzqDzQAyjVJFvmhaWv1SB/l7c5TKhaFsfFF42HVJ4
 OrO5fmAXUqN0BiM9ltJ0s1GGADZfiTyxOc4ai0Du2jQY+ryH6P1jcU3Ow0vsEAmxt4kYiAbg0IvlUxCC1MypvsFDr+3x/cnr8MLjj2kTkuQXVaUKkb5kfKeR
 PjdT8yCBC1VRMmbpvSzZFhr9vm6i0Ua+99dMSCctb3rgVrQppTtm8sUV2c6x3ZrB2v/80pjHYR8SVUBcBky3CYkfRq0ZUlZmvR4YjIep/ES+UyaNDLdoRUNX
 hN51uTK9ouxzGVh3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 09:49 AM, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
> 
> To better organize the code we concentrate the setting of
> V4L2_CAP_STREAMING in one place.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> ---
>  drivers/media/platform/xilinx/xilinx-dma.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/xilinx/xilinx-dma.c b/drivers/media/platform/xilinx/xilinx-dma.c
> index 522cdfdd3345..565e466ba4fa 100644
> --- a/drivers/media/platform/xilinx/xilinx-dma.c
> +++ b/drivers/media/platform/xilinx/xilinx-dma.c
> @@ -494,13 +494,14 @@ xvip_dma_querycap(struct file *file, void *fh, struct v4l2_capability *cap)
>  	struct v4l2_fh *vfh = file->private_data;
>  	struct xvip_dma *dma = to_xvip_dma(vfh->vdev);
>  
> -	cap->capabilities = V4L2_CAP_DEVICE_CAPS | V4L2_CAP_STREAMING
> +	cap->device_caps = V4L2_CAP_STREAMING;
> +	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS
>  			  | dma->xdev->v4l2_caps;

Shouldn't this cap->capabilities assignment be moved down to after the
if-else? Otherwise cap->device_caps isn't fully initialized yet.

>  
>  	if (dma->queue.type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
> -		cap->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
> +		cap->device_caps |= V4L2_CAP_VIDEO_CAPTURE;
>  	else
> -		cap->device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_STREAMING;
> +		cap->device_caps |= V4L2_CAP_VIDEO_OUTPUT;
>  
>  	strlcpy(cap->driver, "xilinx-vipp", sizeof(cap->driver));
>  	strlcpy(cap->card, dma->video.name, sizeof(cap->card));
> 

Regards,

	Hans
