Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AB8JxZofnA9vG1mGiF61Rj7Vrz79ziSTg9RK31JXqtO1hJUGm90z8Qzpr+HUzBFbbhtfYjJmjw5p
ARC-Seal: i=1; a=rsa-sha256; t=1525260393; cv=none;
        d=google.com; s=arc-20160816;
        b=MdnmPv1pkdcfw/v9gPrv7/sSHk3p5Uyba0zqe+vDSkTWxNmErL81kuMFWkCelnXWZw
         5J1Qcc7QjckRMsulCMCn8tSABFtb0oQbRqgxFRLuQm7+bHwdk+ZVJXNdyuy/9Ohi855j
         k5UGtQQZjN7lkgkNNVa7DjUCmhQmz7XMclslKfp0ABHazLcqgFNrjOg5SJ4/hFOvb69D
         rAti/bK80V9ATe0h4h9/5jveOhNieFU3QQ19XqigT5sazzA/r1hSJz6uv5rm/nsE8xcF
         BI7XcoEQb/sDakbXiOHyPFipOdjjREgMbUirJneYMKKLGhgmcTfiTM+XXEpW16RlSB2l
         akRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=rhMHdkSOHFsk5Z4y51q1dERIrKw2yyQH8zAS+GdkW4o=;
        b=NDX5nWSa9XgoRBSTwhDo41ywM5vMCBUvbqb+42j+Dns/gtgJYabCHBeW6oE/l5U/lm
         UIhifUTb9Fbsy35xS/ULjT6fMaE1xJbPEhXCEKOYcoBMBvFUd+Pb+rNFoWBVWsAUteug
         NGVPvtwvBkG/1+D84i9OPACdwS/eaFOdgbve5Pal6yAfU40+E9p1sqMLx5exnb3/19DE
         GUrK9YT1HRARKKRPLSWB+H2ZOoeWA9gaDaay7qUFPdAk8NCGUgDPVRp4D6p9GoTyZIBx
         wWeVQzg7/LLz3REcbWf0SN8PG/mom0VC860Ffq8ZBpqLrtSiZu1opGZb+JBLccT6789t
         s/Vg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ODPzxw+O;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ODPzxw+O;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Wed, 2 May 2018 14:26:15 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Colin King <colin.king@canonical.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][media-next] media: davinci_vpfe: fix memory leaks of
 params
Message-ID: <20180502112615.rsx43yoqiiz54dra@mwanda>
References: <20180502091658.17110-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502091658.17110-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8880 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805020093
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599343290564984150?=
X-GMAIL-MSGID: =?utf-8?q?1599351442656568816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 10:16:58AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are memory leaks of params; when copy_to_user fails and also
> the exit via the label 'error'.  Fix this by kfree'ing params in
> error exit path and jumping to this on the copy_to_user failure path.
> 
> Detected by CoverityScan, CID#1467966 ("Resource leak")
> 
> Fixes: da43b6ccadcf ("[media] davinci: vpfe: dm365: add IPIPE support for media controller driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/media/davinci_vpfe/dm365_ipipe.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
> index 95942768639c..3e67ee6e92f9 100644
> --- a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
> +++ b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
> @@ -1252,12 +1252,12 @@ static const struct ipipe_module_if ipipe_modules[VPFE_IPIPE_MAX_MODULES] = {
>  static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
>  {
>  	struct vpfe_ipipe_device *ipipe = v4l2_get_subdevdata(sd);
> +	struct ipipe_module_params *params;
>  	unsigned int i;
>  	int rval = 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(ipipe_modules); i++) {
>  		const struct ipipe_module_if *module_if;
> -		struct ipipe_module_params *params;
>  		void *from, *to;
>  		size_t size;
>  
> @@ -1275,7 +1275,7 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
>  		if (to && from && size) {
                    ^^

This "to" check is wrong.  Say "params" is NULL and
module_if->param_offset is non-zero then "to" is a bogus pointer.  We
should just test "params" and give up the first time an allocation
fails.

>  			if (copy_from_user(to, (void __user *)from, size)) {
>  				rval = -EFAULT;
> -				break;
> +				goto error;
>  			}
>  			rval = module_if->set(ipipe, to);
>  			if (rval)
> @@ -1287,7 +1287,9 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
>  		}
>  		kfree(params);
>  	}
> +	return rval;

Doing a "return 0;" is more readable than "return rval;".

regards,
dan carpenter
