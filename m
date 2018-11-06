Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03DDC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9E920869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EQrE0NOD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kas5nhOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9E920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389619AbeKGCdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:33:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35660 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389396AbeKGCdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:33:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7736260316; Tue,  6 Nov 2018 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541524060;
        bh=oKcvy4hcXWXZIhQcMlwnw7CKjnIXL9kdb+0XGB8oSGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQrE0NODNt7SG/fxjbgihiAxqtT2M1Yah0jPcStXucsy2aE5cX4aBsWv4DOsuZsoy
         lFhpebAfuXfSkos7DlF9qWd3pKoLiCSIuYPhFASr6qwX8xz85UYVs/BzGl/GuLdDos
         0WOZ4Yp12zqBN1rg8si4r421MaltU1DiOvcsh2V4=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7BA0D60316;
        Tue,  6 Nov 2018 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541524059;
        bh=oKcvy4hcXWXZIhQcMlwnw7CKjnIXL9kdb+0XGB8oSGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kas5nhOOef3g8jOAh6Cxmf5PPoDiR0b0JIuNiOI+ffZygYgQJHJKwo0rxw+qbr5xs
         SvUvIao+/ZatGUgEx2kEyAwAHUf90P0cRuJspp06gYjovfLWRJrkGoZvRjn4ZQ2cfy
         RUKR8I/0/qNvOQP8f2PsE/dQS/SXk6vSVEttlYUM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BA0D60316
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Tue, 6 Nov 2018 10:07:36 -0700
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, chris@chris-wilson.co.uk,
        robdclark@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/msm: Optimize adreno_show_object()
Message-ID: <20181106170736.GB27851@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Sharat Masetty <smasetty@codeaurora.org>,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, chris@chris-wilson.co.uk,
        robdclark@gmail.com, linux-kernel@vger.kernel.org
References: <1541484606-20813-1-git-send-email-smasetty@codeaurora.org>
 <1541484606-20813-3-git-send-email-smasetty@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541484606-20813-3-git-send-email-smasetty@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 11:40:06AM +0530, Sharat Masetty wrote:
