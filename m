Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A0EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DD7206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DD7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeIDXAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:00:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36906 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDXAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:00:09 -0400
Received: by mail-qk1-f193.google.com with SMTP id f17-v6so3121353qkh.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 11:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Onjyzaf7MAvXJkk7WckEfZHjdVETkK9VpjfNJFgsVlw=;
        b=bPVORJEQWK869Ws9C4yNFPd5VnBF8gNSOrkMO1W/vPqh4lXFubaMvQUWeQ7ohwS6Hc
         6Ns1ZcK7BtZYLz9RF6HQ/xZxuB8ZHj3MhD3IZWn96LvsKTi2m8XO2QUgjeRRLtDtZcia
         CGsZsFa8uh4uPjgXe0yuaaubbj4sxG6oYSUc30IqU9/Br9xmRWdaCzEpZ2/Cs/Mk5R2V
         mZXopB98GANmEXkNblQyHGDHBwrq1lC+oKoX/4BFFazxJxyQm2bOAFRk4GYOydRySFSh
         nHcj3e5Z/Jim1jFi/90PLeJRMV1dB4QcoogFdEILZnO97LUb2WHEH3scvzjRbT/HObha
         dy9w==
X-Gm-Message-State: APzg51Dj3I+RDXTzO99mPnggNod8FDP4E3gO/DJrE3PTi0xc5a4WlUUo
        GW545d/Mp4iauNbSfIH8HIWeRQ==
X-Google-Smtp-Source: ANB0VdYgPx2TiTOIriayl7kUCFhBKT/6FXPJVRF3Nn7pf7Ch0NjtSzpFq5cYYwXCEjZxMzMkc6Lbrw==
X-Received: by 2002:a37:f9d:: with SMTP id 29-v6mr30189012qkp.163.1536086029434;
        Tue, 04 Sep 2018 11:33:49 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::3c7a? ([2601:602:9802:a8dc::3c7a])
        by smtp.gmail.com with ESMTPSA id p4-v6sm13947954qkl.41.2018.09.04.11.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 11:33:48 -0700 (PDT)
Subject: Re: [PATCH v2] staging: android: ion: fix ION_IOC_{MAP,SHARE}
 use-after-free
To:     Greg Hackmann <ghackmann@android.com>, linux-kernel@vger.kernel.org
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, kernel-team@android.com,
        Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org
References: <20180904163336.234819-1-ghackmann@google.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <fdee14f1-498c-cccb-8a90-8c89309d3158@redhat.com>
Date:   Tue, 4 Sep 2018 11:33:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904163336.234819-1-ghackmann@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 09:33 AM, Greg Hackmann wrote:
> The ION_IOC_{MAP,SHARE} ioctls drop and reacquire client->lock several
> times while operating on one of the client's ion_handles.  This creates
> windows where userspace can call ION_IOC_FREE on the same client with
> the same handle, and effectively make the kernel drop its own reference.
> For example:
> 
> - thread A: ION_IOC_ALLOC creates an ion_handle with refcount 1
> - thread A: starts ION_IOC_MAP and increments the refcount to 2
> - thread B: ION_IOC_FREE decrements the refcount to 1
> - thread B: ION_IOC_FREE decrements the refcount to 0 and frees the
>              handle
> - thread A: continues ION_IOC_MAP with a dangling ion_handle * to
>              freed memory
> 
> Fix this by holding client->lock for the duration of
> ION_IOC_{MAP,SHARE}, preventing the concurrent ION_IOC_FREE.  Also
> remove ion_handle_get_by_id(), since there's literally no way to use it
> safely.
> 
> This patch is applied on top of 4.4.y, and applies to older kernels
> too.  4.9.y was fixed separately.  Kernels 4.12 and later are
> unaffected, since all the underlying ion_handle infrastructure has been
> ripped out.
> 

Acked-by: Laura Abbott <labbott@redhat.com>

