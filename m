Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80365C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5DE2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGXuJuWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5DE2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeLDT3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:29:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbeLDT3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:29:47 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D42DC20851;
        Tue,  4 Dec 2018 19:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543951786;
        bh=Lv08ZrKz7g1AkPNI7rou+L8IpyiZP+dfjoilDHxS+rU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lGXuJuWI3cdl88KjwyT1AvuJQuyrE+SaJKyQc/Pq5lzgwgvj0l92avrGQjW8xD5wz
         jzvNVxhIPNFsZqNEHDtPSVnW/IQyfh9NpzH1LOnLeFXZ8CbaqaL0GfjJ+VObrliVdB
         EP7m9BpxgTxbta+4gSAo8lSO5/IEvWJ9Ny6R0q2o=
Date:   Tue, 4 Dec 2018 11:29:45 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Wen Yang <wen.yang99@zte.com.cn>
cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wang.yi59@zte.com.cn, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v5] pvcalls-front: Avoid get_free_pages(GFP_KERNEL) under
 spinlock
In-Reply-To: <1543907757-21647-1-git-send-email-wen.yang99@zte.com.cn>
Message-ID: <alpine.DEB.2.10.1812041127030.527@sstabellini-ThinkPad-X260>
References: <1543907757-21647-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Wen Yang wrote:
> The problem is that we call this with a spin lock held.
> The call tree is:
> pvcalls_front_accept() holds bedata->socket_lock.
>     -> create_active()
>         -> __get_free_pages() uses GFP_KERNEL
> 
> The create_active() function is only called from pvcalls_front_accept()
> with a spin_lock held, The allocation is not allowed to sleep and
> GFP_KERNEL is not sufficient.
> 
> This issue was detected by using the Coccinelle software.
> 
> v2: Add a function doing the allocations which is called
>     outside the lock and passing the allocated data to
>     create_active().
> 
> v3: Use the matching deallocators i.e., free_page()
>     and free_pages(), respectively.
> 
> v4: It would be better to pre-populate map (struct sock_mapping),
>     rather than introducing one more new struct.
> 
> v5: Since allocating the data outside of this call it should also
>     be freed outside, when create_active() fails.
>     Move kzalloc(sizeof(*map2), GFP_ATOMIC) outside spinlock and
>     use GFP_KERNEL instead.
> 
> Suggested-by: Juergen Gross <jgross@suse.com>
> Suggested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Suggested-by: Stefano Stabellini <sstabellini@kernel.org>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> CC: Juergen Gross <jgross@suse.com>
> CC: Stefano Stabellini <sstabellini@kernel.org>
> CC: xen-devel@lists.xenproject.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/xen/pvcalls-front.c | 83 +++++++++++++++++++++++++++----------
>  1 file changed, 61 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
> index 77224d8f3e6f..5fd764a7b879 100644
> --- a/drivers/xen/pvcalls-front.c
> +++ b/drivers/xen/pvcalls-front.c
> @@ -335,6 +335,41 @@ int pvcalls_front_socket(struct socket *sock)
>  	return ret;
>  }
>  
> +static void free_active_ring(struct sock_mapping *map)
> +{
> +	free_pages((unsigned long)map->active.data.in,
> +			map->active.ring->ring_order);
> +	free_page((unsigned long)map->active.ring);
> +}
> +
> +static int alloc_active_ring(struct sock_mapping *map)
> +{
> +	void *bytes;
> +
> +	map->active.ring = NULL;

This is superfluous

Aside from this:

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> +	map->active.data.in = NULL;
> +	map->active.ring = (struct pvcalls_data_intf *)
> +		get_zeroed_page(GFP_KERNEL);
> +	if (!map->active.ring)
> +		goto out;
> +
> +	map->active.ring->ring_order = PVCALLS_RING_ORDER;
> +	bytes = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> +					PVCALLS_RING_ORDER);
> +	if (!bytes)
> +		goto out;
> +
> +	map->active.data.in = bytes;
> +	map->active.data.out = bytes +
> +		XEN_FLEX_RING_SIZE(PVCALLS_RING_ORDER);
> +
> +	return 0;
> +
> +out:
> +	free_active_ring(map);
> +	return -ENOMEM;
> +}
> +
>  static int create_active(struct sock_mapping *map, int *evtchn)
>  {
>  	void *bytes;
> @@ -343,15 +378,7 @@ static int create_active(struct sock_mapping *map, int *evtchn)
>  	*evtchn = -1;
>  	init_waitqueue_head(&map->active.inflight_conn_req);
>  
> -	map->active.ring = (struct pvcalls_data_intf *)
> -		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> -	if (map->active.ring == NULL)
> -		goto out_error;
> -	map->active.ring->ring_order = PVCALLS_RING_ORDER;
> -	bytes = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> -					PVCALLS_RING_ORDER);
> -	if (bytes == NULL)
> -		goto out_error;
> +	bytes = map->active.data.in;
>  	for (i = 0; i < (1 << PVCALLS_RING_ORDER); i++)
>  		map->active.ring->ref[i] = gnttab_grant_foreign_access(
>  			pvcalls_front_dev->otherend_id,
> @@ -361,10 +388,6 @@ static int create_active(struct sock_mapping *map, int *evtchn)
>  		pvcalls_front_dev->otherend_id,
>  		pfn_to_gfn(virt_to_pfn((void *)map->active.ring)), 0);
>  
> -	map->active.data.in = bytes;
> -	map->active.data.out = bytes +
> -		XEN_FLEX_RING_SIZE(PVCALLS_RING_ORDER);
> -
>  	ret = xenbus_alloc_evtchn(pvcalls_front_dev, evtchn);
>  	if (ret)
>  		goto out_error;
> @@ -385,8 +408,6 @@ static int create_active(struct sock_mapping *map, int *evtchn)
>  out_error:
>  	if (*evtchn >= 0)
>  		xenbus_free_evtchn(pvcalls_front_dev, *evtchn);
> -	free_pages((unsigned long)map->active.data.in, PVCALLS_RING_ORDER);
> -	free_page((unsigned long)map->active.ring);
>  	return ret;
>  }
>  
> @@ -406,17 +427,24 @@ int pvcalls_front_connect(struct socket *sock, struct sockaddr *addr,
>  		return PTR_ERR(map);
>  
>  	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
> +	ret = alloc_active_ring(map);
> +	if (ret < 0) {
> +		pvcalls_exit_sock(sock);
> +		return ret;
> +	}
>  
>  	spin_lock(&bedata->socket_lock);
>  	ret = get_request(bedata, &req_id);
>  	if (ret < 0) {
>  		spin_unlock(&bedata->socket_lock);
> +		free_active_ring(map);
>  		pvcalls_exit_sock(sock);
>  		return ret;
>  	}
>  	ret = create_active(map, &evtchn);
>  	if (ret < 0) {
>  		spin_unlock(&bedata->socket_lock);
> +		free_active_ring(map);
>  		pvcalls_exit_sock(sock);
>  		return ret;
>  	}
> @@ -780,25 +808,36 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
>  		}
>  	}
>  
> -	spin_lock(&bedata->socket_lock);
> -	ret = get_request(bedata, &req_id);
> -	if (ret < 0) {
> +	map2 = kzalloc(sizeof(*map2), GFP_KERNEL);
> +	if (map2 == NULL) {
>  		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
>  			  (void *)&map->passive.flags);
> -		spin_unlock(&bedata->socket_lock);
> +		pvcalls_exit_sock(sock);
> +		return -ENOMEM;
> +	}
> +	ret = alloc_active_ring(map2);
> +	if (ret < 0) {
> +		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
> +				(void *)&map->passive.flags);
> +		kfree(map2);
>  		pvcalls_exit_sock(sock);
>  		return ret;
>  	}
> -	map2 = kzalloc(sizeof(*map2), GFP_ATOMIC);
> -	if (map2 == NULL) {
> +	spin_lock(&bedata->socket_lock);
> +	ret = get_request(bedata, &req_id);
> +	if (ret < 0) {
>  		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
>  			  (void *)&map->passive.flags);
>  		spin_unlock(&bedata->socket_lock);
> +		free_active_ring(map2);
> +		kfree(map2);
>  		pvcalls_exit_sock(sock);
> -		return -ENOMEM;
> +		return ret;
>  	}
> +
>  	ret = create_active(map2, &evtchn);
>  	if (ret < 0) {
> +		free_active_ring(map2);
>  		kfree(map2);
>  		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
>  			  (void *)&map->passive.flags);
> -- 
> 2.19.1
> 
