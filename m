Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754933AbeBAUIE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:08:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55390 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754663AbeBAUH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:07:57 -0500
Subject: Re: [PATCH] xen: fix frontend driver disconnected from xenbus on
 removal
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: jgross@suse.com, david.vrabel@citrix.com, otubo@redhat.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <1517475439-10541-1-git-send-email-andr2000@gmail.com>
 <1517475439-10541-2-git-send-email-andr2000@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <3943477e-7768-ceb3-38a3-3a20cb0e3082@oracle.com>
Date: Thu, 1 Feb 2018 15:08:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1517475439-10541-2-git-send-email-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=810
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2018 03:57 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Current xenbus frontend driver removal flow first disconnects
> the driver from xenbus and then calls driver's remove callback.
> This makes it impossible for the driver to listen to backend's
> state changes and synchronize the removal procedure.
>
> Fix this by removing other end XenBus watches after the
> driver's remove callback is called.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>  drivers/xen/xenbus/xenbus_probe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
> index 74888cacd0b0..9c63cd3f416b 100644
> --- a/drivers/xen/xenbus/xenbus_probe.c
> +++ b/drivers/xen/xenbus/xenbus_probe.c
> @@ -258,11 +258,11 @@ int xenbus_dev_remove(struct device *_dev)
>  
>  	DPRINTK("%s", dev->nodename);
>  
> -	free_otherend_watch(dev);
> -
>  	if (drv->remove)
>  		drv->remove(dev);


Is it possible for the watch to fire here?

-boris

>  
> +	free_otherend_watch(dev);
> +
>  	free_otherend_details(dev);
>  
>  	xenbus_switch_state(dev, XenbusStateClosed);
