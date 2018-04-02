Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754446AbeDBSiC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 14:38:02 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:50675 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753316AbeDBSiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 14:38:00 -0400
Subject: Re: [net-next 2/2] net: netcp: ethss: k2g: add promiscuous mode
 support
To: Andrew Lunn <andrew@lunn.ch>
CC: <w-kwok2@ti.com>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>, <nsekhar@ti.com>,
        <grygorii.strashko@ti.com>
References: <1522685839-9497-1-git-send-email-m-karicheri2@ti.com>
 <1522685839-9497-3-git-send-email-m-karicheri2@ti.com>
 <20180402164708.GD14165@lunn.ch>
From: Murali Karicheri <m-karicheri2@ti.com>
Organization: Texas Instruments
Message-ID: <4e45994e-7609-e8ed-a05b-d5b577aaa0bb@ti.com>
Date: Mon, 2 Apr 2018 14:40:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180402164708.GD14165@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Thanks for reviewing this!

On 04/02/2018 12:47 PM, Andrew Lunn wrote:
> On Mon, Apr 02, 2018 at 12:17:19PM -0400, Murali Karicheri wrote:
>> +static int gbe_set_rx_mode(void *intf_priv, bool promisc)
>> +{
>> +	struct gbe_intf *gbe_intf = intf_priv;
>> +	struct gbe_priv *gbe_dev = gbe_intf->gbe_dev;
>> +	struct cpsw_ale *ale = gbe_dev->ale;
>> +	unsigned long timeout;
>> +	int i, ret = -ETIMEDOUT;
>> +
>> +	/* Disable(1)/Enable(0) Learn for all ports (host is port 0 and
>> +	 * slaves are port 1 and up
>> +	 */
>> +	for (i = 0; i <= gbe_dev->num_slaves; i++) {
>> +		cpsw_ale_control_set(ale, i,
>> +				     ALE_PORT_NOLEARN, !!promisc);
>> +		cpsw_ale_control_set(ale, i,
>> +				     ALE_PORT_NO_SA_UPDATE, !!promisc);
>> +	}
> 
> Hi Murali
> 
> Does this mean that in promisc mode, switching of frames between ports
> in hardware is disabled? You are relying on the software bridge to
> perform such bridging between ports?

The K2G switch has only one slave port. The other port is the host port.
So there is no switching applicable here. At the egress drivers provide 
frame with PS_FLAG to indicate which port the frame is forwarded to and
at the Ingress direction, it forward the received frame to the Host port
which is the only other port in a K2G switch (2u). To Implement
promiscuous mode, this requires ALE to be enabled and take advantage of
ALE feature to flood all received unicast frames to host port. In the 
non-promiscuous mode, it disables that feature. So only frames with
destination MAC address match is forwarded.

For other K2 devices that has more than one port available, what you say
is applicable. However we have not implemented the switch mode of these
devices with multiple ports and don't have plan to do the same anytime
in the future as this device is already matured and adding this feature
at this point doesn't make much sense now. The driver on these devices
currently bypass ALE and implement plain Ethernet interfaces (n port)
for Ethernet connectivity.

> 
> You might want to look at skb->offload_fwd_mark. By setting this, you
> can tell the software bridge the hardware has already bridged the
> frame. You might then be able to have promisc enabled, and the
> hardware still doing the forwarding.

Yes, if we decide to support switch mode for K2 devices, I will certainly
look at this and add support as you have suggested.

> 
> 	 Andrew
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
