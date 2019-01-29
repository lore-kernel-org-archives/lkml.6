Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86701C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E24D2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N3aZVUHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfA2IMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:12:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46016 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfA2IMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:12:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0T896Ia175928;
        Tue, 29 Jan 2019 08:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=KZKPNVLlmi9MM1fC6Evv97EB/zIPVuPe5u1P5j2SJjY=;
 b=N3aZVUHFu4AO5rzApetElatEsC0PGeAz9j7MFQXlkun3pzSL3qFD0AiUxRJkt7cV0uzB
 D9MbTfdV52epp3VBz1VmjE+Nu/QQ176ZakZf0anqZwfKL/N0zy+vvjaiGEGK8B7CpV5a
 BFG5ZZsL7h4CuULkusOJxZbObj0HJxOLLZOHQgJ5A16HSSLi69DoNu15Y+O38HrS8NGk
 uXF/JzfnVAGCQ6NT2whbGRR7DyMuHxhwY4x0F/rDrh+cnPFquMzEeNKHu1mOEFpBE2D3
 fY/Woo2x+5LCm18+kYLPOqYcwPNkSwkyqGVDXQx9/z0OQj/ZXaK9Wwvu5Z++PwYxxx5S OQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2q8g6r2ngp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 08:12:35 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0T8CTqe013103
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jan 2019 08:12:29 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0T8CSrE006274;
        Tue, 29 Jan 2019 08:12:28 GMT
Received: from kadam (/197.157.0.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Jan 2019 00:12:28 -0800
Date:   Tue, 29 Jan 2019 11:12:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH 1/7] binder: create userspace-to-binder-buffer copy
 function
Message-ID: <20190129081218.GL1795@kadam>
References: <20190129004934.85885-1-tkjos@google.com>
 <20190129004934.85885-2-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129004934.85885-2-tkjos@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9150 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901290062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:49:28PM -0800, Todd Kjos wrote:
> +/**
> + * binder_alloc_copy_user_to_buffer() - copy src user to tgt user
> + * @alloc: binder_alloc for this proc
> + * @buffer: binder buffer to be accessed
> + * @buffer_offset: offset into @buffer data
> + * @from: userspace pointer to source buffer
> + * @bytes: bytes to copy
> + *
> + * Copy bytes from source userspace to target buffer.
> + *
> + * Return: bytes remaining to be copied
> + */
> +unsigned long
> +binder_alloc_copy_user_to_buffer(struct binder_alloc *alloc,
> +				 struct binder_buffer *buffer,
> +				 binder_size_t buffer_offset,
> +				 const void __user *from,
> +				 size_t bytes)
> +{
> +	if (!check_buffer(alloc, buffer, buffer_offset, bytes))
> +		return bytes;
> +
> +	while (bytes) {
> +		unsigned long size;
> +		unsigned long ret;
> +		struct page *page;
> +		pgoff_t pgoff;
> +		void *kptr;
> +
> +		page = binder_alloc_get_page(alloc, buffer,
> +					     buffer_offset, &pgoff);
> +		size = min(bytes, (size_t)(PAGE_SIZE - pgoff));

This code has so much more casting than necessary.  To me casting says
that we haven't got the types correct or something.  I've just pulled
this function out as an example really, but none of the casts here are
required...  This could just be:

		size = min(bytes, PAGE_SIZE - pgoff);

Btw, if you really need to do a cast inside a min() (you don't in this
cast) then use min_t().

> +		kptr = (void *)((uintptr_t)kmap(page) + pgoff);

This would be a lot cleaner as:

		kptr = kmap(page) + pgoff;

> +		ret = copy_from_user(kptr, (const void __user *)(uintptr_t)from,
> +				     size);

Remove the cast:

		ret = copy_from_user(kptr, from, size);


> +		kunmap(page);
> +		if (ret)
> +			return bytes - size + ret;
> +		bytes -= size;
> +		from = (void __user *)(uintptr_t)from + size;

Remove the cast:

		from += size;

> +		buffer_offset += size;
> +	}
> +	return 0;
> +}

regards,
dan carpenter

