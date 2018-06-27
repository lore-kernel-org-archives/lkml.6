Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6996C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C87825B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rDVNk6uI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C87825B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966127AbeF0RVm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:21:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44442 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754757AbeF0RVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:21:39 -0400
Received: from [192.168.0.67] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62B941A8F;
        Wed, 27 Jun 2018 19:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1530120096;
        bh=2WfHRMqWP8zXKBg7tgXaDhGTiGpTceGz7pdtUBTgFnc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rDVNk6uIF3me+9Hj7+5Z61PB9IdRDzPO5ls2ZVGVpUBCz42zybmGqy9K2ngsmD3tF
         GbImgeU8wH75dfaolhHLxz+WoUDZM+ZCgctz7iRDjEKh7a77db0z8kt5KQMGDcwO55
         TApvs8iMxF8SKEzqImLRnHwFTpOhIUXKQBorXE0U=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH v1] media: uvcvideo: Cache URB header data before
 processing
To:     Keiichi Watanabe <keiichiw@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, tfiga@chromium.org,
        dianders@chromium.org
References: <20180627103408.33003-1-keiichiw@chromium.org>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <344dca0a-bdb1-7b4d-37d4-e6ebca05bf4f@ideasonboard.com>
Date:   Wed, 27 Jun 2018 18:21:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627103408.33003-1-keiichiw@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keiichi,

I just wanted to reply here quickly to say this is a really interesting
development.

I would like to review and test it properly; however I am now on holiday
until at least the 9th July and so I won't be able to look until after
that date.

I didn't want you to be left hanging though :-)

Ping me if you haven't heard anything by the 20th or so. Of course if
anyone else gets round to testing and reviewing then that's great too.

Regards
--
Kieran



