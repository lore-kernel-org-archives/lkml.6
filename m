Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09383ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB7A208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TJ2FA6W4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB7A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeJRFNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:13:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33936 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeJRFNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:13:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9HLDiss170496;
        Wed, 17 Oct 2018 21:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=XgG3l59cDoMsvHkcZ3ha+sS3zn/NEp0DJlfCrHv4m6c=;
 b=TJ2FA6W4lD2Hd+C0EZGoei8zCVJycqa/jCZ11e+hJmulFnt1i6XRnb9LJBcQ91X69Rvg
 1YnTk/Cz1VfcXEXcrfl1KpV4VYDAY2NsE8s11vbZUyiDpnYQAg7Y7IHXVQXKnI/LrbiO
 FzJ77GXp3tVIH2Za/g/f0LxccWww1v+i9TBTCfSE6aVTHExANtGzv5yyoq4fzGr6xfuX
 Rz/zx2GIL1CMlJ7SHz664ce0Cf/2+VngszexeUo92m+6SXOaLWZPYT1FQlCkG9pqb6+/
 WmOB9M4AZNVIwghm05r8YLjl1jIxn/1PMafnPasyKvnKIU8KTfbnAuFKlLYEb4fGG2dl Rw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n384u9pq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 21:15:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9HLFelQ013559
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 21:15:41 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9HLFeeS022442;
        Wed, 17 Oct 2018 21:15:40 GMT
Received: from localhost.localdomain (/209.6.36.129)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Oct 2018 14:15:39 -0700
Date:   Wed, 17 Oct 2018 17:15:33 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Wenwen Wang <wang6495@umn.edu>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] drivers/vfio: Fix an 8-byte alignment issue
Message-ID: <20181017211532.GB9499@localhost.localdomain>
References: <1539800299-2787-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539800299-2787-1-git-send-email-wang6495@umn.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9049 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=792
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810170176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 01:18:19PM -0500, Wenwen Wang wrote:
> This patch adds a 4-byte reserved field in the structure
> vfio_eeh_pe_op to make sure that the u64 fields in the structure
> vfio_eeh_pe_err are 8-byte aligned.

Won't this break 32-bit kernels? That is the size of the structure
will now be 4 bytes bigger..
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  include/uapi/linux/vfio.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 1aa7b82..3e71ded 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -729,6 +729,7 @@ struct vfio_eeh_pe_op {
>  	__u32 argsz;
>  	__u32 flags;
>  	__u32 op;
> +	__u32 __res;
>  	union {
>  		struct vfio_eeh_pe_err err;
>  	};
> -- 
> 2.7.4
> 
