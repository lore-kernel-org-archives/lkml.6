Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0796860767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932261AbeFFGsp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:48:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41218 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932164AbeFFGsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:48:43 -0400
X-Google-Smtp-Source: ADUXVKLmAxjgmAWAq+lggAxTjQuqkhfuoH6vUYL6+PXCFAg6J+B09Ji7pNgrNjFY8BCh+2kxzouG0A==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] r8169: Reinstate ALDPS and ASPM support
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180605141114.GC14873@lunn.ch>
Date: Wed, 6 Jun 2018 14:47:36 +0800
Cc: David Miller <davem@davemloft.net>,
        Hayes Wang <hayeswang@realtek.com>, hkallweit1@gmail.com,
        romieu@fr.zoreil.com, Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ryankao <ryankao@realtek.com>
Content-Transfer-Encoding: 7bit
Message-Id: <8BAED2AC-DA94-4F63-BA16-EB3D54649BC5@canonical.com>
References: <20180605045812.17977-1-kai.heng.feng@canonical.com>
 <20180605141114.GC14873@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 22:11, Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Jun 05, 2018 at 12:58:12PM +0800, Kai-Heng Feng wrote:
>> This patch reinstate ALDPS and ASPM support on r8169.
>>
>> On some Intel platforms, ASPM support on r8169 is the key factor to let
>> Package C-State achieve PC8. Without ASPM support, the deepest Package
>> C-State can hit is PC3. PC8 can save additional ~3W in comparison with
>> PC3.
>>
>> This patch is from Realtek.
>>
>> Fixes: e0c075577965 ("r8169: enable ALDPS for power saving")
>> Fixes: d64ec841517a ("r8169: enable internal ASPM and clock request  
>> settings")
>>
>> Cc: Ryankao <ryankao@realtek.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/net/ethernet/realtek/r8169.c | 190 +++++++++++++++++++++------
>>  1 file changed, 151 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169.c  
>> b/drivers/net/ethernet/realtek/r8169.c
>> index 75dfac0248f4..a28ef20be221 100644
>> --- a/drivers/net/ethernet/realtek/r8169.c
>> +++ b/drivers/net/ethernet/realtek/r8169.c
>> @@ -319,6 +319,8 @@ static const struct pci_device_id rtl8169_pci_tbl[]  
>> = {
>>
>>  MODULE_DEVICE_TABLE(pci, rtl8169_pci_tbl);
>>
>> +static int enable_aspm = 1;
>> +static int enable_aldps = 1;
>>  static int use_dac = -1;
>>  static struct {
>>  	u32 msg_enable;
>> @@ -817,6 +819,10 @@ struct rtl8169_private {
>>
>>  MODULE_AUTHOR("Realtek and the Linux r8169 crew <netdev@vger.kernel.org>");
>>  MODULE_DESCRIPTION("RealTek RTL-8169 Gigabit Ethernet driver");
>> +module_param(enable_aspm, int, 0);
>> +MODULE_PARM_DESC(enable_aspm, "Enable ASPM");
>> +module_param(enable_aldps, int, 0);
>> +MODULE_PARM_DESC(enable_aldps, "Enable ALDPS");
>
> Hi Kai
>
> No module parameter please. Just turn it on by default. Assuming
> testing shows works.

Hi Andrew,

Sure.

Do you think we should also strip out the enable/disable logic?

Or just remove the parameter?

Kai-Heng

>
> 	Andrew
