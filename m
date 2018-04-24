Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeDXMvM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:51:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35865 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932950AbeDXMvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:51:07 -0400
X-ME-Sender: <xms:OyjfWhLKIF6cl3DtHCZDRcPZntlF1_xQBSqOs7i2WT13Mda_BSIHjQ>
Date: Tue, 24 Apr 2018 15:51:04 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Colin King <colin.king@canonical.com>
Cc: Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, nogahf@mellanox.com
Subject: Re: [PATCH] mlxsw: spectrum_switchdev: remove duplicated check on
 multicast_enable
Message-ID: <20180424125104.GA2461@splinter.mtl.com>
References: <20180424115139.21134-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424115139.21134-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 12:51:39PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check on bridge_port->bridge_device->multicast_enable is performed
> twice in two nested if statements. I can't see any reason for this, the
> second check is redundant and can be removed.
> 
> Detected by cppcheck:
> drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c:1722]:
> (warning) Identical inner 'if' condition is always true.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> index c11c9a635866..989ed19e25c9 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> @@ -1719,12 +1719,9 @@ __mlxsw_sp_port_mdb_del(struct mlxsw_sp_port *mlxsw_sp_port,
>  	int err;
>  
>  	if (bridge_port->bridge_device->multicast_enabled) {
> -		if (bridge_port->bridge_device->multicast_enabled) {

This looks like a copy-paste error. I believe the intention was to check
'!bridge_port->mrouter' so that if port is an mrouter port packets
hitting the MDB entry would still be sent to it even after it was
removed from the MDB entry ports list.

I will send a patch later this week after I run it by Nogah who worked
on this part.

Thanks for the patch.

> -			err = mlxsw_sp_port_smid_set(mlxsw_sp_port, mid->mid,
> -						     false);
> -			if (err)
> -				netdev_err(dev, "Unable to remove port from SMID\n");
> -		}
> +		err = mlxsw_sp_port_smid_set(mlxsw_sp_port, mid->mid, false);
> +		if (err)
> +			netdev_err(dev, "Unable to remove port from SMID\n");
>  	}
>  
>  	err = mlxsw_sp_port_remove_from_mid(mlxsw_sp_port, mid);
> -- 
> 2.17.0
> 
