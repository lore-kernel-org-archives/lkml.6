Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AG47ELvcBm1fWmoKioYBQeeuWbFfnOgKj3J3s9qREhBN0yL01zcJDmMbG/DR9q1cjyvfGZBhkpYT
ARC-Seal: i=1; a=rsa-sha256; t=1521189170; cv=none;
        d=google.com; s=arc-20160816;
        b=Qb9HgXdgQpHml7Yb04UzwbMTGM+c7GnlqNiURsE+r3ESS/4iZ/rqKk4CaVJhnEYp2Z
         Z5DDvW1twTXI7FlYRgMxY3VjK5f5IGa8/ZxqdvD2mIfBq3QQvg0tBWz6AK9tInqGxMsr
         1wxcmWvwe/CNBfh00ayY3LOlq1MKvyOnv84Pqf32bgMU3gWygFbW6k103KPyS2n+VJsf
         8H5cGY0wgmWbJGhDnTzSy96DsunO0xhc2BH3iXfEkRCT/zxHfnA6ubbpNO7fNcwr2cb+
         k58i4R2C2iuIj9DxPOCEXFFxca/VcHk/6SbCIX5pMP8ZpWVMGSpf1KVr0lc5m9YRLjn5
         rRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=LLsV9QOUkU9k5FYBV5iH07mDwxPzAYKbrTGH7lGxVa4=;
        b=ucg6V2Ar9dtcX24HnQ6UIZcEMCNW6P+7etaJZcUPCJIXbKqobBq6Nh2NW6DDwDFq6s
         YLcxueajtYixZpwrh//VcNCLxuu7DuGcE8Bmtv1SDZ600sRHaaoD9+FVQLsG1pCaTOYx
         tuYYDW9RJNsB1DXpdddC1s+j6pZ9Go6z/iuXLcg5Vp40ranxf5OSrwc4+b2vwNVe9GQy
         5qhaDFRkxehKGKuIDidzkopyEVnreCoTj2xROTOuTiyqIq8Zn4+ViK+PwZa8ClDGbHKT
         S+LhAmNvLk9JDYmSL4+OGxnFKW4DGp2vuk09XobCRk+eko2KfmlM0kM1y4/JWUCAlN8M
         FlbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gUfNW0XE;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gUfNW0XE;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 16 Mar 2018 11:32:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
Cc: mchehab@kernel.org, devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        arvind.yadav.cs@gmail.com, linux-media@vger.kernel.org
Subject: Re: [PATCH] staging: media: davinci_vpfe: add error handling on
 kmalloc failure
Message-ID: <20180316083234.yq7a4rx6w35amflu@mwanda>
References: <CGME20180316045841epcas2p34dc11231c65e2032e88ac7138db2daee@epcas2p3.samsung.com>
 <1521176303-17546-1-git-send-email-ji_hun.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521176303-17546-1-git-send-email-ji_hun.kim@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160005
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595068985971756322?=
X-GMAIL-MSGID: =?utf-8?q?1595082455289762175?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 01:58:23PM +0900, Ji-Hun Kim wrote:
> There is no failure checking on the param value which will be allocated
> memory by kmalloc. Add a null pointer checking statement. Then goto error:
> and return -ENOMEM error code when kmalloc is failed.
> 
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
> ---
>  drivers/staging/media/davinci_vpfe/dm365_ipipe.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
> index 6a3434c..55a922c 100644
> --- a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
> +++ b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
> @@ -1280,6 +1280,10 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
>  
>  			params = kmalloc(sizeof(struct ipipe_module_params),
>  					 GFP_KERNEL);
> +			if (!params) {
> +				rval = -ENOMEM;
> +				goto error;
                                ^^^^^^^^^^

What does "goto error" do, do you think?  It's not clear from the name.
When you have an unclear goto like this it often means the error
handling is going to be buggy.

In this case, it does nothing so a direct "return -ENOMEM;" would be
more clear.  But the rest of the error handling is buggy.

  1263  static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
  1264  {
  1265          struct vpfe_ipipe_device *ipipe = v4l2_get_subdevdata(sd);
  1266          unsigned int i;
  1267          int rval = 0;
  1268  
  1269          for (i = 0; i < ARRAY_SIZE(ipipe_modules); i++) {
  1270                  unsigned int bit = 1 << i;
  1271  
  1272                  if (cfg->flag & bit) {
  1273                          const struct ipipe_module_if *module_if =
  1274                                                  &ipipe_modules[i];
  1275                          struct ipipe_module_params *params;
  1276                          void __user *from = *(void * __user *)
  1277                                  ((void *)cfg + module_if->config_offset);
  1278                          size_t size;
  1279                          void *to;
  1280  
  1281                          params = kmalloc(sizeof(struct ipipe_module_params),
  1282                                           GFP_KERNEL);

Do a direct return:

				if (!params)
					return -ENOMEM;

  1283                          to = (void *)params + module_if->param_offset;
  1284                          size = module_if->param_size;
  1285  
  1286                          if (to && from && size) {
  1287                                  if (copy_from_user(to, from, size)) {
  1288                                          rval = -EFAULT;
  1289                                          break;

The most recent thing we allocated is "params" so lets do a
"goto free_params;".  We'll have to declare "params" at the start of the
function instead inside this block.

  1290                                  }
  1291                                  rval = module_if->set(ipipe, to);
  1292                                  if (rval)
  1293                                          goto error;

goto free_params again since params is still the most recent thing we
allocated.

  1294                          } else if (to && !from && size) {
  1295                                  rval = module_if->set(ipipe, NULL);
  1296                                  if (rval)
  1297                                          goto error;

And here again goto free_params.

  1298                          }
  1299                          kfree(params);
  1300                  }
  1301          }
  1302  error:
  1303          return rval;


Change this to:

	return 0;

free_params:
	kfree(params);
	return rval;

  1304  }

regards,
dan carpenter
