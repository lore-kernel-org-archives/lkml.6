Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034057AbeBOQPk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:15:40 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33176 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034041AbeBOQPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:15:35 -0500
X-Google-Smtp-Source: AH8x226050fTgIrvrT7jWH/DyELZq/ax4wxulMjOZeSK2HmzZN26ty57VvRHpxgQTuKQPc5ndflNHw==
Subject: Re: [PATCH 0/2] power: supply: Fix AXP288 fallback when not needed
To: Carlo Caione <carlo@caione.org>, linux@endlessm.com, rjw@rjwysocki.net,
        lenb@kernel.org, sre@kernel.org, wens@csie.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
References: <20180214194201.24385-1-carlo@caione.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <acfd286f-cedc-930e-3810-8795b4bd7dbb@redhat.com>
Date: Thu, 15 Feb 2018 17:15:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214194201.24385-1-carlo@caione.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Carlo,

On 14-02-18 20:41, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> With commits af3ec837 and dccfae6d a blacklist was introduced to avoid
> using the ACPI drivers for AC and battery when a native PMIC driver was
> already present. While this is in general a good idea (because of broken
> DSDT or proprietary and undocumented ACPI opregions for the ACPI
> AC/battery devices) we have come across at least one CherryTrail laptop
> (ECS EF20EA) shipping the AXP288 together with a separate FG controller
> (a MAX17047) instead of the one embedded in the AXP288.

Thank you for the patches, the code looks good, but I think you need
to split them up a bit differently, the patches under drivers/acpi
need to be merged into a different subsys tree as those under
drivers/power/supply, so the "power: supply: ACPI/AXP288: Add quirks
for ECS EF20EA" needs to be split I believe.

Also the patches to files under drivers/acpi should have an
"ACPI: " prefix for their subject AFAIK.

Regards,

Hans




> This is the interesting analisys done by Hans de Goede (thank you):
> 
> Looking at the _BIX method of the BATC/PNP0C0A device, we see it referencing
> FG10:
> 
> Method (_BIX, 0, NotSerialized)  // _BIX: Battery Information Extend
> {
>      If (AVBL == One)
>      {
>          BUF2 = FG10 /* \_SB_.PCI0.I2C1.FG10 */
> 
> And FG10 is defined as:
> 
> Field (DVFG, BufferAcc, NoLock, Preserve)
> {
>      Connection (SMFG),
>      Offset (0x10),
>      AccessAs (BufferAcc, AttribBytes (0x02)),
>      FG10,   8
> }
> 
> With SMFG being defined as:
> 
> Name (SMFG, ResourceTemplate ()
> {
>      I2cSerialBusV2 (0x0036, ControllerInitiated, 0x000186A0,
>          AddressingMode7Bit, "\\_SB.PCI0.I2C1",
>          0x00, ResourceConsumer, , Exclusive,
>          )
> })
> 
> Looking for I2C1 address 0x0036 we find:
> 
> Device (ANFG)
> {
>      Name (_HID, "MAX17047" /* Fuel Gauge Controller */)  // _HID: Hardwa
>      Name (_CID, "MAX17047" /* Fuel Gauge Controller */)  // _CID: Compat
>      Name (_DDN, "Fuel Gauge Controller")  // _DDN: DOS Device Name
>      Name (RBUF, ResourceTemplate ()
>      {
>          I2cSerialBusV2 (0x0036, ControllerInitiated, 0x00061A80,
>              AddressingMode7Bit, "\\_SB.PCI0.I2C1",
>              0x00, ResourceConsumer, , Exclusive,
>              )
>          GpioInt (Level, ActiveLow, ExclusiveAndWake, PullNone, 0x0000,
>              "\\_SB.GPO3", 0x00, ResourceConsumer, ,
>              )
>              {   // Pin list
>                  0x0001
>              }
>      })
> 
> Where as the AXP288 PMIC is I2C7 address 0x034:
> 
> Device (PMI1)
> {
>      Name (_ADR, Zero)  // _ADR: Address
>      Name (_HID, "INT33F4" /* XPOWER PMIC Controller */)  // _HID: Ha
>      Name (_CID, "INT33F4" /* XPOWER PMIC Controller */)  // _CID: Co
>      Name (_DDN, "XPOWER PMIC Controller")  // _DDN: DOS Device Name
>      Name (_HRV, 0x03)  // _HRV: Hardware Revision
>      Name (_UID, One)  // _UID: Unique ID
> 
>      Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Setti
>      {
>          Name (SBUF, ResourceTemplate ()
>          {
>              I2cSerialBusV2 (0x0034, ControllerInitiated, 0x000F4240,
>                  AddressingMode7Bit, "\\_SB.PCI0.I2C7",
>                  0x00, ResourceConsumer, , Exclusive,
>                  )
> 
> So basically this laptopt is using a separate FG chip instead of the one
> embedded in the AXP288.
> 
> To have this correctly working we need basically to avoid the fallback on the
> AXP288 driver enabling again the ACPI AC/battery drivers and at the same time
> avoiding that the AXP288 FG driver is probed at all.
> 
> I'm still not fully convinced that having two different quirks (one to disable
> the blacklist and another to disable the AXP288 FG probing) is the right way to
> fix this. So any comment is welcome.
> 
> Carlo Caione (2):
>    power: supply: ACPI/AXP288: Add quirk to avoid using PMIC
>    power: supply: ACPI/AXP288: Add quirks for ECS EF20EA
> 
>   drivers/acpi/ac.c                        | 33 ++++++++++++++++++++++++--------
>   drivers/acpi/battery.c                   | 33 ++++++++++++++++++++++++--------
>   drivers/power/supply/axp288_fuel_gauge.c |  6 ++++++
>   3 files changed, 56 insertions(+), 16 deletions(-)
> 
