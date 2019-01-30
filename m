Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8F1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C9121473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfA3Bmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:42:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:60374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbfA3Bmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:42:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD3B8AD0A;
        Wed, 30 Jan 2019 01:42:30 +0000 (UTC)
Subject: Re: [RFC net-next 1/4] net: Reserve protocol identifiers for EnOcean
To:     Alexander Aring <aring@mojatatu.com>
Cc:     linux-lpwan@lists.infradead.org, linux-wpan@vger.kernel.org,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        support@enocean.com, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20190129050130.10932-1-afaerber@suse.de>
 <20190129050130.10932-2-afaerber@suse.de>
 <20190129125708.plsbgcpcwhtezgo5@x220t>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <6a220f80-1c75-12e6-1f8c-53b76412257a@suse.de>
Date:   Wed, 30 Jan 2019 02:42:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190129125708.plsbgcpcwhtezgo5@x220t>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Am 29.01.19 um 13:57 schrieb Alexander Aring:
> On Tue, Jan 29, 2019 at 06:01:27AM +0100, Andreas Färber wrote:
>> EnOcean wireless technology is based on ASK (ERP1) and FSK (ERP2) modulations
>> for sub-GHz and on IEEE 802.15.4 for 2.4 GHz.
>>
> 
> I am not sure what you try to do here. If I see that correctly you
> want to add for some special protocol vendor specific transceiver which
> is underneath an 802.15.4 transceiver a new ARPHRD type and even more
> for each modulation what it supports?

No. EnOcean uses a 4-byte node ID across PHY layers, which I am using a
single ARPHRD_ENOCEAN for (which you conveniently cut off above).

As indicated above, the 868 MHz transceiver is _not_ using 802.15.4 PHY
or MAC to my knowledge. It does sound like you spotted "IEEE 802.15.4"
and literally blended out all the rest...

> 
> If it's a 802.15.4 transceiver why not using the 802.15.4 subsystem?
> 
> For me it sounds more like a HardMAC transceiver driver for doing the
> vendor protocol. The different modulations is part of a 802.15.4 phy
> device class. Similar like in wireless.

I've tried to design this exactly so that one _could_ implement it based
on 802.15.4 PHY framework for 2.4 GHz or based on an FSK PHY for sub-GHz
as a soft-MAC, layered similarly to LoRaWAN vs. LoRa, alongside the ESP
serdev driver in this series.

In ESP3 the only 802.15.4 specific operations are getting/setting the
channel (COMMAND_2_4 packet type), and there's a CO_GET_FREQUENCY_INFO
command to discover frequency and protocol, with 802.15.4 having a
different ID than ERP2 (and I spot a value 0x30 for "Long Range" :-)).
So in theory it might be possible to instantiate an 802.15.4 PHY after
discovering that ESP3 value, but neither is this a generic 802.15.4 PHY
nor a generic FSK PHY, and none of that relates to above ARPHRD really.

PF_PACKET with SOCK_DGRAM for ETH_P_ERP2 gives me the subtelegram
contents to transmit via ESP, whereas SOCK_RAW would give the full frame
to transmit via FSK PHY. By avoiding a custom PF_ENOCEAN we seem to lose
the ability to prepend any protocol headers on the skb for SOCK_DGRAM.

Did you actually read my P.S. in the cover letter? I was glad to avoid
much PF_ socket boilerplate code here (as a playground for LoRa), and
now you're complaining about a single ARPHRD constant! :-/
By that standard we could stop implementing anything new... If you're
worried about number space, why has no one commented on the values added
for LoRa and other previous wireless technologies? No one had any such
comments on my LoRa RFC, nor on Jian-Hong's LoRaWAN patches, so I've
been reserving new ARPHRD_ constants for each technology I work on. If
ARPHRD_NONE would be a better value to use for PHY layers, no one
bothered to point it out so far! Nor did anyone suggest to Jian-Hong to
reuse ARPHRD_EUI64! And yet I spot nothing more suitable for EnOcean
addresses than a custom value. Fact is, the net_device wants some value.
Note that you have two ARPHRD constants assigned for 802.15.4 alone, so
please be fair to others.

An 802.15.4 PHY won't help me for 868 MHz FSK - by my reading 802.15.4
is PSK (BPSK/OQPSK), thus incompatible with ASK/OOK and FSK/MSK.

