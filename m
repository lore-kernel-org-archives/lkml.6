Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030278AbeCALcs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:32:48 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36500 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030264AbeCALcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:32:42 -0500
Subject: Re: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Samuel Holland <samuel@sholland.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-4-samuel@sholland.org>
 <20180228083214.h4oi2kmjjqmoyfhn@flea>
 <fdf86770-6f45-3b3c-50ea-7a8363894639@sholland.org>
 <20180301103259.nomjbwkw4xbvhbfv@flea>
From: Andre Przywara <andre.przywara@arm.com>
Message-ID: <db1bc925-699e-14e7-f3fb-4dc83e2f6640@arm.com>
Date: Thu, 1 Mar 2018 11:32:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301103259.nomjbwkw4xbvhbfv@flea>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/03/18 10:32, Maxime Ripard wrote:
> On Wed, Feb 28, 2018 at 11:19:11AM -0600, Samuel Holland wrote:
>> Hi,
>>
>> On 02/28/18 02:32, Maxime Ripard wrote:
>>> On Tue, Feb 27, 2018 at 08:27:14PM -0600, Samuel Holland wrote:
>>>> +	/*
>>>> +	 * The failure path should not disable the clock or assert the reset,
>>>> +	 * because the PSCI implementation in firmware relies on this device
>>>> +	 * being functional. Claiming the clock in this driver is required to
>>>> +	 * prevent Linux from turning it off.
>>>> +	 */
>>>> +	ret = clk_prepare_enable(clk);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "Failed to enable bus clock: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>
>>> You don't need it to be always on though. You only need it to be
>>> enabled when you access the registers (on both sides I guess?). So you
>>> could very well enable the clock in your registers accessors in Linux,
>>> and do the same in the ARISC firmware. That should work.
>>
>> It does need to always be on because the *PSCI* implementation (ATF) also uses
>> SCPI concurrently with Linux (on a separate channel). Turning off the clock
>> anywhere in Linux could turn it off in the middle of a PSCI SCPI call on a
>> different CPU, causing ATF to hang in EL3 (which would be very bad).
> 
> Then the above code doesn't fix anything. You should mark the clock
> critical, otherwise that clock will be turned off if the driver is
> compiled as a module and not loaded (or loaded later), or if the
> driver is not even compiled in.

... or if the module gets unloaded for some reason. So yes, I agree.
Actually I was hitting this problem before on several occasions:
- If firmware (either ATF or on the ARISC) wants to check temperatures,
it needs to rely on Linux not turning off the THS clock - which it does
at the moment when there is no Linux driver.
- If an EFI framebuffer needs to keep running in Linux, we should not
turn off the HDMI and DE clocks. simplefb solves this, but efifb has no
simple way of copying this approach.
- If a type 1 hypervisor like Xen uses the serial console (and exports a
virtual console to the guest), Linux turns off the now apparently unused
UART0 gate clock, killing Xen's console. So booting Xen on Allwinner
requires clk_ignore_unused at the moment.

There are ways to mitigate or workaround each one of these, but I was
wondering if we should look at a more general approach.

The most flexible seems to have some "clock victim" DT node, somewhat
mimicking the simplefb solution: One DT node which just references
clocks that are used by other (firmware) components in the system and
which can't be protected otherwise.
Normally this node would be empty, but firmware can add clock references
the moment it needs one clock. So ATF could add the THS clock, and Xen
could add the UART0 gate clock. This could be done at runtime by the
firmware or hypervisor. Xen for instance already amends the DT before
passing it on to Dom0, so copying all the clock references from the UART
to this node would be easy to implement.

Does that sound worthwhile to pursue? I could sketch up something if
that makes sense.

Cheers,
Andre.
