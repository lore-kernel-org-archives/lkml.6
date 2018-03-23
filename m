Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeCWT0y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:26:54 -0400
Received: from smtp05.mail.online.nl ([194.134.25.75]:10641 "EHLO
        smtp05.mail.online.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752390AbeCWT0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:26:52 -0400
Subject: Re: [PATCH] of_net: Implement of_get_nvmem_mac_address helper
To: Andrew Lunn <andrew@lunn.ch>
References: <1521815074-30424-1-git-send-email-mike.looijmans@topic.nl>
 <20180323151101.GB24361@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, robh+dt@kernel.org,
        frowand.list@gmail.com
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <b68d4540-b15d-ec31-05a8-e1a4632bb5ee@topic.nl>
Date: Fri, 23 Mar 2018 20:20:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180323151101.GB24361@lunn.ch>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-3-2018 16:11, Andrew Lunn wrote:
> On Fri, Mar 23, 2018 at 03:24:34PM +0100, Mike Looijmans wrote:
>> It's common practice to store MAC addresses for network interfaces into
>> nvmem devices. However the code to actually do this in the kernel lacks,
>> so this patch adds of_get_nvmem_mac_address() for drivers to obtain the
>> address from an nvmem cell provider.
>>
>> This is particulary useful on devices where the ethernet interface cannot
>> be configured by the bootloader, for example because it's in an FPGA.
>>
>> Tested by adapting the cadence macb driver to call this instead of
>> of_get_mac_address().
>
> Hi Mike
>
> Please can you document the device tree binding. I assume you are
> adding a nvmen-cells and nvmem-cell-names to the Ethernet node in
> device tree.

Indeed. I'll add my settings as an example. Where should I put this 
documentation, in the commit comment or somewhere in 
Documents/devicetree/bindings?

>> +/**
>> + * Search the device tree for a MAC address, by calling of_get_mac_address
>> + * and if that doesn't provide an address, fetch it from an nvmem provider
>> + * using the name 'mac-address'.
>> + * On success, copies the new address is into memory pointed to by addr and
>> + * returns 0. Returns a negative error code otherwise.
>> + * @dev:	Pointer to the device containing the device_node
>> + * @addr:	Pointer to receive the MAC address using ether_addr_copy()
>> + */
>> +int of_get_nvmem_mac_address(struct device *dev, char *addr)
>> +{
>> +	const char *mac;
>> +	struct nvmem_cell *cell;
>> +	size_t len;
>> +	int ret;
>> +
>> +	mac = of_get_mac_address(dev->of_node);
>> +	if (mac) {
>> +		ether_addr_copy(addr, mac);
>> +		return 0;
>> +	}
>
> Is there a need to add a new API? Could of_get_mac_address() be
> extended to look in NVMEM? The MAC driver does not care. It is saying,
> using OF get me a MAC address. One API seems sufficient, and would
> mean you don't need to change the MAC drivers.

It's what I intended to do, but there were two problems with that:
- of_get_mac_address() returns a pointer to constant data in memory, but 
the nvmem functions return an allocated memory object that must be freed 
after use. This changes the way the call is to be made.
- The nvmem functions need the "struct device" pointer as well, while 
of_get_mac_address() only gets passed the DT node.

One approach would be to deprecate the of_get_mac_address() interface 
and migrate existing drivers to the of_get_nvmem_mac_address() interface.


-- 
Mike Looijmans
