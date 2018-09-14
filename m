Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2ACC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 04:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5679820866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 04:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/+WBR61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5679820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeINJz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 05:55:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbeINJz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 05:55:58 -0400
Received: from localhost (unknown [213.57.183.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E197320866;
        Fri, 14 Sep 2018 04:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536900198;
        bh=U7warps25KnJZmTTud5b/JDdUSMZGupmfF/DAGqN89Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/+WBR61OcRxtsOZSYacCLriAjilPJt/bhFVl7MCwRM6CvaR6EqMPFDYaMK+hIZVP
         yq+Bv7cm/oihX21sfFba+s7Ij+XT70KJS85B64HcioTzU5Yv2JtYt/VU4FvN1mng25
         0RJTZuA01U2dZ6ZUhCPFPZEtJI/sGyu8vQ20TPmI=
Date:   Fri, 14 Sep 2018 07:43:14 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Qing Huang <qing.huang@oracle.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, tariqt@mellanox.com,
        davem@davemloft.net
Subject: Re: [PATCH] net/mlx4_core: print firmware version during driver
 loading
Message-ID: <20180914044314.GC5257@mtr-leonro.mtl.com>
References: <20180914002514.27571-1-qing.huang@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pE2VAHO2njSJCslu"
Content-Disposition: inline
In-Reply-To: <20180914002514.27571-1-qing.huang@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pE2VAHO2njSJCslu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 13, 2018 at 05:25:14PM -0700, Qing Huang wrote:
> When debugging firmware related issues, it's very helpful to have

      ^^^^^^^^^^ exactly, this is why we set this print as mlx4_dbg and
      not mlx4_info.

> the installed FW version info in the kernel log when the driver is
> loaded. It's easier to match error/warning messages with different
> FW versions in the log other than running a separate tool to get
> the information back and forth.
>
> Signed-off-by: Qing Huang <qing.huang@oracle.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/fw.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
> index babcfd9..e1c5218 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/fw.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
> @@ -1686,11 +1686,11 @@ int mlx4_QUERY_FW(struct mlx4_dev *dev)
>  	MLX4_GET(lg, outbox, QUERY_FW_MAX_CMD_OFFSET);
>  	cmd->max_cmds = 1 << lg;
>
> -	mlx4_dbg(dev, "FW version %d.%d.%03d (cmd intf rev %d), max commands %d\n",
> -		 (int) (dev->caps.fw_ver >> 32),
> -		 (int) (dev->caps.fw_ver >> 16) & 0xffff,
> -		 (int) dev->caps.fw_ver & 0xffff,
> -		 cmd_if_rev, cmd->max_cmds);
> +	mlx4_info(dev, "FW version %d.%d.%03d (cmd intf rev %d), max commands %d\n",
> +		  (int)(dev->caps.fw_ver >> 32),
> +		  (int)(dev->caps.fw_ver >> 16) & 0xffff,
> +		  (int)dev->caps.fw_ver & 0xffff,
> +		  cmd_if_rev, cmd->max_cmds);
>
>  	MLX4_GET(fw->catas_offset, outbox, QUERY_FW_ERR_START_OFFSET);
>  	MLX4_GET(fw->catas_size,   outbox, QUERY_FW_ERR_SIZE_OFFSET);
> --
> 2.9.3
>

--pE2VAHO2njSJCslu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbmzxiAAoJEORje4g2clinrfcP/34SGf7sbKKus+eE9PWYOb7t
+IBvCXBk7zk9T+amaFMp4zHhUs7MEI3nlG4ZVcd8/YZWhP4ty0H7g0Qw/g19AJ5w
zyLE9BvgbrUL20jPdIMtOqrWmLHhHMXsYbe49X1XpETrjWRiMLNxBjxrJnLiydf8
/uyA4+LPL7i9B52gjSHhPDl2qHU0mHhNoXc+s3iKFl4UdtScaXWCu0LMprbxYYD6
FE1Jr8uer+B0sACkLbWDlxNm+hdoVzZirOSFeGIB+toXj3GbuxUv8zu3LkXi0NoM
+bQNY1pB6BG9X/Av9diy+4GRJ4j7ndTb8m0GP9EGiukAmrDN3tBr950Op/55O0rq
R/RiLLvPSkZ2D1xX4LTYA5cccNlgFdbZ8X019m35FbcgSPIWg5gw3ot5IFsxQGUz
S+ALaR4lQji8np09HOlFTNTD22Y27M6rBmdy9mML2E8vnqVJMmI7ZWVx20/vnh6c
CK1qUr/Q6zY6zCD8UeC2Rr1GoJSaAH77G6WSgkCxUqIDTPiUzlOrKJQGviwCD5B2
cEpWvuKhUch9qMkr2yDMi6o6agMRfhv0BQGgKu5KTyHX602vdXlWfIXu5WW5Gf9K
P2RinwHuR/RAW71BPpB0hfv4/Efe0KHCQcVqZqfA28S5OSWmeUMfrsuKt6+VRmW/
xMThVeSXx6PlxdrXEKF8
=+Pc2
-----END PGP SIGNATURE-----

--pE2VAHO2njSJCslu--
