Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeDBQrQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:47:16 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49084 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752783AbeDBQrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:47:12 -0400
Date: Mon, 2 Apr 2018 18:47:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: w-kwok2@ti.com, linux-kernel@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, nsekhar@ti.com, grygorii.strashko@ti.com
Subject: Re: [net-next 2/2] net: netcp: ethss: k2g: add promiscuous mode
 support
Message-ID: <20180402164708.GD14165@lunn.ch>
References: <1522685839-9497-1-git-send-email-m-karicheri2@ti.com>
 <1522685839-9497-3-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522685839-9497-3-git-send-email-m-karicheri2@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 12:17:19PM -0400, Murali Karicheri wrote:
> +static int gbe_set_rx_mode(void *intf_priv, bool promisc)
> +{
> +	struct gbe_intf *gbe_intf = intf_priv;
> +	struct gbe_priv *gbe_dev = gbe_intf->gbe_dev;
> +	struct cpsw_ale *ale = gbe_dev->ale;
> +	unsigned long timeout;
> +	int i, ret = -ETIMEDOUT;
> +
> +	/* Disable(1)/Enable(0) Learn for all ports (host is port 0 and
> +	 * slaves are port 1 and up
> +	 */
> +	for (i = 0; i <= gbe_dev->num_slaves; i++) {
> +		cpsw_ale_control_set(ale, i,
> +				     ALE_PORT_NOLEARN, !!promisc);
> +		cpsw_ale_control_set(ale, i,
> +				     ALE_PORT_NO_SA_UPDATE, !!promisc);
> +	}

Hi Murali

Does this mean that in promisc mode, switching of frames between ports
in hardware is disabled? You are relying on the software bridge to
perform such bridging between ports?

You might want to look at skb->offload_fwd_mark. By setting this, you
can tell the software bridge the hardware has already bridged the
frame. You might then be able to have promisc enabled, and the
hardware still doing the forwarding.

	 Andrew
