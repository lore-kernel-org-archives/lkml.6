Return-Path: <p.zabel@pengutronix.de>
X-Google-Smtp-Source: AG47ELvERB+KYHOFC9AtCzMFQKccexzsYarDyo+I2Ta6ru2IYUHbSCl9EdRO3Cb5WUFz/xasBtAz
ARC-Seal: i=1; a=rsa-sha256; t=1519893333; cv=none;
        d=google.com; s=arc-20160816;
        b=sYPGiz7k1mk+4AvvWj+efRqX+t8R/y9UYLU6sytKSJvZDYtMzlYm0oqJQ6yxKnlS5f
         fpP2056ZkCY4ukIj2I1+YSsw5aK3zKnTW3DYkyfWUKyjWu1h+MYIVncz0hmoryr/9tK5
         r/EIMOZgbDASWpCGSnrwUHsMc/YXFBj1u8aNqOsPu6bMadtFFjDTmmVr4QgFufKDtdp0
         FLSGbvIzeKoWqj3QEU2fNmmy7Yy3iB36uomczV66s4afVDYwAgLxZMAo/knFRdnZXRna
         3OaORzAs3GgFF6EYZTcCp+HFKQjCjnWGdIESUn8tnctbqp1AyTSFAj5djzTmiqO0Zlvv
         iJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=VpI59moEndDwqlP0p+t63/SpAXot3XbYHBiiMJf4NEs=;
        b=HRUXLWBtl8Vgutgb8mwIIYf9AU3dJJ4Zubov2dKroW3vALWrExgIllm0aSWf1OEiz5
         nYzV3YWpqmjt8QQv5wFkemiOHQiID/vplhHv+PSZuE6kDRrU1WLT9/l4KdpMqn3xsJzz
         4WwtTIKU6neOWFIU4lYZvY7PLh5uvXqperLK0JVQiYAiXklrLpivghvaDx7KaWpidIAp
         qMt7eglcHYNPP3lgFQXlurlx5FW2ncT1LcH4/cNXyazda37aMmbxHIZTd8ukpuF2Ry07
         Th1GM/7NYW76aZq3R3+t91zywa1YsLE3mx6FfoBj6IH+vLefEo9t7vsZrp/U3rWU/VPu
         icHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of p.zabel@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=p.zabel@pengutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of p.zabel@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <1519893326.3034.1.camel@pengutronix.de>
Subject: Re: [PATCH] staging/imx: Fix inconsistent IS_ERR and PTR_ERR
From: Philipp Zabel <p.zabel@pengutronix.de>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Steve Longerbeam
	 <slongerbeam@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva"
 <garsilva@embeddedor.com>
Date: Thu, 01 Mar 2018 09:35:26 +0100
In-Reply-To: <20180301040939.GA13274@embeddedgus>
References: <20180301040939.GA13274@embeddedgus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593706944440057524?=
X-GMAIL-MSGID: =?utf-8?q?1593723672330017671?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-28 at 22:09 -0600, Gustavo A. R. Silva wrote:
> Fix inconsistent IS_ERR and PTR_ERR in imx_csi_probe.
> The proper pointer to be passed as argument is pinctrl
> instead of priv->vdev.
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: 52e17089d185 ("media: imx: Don't initialize vars that won't be used")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/staging/media/imx/imx-media-csi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
> index 5a195f8..4f290a0 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -1798,7 +1798,7 @@ static int imx_csi_probe(struct platform_device *pdev)
>  	priv->dev->of_node = pdata->of_node;
>  	pinctrl = devm_pinctrl_get_select_default(priv->dev);
>  	if (IS_ERR(pinctrl)) {
> -		ret = PTR_ERR(priv->vdev);
> +		ret = PTR_ERR(pinctrl);
>  		goto free;
>  	}

Thanks,
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
