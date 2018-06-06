Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6AA760263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbeFFHAh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:00:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41349 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbeFFHAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:00:35 -0400
X-Google-Smtp-Source: ADUXVKKYov3KVJ3Xz8HdhsZCZ2HrABhj3LFK25PqP7y2yo9yWXPJts11KzlX509JhdfR0doM7gKfag==
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180605172805.GD30381@bhelgaas-glaptop.roam.corp.google.com>
Date: Wed, 6 Jun 2018 14:58:52 +0800
Cc: Ryankao <ryankao@realtek.com>,
        "jrg.otte@gmail.com" <jrg.otte@gmail.com>,
        David Miller <davem@davemloft.net>,
        Hayes Wang <hayeswang@realtek.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "romieu@fr.zoreil.com" <romieu@fr.zoreil.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hau <hau@realtek.com>
Content-Transfer-Encoding: 8bit
Message-Id: <C2132983-62FC-4099-892D-DD9E5F6587FC@canonical.com>
References: <20180605045812.17977-1-kai.heng.feng@canonical.com>
 <9D9E2AF1-CD59-425B-85E9-DB89D620CA67@canonical.com>
 <B01FA80E1422A647BEB597328C544223D30B8F90@RTITMBSV05.realtek.com.tw>
 <20180605172805.GD30381@bhelgaas-glaptop.roam.corp.google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bjorn,

at 01:28, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Jun 05, 2018 at 06:34:09AM +0000, Ryankao wrote:
>> Add realtek folk Hau
>>
>> -----Original Message-----
>> From: Kai Heng Feng [mailto:kai.heng.feng@canonical.com]
>> Sent: Tuesday, June 05, 2018 1:02 PM
>> To: jrg.otte@gmail.com
>> Cc: David Miller <davem@davemloft.net>; Hayes Wang  
>> <hayeswang@realtek.com>; hkallweit1@gmail.com; romieu@fr.zoreil.com;  
>> Linux Netdev List <netdev@vger.kernel.org>; Linux Kernel Mailing List  
>> <linux-kernel@vger.kernel.org>; Ryankao <ryankao@realtek.com>
>> Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
>>
>> Hi Jörg Otte,
>>
>> Can you give this patch a try?
>>
>> Since you are the only one that reported ALDPS/ASPM regression,
>>
>> And I think this patch should solve the issue you had [1].
>>
>> Hopefully we don't need to go down the rabbit hole of  
>> blacklist/whitelist...
>>
>> Kai-Heng
>>
>> [1] https://lkml.org/lkml/2013/1/5/36
>
> I have no idea what ALDPS is.  It's not mentioned in the PCIe spec, so
> presumably it's some Realtek-specific thing.  ASPM is a generic PCIe
> thing.  Changes to these two things should be in separate patches so
> they don't get tangled up.

Sure, I'll split them in two. I'll also consult with Realtek to explain  
what ALDPS actually does.

>
>>> On Jun 5, 2018, at 12:58 PM, Kai-Heng Feng
>>> <kai.heng.feng@canonical.com>
>>> wrote:
>>>
>>> This patch reinstate ALDPS and ASPM support on r8169.
>>>
>>> On some Intel platforms, ASPM support on r8169 is the key factor to
>>> let Package C-State achieve PC8. Without ASPM support, the deepest
>>> Package C-State can hit is PC3. PC8 can save additional ~3W in
>>> comparison with PC3.
>>>
>>> This patch is from Realtek.
>>>
>>> Fixes: e0c075577965 ("r8169: enable ALDPS for power saving")
>>> Fixes: d64ec841517a ("r8169: enable internal ASPM and clock request
>>> settings")
>
>>> +3507,15 @@ static void rtl8168e_1_hw_phy_config(struct
>>> rtl8169_private *tp)
>>>  	rtl_writephy(tp, 0x0d, 0x4007);
>>>  	rtl_writephy(tp, 0x0e, 0x0000);
>>>  	rtl_writephy(tp, 0x0d, 0x0000);
>>> +
>>> +	/* Check ALDPS bit, disable it if enabled */
>>> +	rtl_writephy(tp, 0x1f, 0x0000);
>>> +	if (enable_aldps)
>>> +		rtl_w0w1_phy(tp, 0x15, 0x1000, 0x0000);
>>> +	else if (rtl_readphy(tp, 0x15) & 0x1000)
>>> +		rtl_w0w1_phy(tp, 0x15, 0x0000, 0x1000);
>
> There's a lot of repetition of this code with minor variations.  You
> could probably factor it out and make it more concise and more
> readable.

You are right. Will do.

>
>>> +static void rtl8169_check_link_status(struct net_device *dev,
>>> +				      struct rtl8169_private *tp) {
>>> +	struct device *d = tp_to_dev(tp);
>>> +
>>> +	if (tp->link_ok(tp)) {
>>> +		rtl_link_chg_patch(tp);
>>> +		/* This is to cancel a scheduled suspend if there's one. */
>>> +		if (pm_request_resume(d))
>>> +			_rtl_reset_work(tp);
>>> +		netif_carrier_on(dev);
>>> +		if (net_ratelimit())
>>> +			netif_info(tp, ifup, dev, "link up\n");
>>> +	} else {
>>> +		netif_carrier_off(dev);
>>> +		netif_info(tp, ifdown, dev, "link down\n");
>>> +		pm_runtime_idle(d);
>>> +	}
>>> +}
>
> This function apparently just got moved around without changing
> anything.  That's fine, but the move should be in a separate patch to
> make the real changes easier to review.

It actually added a new condition to check the return value of  
pm_request_resume().

It's probably a bogus check though. I'll ask Realtek why they did this.

>
>>> @@ -7649,8 +7757,12 @@ static int rtl_init_one(struct pci_dev *pdev,
>>> const struct pci_device_id *ent)
>>>
>>>  	/* disable ASPM completely as that cause random device stop working
>>>  	 * problems as well as full system hangs for some PCIe devices users */
>>> -	pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |
>>> -				     PCIE_LINK_STATE_CLKPM);
>>> +	if (!enable_aspm) {
>>> +		pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S |
>>> +					     PCIE_LINK_STATE_L1 |
>>> +					     PCIE_LINK_STATE_CLKPM);
>>> +		netif_info(tp, probe, dev, "ASPM disabled\n");
>>> +	}
>
> ASPM is a generic PCIe feature that should be configured by the PCI
> core without any help from the device driver.
>
> If code in the driver is needed, that means either the PCI core is
> doing it wrong and we should fix it there, or the device is broken and
> the driver is working around the erratum.
>
> If this is an erratum, you should include details about exactly what's
> broken and (ideally) a URL to the published erratum.  Otherwise this
> is just unmaintainable black magic and likely to be broken by future
> ASPM changes in the PCI core.
>
> ASPM configuration is done by the PCI core before drivers are bound to
> the device.  If you need device-specific workarounds, they should
> probably be in quirks so they're done before the core does that ASPM
> configuration.

You are right.

I think calling pci_disable_link_state() is unnecessary, I'll also consult  
with Realtek about this.

I'll also do some testing and send a separate patch to remove  
pci_disable_link_state() for -rc kernel to test if this is something really  
needed.

Kai-Heng

>
>>> /* enable device (incl. PCI PM wakeup and hotplug setup) */
>>>  	rc = pcim_enable_device(pdev);
>>> --
>>> 2.17.0
>>
>> ------Please consider the environment before printing this e-mail.