> Cc: stable@vger.kernel.org # v4.4-
> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> ---
> v2: remove Change-Id line from commit message
> 
>   drivers/staging/android/ion/ion.c | 60 +++++++++++++++++++------------
>   1 file changed, 37 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 47cb163da9a0..4adb1138af09 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -449,18 +449,6 @@ static struct ion_handle *ion_handle_get_by_id_nolock(struct ion_client *client,
>   	return ERR_PTR(-EINVAL);
>   }
>   
> -struct ion_handle *ion_handle_get_by_id(struct ion_client *client,
> -						int id)
> -{
> -	struct ion_handle *handle;
> -
> -	mutex_lock(&client->lock);
> -	handle = ion_handle_get_by_id_nolock(client, id);
> -	mutex_unlock(&client->lock);
> -
> -	return handle;
> -}
> -
>   static bool ion_handle_validate(struct ion_client *client,
>   				struct ion_handle *handle)
>   {
> @@ -1138,24 +1126,28 @@ static struct dma_buf_ops dma_buf_ops = {
>   	.kunmap = ion_dma_buf_kunmap,
>   };
>   
> -struct dma_buf *ion_share_dma_buf(struct ion_client *client,
> -						struct ion_handle *handle)
> +static struct dma_buf *__ion_share_dma_buf(struct ion_client *client,
> +					   struct ion_handle *handle,
> +					   bool lock_client)
>   {
>   	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>   	struct ion_buffer *buffer;
>   	struct dma_buf *dmabuf;
>   	bool valid_handle;
>   
> -	mutex_lock(&client->lock);
> +	if (lock_client)
> +		mutex_lock(&client->lock);
>   	valid_handle = ion_handle_validate(client, handle);
>   	if (!valid_handle) {
>   		WARN(1, "%s: invalid handle passed to share.\n", __func__);
> -		mutex_unlock(&client->lock);
> +		if (lock_client)
> +			mutex_unlock(&client->lock);
>   		return ERR_PTR(-EINVAL);
>   	}
>   	buffer = handle->buffer;
>   	ion_buffer_get(buffer);
> -	mutex_unlock(&client->lock);
> +	if (lock_client)
> +		mutex_unlock(&client->lock);
>   
>   	exp_info.ops = &dma_buf_ops;
>   	exp_info.size = buffer->size;
> @@ -1170,14 +1162,21 @@ struct dma_buf *ion_share_dma_buf(struct ion_client *client,
>   
>   	return dmabuf;
>   }
> +
> +struct dma_buf *ion_share_dma_buf(struct ion_client *client,
> +				  struct ion_handle *handle)
> +{
> +	return __ion_share_dma_buf(client, handle, true);
> +}
>   EXPORT_SYMBOL(ion_share_dma_buf);
>   
> -int ion_share_dma_buf_fd(struct ion_client *client, struct ion_handle *handle)
> +static int __ion_share_dma_buf_fd(struct ion_client *client,
> +				  struct ion_handle *handle, bool lock_client)
>   {
>   	struct dma_buf *dmabuf;
>   	int fd;
>   
> -	dmabuf = ion_share_dma_buf(client, handle);
> +	dmabuf = __ion_share_dma_buf(client, handle, lock_client);
>   	if (IS_ERR(dmabuf))
>   		return PTR_ERR(dmabuf);
>   
> @@ -1187,8 +1186,19 @@ int ion_share_dma_buf_fd(struct ion_client *client, struct ion_handle *handle)
>   
>   	return fd;
>   }
> +
> +int ion_share_dma_buf_fd(struct ion_client *client, struct ion_handle *handle)
> +{
> +	return __ion_share_dma_buf_fd(client, handle, true);
> +}
>   EXPORT_SYMBOL(ion_share_dma_buf_fd);
>   
> +static int ion_share_dma_buf_fd_nolock(struct ion_client *client,
> +				       struct ion_handle *handle)
> +{
> +	return __ion_share_dma_buf_fd(client, handle, false);
> +}
> +
>   struct ion_handle *ion_import_dma_buf(struct ion_client *client, int fd)
>   {
>   	struct dma_buf *dmabuf;
> @@ -1335,11 +1345,15 @@ static long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   	{
>   		struct ion_handle *handle;
>   
> -		handle = ion_handle_get_by_id(client, data.handle.handle);
> -		if (IS_ERR(handle))
> +		mutex_lock(&client->lock);
> +		handle = ion_handle_get_by_id_nolock(client, data.handle.handle);
> +		if (IS_ERR(handle)) {
> +			mutex_unlock(&client->lock);
>   			return PTR_ERR(handle);
> -		data.fd.fd = ion_share_dma_buf_fd(client, handle);
> -		ion_handle_put(handle);
> +		}
> +		data.fd.fd = ion_share_dma_buf_fd_nolock(client, handle);
> +		ion_handle_put_nolock(handle);
> +		mutex_unlock(&client->lock);
>   		if (data.fd.fd < 0)
>   			ret = data.fd.fd;
>   		break;
> 