On 27/06/18 11:34, Keiichi Watanabe wrote:
> On some platforms with non-coherent DMA (e.g. ARM), USB drivers use
> uncached memory allocation methods. In such situations, it sometimes
> takes a long time to access URB buffers.  This can be a cause of video
> flickering problems if a resolution is high and a USB controller has
> a very tight time limit. (e.g. dwc2) To avoid this problem, we copy
> header data from (uncached) URB buffer into (cached) local buffer.
> 
> This change should make the elapsed time of the interrupt handler
> shorter on platforms with non-coherent DMA. We measured the elapsed
> time of each callback of uvc_video_complete without/with this patch
> while capturing Full HD video in
> https://webrtc.github.io/samples/src/content/getusermedia/resolution/.
> I tested it on the top of Kieran Bingham's Asynchronous UVC series
> https://www.mail-archive.com/linux-media@vger.kernel.org/msg128359.html.
> The test device was Jerry Chromebook (RK3288) with Logitech Brio 4K.
> I collected data for 5 seconds. (There were around 480 callbacks in
> this case.) The following result shows that this patch makes
> uvc_video_complete about 2x faster.
> 
>            | average | median  | min     | max     | standard deviation
> w/o caching| 45319ns | 40250ns | 33834ns | 142625ns| 16611ns
> w/  caching| 20620ns | 19250ns | 12250ns | 56583ns | 6285ns
> 
> In addition, we confirmed that this patch doesn't make it worse on
> coherent DMA architecture by performing the same measurements on a
> Broadwell Chromebox with the same camera.
> 
>            | average | median  | min     | max     | standard deviation
> w/o caching| 21026ns | 21424ns | 12263ns | 23956ns | 1932ns
> w/  caching| 20728ns | 20398ns |  8922ns | 45120ns | 3368ns
> 
> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
> ---
> 
> After applying 6 patches in
> https://www.mail-archive.com/linux-media@vger.kernel.org/msg128359.html,
> I measured elapsed time by adding the following code to
> /drivers/media/usb/uvc/uvc_video.c
> 
> @@ -XXXX,6 +XXXX,9 @@ static void uvc_video_complete(struct urb *urb)
>         struct uvc_video_queue *queue = &stream->queue;
>  	struct uvc_buffer *buf = NULL;
>  	int ret;
> +	ktime_t start, end;
> +	int elapsed_time;
> +	start = ktime_get();
>  	switch (urb->status) {
>  	case 0:
> 
> @@ -XXXX,6 +XXXX,10 @@ static void uvc_video_complete(struct urb *urb)
> 
>  	INIT_WORK(&uvc_urb->work, uvc_video_copy_data_work);
>  	queue_work(stream->async_wq, &uvc_urb->work);
> +
> +	end = ktime_get();
> +	elapsed_time = ktime_to_ns(ktime_sub(end, start));
> +	pr_err("elapsed time: %d ns", elapsed_time);
>  }
> 
>  /*
> 
> 
>  drivers/media/usb/uvc/uvc_video.c | 92 +++++++++++++++----------------
>  1 file changed, 43 insertions(+), 49 deletions(-)
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index a88b2e51a666..ff2eddc55530 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -391,36 +391,15 @@ static inline ktime_t uvc_video_get_time(void)
> 
>  static void
>  uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
> -		       const u8 *data, int len)
> +		       const u8 *data, int len, unsigned int header_size,
> +		       bool has_pts, bool has_scr)
>  {
>  	struct uvc_clock_sample *sample;
> -	unsigned int header_size;
> -	bool has_pts = false;
> -	bool has_scr = false;
>  	unsigned long flags;
>  	ktime_t time;
>  	u16 host_sof;
>  	u16 dev_sof;
> 
> -	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
> -	case UVC_STREAM_PTS | UVC_STREAM_SCR:
> -		header_size = 12;
> -		has_pts = true;
> -		has_scr = true;
> -		break;
> -	case UVC_STREAM_PTS:
> -		header_size = 6;
> -		has_pts = true;
> -		break;
> -	case UVC_STREAM_SCR:
> -		header_size = 8;
> -		has_scr = true;
> -		break;
> -	default:
> -		header_size = 2;
> -		break;
> -	}
> -
>  	/* Check for invalid headers. */
>  	if (len < header_size)
>  		return;
> @@ -717,11 +696,10 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
>   */
> 
>  static void uvc_video_stats_decode(struct uvc_streaming *stream,
> -		const u8 *data, int len)
> +				   const u8 *data, int len,
> +				   unsigned int header_size, bool has_pts,
> +				   bool has_scr)
>  {
> -	unsigned int header_size;
> -	bool has_pts = false;
> -	bool has_scr = false;
>  	u16 uninitialized_var(scr_sof);
>  	u32 uninitialized_var(scr_stc);
>  	u32 uninitialized_var(pts);
> @@ -730,25 +708,6 @@ static void uvc_video_stats_decode(struct uvc_streaming *stream,
>  	    stream->stats.frame.nb_packets == 0)
>  		stream->stats.stream.start_ts = ktime_get();
> 
> -	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
> -	case UVC_STREAM_PTS | UVC_STREAM_SCR:
> -		header_size = 12;
> -		has_pts = true;
> -		has_scr = true;
> -		break;
> -	case UVC_STREAM_PTS:
> -		header_size = 6;
> -		has_pts = true;
> -		break;
> -	case UVC_STREAM_SCR:
> -		header_size = 8;
> -		has_scr = true;
> -		break;
> -	default:
> -		header_size = 2;
> -		break;
> -	}
> -
>  	/* Check for invalid headers. */
>  	if (len < header_size || data[0] < header_size) {
>  		stream->stats.frame.nb_invalid++;
> @@ -957,10 +916,41 @@ static void uvc_video_stats_stop(struct uvc_streaming *stream)
>   * to be called with a NULL buf parameter. uvc_video_decode_data and
>   * uvc_video_decode_end will never be called with a NULL buffer.
>   */
> +static void uvc_video_decode_header_size(const u8 *data, int *header_size,
> +					 bool *has_pts, bool *has_scr)
> +{
> +	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
> +	case UVC_STREAM_PTS | UVC_STREAM_SCR:
> +		*header_size = 12;
> +		*has_pts = true;
> +		*has_scr = true;
> +		break;
> +	case UVC_STREAM_PTS:
> +		*header_size = 6;
> +		*has_pts = true;
> +		break;
> +	case UVC_STREAM_SCR:
> +		*header_size = 8;
> +		*has_scr = true;
> +		break;
> +	default:
> +		*header_size = 2;
> +	}
> +}
> +
>  static int uvc_video_decode_start(struct uvc_streaming *stream,
> -		struct uvc_buffer *buf, const u8 *data, int len)
> +				  struct uvc_buffer *buf, const u8 *urb_data,
> +				  int len)
>  {
>  	u8 fid;
> +	u8 data[12];
> +	unsigned int header_size;
> +	bool has_pts = false, has_scr = false;
> +
> +	/* Cache the header since urb_data is uncached memory. The size of
> +	 * header is at most 12 bytes.
> +	 */
> +	memcpy(data, urb_data, min(len, 12));
> 
>  	/* Sanity checks:
>  	 * - packet must be at least 2 bytes long
> @@ -983,8 +973,12 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
>  			uvc_video_stats_update(stream);
>  	}
> 
> -	uvc_video_clock_decode(stream, buf, data, len);
> -	uvc_video_stats_decode(stream, data, len);
> +	uvc_video_decode_header_size(data, &header_size, &has_pts, &has_scr);
> +
> +	uvc_video_clock_decode(stream, buf, data, len, header_size, has_pts,
> +			       has_scr);
> +	uvc_video_stats_decode(stream, data, len, header_size, has_pts,
> +			       has_scr);
> 
>  	/* Store the payload FID bit and return immediately when the buffer is
>  	 * NULL.
> --
> 2.18.0.rc2.346.g013aa6912e-goog
> 

-- 
Regards
--
Kieran
