Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeBJPqN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 10:46:13 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:48382 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbeBJPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 10:46:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Sat, 10 Feb 2018 16:46:10 +0100
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org, kernel@pengutronix.de
Cc: fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] soc: imx: gpc: de-register power domains only if
 initialized
In-Reply-To: <20180107134905.15624-1-stefan@agner.ch>
References: <20180107134905.15624-1-stefan@agner.ch>
Message-ID: <58a199f07ff636d1a5ad69aa54ce30ea@agner.ch>
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.01.2018 14:49, Stefan Agner wrote:
> If power domain information are missing in the device tree, no
> power domains get initialized. However, imx_gpc_remove tries to
> remove power domains always in the old DT binding case. Only
> remove power domains when imx_gpc_probe initialized them in
> first place.

Shawn, I think this patch can be merged. The discussion branches a bit
off into a second problem, but this patch should be fine.

--
Stefan

> 
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/soc/imx/gpc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 53f7275d6cbd..62bb724726d9 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -470,13 +470,21 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  
>  static int imx_gpc_remove(struct platform_device *pdev)
>  {
> +	struct device_node *pgc_node;
>  	int ret;
>  
> +	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
> +
> +	/* bail out if DT too old and doesn't provide the necessary info */
> +	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
> +	    !pgc_node)
> +		return 0;
> +
>  	/*
>  	 * If the old DT binding is used the toplevel driver needs to
>  	 * de-register the power domains
>  	 */
> -	if (!of_get_child_by_name(pdev->dev.of_node, "pgc")) {
> +	if (!pgc_node) {
>  		of_genpd_del_provider(pdev->dev.of_node);
>  
>  		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