As noted in the cover letter, Semtech chips have FSK and OOK support
alongside LoRa modulation; so I am looking into FSK PHY support, both
for those chips as well as for some pure FSK/OOK transceivers posted to
linux-lpwan list (and potentially more, given time):
https://lists.infradead.org/pipermail/linux-lpwan/2019-January/000116.html
https://lists.infradead.org/pipermail/linux-lpwan/2019-January/000117.html
https://en.opensuse.org/User:A_faerber/LoRa_interop

Therefore an FSK PHY's netlink interface will need to be able to handle
the requirements of upper-layer protocols, such as:
* Wireless M-Bus (which I could not yet find a suitable 868MHz hard-MAC
for to test against, only 169MHz; Si4432 has an Application Note AN451),
* KNX RF (which I have not come across a hard-MAC for either),
* Sigfox downstream (cf. mm002 LoRa driver as hard-MAC; no public docs),
* Z-Wave (not enough docs to implement much more for now), and here
* EnOcean Radio Protocol 2.

In general I want to make sure my implementations can work with both
soft- and hard-MAC hardware out there, as demonstrated for LoRaWAN.
Pointing a user with hard-MAC device to a theoretical generic subsystem
of your preference doesn't help them, nor does it help to split the
community into separate hard-MAC vs. soft-MAC implementation camps that
make it hard for users to switch.
* For example, when looking for how to actually use the Pine64 Z-Wave
adapter, back in the day I merely found an OpenHAB Raspbian(?) image
that as an openSUSE contributor I would surely not block my board with;
no explanations, no instructions, nothing. And when you have a pure Java
application on the one hand and a C/Python/whatever application on the
other, chances are that the kernel is the only common point of reuse. I
surely mentioned that I hate any userspace applications that attempt to
detect hardware on spidev/i2c-dev/tty without using the kernel-provided
facilities such as DT; finally, serdev allows to move any such
hardware-dependent tty code into the kernel - we just need to figure out
how to best expose functionality there (and ideally grow some more
helpers). Just note how patch 3/4 reuses the kernel's crc8
implementation instead of re-implementing it from scratch. Similarly I'd
love for my AT based LoRa drivers to share more serdev code, despite
line ending and response styles differing greatly (think
serdev_device_readline w/args?); binary protocols like ESP here are
luckily not affected as much. It could also use some more/better
documentation, some of the return values are wrong.
* As another example, we seem to be lacking a generic SDR subsystem:
People with SDR hardware seem to use either downstream kernel modules,
possibly application-generated, or closed-source userspace libraries?
Neither seems able to currently reuse the net subsystem for protocols.
And yet I've been asked repeatedly to design drivers in a way they could
be used with SDR, too, but without any way to actually test that today.
Has anyone talked to the SDR chipset/equipment vendors to remedy that?
The one I was in contact with simply chose not to reply again to date...

For ETH_P_ we seem to be far away from 0xffff, so I don't see a problem
there? Not just was it the easiest thing to implement & test short-term,
but as outlined in the cover letter I saw no way here to turn that into
a non-net-subsystem because the data transmitted is not self-describing
(mostly battery-less sensors/actuators with ca. 4 byte data payload).
You must know that your device with id 0x12345678 conforms to profile X.

Is describing remote devices in DT an option? (CC'ing Rob and Jonathan)

/.../uart@foo {
	enocean {
		compatible = "enocean,esp3";
		#address-cells = <1>;
		#size-cells = <0>;

		window-handle@41424344 {
			compatible = "manufacturer1,handle";
			reg = <0x41424344>;
			enocean,equipment-profile = <1 2 3>;
			#io-channel-cells = <1>;
		};

		light-switch@41424348 {
			compatible = "manufacturer2,rocker";
			reg = <0x41424348>;
			enocean,equipment-profile = <4 5 6>;
			#io-channel-cells = <2>;
		};
	};
};

Pro: This would allow to abstract sensors (iio?) and actuators (gpio?).
     Cf. https://patchwork.ozlabs.org/patch/1028209/ for comparison.
Con: How to deal with it on ACPI or on DT platforms without Overlays?
     How would the kernel preserve remote device state across reboots?

So no, I don't think we can or should shoehorn non-802.15.4 PHYs into
your ieee802154 PHY layer. If you see ways to share code between the
various wireless PHYs, that would be great, but at present it seems like
mostly boilerplate code with nothing in your phy struct applying to FSK
or LoRa. Compare my cfglora series pointed to and Xue Liu's recent sysfs
patch under discussion. If no more comments turn up on my cfglora series
I'll copy it into a cfgfsk, so that I can integrate both into sx127x as
a base for further discussions at Netdevconf. Thanks.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
