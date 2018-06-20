Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908A2C1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494E520652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AFnPV3KF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494E520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754822AbeFTJKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:10:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33254 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754059AbeFTIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:35:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5K8XSG0100918;
        Wed, 20 Jun 2018 08:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=goKmHpHCaGRBPJcTlA5nNXrblVXj3JcEECW6ZSIzQAw=;
 b=AFnPV3KFVQ3vaBoUEYIoup6jX8NG/mCz3aj3j7jkenWWwZ8ajb2KrHdvnzkOn9r/hKVJ
 ktFM7zv6AKiJzq2T5y2D4nQ1iDLw8dFNMdoFURPSlJEaTRt/iJnL+ygw6oSz7F+XRd0s
 DJ2avRAW12K42ZJNb3p82yj5bMBvncUkFQtXMebnoIf8wPIYzmosUfFcy82QUyIfhbpD
 2RC1cff4idNgMgBa5aI2+qn5wvimzLrxeVgxoJGx2EG21hmSTtcJyE2cPy4wIL2Gii5K
 gcRga9PFa9OPpLiqQJRFVewhOEJs1s+qlM0hIJy/K3TQJ/i17jwnhFAtcIvYGIKU7o3V sw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jmtgwudvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 08:34:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5K8Yt9p016333
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 08:34:56 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5K8Ysuf016460;
        Wed, 20 Jun 2018 08:34:54 GMT
Received: from mwanda (/197.157.34.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 01:34:53 -0700
Date:   Wed, 20 Jun 2018 11:34:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: pi433: fix race condition in pi433_open
Message-ID: <20180620083439.6ouovmhsc235aprw@mwanda>
References: <20180620023326.GA30440@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620023326.GA30440@hle-laptop.local>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=873
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:33:26PM -0400, Hugo Lefeuvre wrote:
> @@ -1178,6 +1152,11 @@ static int pi433_probe(struct spi_device *spi)
>  	device->tx_active = false;
>  	device->interrupt_rx_allowed = false;
>  
> +	/* init rx buffer */
> +	device->rx_buffer = kmalloc(MAX_MSG_SIZE, GFP_KERNEL);
> +	if (!device->rx_buffer)
> +		return -ENOMEM;

We need to free device.

> +
>  	/* init wait queues */
>  	init_waitqueue_head(&device->tx_wait_queue);
>  	init_waitqueue_head(&device->rx_wait_queue);
> @@ -1280,6 +1259,7 @@ static int pi433_probe(struct spi_device *spi)
>  minor_failed:
>  	free_gpio(device);
>  GPIO_failed:
> +	kfree(device->rx_buffer);
>  	kfree(device);
>  
>  	return retval;

regards,
dan carpenter
