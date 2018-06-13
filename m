Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 85A55C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38309208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sOi6VEEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38309208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935027AbeFMJRK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:17:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45052 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934073AbeFMJRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:17:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5D9GHn7149869;
        Wed, 13 Jun 2018 09:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=StjdrJxoIV5mVjXNd7KrPtGp01o53nnHPN28U4GltxY=;
 b=sOi6VEEebOQDk7do2gIrFcOgpuC+VWjTQQyrRxtboFKtDbDOcVnR6Pnw8kDzkUOBz/m7
 cFXf614RliSPIqbb1PGKKw/V0/3b0kW2A7Ay+NZ0p44fEG59gO0hnIBK3dmwbvmD3bpn
 d+wHWy3CbzUGwi9FFOHrWToKrm9KdWs7VVgbLjgAz08I+wPMAxYdbsicHwKPGhAie7jt
 IwNU5eAA3RQTtg3qGh3ItXx7QW5ZGWFZveeDKpGYRkXAk3NhdBdxVEuIM2jXGFzht2U6
 /eRrQiYHvPxgG3rqglfIqRCEDOgxtbGjWubbuKAmBAbvRWvzkWwVwtWxobsTMlWEQDvW BA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jjp6bsjvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 09:17:01 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5D9Gxoi023249
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 09:17:00 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5D9GxZA031000;
        Wed, 13 Jun 2018 09:16:59 GMT
Received: from mwanda (/197.157.34.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jun 2018 02:16:58 -0700
Date:   Wed, 13 Jun 2018 12:16:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH v2] staging: pi433: fix race condition in pi433_ioctl
Message-ID: <20180613091649.r3bck3wjma6tmjet@mwanda>
References: <20180613014741.GC2265@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613014741.GC2265@hle-laptop.local>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 09:47:41PM -0400, Hugo Lefeuvre wrote:
>  drivers/staging/pi433/pi433_if.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index b061f77dda41..3ec1ed01d04b 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -880,6 +880,7 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	int			retval = 0;
>  	struct pi433_instance	*instance;
>  	struct pi433_device	*device;
> +	struct pi433_tx_cfg	tx_cfg_buffer;
>  	void __user *argp = (void __user *)arg;
>  
>  	/* Check type and command number */
> @@ -902,9 +903,15 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  			return -EFAULT;
>  		break;
>  	case PI433_IOC_WR_TX_CFG:
> -		if (copy_from_user(&instance->tx_cfg, argp,
> -				   sizeof(struct pi433_tx_cfg)))
> +		/* do not modify tx config while it is being copied to fifo */

There is no need for this comment, since it's obvious.  Also if you use
simpler names then the copy fits on one line:

		if (copy_from_user(&tx_cfg, argp, sizeof(tx_cfg)) {


> +		mutex_lock(&device->tx_fifo_lock);
> +		if (copy_from_user(&tx_cfg_buffer, argp,
> +				   sizeof(struct pi433_tx_cfg))) {

Sorry for the duplicate review, but it got sent to both my inboxes... :P

regards,
dan carpenter

