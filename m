Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeEGLDU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 07:03:20 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:45612 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751210AbeEGLDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 07:03:19 -0400
Subject: Re: [PATCH v9 05/15] vb2: add unordered vb2_queue property for
 drivers
To: Ezequiel Garcia <ezequiel@collabora.com>, linux-media@vger.kernel.org
Cc: kernel@collabora.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, Pawel Osciak <pawel@osciak.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Brian Starkey <brian.starkey@arm.com>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>
References: <20180504200612.8763-1-ezequiel@collabora.com>
 <20180504200612.8763-6-ezequiel@collabora.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <4e3fa169-00f9-daef-134f-3bdcbc53bd8e@xs4all.nl>
Date: Mon, 7 May 2018 13:03:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504200612.8763-6-ezequiel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfE6bKu0HmYAn6bNSG07BCSKv7FnsgcAgbigv4ehx9x2pHMA3Ux7J1CkqY7xyjWLyczoXe8zvuV83P0L58a43UFqt5+azVQeuIZjlfXJ1tyvE38qUqK29
 mvXHuSObX76aJzB2MLXIBxXPM/7f3vqGMIxDZmr7rYKrz8VDvNlh68yOXYNLDZ7N0+8x4GX9ylv/Iz3RCs+b6ezSKEeVoQDwLALrmxFb8CVj1Zt89GkLKnyW
 rjU1h8Jb5COKIqqrpwkTr2AfOJ2gK5GI1//eTcP0sKoC0jCCcBVh/BUK6rFXiECzFh8Bzft7s9ceqHy+khO51A0EbAXVOM4+Dz6E7K5zdHy+qHK7Xu0MoJQh
 KSGxGFRgBJKY0uFwbF2ATAEm7Ra2hGXJS2MqouuZ1FlXtpQAUNMHHHmtQZg3dMxn3tpSdUCszMEB0ETXk/dFzinJOtO01zI4fo8QQ6KxIy3+V92y7cRonk4k
 bZgeGTV/qGP0W24xnvfjspElnA7/H2NRw4CidGD2N+c5rEQnaaqWBROsMhKRi6Kn6ops+bchcKO4c19ISuUPhTvyFqMP4uJyVyk/xmehyQ/SuakNqvnRkGkP
 3uMCwRvMub9/fIa7eMnXRo2G
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/18 22:06, Ezequiel Garcia wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
> 
> Explicit synchronization benefits a lot from ordered queues, they fit
> better in a pipeline with DRM for example so create a opt-in way for
> drivers notify videobuf2 that the queue is unordered.
> 
> v5: go back to a bitfield property for the unordered property.

This needs to be a callback. Whether or not the queue is unordered depends
on the current format (see the next two patches). So if a queue can e.g.
capture both raw/MJPEG and compressed (MPEG-like) data, then it has to call
a callback.

Regards,

	Hans

> 
> v4: rename it to vb2_ops_is_unordered() (Hans Verkuil)
> 
> v3: - make it bool (Hans)
>     - create vb2_ops_set_unordered() helper
> 
> v2: improve comments for is_unordered flag (Hans Verkuil)
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  include/media/videobuf2-core.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index f9633de0386c..364e4cb41b10 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -467,6 +467,8 @@ struct vb2_buf_ops {
>   * @quirk_poll_must_check_waiting_for_buffers: Return %EPOLLERR at poll when QBUF
>   *              has not been called. This is a vb1 idiom that has been adopted
>   *              also by vb2.
> + * @unordered:	tell if the queue is unordered, i.e. buffers can be
> + *		dequeued in a different order from how they were queued.
>   * @lock:	pointer to a mutex that protects the &struct vb2_queue. The
>   *		driver can set this to a mutex to let the v4l2 core serialize
>   *		the queuing ioctls. If the driver wants to handle locking
> @@ -533,6 +535,7 @@ struct vb2_queue {
>  	unsigned			fileio_read_once:1;
>  	unsigned			fileio_write_immediately:1;
>  	unsigned			allow_zero_bytesused:1;
> +	unsigned			unordered:1;
>  	unsigned		   quirk_poll_must_check_waiting_for_buffers:1;
>  
>  	struct mutex			*lock;
> 
