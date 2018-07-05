Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE27C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BF324140
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BF324140
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=helios.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeGEKw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:52:28 -0400
Received: from proxy.helios.de ([193.141.98.37]:50309 "EHLO proxy.helios.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753454AbeGEKw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:52:26 -0400
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jul 2018 06:52:25 EDT
Received: from hpx.helios.de (hpx.helios.de [172.16.0.106])
        by proxy.helios.de (Postfix) with ESMTP id 420FB20A34;
        Thu,  5 Jul 2018 12:43:37 +0200 (CEST)
Received: from macht.dyn.helios.de (proxy.helios.de [172.16.0.2])
        by hpx.helios.de (Postfix) with ESMTP id 302FB1F936;
        Thu,  5 Jul 2018 12:43:37 +0200 (CEST)
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
To:     Stefan Schmidt <stefan@datenfreihafen.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?Q?Konstantin_B=c3=b6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>, contact@snootlab.com,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        lora@radioshuttle.de, Alexander Graf <agraf@suse.de>,
        =?UTF-8?Q?Michal_Kube=c4=8dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
References: <20180701110804.32415-1-afaerber@suse.de>
 <487df785-ddf5-ed81-a253-6afb7f2de811@datenfreihafen.org>
From:   Helmut Tschemernjak <helmut@helios.de>
Organization: HELIOS Software GmbH
Message-ID: <5aac9ea5-484c-1b3b-8058-50e11e8d7a9a@helios.de>
Date:   Thu, 5 Jul 2018 12:43:36 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <487df785-ddf5-ed81-a253-6afb7f2de811@datenfreihafen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andreas,

I put the kernel support for the SX1276 LoRa chip in question. I don’t 
think that this kind of device should be in the Linux kernel.

Here are a few facts to consider:
- A LoRa transaction is very slow  (e.g. SF7 needs about 210 ms, for 
SF12 6280 ms) for 12 bytes user data with acknowledge.

- There are many different implementations for the antenna switch, 
switching between receiving/sending, PA-BOOST, 433, 868/915 MHz. (I know 
SX1276 Heltec ESP32, SX1276 Murata, RFM95-(1276), SX1276 Heltec 
STM32-L4) they are all different regarding this.

- The LoRa chip device ID is only 8-bit which is not sufficient for 
larger networks, e.g. our RadioShuttle protocol uses compressed 32-bit 
device IDs.

- The chip can do MTU sizes up to 2048 bytes, most protocols use less 
than 250 bytes.

- Applications do on-the-fly channel and spreading factor switching 
which makes it more difficult for the configuration.

- The chip supports Lora modulation as well as  FSK, GFSK, MSK, GMSK, 
and OOK modulation, for some use cases the other modulations are of 
interest, e.g. to communicated with other devices.

- Power saving modes, like sleep, suspend may be required for battery 
operation.

- Cad detection is very flexible and can be differently used.

- LoRa preamble may be different depending on the protocol used.

- The new Lora chip SX1262 / 68 (successor of the SX1276) has different 
hardware and all different registers, it is driver incompatible with the 
SX1276. It needs an entire new driver.

- The device is not multi-process capable (only a single process can 
communicate with it).

- There are SX1276 LoRa modules with a build-in protocol (LoRaWAN and 
RAW) via a serial connection only, again complete different API compared 
the SX1276 chip. Software updates for this devices are difficult.

- I am even convinced that the LoRaWAN protocol with the concentrator 
concept is not good, the peer to peer communication and a standard MQTT 
gateway (what we do) is way more flexible.

For all this reasons, I feel a user level driver task implementation is 
way more flexible. I did a lot of work/enhancements on the SX1276 link 
level driver from Semtech, it is available and maintained on mbed.org 
and supports mbed-os, Arduino and is prepared for Linux.
https://os.mbed.com/users/Helmut64/code/SX1276GenericLib/

Protocols e.g. our RadioShuttle LoRa peer to peer protocol or the 
LoRaWAN protocol can run on top of the SX1276GenericLib. We may should 
focus on such a driver library getting supported for multiple OS's (Win, 
Linux, mbed, Ardino, etc.)

Again I feel a Linux kernel device driver for the SX1276 chip make 
little sense for me.

Regards
Helmut Tschemernjak (www.radioshuttle.de, www.helios.de)
