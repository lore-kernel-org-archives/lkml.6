Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDE8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC835208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZDujZu3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC835208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936899AbeFRKTA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:19:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43080 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933409AbeFRKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:18:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5IADnUh193802;
        Mon, 18 Jun 2018 10:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=+4WdmHIXGalIxVJ754jvmJYpuTp1XA5A7Kamod648Tc=;
 b=ZDujZu3g7oNPhVdy/w4I2LVYq/OVWLw2dNdnYCUgBFWvk/Z0zqkKFlnjHhZ0eby7jH+E
 qVyA/3xK8wjPhmW2FmqmLhvn/WHhNeb5hx3GvtE0rXfPD605wQcMaXjGHrsIj0iRdk9f
 tIZaApXwHRPCRqcNNTUMTI7a5F7uDkS76LG/jEcopdJSXIXgVNJR6f3oLf+QJM6q+QEi
 cm+wtCqdf+iYh/j++9n3j5pICaQvsVvKWl4mVT74slKjaG5QfsIYkZdNSEZf21uClSuq
 tXSmY0TjBePCDRzBifvy0QUE0fAzNbhpTIXfFGL9ETqUUdduPApo3koMsqq2zuOezWpT sA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jmu6xkdyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 10:18:49 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5IAImBt019763
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jun 2018 10:18:48 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5IAIkm6013077;
        Mon, 18 Jun 2018 10:18:46 GMT
Received: from mwanda (/197.157.0.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 03:18:45 -0700
Date:   Mon, 18 Jun 2018 13:18:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix race condition in pi433_open
Message-ID: <20180618101838.gzbrxabilnqyilsi@mwanda>
References: <20180618022400.GA1893@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618022400.GA1893@hle-laptop.local>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8927 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806180125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 10:24:00PM -0400, Hugo Lefeuvre wrote:
> Whenever pi433_open and pi433_remove execute concurrently, a race
> condition potentially resulting in use-after-free might happen.
> 
> Let T1 and T2 be two kernel threads.
> 
> 1. T1 executes pi433_open and stops before "device->users++".
> 2. The pi433 device was removed inbetween, so T2 executes pi433_remove
>    and frees device because the user count has not been incremented yet.
> 3. T1 executes "device->users++" (use-after-free).
> 
> This race condition happens because the check of minor number and
> user count increment does not happen atomically.
> 
> Fix: Extend scope of minor_lock in pi433_open().
> 
> Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
> ---
>  drivers/staging/pi433/pi433_if.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index 94e0bfcec991..73c511249f7f 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -957,11 +957,13 @@ static int pi433_open(struct inode *inode, struct file *filp)
>  
>  	mutex_lock(&minor_lock);
>  	device = idr_find(&pi433_idr, iminor(inode));
> -	mutex_unlock(&minor_lock);
>  	if (!device) {
> +		mutex_unlock(&minor_lock);
>  		pr_debug("device: minor %d unknown.\n", iminor(inode));
>  		return -ENODEV;
>  	}
> +	device->users++;
> +	mutex_unlock(&minor_lock);
>  
>  	if (!device->rx_buffer) {
>  		device->rx_buffer = kmalloc(MAX_MSG_SIZE, GFP_KERNEL);

We need to decrement device->users-- on the error paths as well.
This function was already slightly broken with respect to counting the
users, but let's not make it worse.

I think it's still a tiny bit racy because it's not an atomic type.

I'm not sure the error handling in open() works either.  It's releasing
device->rx_buffer but there could be another user.  The ->rx_buffer
should be allocated in probe() instead of open() probably, no?  And then
freed in pi433_remove().  Then once we put that in the right layer
it means we can just get rid of ->users...

The lines:

  1008                  if (!device->spi)
  1009                          kfree(device);

make no sort of sense at all...  Fortunately it's not posssible for
device->spi to be NULL so it's dead code.

regards,
dan carpenter

