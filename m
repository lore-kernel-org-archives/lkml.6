Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93777C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C77020823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfARJ3w convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:29:52 -0500
Received: from emcscan.emc.com.tw ([192.72.220.5]:40447 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARJ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:29:51 -0500
Received: from unknown (HELO elanic) ([192.168.10.6])
  by emcscan.emc.com.tw with ESMTP; 18 Jan 2019 17:29:48 +0800
Received: from elanic (elanic.emc.com.tw [127.0.0.1])
        by elanic (Postfix) with ESMTP id 76F793CAA48;
        Fri, 18 Jan 2019 17:29:47 +0800 (CST)
Received: from nb92073 (unknown [192.168.33.46])
        by elanic (Postfix) with ESMTP id 55BB83C9A1A;
        Fri, 18 Jan 2019 17:29:47 +0800 (CST)
From:   =?big5?B?ufmxUrph?= <kt.liao@emc.com.tw>
To:     "'Kai Heng Feng'" <kai.heng.feng@canonical.com>,
        "'Benjamin Tissoires'" <benjamin.tissoires@redhat.com>
Cc:     "'Dmitry Torokhov'" <dmitry.torokhov@gmail.com>,
        "'open list:HID CORE LAYER'" <linux-input@vger.kernel.org>,
        "'lkml'" <linux-kernel@vger.kernel.org>
References: <20190117092948.32079-1-kai.heng.feng@canonical.com> <CAO-hwJKyBHM1Yy8=pQrbDoArTOX4=8G6f0jECv4x1mth+LZZDw@mail.gmail.com> <0BD3A587-B7B6-4C99-8F87-187394FF6EFC@canonical.com>
In-Reply-To: <0BD3A587-B7B6-4C99-8F87-187394FF6EFC@canonical.com>
Subject: RE: [PATCH 1/1] Input: elantech: Use SMBus based on bus info
Date:   Fri, 18 Jan 2019 17:29:48 +0800
Message-ID: <008c01d4af10$5b157f20$11407d60$@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="big5"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHJ0ez6sNBF33KjOgYLuyaFbXnUWQExGMrGAaD412qls+jlsA==
Content-Language: zh-tw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Kai Heng Feng [mailto:kai.heng.feng@canonical.com] 
Sent: Friday, January 18, 2019 12:15 AM
To: Benjamin Tissoires
Cc: Dmitry Torokhov; ¹ù±Rºa; open list:HID CORE LAYER; lkml
Subject: Re: [PATCH 1/1] Input: elantech: Use SMBus based on bus info



> On Jan 17, 2019, at 10:42 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> 
> Hi Kai-Heng,
> 
> On Thu, Jan 17, 2019 at 10:30 AM Kai-Heng Feng 
> <kai.heng.feng@canonical.com> wrote:
>> 
>> There are some new HP laptops with Elantech touchpad don't support 
>> multitouch.
>> 
>> Both ETP_BUS_SMB_HST_NTFY_ONLY and ETP_BUS_PS2_SMB_HST_NTFY devices 
>> can use SMBus to support 5 fingers touch, so we need to chech them too.
>> 
>> So use elantech_use_host_notify() to do a more thouroughly check.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/input/mouse/elantech.c | 58 
>> +++++++++++++++++-----------------
>> 1 file changed, 29 insertions(+), 29 deletions(-)
>> 
>> diff --git a/drivers/input/mouse/elantech.c 
>> b/drivers/input/mouse/elantech.c index 9fe075c137dc..5bcf1c147eb1 
>> 100644
>> --- a/drivers/input/mouse/elantech.c
>> +++ b/drivers/input/mouse/elantech.c
>> @@ -1799,6 +1799,34 @@ static int elantech_create_smbus(struct psmouse
*psmouse,
>>                                  leave_breadcrumbs); }
>> 
>> +static bool elantech_use_host_notify(struct psmouse *psmouse,
>> +                                    struct elantech_device_info 
>> +*info) {
>> +       if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
>> +               return true;
>> +
>> +       switch (info->bus) {
>> +       case ETP_BUS_PS2_ONLY:
>> +               /* expected case */
>> +               break;
>> +       case ETP_BUS_SMB_ALERT_ONLY:
>> +               /* fall-through  */
>> +       case ETP_BUS_PS2_SMB_ALERT:
>> +               psmouse_dbg(psmouse, "Ignoring SMBus provider through
alert protocol.\n");
>> +               break;
>> +       case ETP_BUS_SMB_HST_NTFY_ONLY:
>> +               /* fall-through  */
>> +       case ETP_BUS_PS2_SMB_HST_NTFY:
>> +               return true;
>> +       default:
>> +               psmouse_dbg(psmouse,
>> +                           "Ignoring SMBus bus provider %d.\n",
>> +                           info->bus);
>> +       }
>> +
>> +       return false;
>> +}
>> +
>> /**
>>  * elantech_setup_smbus - called once the PS/2 devices are enumerated
>>  * and decides to instantiate a SMBus InterTouch device.
>> @@ -1818,7 +1846,7 @@ static int elantech_setup_smbus(struct psmouse
*psmouse,
>>                 * i2c_blacklist_pnp_ids.
>>                 * Old ICs are up to the user to decide.
>>                 */
>> -               if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
>> +               if (!elantech_use_host_notify(psmouse, info) ||
> 
> That was my initial approach of the series, but I ended up being more 
> conservative as this would flip all of the existing elantech SMBUS 
> capable touchpads to use elan_i2c.
> And I didn't want to deal with 4/5 year old laptops that suddenly broke.
> 
> So I wonder if you can restrict this default change to the recent 
> laptops (let's say 2018+). Maybe by looking at their FW version or 
> something else in the DMI?

It was KT who told me that I should use ETP_BUS_PS2_SMB_HST_NTFY.

As for date, KT still knows better than me.

KT,
Can you name a year which is safe enough to enable SMBus?

I have discussed it internally. 
The internal rule for FW's SMbus implementation is stable after 2018
If you meet some special case, please let me know.

BTW, The SMbus supporting is requested by HP this time, and there are plenty
of HP laptop use old IC
which doesn't meet " ETP_NEW_IC_SMBUS_HOST_NOTIFY".

Elan touchpad works well in PS/2 for HP, because it don't support
TrackPoint.
You may let old HP platform work as PS/2 for safety.

Thanks
KT

Kai-Heng

> 
> Cheers,
> Benjamin
> 
>>                    psmouse_matches_pnp_id(psmouse,
i2c_blacklist_pnp_ids))
>>                        return -ENXIO;
>>        }
>> @@ -1838,34 +1866,6 @@ static int elantech_setup_smbus(struct psmouse
*psmouse,
>>        return 0;
>> }
>> 
>> -static bool elantech_use_host_notify(struct psmouse *psmouse,
>> -                                    struct elantech_device_info *info)
>> -{
>> -       if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
>> -               return true;
>> -
>> -       switch (info->bus) {
>> -       case ETP_BUS_PS2_ONLY:
>> -               /* expected case */
>> -               break;
>> -       case ETP_BUS_SMB_ALERT_ONLY:
>> -               /* fall-through  */
>> -       case ETP_BUS_PS2_SMB_ALERT:
>> -               psmouse_dbg(psmouse, "Ignoring SMBus provider through
alert protocol.\n");
>> -               break;
>> -       case ETP_BUS_SMB_HST_NTFY_ONLY:
>> -               /* fall-through  */
>> -       case ETP_BUS_PS2_SMB_HST_NTFY:
>> -               return true;
>> -       default:
>> -               psmouse_dbg(psmouse,
>> -                           "Ignoring SMBus bus provider %d.\n",
>> -                           info->bus);
>> -       }
>> -
>> -       return false;
>> -}
>> -
>> int elantech_init_smbus(struct psmouse *psmouse) {
>>        struct elantech_device_info info;
>> --
>> 2.17.1

