Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B9415C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E01820891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b6BR/Pug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E01820891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934927AbeFMJIs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:08:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39700 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754493AbeFMJIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:08:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5D95dV5142809;
        Wed, 13 Jun 2018 09:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=JafLCgdozYDDcCkF69G/2u4pkJBQEMmW9iPrpSrPDpc=;
 b=b6BR/PugNWC/fWdNEFaGguaAORZH1YtaH6r0oEZY86+9FAYAzVXwyGf/Whp1lrW9OkeM
 lrC+u4zOqdZzIQ4PUsB/Tb0EiYe1s8wbRfNUCteLbG77ekHOys7PCdLryvYS4lgnvem/
 +ecIxZKtNODhj2vydD+n9pIHGtQmnE9DWaONtWu8kFw2wXqDDG5FiuDbBwiPlpVqDM7q
 Wmspc591rbd+tzlYtHDJ7xfDVWnjczw2Aakhupi9fZgvVabWj4DJgAM0t9b6GSIqdAun
 6BQpqRNnHGnDr59M+Vl/m8To6Fc+6YAkdz7DOl0OOJdB/evhF1AYHdLWx6rR9176EUng ww== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jjp6bsj24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 09:08:23 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5D98LcV016709
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 09:08:22 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5D98JFY025520;
        Wed, 13 Jun 2018 09:08:19 GMT
Received: from mwanda (/197.157.34.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jun 2018 02:08:18 -0700
Date:   Wed, 13 Jun 2018 12:08:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>
Subject: Re: [PATCH v2] staging: pi433: fix race condition in pi433_ioctl
Message-ID: <20180613090807.4efocuy63kbg4p7r@mwanda>
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
 engine=8.0.1-1805220000 definitions=main-1806130102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 09:47:41PM -0400, Hugo Lefeuvre wrote:
> In the PI433_IOC_WR_TX_CFG case in pi433_ioctl, instance->tx_cfg is
> modified via
> 
> copy_from_user(&instance->tx_cfg, argp, sizeof(struct pi433_tx_cfg)))
> 
> without any kind of synchronization. In the case where two threads
> would execute this same command concurrently the tx_cfg field might
> enter in an inconsistent state.
> 
> Additionally: if ioctl(PI433_IOC_WR_TX_CFG) and write() execute
> concurrently the tx config might be modified while it is being
> copied to the fifo, resulting in potential data corruption.
> 
> Fix: Get instance->tx_cfg_lock before modifying tx config in the
> PI433_IOC_WR_TX_CFG case in pi433_ioctl.
> 
> Also, do not copy data directly from user space to instance->tx_cfg.
> Instead use a temporary buffer allowing future checks for correctness
> of copied data.
> 
> Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
> ---
> Changes in v2:
>     - Use device->tx_fifo_lock instead of introducing a new lock in
>       instance.
>     - Do not copy data directly from user space to instance->tx_cfg,
>       instead use a temporary buffer allowing future checks for
>       correctness of copied data.
> ---
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
> +		mutex_lock(&device->tx_fifo_lock);
> +		if (copy_from_user(&tx_cfg_buffer, argp,
> +				   sizeof(struct pi433_tx_cfg))) {
> +			mutex_unlock(&device->tx_fifo_lock);
>  			return -EFAULT;
> +		}
> +		memcpy(&instance->tx_cfg, &tx_cfg_buffer, sizeof(struct pi433_tx_cfg));
> +		mutex_unlock(&device->tx_fifo_lock);

The lock is only needed around the memcpy() and that makes the code a
bit simpler as well.

regards,
dan carpenter


