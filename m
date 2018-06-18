Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0473BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A942086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bZWuAvFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A942086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934225AbeFRNKm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:10:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39962 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932844AbeFRNKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:10:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5ID92SE091471;
        Mon, 18 Jun 2018 13:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=Y/Z505Wq3e10rZuW2On/HWwU+Mk/Wxz2E3bhXqCx870=;
 b=bZWuAvFssFAe92cuQVA2v3w7bhvQxT0jKmajZ2kGbYYpydRjh9faBdTkTmQOg7jkBVX3
 hdcklKeyax7sIw9zDOoaCIRLC38dXcaOQLG9pDNe7DdpApDshdzSuoweVsKw+gBGoT0G
 Jz+5XYeH+BvUUSAuGDsVEpF+urcOWF2BX06tSon5WTfEFNqqmi6fcw5CIxQXI6KEQqy8
 7y/qxWCU79O5yUr+rFB8T8/v4rL0rIVnqRvsZCsbxCfWugo6LLgTn0L8l0/vrBhF1lxd
 nJUzwkMUePI10v7b9C8usjLmcC6LbQHjPhM69NIG4yIx3Skl/S68uBRIEV7H2w3DeoqD lA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jmt01c0ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 13:10:25 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5IDAOVI013875
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 13:10:24 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5IDANp9016265;
        Mon, 18 Jun 2018 13:10:24 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 06:10:23 -0700
Subject: Re: [PATCH] jfs: Fix buffer overrun in ea_get
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shankarapailoor@gmail.com
References: <1529311091-8307-1-git-send-email-nborisov@suse.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <245a3ccb-3390-d650-91f0-c8e6f002499f@oracle.com>
Date:   Mon, 18 Jun 2018 08:10:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529311091-8307-1-git-send-email-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8927 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806180159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 03:38 AM, Nikolay Borisov wrote:
> Currently ea_buf->xattr buffer is allocated with min(min_size, ea_size).
> This is wrong since after the xattr buffer is allocated the ->max_size
> variable is actually rounded up to th next ->s_blocksize size. Fix this
> by using the rounded up max_size as input to the malloc.
> 
> Suggested-by: Shankara Pailoor <shankarapailoor@gmail.com>
> Reported-by: Shankara Pailoor <shankarapailoor@gmail.com>
> CC: shankarapailoor@gmail.com
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> Hello David, 
> 
> I'm sending you the patch for the issue which was originally reported and 
> suggested by Shankar.  I won't usually got and override the original 
> author of a patch but given the clear lack of experience with upstream (missing 
> SOB line, no changelog explaining the change etc) and the 
> fact there is already a CVE for this issue (using syzkaller for quick CVE 
> generation seems to be all the rage these days, go figure...) I'd rather have 
> an upstream, backportable version sooner rather than later. 

Thanks, but I already had Shankar's patch in the linux-next build. I was
out on vacation so I didn't get it pushed to Linus as soon as I would
have liked, but did so this morning.

I appreciate your effort.

Shaggy

> 
>  fs/jfs/xattr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
> index c60f3d32ee91..96b9355ff69a 100644
> --- a/fs/jfs/xattr.c
> +++ b/fs/jfs/xattr.c
> @@ -493,14 +493,14 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
>  		 * To keep the rest of the code simple.  Allocate a
>  		 * contiguous buffer to work with
>  		 */
> -		ea_buf->xattr = kmalloc(size, GFP_KERNEL);
> -		if (ea_buf->xattr == NULL)
> -			return -ENOMEM;
> -
>  		ea_buf->flag = EA_MALLOC;
>  		ea_buf->max_size = (size + sb->s_blocksize - 1) &
>  		    ~(sb->s_blocksize - 1);
>  
> +		ea_buf->xattr = kmalloc(ea_buf->max_size, GFP_KERNEL);
> +		if (ea_buf->xattr == NULL)
> +			return -ENOMEM;
> +
>  		if (ea_size == 0)
>  			return 0;
>  
> 
