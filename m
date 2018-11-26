Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A582FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2992086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3l2SdiMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2992086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeKZUle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:41:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51860 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbeKZUle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:41:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAQ9gwAq150245;
        Mon, 26 Nov 2018 09:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Fa5xW9Cxynbl4UAT5xsxSvfem6iGLOlMnOMw99xSS+A=;
 b=3l2SdiMorebgo9Vr8WCttLobCnlSqF/zd1HEmax1G21hQoiajbLxCHLTp7fAmoavmwdz
 gGV43XITJau5HDNN/PDCsPUbitVVlAzcNiwH5z2kLkNCRcg98jVm1JJdc+Gxv+y9qt9A
 IouBuCKaGoXi847RDHSr7OLhN2/Zr5CzRGCoTuhd7mcwietYsEmAxgb74/L55mE9tqCQ
 +f+8tZG3sjEHHs0G9+cfr0h2+xMr8FyfxYuvqeBFmd3ZHqw95o5FzEfBABVCVS7+ygss
 YUFXHh9Kh2KEuUOoGGicKAxIxC2smafhrCL4cmXeo67ZdJrrCRckpye3xvm0f1iBaNZV VQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nxy9qvn6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 09:47:56 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAQ9ltgW028062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 09:47:56 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAQ9lsG9000830;
        Mon, 26 Nov 2018 09:47:54 GMT
Received: from unbuntlaptop (/41.202.241.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 01:47:54 -0800
Date:   Mon, 26 Nov 2018 12:47:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux@wolf-entwicklungen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix potential null dereference
Message-ID: <20181126094745.GF3088@unbuntlaptop>
References: <20181125092225.10188-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125092225.10188-1-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9088 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811260090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 10:22:25AM +0100, Michael Straube wrote:
> Add a test for successful call to cdev_alloc() to avoid
> potential null dereference. Issue reported by smatch.
> 

Fixes: 874bcba65f9a ("staging: pi433: New driver")


> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/pi433/pi433_if.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index 786478671190..d72de2105053 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -1245,6 +1245,10 @@ static int pi433_probe(struct spi_device *spi)
>  
>  	/* create cdev */
>  	device->cdev = cdev_alloc();
> +	if (!device->cdev) {
> +		dev_dbg(device->dev, "allocation of cdev failed");
> +		goto cdev_failed;
> +	}
>  	device->cdev->owner = THIS_MODULE;
>  	cdev_init(device->cdev, &pi433_fops);
>  	retval = cdev_add(device->cdev, device->devt, 1);

There is a second related bug here if we cdev_add() fails then we should
call cdev_del(device->cdev).  (cdev_del() does not take a NULL cdev
pointer).

regards,
dan carpenter

