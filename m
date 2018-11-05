Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD0FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D082086B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D082086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbeKEWaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:30:12 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:45606 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729100AbeKEWaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:30:11 -0500
Received: from [IPv6:2001:983:e9a7:1:d0f:9589:6703:bc30] ([IPv6:2001:983:e9a7:1:d0f:9589:6703:bc30])
        by smtp-cloud8.xs4all.net with ESMTPA
        id Jee9gPPqk0ZZEJeeAgFFMO; Mon, 05 Nov 2018 14:10:28 +0100
Subject: Re: [PATCH v2] media: vivid: Improve timestamping
To:     Gabriel Francisco Mandaji <gfmandaji@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkcamp@lists.libreplanetbr.org
References: <20181021230026.GA19458@gfm-note>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <f95880e5-0127-e5bf-db44-a380c21283ce@xs4all.nl>
Date:   Mon, 5 Nov 2018 14:10:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181021230026.GA19458@gfm-note>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNBSuU+yvpzaaqiHoGChJMGi6rZbIssrp0Vkixu/yc9s3eiT2utn42HwHve1LErQh/lI84aj9ynI3wE0vz3rPos5Z9kJz550/iwXKm3BWsgtTpq9igSk
 q/YH+lKJabKf38Tam8rhtOBRpyvL83yjgPKOLUfQZxxJU3vZsjuiArEZan2SVr9msjn2J1QdvZgfZhUu30ACaafqmsxTfHJnpKWamHTsLWsBJIBWR7Yt9+tE
 rJNoNtZ08E80spLpq4eLc367HuMzaZgpOKfc/6v8GSs6aETxGzzXSk239w9tOIdMMjiMEnHmlAZl1n4aF5OzH6VGMdVw3B0q2QrQpHhYSmh3ijKjCB4rcQzY
 Dq/OvsXBKvBSynidn7uJmunrpgJ71k169PL0Ipy9eq18Y7/lrsCbYKjXmtC7PmAg8nUiI3Kn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

This doesn't work. See my comment below.

I recommend testing with:

v4l2-ctl -P --stream-mmap --verbose

This shows the expected frame rate and --verbose shows the reported frame periods.

On 10/22/2018 01:00 AM, Gabriel Francisco Mandaji wrote:
> Simulate a more precise timestamp by calculating it based on the
> current framerate.
> 
> Signed-off-by: Gabriel Francisco Mandaji <gfmandaji@gmail.com>
> ---
> Changes in v2:
>     - fix spelling
>     - end of exposure is offset by 90% of the frame period
>     - fix timestamp calculation for FIELD_ALTERNATE (untested)
>     - timestamp is now calculated and set from vivid_thread_cap_tick()
>     - capture vbi uses the same timestamp as non-vbi, but offset by 5%
>     - timestamp stays consistent even if the FPS changes
>     - tested with dropped frames
> 
> If 'Start of Exposure'/'End of Frame' changes mid-capture, it will be
> completely ignored. If that's an issue, I'll change how the frame
> period and cap_stream_start are calculated.
> 
> Also, should I modify the output's timestamp on this patch or on adrivers/media/platform/vivid/vivid-kthread-cap.c
> separated one?

Separate one.

