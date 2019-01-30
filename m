Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1957BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D497420882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VqV9pYl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbfA3OqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:46:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46290 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfA3OqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:46:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0UEjJFL104458;
        Wed, 30 Jan 2019 14:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=BQh09Toh6u76O6u6QPdRhUAIebzS0ybre9tEZkRnKD8=;
 b=VqV9pYl3YxU2hkWo43bar1n7gXv97OvCxzZkFFpQg9wmyuuC8JQ1SSLX1NDt1mWvZcq7
 I1yZmH9oufhVekSQ0t71cgNqnY5GGiWFejdp7ikIPX2ig0XeNr3ItKfrgufcJKaeKkzg
 Ch7g1r6Mtx5EgwOJxOKbsedezm/GlhOv4RKUUazOkG/Y1UpLguFYE326ZT2eLZr41uHv
 lHKEIipIq5cH0lPBrRj/h6VLN/w1F0ELKZhualvQmc7g7XC35EmF8xRtyGtrTO9kFsvE
 GtC4eF6x6PDu49bsbRE0GYskmTdP3weSCfVP7GYtkOTvDiflRzY1et20RjM6vI7qBTOr ew== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2q8eyujx4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 14:45:54 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0UEjmBo015773
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 14:45:49 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0UEjmbg026486;
        Wed, 30 Jan 2019 14:45:48 GMT
Received: from kadam (/197.157.0.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jan 2019 06:45:47 -0800
Date:   Wed, 30 Jan 2019 17:45:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>, Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH] staging: erofs: keep corrupted fs from crashing kernel
 in erofs_namei()
Message-ID: <20190130144534.GB2010@kadam>
References: <20190129155540.17473-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129155540.17473-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9151 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901300116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 11:55:40PM +0800, Gao Xiang wrote:
> +static struct page *find_target_block_classic(struct inode *dir,
> +					      struct erofs_qstr *name,
> +					      int *_diff,
> +					      int *_ndirents)
>  {
>  	unsigned int startprfx, endprfx;
> -	unsigned int head, back;
> +	int head, back;
>  	struct address_space *const mapping = dir->i_mapping;
>  	struct page *candidate = ERR_PTR(-ENOENT);
>  
> @@ -105,33 +108,34 @@ static struct page *find_target_block_classic(
>  	back = inode_datablocks(dir) - 1;
>  
>  	while (head <= back) {
> -		unsigned int mid = head + (back - head) / 2;
> +		const int mid = head + (back - head) / 2;
>  		struct page *page = read_mapping_page(mapping, mid, NULL);
>  
> -		if (IS_ERR(page)) {
> -exact_out:
> -			if (!IS_ERR(candidate)) /* valid candidate */
> -				put_page(candidate);
> -			return page;
> -		} else {
> -			int diff;
> -			unsigned int ndirents, matched;
> -			struct qstr dname;
> +		if (!IS_ERR(page)) {

It's almost always better to do failure handling instead of success
handing because it lets you pull everything in one indent level.  You'd
need to move a bunch of the declarations around.

	if (IS_ERR(page))
		goto out;

But really the out label is not part of the loop so you could move it
to the bottom of the function...

>  			struct erofs_dirent *de = kmap_atomic(page);
> -			unsigned int nameoff = le16_to_cpu(de->nameoff);
> -
> -			ndirents = nameoff / sizeof(*de);
> +			const int nameoff = nameoff_from_disk(de->nameoff,
> +							      EROFS_BLKSIZ);
> +			const int ndirents = nameoff / sizeof(*de);
> +			int diff;
> +			unsigned int matched;
> +			struct erofs_qstr dname;
>  
> -			/* corrupted dir (should have one entry at least) */
> -			BUG_ON(!ndirents || nameoff > PAGE_SIZE);
> +			if (unlikely(!ndirents)) {
> +				DBG_BUGON(1);
> +				put_page(page);
> +				page = ERR_PTR(-EIO);
> +				goto out;

We need to kunmap_atomic(de) on this path.

> +			}
>  
>  			matched = min(startprfx, endprfx);
>  
>  			dname.name = (u8 *)de + nameoff;
> -			dname.len = ndirents == 1 ?
> -				/* since the rest of the last page is 0 */
> -				EROFS_BLKSIZ - nameoff
> -				: le16_to_cpu(de[1].nameoff) - nameoff;
> +			if (ndirents == 1)
> +				dname.end = (u8 *)de + EROFS_BLKSIZ;
> +			else
> +				dname.end = (u8 *)de +
> +					nameoff_from_disk(de[1].nameoff,
> +							  EROFS_BLKSIZ);
>  
>  			/* string comparison without already matched prefix */
>  			diff = dirnamecmp(name, &dname, &matched);
> @@ -139,7 +143,7 @@ static struct page *find_target_block_classic(
>  
>  			if (unlikely(!diff)) {
>  				*_diff = 0;
> -				goto exact_out;
> +				goto out;
>  			} else if (diff > 0) {
>  				head = mid + 1;
>  				startprfx = matched;
> @@ -147,35 +151,42 @@ static struct page *find_target_block_classic(
>  				if (likely(!IS_ERR(candidate)))
                                    ^^^^^^
Not related to the this patch, but I wonder how this works.  IS_ERR()
already has an opposite unlikely() inside so I wonder which trumps the
other?

>  					put_page(candidate);
>  				candidate = page;
> +				*_ndirents = ndirents;

regards,
dan carpenter