> When the userspace tries to read the crashstate dump, the read side
> implementation in the driver currently ascii85 encodes all the binary
> buffers and it does this each time the read system call is called.
> A userspace tool like cat typically does a page by page read and the
> number of read calls depends on the size of the data captured by the
> driver. This is certainly not desirable and does not scale well with
> large captures.
> 
> This patch encodes the buffer only once in the read path. With this there
> is an immediate >10X speed improvement in crashstate save time.
> 
> Signed-off-by: Sharat Masetty <smasetty@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 76 ++++++++++++++++++++++++---------
>  drivers/gpu/drm/msm/msm_gpu.h           |  2 +
>  2 files changed, 58 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index c93702d..e29093e 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -475,34 +475,70 @@ int adreno_gpu_state_put(struct msm_gpu_state *state)
>  
>  #if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
>  
> -static void adreno_show_object(struct drm_printer *p, u32 *ptr, int len)
> +static char *adreno_gpu_ascii85_encode(u32 *src, size_t len)
>  {
> -	char out[ASCII85_BUFSZ];
> -	long l, datalen, i;
> +	void *buf;
> +	size_t buf_itr = 0;
> +	long i, l;
>  
> -	if (!ptr || !len)
> -		return;
> +	if (!len)
> +		return NULL;
> +
> +	l = ascii85_encode_len(len);
>  
>  	/*
> -	 * Only dump the non-zero part of the buffer - rarely will any data
> -	 * completely fill the entire allocated size of the buffer
> +	 * ascii85 outputs either a 5 byte string or a 1 byte string. So we
> +	 * account for the worst case of 5 bytes per dword plus the 1 for '\0'
>  	 */
> -	for (datalen = 0, i = 0; i < len >> 2; i++) {
> -		if (ptr[i])
> -			datalen = (i << 2) + 1;
> -	}
> +	buf = kvmalloc((l * 5) + 1, GFP_KERNEL);
> +	if (!buf)
> +		return NULL;
>  
> -	/* Skip printing the object if it is empty */
> -	if (datalen == 0)
> +	for (i = 0; i < l; i++)
> +		buf_itr += ascii85_encode_to_buf(src[i], buf + buf_itr);

If this is the only use of ascii85_encode_to_buf I don't think we need it in the
common header - the same functionality can just be built in here.

> +
> +	return buf;
> +}
> +
> +/* len is expected to be in bytes */
> +static void adreno_show_object(struct drm_printer *p, void **ptr, int len,
> +		bool *encoded)
> +{
> +	if (!*ptr || !len)
>  		return;
>  
> -	l = ascii85_encode_len(datalen);
> +	if (!*encoded) {

We wouldn't need the encoded bool if you used different pointers for the
non-encoded and encoded objects -

if (!encoded) {
   encoded = adreno_gpu_ascii85_encode(raw);

   kvfree(raw);
   raw = NULL;
}

And then just blindly kvfree() both in the destroy function - I think that
would be a bit clearer than trying to reuse the buffer.
   
> +		long datalen, i;
> +		u32 *buf = *ptr;
> +
> +		/*
> +		 * Only dump the non-zero part of the buffer - rarely will
> +		 * any data completely fill the entire allocated size of
> +		 * the buffer.
> +		 */
> +		for (datalen = 0, i = 0; i < len >> 2; i++) {
> +			if (buf[i])
> +				datalen = ((i + 1) << 2);
> +		}
> +
> +		/*
> +		 * If we reach here, then the originally captured binary buffer
> +		 * will be replaced with the ascii85 encoded string
> +		 */
> +		*ptr = adreno_gpu_ascii85_encode(buf, datalen);
> +
> +		kvfree(buf);
> +
> +		*encoded = true;
> +	}
> +
> +	if (!*ptr)
> +		return;
>  
>  	drm_puts(p, "    data: !!ascii85 |\n");
>  	drm_puts(p, "     ");
>  
> -	for (i = 0; i < l; i++)
> -		drm_puts(p, ascii85_encode(ptr[i], out));
> +	drm_puts(p, *ptr);
>  
>  	drm_puts(p, "\n");
>  }
> @@ -534,8 +570,8 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
>  		drm_printf(p, "    wptr: %d\n", state->ring[i].wptr);
>  		drm_printf(p, "    size: %d\n", MSM_GPU_RINGBUFFER_SZ);
>  
> -		adreno_show_object(p, state->ring[i].data,
> -			state->ring[i].data_size);
> +		adreno_show_object(p, &state->ring[i].data,
> +			state->ring[i].data_size, &state->ring[i].encoded);

This implies we should make a sub struct to store the data / size / state of the
buffers so this can turn into:


adreno_show_object(&(state->ring[i].object))

We could repurpose msm_gpu_state_bo for this task - this would dovetail nicely
into the suggestion above to use individual pointers for the encoded and
non-encoded buffers.


>  	}
>  
>  	if (state->bos) {
> @@ -546,8 +582,8 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
>  				state->bos[i].iova);
>  			drm_printf(p, "    size: %zd\n", state->bos[i].size);
>  
> -			adreno_show_object(p, state->bos[i].data,
> -				state->bos[i].size);
> +			adreno_show_object(p, &state->bos[i].data,
> +				state->bos[i].size, &state->bos[i].encoded);

And then this would turn into just adreno_show_object(p, &state->bos[i]);

>  		}
>  	}
>  
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index f82bac0..efb49bb 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -187,6 +187,7 @@ struct msm_gpu_state_bo {
>  	u64 iova;
>  	size_t size;
>  	void *data;
> +	bool encoded;
>  };
>  
>  struct msm_gpu_state {
> @@ -201,6 +202,7 @@ struct msm_gpu_state {
>  		u32 wptr;
>  		void *data;
>  		int data_size;
> +		bool encoded;
>  	} ring[MSM_GPU_MAX_RINGS];
>  
>  	int nr_registers;
> -- 
> 1.9.1
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