> ---
>  drivers/media/platform/vivid/vivid-core.h        |  2 +
>  drivers/media/platform/vivid/vivid-kthread-cap.c | 47 +++++++++++++++++-------
>  drivers/media/platform/vivid/vivid-vbi-cap.c     |  4 --
>  3 files changed, 35 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/media/platform/vivid/vivid-core.h b/drivers/media/platform/vivid/vivid-core.h
> index cd4c823..ba6fb3a 100644
> --- a/drivers/media/platform/vivid/vivid-core.h
> +++ b/drivers/media/platform/vivid/vivid-core.h
> @@ -384,6 +384,8 @@ struct vivid_dev {
>  	/* thread for generating video capture stream */
>  	struct task_struct		*kthread_vid_cap;
>  	unsigned long			jiffies_vid_cap;
> +	u64				cap_stream_start;
> +	u64				cap_frame_period;
>  	u32				cap_seq_offset;
>  	u32				cap_seq_count;
>  	bool				cap_seq_resync;
> diff --git a/drivers/media/platform/vivid/vivid-kthread-cap.c b/drivers/media/platform/vivid/vivid-kthread-cap.c
> index f06003b..828a58c 100644
> --- a/drivers/media/platform/vivid/vivid-kthread-cap.c
> +++ b/drivers/media/platform/vivid/vivid-kthread-cap.c
> @@ -425,12 +425,6 @@ static void vivid_fillbuff(struct vivid_dev *dev, struct vivid_buffer *buf)
>  		is_loop = true;
>  
>  	buf->vb.sequence = dev->vid_cap_seq_count;
> -	/*
> -	 * Take the timestamp now if the timestamp source is set to
> -	 * "Start of Exposure".
> -	 */
> -	if (dev->tstamp_src_is_soe)
> -		buf->vb.vb2_buf.timestamp = ktime_get_ns();
>  	if (dev->field_cap == V4L2_FIELD_ALTERNATE) {
>  		/*
>  		 * 60 Hz standards start with the bottom field, 50 Hz standards
> @@ -554,14 +548,6 @@ static void vivid_fillbuff(struct vivid_dev *dev, struct vivid_buffer *buf)
>  			}
>  		}
>  	}
> -
> -	/*
> -	 * If "End of Frame" is specified at the timestamp source, then take
> -	 * the timestamp now.
> -	 */
> -	if (!dev->tstamp_src_is_soe)
> -		buf->vb.vb2_buf.timestamp = ktime_get_ns();
> -	buf->vb.vb2_buf.timestamp += dev->time_wrap_offset;
>  }
>  
>  /*
> @@ -667,10 +653,27 @@ static void vivid_overlay(struct vivid_dev *dev, struct vivid_buffer *buf)
>  	}
>  }
>  
> +static void vivid_cap_update_frame_period(struct vivid_dev *dev)
> +{
> +	u64 f_period = dev->timeperframe_vid_cap.numerator * 1000000000 /
> +		       dev->timeperframe_vid_cap.denominator;
> +	if (dev->field_cap == V4L2_FIELD_ALTERNATE)
> +		f_period /= 2;
> +	/*
> +	 * If "End of Frame", then calculate the exposure time as 0.9
> +	 * of the frame period.
> +	 */
> +	if (!dev->tstamp_src_is_soe)
> +		f_period += f_period / 10 * 9;

This is very wrong: if the timestamp is for the "End of Frame" (the default), then
that does not change the frame period value, it just adds an offset.

Easiest is probably to add a dev->cap_frame_offset field:

	if (dev->tstamp_src_is_soe)
		dev->cap_frame_offset = 0;
	else
		dev->cap_frame_offset = f_period * 9 / 10;

This bug gave really weird frame periods.

Regards,

	Hans

> +
> +	dev->cap_frame_period = f_period;
> +}
> +
>  static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
>  {
>  	struct vivid_buffer *vid_cap_buf = NULL;
>  	struct vivid_buffer *vbi_cap_buf = NULL;
> +	u64 f_time = 0;
>  
>  	dprintk(dev, 1, "Video Capture Thread Tick\n");
>  
> @@ -702,6 +705,9 @@ static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
>  	if (!vid_cap_buf && !vbi_cap_buf)
>  		goto update_mv;
>  
> +	f_time = dev->cap_frame_period * dev->vid_cap_seq_count +
> +		 dev->cap_stream_start + dev->time_wrap_offset;
> +
>  	if (vid_cap_buf) {
>  		/* Fill buffer */
>  		vivid_fillbuff(dev, vid_cap_buf);
> @@ -717,9 +723,13 @@ static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
>  				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
>  		dprintk(dev, 2, "vid_cap buffer %d done\n",
>  				vid_cap_buf->vb.vb2_buf.index);
> +
> +		vid_cap_buf->vb.vb2_buf.timestamp = f_time;
>  	}
>  
>  	if (vbi_cap_buf) {
> +		u64 vbi_period;
> +
>  		if (dev->stream_sliced_vbi_cap)
>  			vivid_sliced_vbi_cap_process(dev, vbi_cap_buf);
>  		else
> @@ -728,6 +738,10 @@ static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
>  				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
>  		dprintk(dev, 2, "vbi_cap %d done\n",
>  				vbi_cap_buf->vb.vb2_buf.index);
> +
> +		/* If capturing a VBI, offset by 0.05 */
> +		vbi_period = dev->cap_frame_period / 100 * 5;
> +		vbi_cap_buf->vb.vb2_buf.timestamp = f_time + vbi_period;
>  	}
>  	dev->dqbuf_error = false;
>  
> @@ -759,6 +773,8 @@ static int vivid_thread_vid_cap(void *data)
>  	dev->cap_seq_count = 0;
>  	dev->cap_seq_resync = false;
>  	dev->jiffies_vid_cap = jiffies;
> +	dev->cap_stream_start = ktime_get_ns();
> +	vivid_cap_update_frame_period(dev);
>  
>  	for (;;) {
>  		try_to_freeze();
> @@ -771,6 +787,9 @@ static int vivid_thread_vid_cap(void *data)
>  			dev->jiffies_vid_cap = cur_jiffies;
>  			dev->cap_seq_offset = dev->cap_seq_count + 1;
>  			dev->cap_seq_count = 0;
> +			dev->cap_stream_start += dev->cap_frame_period *
> +						 dev->cap_seq_offset;
> +			vivid_cap_update_frame_period(dev);
>  			dev->cap_seq_resync = false;
>  		}
>  		numerator = dev->timeperframe_vid_cap.numerator;
> diff --git a/drivers/media/platform/vivid/vivid-vbi-cap.c b/drivers/media/platform/vivid/vivid-vbi-cap.c
> index 92a8529..c7cacc6 100644
> --- a/drivers/media/platform/vivid/vivid-vbi-cap.c
> +++ b/drivers/media/platform/vivid/vivid-vbi-cap.c
> @@ -95,8 +95,6 @@ void vivid_raw_vbi_cap_process(struct vivid_dev *dev, struct vivid_buffer *buf)
>  
>  	if (!VIVID_INVALID_SIGNAL(dev->std_signal_mode))
>  		vivid_vbi_gen_raw(&dev->vbi_gen, &vbi, vbuf);
> -
> -	buf->vb.vb2_buf.timestamp = ktime_get_ns() + dev->time_wrap_offset;
>  }
>  
>  
> @@ -119,8 +117,6 @@ void vivid_sliced_vbi_cap_process(struct vivid_dev *dev,
>  		for (i = 0; i < 25; i++)
>  			vbuf[i] = dev->vbi_gen.data[i];
>  	}
> -
> -	buf->vb.vb2_buf.timestamp = ktime_get_ns() + dev->time_wrap_offset;
>  }
>  
>  static int vbi_cap_queue_setup(struct vb2_queue *vq,
> 

