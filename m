Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933914AbeB1Tt1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:49:27 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:39943 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933687AbeB1TtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:49:25 -0500
X-Google-Smtp-Source: AG47ELuSmNHAIVdA43LeI744EDjWnshB81mcWwi/+2yXyF/iLLxqTjiPkN4zHQ7vEhEaA1PUp6l5of3OJ/PzNDyS1ro=
MIME-Version: 1.0
In-Reply-To: <20180228194449.GB30733@flint.armlinux.org.uk>
References: <20180228193612.29409-1-f.fainelli@gmail.com> <20180228193612.29409-6-f.fainelli@gmail.com>
 <20180228194449.GB30733@flint.armlinux.org.uk>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Wed, 28 Feb 2018 11:49:24 -0800
Message-ID: <CAAtXAHcdU-MuXk6qD+mM=WhCcHF8J2tQOwT-BFdyOLbdqNPfYQ@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] net: phy: marvell10g: Utilize gen10g_soft_reset()
To: Russell King <rmk@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian,

On Wed, Feb 28, 2018 at 11:44 AM, Russell King <rmk@armlinux.org.uk> wrote:
> On Wed, Feb 28, 2018 at 11:36:12AM -0800, Florian Fainelli wrote:
>> We do the same thing as the generic function: nothing, so utilize it.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/net/phy/marvell10g.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
>> index 8a0bd98fdec7..da014eae1476 100644
>> --- a/drivers/net/phy/marvell10g.c
>> +++ b/drivers/net/phy/marvell10g.c
>> @@ -75,11 +75,6 @@ static int mv3310_probe(struct phy_device *phydev)
>>   * Resetting the MV88X3310 causes it to become non-responsive.  Avoid
>>   * setting the reset bit(s).
>>   */
>> -static int mv3310_soft_reset(struct phy_device *phydev)
>> -{
>> -     return 0;
>> -}
>> -
>
> You do realise that getting rid of that function makes a nonsense of the
> comment above it - and removing the comment along with the function gets
> rid of the very important reason _why_ we have en empty reset method?
>
>>  static int mv3310_config_init(struct phy_device *phydev)
>>  {
>>       __ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
>> @@ -377,7 +372,7 @@ static struct phy_driver mv3310_drivers[] = {
>>                                 SUPPORTED_10000baseT_Full |
>>                                 SUPPORTED_Backplane,
>>               .probe          = mv3310_probe,
>> -             .soft_reset     = mv3310_soft_reset,
>> +             .soft_reset     = gen10g_soft_reset,
>>               .config_init    = mv3310_config_init,
>>               .config_aneg    = mv3310_config_aneg,
>>               .aneg_done      = mv3310_aneg_done,
>> --
>> 2.14.1
>>
>
> --
> Russell King
> ARM architecture Linux Kernel maintainer

FWIW I have a local patch that goes something like that, which I meant to send
at one point and forgot

Something like that:

 static int gen10g_soft_reset(struct phy_device *phydev)
 {
+       int val;
+
+       val = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_CTRL1);
+       if (val < 0)
+               return val;
+
+       val |= MDIO_CTRL1_RESET;
+       phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1, val);
+
 -       /* Do nothing for now */
        return 0;
 }

If that looks reasonable I can properly submit a patch,

Moritz
