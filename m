Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751867AbeDENSW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:18:22 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7157 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751278AbeDENST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:18:19 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tejun Heo <tj@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC: Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org"
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] ata: ahci-platform: add reset control support
Thread-Topic: [PATCH] ata: ahci-platform: add reset control support
Thread-Index: AQHTzMQZUjD7lVbUeEu8qjF8anGqFaPyBeiA
Date: Thu, 5 Apr 2018 13:17:45 +0000
Message-ID: <e33f54ed-2848-9a4f-9669-7fada8c60326@st.com>
References: <1521768653-11824-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20180405095429.GA7506@ulmo>
In-Reply-To: <20180405095429.GA7506@ulmo>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <BE3B334EEE98F84BA88BFEA6331EA38F@st.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry

On 04/05/2018 11:54 AM, Thierry Reding wrote:
> On Fri, Mar 23, 2018 at 10:30:53AM +0900, Kunihiko Hayashi wrote:
>> Add support to get and control a list of resets for the device
>> as optional and shared. These resets must be kept de-asserted until
>> the device is enabled.
>>
>> This is specified as shared because some SoCs like UniPhier series
>> have common reset controls with all ahci controller instances.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
>>   drivers/ata/ahci.h                                 |  1 +
>>   drivers/ata/libahci_platform.c                     | 24 +++++++++++++++++++---
>>   3 files changed, 23 insertions(+), 3 deletions(-)
> 
> This causes a regression on Tegra because we explicitly request the
> resets after the call to ahci_platform_get_resources().

I confirm, we got exactly the same behavior on STi platform.

> 
>  From a quick look, ahci_mtk and ahci_st are in the same boat, adding the
> corresponding maintainers to Cc.
> 
> Patrice, Matthias: does SATA still work for you after this patch? This
> has been in linux-next since next-20180327.

SATA is still working after this patch, but a kernel warning is 
triggered due to the fact that resets are both requested by 
libahci_platform and by ahci_st driver.

Patrice

> 
> Given how this is one of the more hardware-specific bits, perhaps a
> better way to do this is to move reset handling into a Uniphier driver
> much like Tegra, Mediatek and ST?
> 
> That said, I don't see SATA support for any of the Socionext hardware
> either in the DT bindings or drivers/ata, so perhaps it'd be best to
> back this out again until we have something that's more well tested?
> 
> Thierry
> 
