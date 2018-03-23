Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeCWPLF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:11:05 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40162 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbeCWPLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:11:03 -0400
Date: Fri, 23 Mar 2018 16:11:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, robh+dt@kernel.org,
        frowand.list@gmail.com
Subject: Re: [PATCH] of_net: Implement of_get_nvmem_mac_address helper
Message-ID: <20180323151101.GB24361@lunn.ch>
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 03:24:34PM +0100, Mike Looijmans wrote:
> It's common practice to store MAC addresses for network interfaces into
> nvmem devices. However the code to actually do this in the kernel lacks,
> so this patch adds of_get_nvmem_mac_address() for drivers to obtain the
> address from an nvmem cell provider.
> 
> This is particulary useful on devices where the ethernet interface cannot
> be configured by the bootloader, for example because it's in an FPGA.
> 
> Tested by adapting the cadence macb driver to call this instead of
> of_get_mac_address().

Hi Mike

Please can you document the device tree binding. I assume you are
adding a nvmen-cells and nvmem-cell-names to the Ethernet node in
device tree.

> +/**
> + * Search the device tree for a MAC address, by calling of_get_mac_address
> + * and if that doesn't provide an address, fetch it from an nvmem provider
> + * using the name 'mac-address'.
> + * On success, copies the new address is into memory pointed to by addr and
> + * returns 0. Returns a negative error code otherwise.
> + * @dev:	Pointer to the device containing the device_node
> + * @addr:	Pointer to receive the MAC address using ether_addr_copy()
> + */
> +int of_get_nvmem_mac_address(struct device *dev, char *addr)
> +{
> +	const char *mac;
> +	struct nvmem_cell *cell;
> +	size_t len;
> +	int ret;
> +
> +	mac = of_get_mac_address(dev->of_node);
> +	if (mac) {
> +		ether_addr_copy(addr, mac);
> +		return 0;
> +	}

Is there a need to add a new API? Could of_get_mac_address() be
extended to look in NVMEM? The MAC driver does not care. It is saying,
using OF get me a MAC address. One API seems sufficient, and would
mean you don't need to change the MAC drivers.

     Andrew
