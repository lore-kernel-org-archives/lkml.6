Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeC3Php (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 11:37:45 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:54800 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752249AbeC3Phn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 11:37:43 -0400
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: DW MMC multislot support
Thread-Topic: DW MMC multislot support
Thread-Index: AQHTyD0JSeKceRkIz0KVQ7V0wLDfzA==
Date: Fri, 30 Mar 2018 15:37:39 +0000
Message-ID: <1522424259.32101.7.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.75]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CC2C62C4259CA4791F613D157505327@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2UFbo9R011980

Hi,

I have plans to add multislot support to DesignWare MMC driver.

As of today I have proof of concept for multislot DW MMC driver with two slots working
simultaneously:
I reverted all commits which remove previous implementation of "pseudo-multislot"
and add all required steps for changing slot number to __dw_mci_start_request function.

But I have several issues with set_ios function in multislot mode (as each slot
is registered as separate mmc host):
1) We can change clock for slot 1 while slot 0 is active.
2) We can disable one slot (by calling set_ios with 'power_mode' == MMC_POWER_OFF)
 which cause clock disable for all slots.
3) We can enable one slot (by calling set_ios with 'power_mode' == MMC_POWER_ON)
 which cause DMA and FIFO reset while another slot is active.
And so on...


Here is my ideas how to fix this:
1) In set_ios function we can simply store parameters
 (like clock speed/timings/bus width) to corresponding slot structure and apply
 them only in the beginning of __dw_mci_start_request function if current slot is
 changed.
 Another option is to choose maximum clock which is suitable for both slots
 instead of clock switch on every slot change.
2) Do all actions for slot disabling ('power_mode' == MMC_POWER_OFF) only if
 others slots are disabled too.
3) Do all actions for slot enabling ('power_mode' == MMC_POWER_ON) only if
 no slots are enabled.


Maybe you have any comments or remarks about this?
All comments and suggestions are more than welcome.
-- 
 Eugeniy Paltsev
