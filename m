Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423480AbeE1MRK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:17:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50348 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422783AbeE1MRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:17:00 -0400
Date: Mon, 28 May 2018 15:16:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.14 286/496] macsec: missing dev_put() on error in
 macsec_newlink()
Message-ID: <20180528121644.4wftwxql43eoug5h@mwanda>
References: <20180528100319.498712256@linuxfoundation.org>
 <20180528100331.887783491@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528100331.887783491@linuxfoundation.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8906 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805280150
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I'm sorryt.  This one was buggy.  We did a revert of it in commit
bd28899dd34f ("Revert "macsec: missing dev_put() on error in
macsec_newlink()"").

You have queued for 4.8 as well.

regards,
dan carpenter

On Mon, May 28, 2018 at 12:01:11PM +0200, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Dan Carpenter <dan.carpenter@oracle.com>
> 
> [ Upstream commit 5dcd8400884cc4a043a6d4617e042489e5d566a9 ]
> 
> We moved the dev_hold(real_dev); call earlier in the function but forgot
> to update the error paths.
> 
> Fixes: 0759e552bce7 ("macsec: fix negative refcnt on parent link")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/macsec.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -3248,7 +3248,7 @@ static int macsec_newlink(struct net *ne
>  
>  	err = netdev_upper_dev_link(real_dev, dev);
>  	if (err < 0)
> -		goto unregister;
> +		goto put_dev;
>  
>  	/* need to be already registered so that ->init has run and
>  	 * the MAC addr is set
> @@ -3284,7 +3284,8 @@ del_dev:
>  	macsec_del_dev(macsec);
>  unlink:
>  	netdev_upper_dev_unlink(real_dev, dev);
> -unregister:
> +put_dev:
> +	dev_put(real_dev);
>  	unregister_netdevice(dev);
>  	return err;
>  }
> 
