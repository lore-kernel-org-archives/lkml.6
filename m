Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479BEC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C5F20673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sOgWd3fN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C5F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeLAE6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:58:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45668 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeLAE6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 23:58:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAUHmZV8154229;
        Fri, 30 Nov 2018 17:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=N8NF2J0llPoZjuySiOSLpQ324eG7B+5VZqWkizwvyJ4=;
 b=sOgWd3fN5bvLJMRCj5jJcuW4dJ5IxmAF6C1pgrKTR7QurlfswKes4vCZQ4lnVHYx6Qyb
 dQpIi8yyYI14O9kyo8h9Phan8B7LMV+HDcDCstI1wcxD8XjoydFWCBW4+0GTv7R0K/5Y
 UUiT7J1245EZtpSMjdkvzI+6XAb3NJes1eYjoe0azAqRN1w/vGZDcP7MP9NWfyxrN/0D
 97BV+yWpQIYA5Phx8DbUVGYufp4f2dGkXzY/0CpZOu5aa78vDWtM76arUF92YEdBci8C
 NfedJarT53PSPBO+dBrIFzrMdbdSqPkrfnBo1FWGytn+GmQVGWATd3kqNPbe5tXtsjub oQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2nxxkqykve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Nov 2018 17:48:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAUHmV44001399
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Nov 2018 17:48:31 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAUHmUMY004896;
        Fri, 30 Nov 2018 17:48:30 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Nov 2018 09:48:30 -0800
Subject: Re: [PATCH v3] pvcalls-front: Avoid __get_free_pages(GFP_KERNEL)
 under spinlock
To:     Wen Yang <wen.yang99@zte.com.cn>, jgross@suse.com,
        sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Julia Lawall <julia.lawall@lip6.fr>
References: <20181130110107.31468-1-wen.yang99@zte.com.cn>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <810c02f4-4436-79fb-5da1-0cf80f8486d1@oracle.com>
Date:   Fri, 30 Nov 2018 12:48:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181130110107.31468-1-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9093 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811300152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/18 6:01 AM, Wen Yang wrote:
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
> v3: Use the matching deallocators i.e., free_page()
>     and free_pages(), respectively.
>
> Suggested-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> CC: Juergen Gross <jgross@suse.com>
> CC: Stefano Stabellini <sstabellini@kernel.org>
> CC: xen-devel@lists.xenproject.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/xen/pvcalls-front.c | 71 ++++++++++++++++++++++++++++++-------
>  1 file changed, 59 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
> index 2f11ca72a281..a26f416daf46 100644
> --- a/drivers/xen/pvcalls-front.c
> +++ b/drivers/xen/pvcalls-front.c
> @@ -335,7 +335,43 @@ int pvcalls_front_socket(struct socket *sock)
>  	return ret;
>  }
>  
> -static int create_active(struct sock_mapping *map, int *evtchn)
> +struct sock_mapping_active_ring {
> +	struct pvcalls_data_intf *ring;
> +	RING_IDX ring_order;
> +	void *bytes;
> +};
> +
> +static int alloc_active_ring(struct sock_mapping_active_ring *active_ring)
> +{
> +	active_ring->ring = NULL;

This is not necessary.

> +	active_ring->bytes = NULL;
> +
> +	active_ring->ring = (struct pvcalls_data_intf *)
> +		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	if (active_ring->ring == NULL)
> +		goto out_error;
> +	active_ring->ring_order = PVCALLS_RING_ORDER;
> +	active_ring->bytes = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> +			PVCALLS_RING_ORDER);
> +	if (active_ring->bytes == NULL)
> +		goto out_error;
> +
> +	return 0;
> +
> +out_error:
> +	free_pages((unsigned long)active_ring->bytes, active_ring->ring_order);
> +	free_page((unsigned long)active_ring->ring);
> +	return -ENOMEM;
> +}
> +



> @@ -397,6 +427,7 @@ int pvcalls_front_connect(struct socket *sock, struct sockaddr *addr,
>  	struct sock_mapping *map = NULL;
>  	struct xen_pvcalls_request *req;
>  	int notify, req_id, ret, evtchn;
> +	struct sock_mapping_active_ring active_ring;
>  
>  	if (addr->sa_family != AF_INET || sock->type != SOCK_STREAM)
>  		return -EOPNOTSUPP;
> @@ -406,15 +437,21 @@ int pvcalls_front_connect(struct socket *sock, struct sockaddr *addr,
>  		return PTR_ERR(map);
>  
>  	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
> +	ret = alloc_active_ring(&active_ring);

Why not just alloc_active_ring(map)?


-boris

