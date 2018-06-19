Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC44DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641C720836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641C720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938068AbeFSNNX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:13:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53854 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937707AbeFSNNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:13:20 -0400
Received: from [123.118.222.68] (helo=[192.168.1.10])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1fVGRg-0005Vp-R4; Tue, 19 Jun 2018 13:13:17 +0000
Subject: Re: [PATCH] Input: elan: enable middle button of touchpads on
 ThinkPad P52
To:     Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc:     linux-input <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org, KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20180612070906.5305-1-aaron.ma@canonical.com>
 <CAN+gG=EDc8WsC3MjbY1VnYyo7G1ZBUboM2_T-Zd8r322dOvwTA@mail.gmail.com>
From:   Aaron Ma <aaron.ma@canonical.com>
Openpgp: preference=signencrypt
Message-ID: <32d6c8c8-7662-3ab4-ca92-2357ca668f4b@canonical.com>
Date:   Tue, 19 Jun 2018 21:13:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAN+gG=EDc8WsC3MjbY1VnYyo7G1ZBUboM2_T-Zd8r322dOvwTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 08:21 PM, Benjamin Tissoires wrote:
> On Tue, Jun 12, 2018 at 9:10 AM Aaron Ma <aaron.ma@canonical.com> wrote:
>> PNPID is better way to identify the type of touchpads.
>> Enable middle button support on 2 types of touchpads on Lenovo P52.
>>
>> Cc: stable@vger.kernel.org
>> Cc: KT Liao <kt.liao@emc.com.tw>
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>> ---
>>  drivers/input/mouse/elantech.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
> Looks good to me:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Aaron, our internal tests show that the P52 shows a lot of lost
> synchronization in pre-v4.18 kernels. Do you have a fix for that too?
> 

https://lkml.org/lkml/2018/5/28/694
should fix the sync issue.


> In v4.18 we need to fix the elan_i2c module as right now the touchpad
> is muted when booted with such a kernel.

Does this touchpad support elan_i2c?

Regards,
Aaron

> 
> Cheers,
> Benjamin
> 
>> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
>> index fb4d902c4403..67b061dd4494 100644
>> --- a/drivers/input/mouse/elantech.c
>> +++ b/drivers/input/mouse/elantech.c
>> @@ -1175,6 +1175,12 @@ static const struct dmi_system_id elantech_dmi_has_middle_button[] = {
>>         { }
>>  };
>>
>> +static const char * const middle_button_pnp_ids[] = {
>> +       "LEN2131", /* ThinkPad P52 w/ NFC */
>> +       "LEN2132", /* ThinkPad P52 */
>> +       NULL
>> +};
>> +
>>  /*
>>   * Set the appropriate event bits for the input subsystem
>>   */
>> @@ -1194,7 +1200,8 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>>         __clear_bit(EV_REL, dev->evbit);
>>
>>         __set_bit(BTN_LEFT, dev->keybit);
>> -       if (dmi_check_system(elantech_dmi_has_middle_button))
>> +       if (dmi_check_system(elantech_dmi_has_middle_button) ||
>> +               psmouse_matches_pnp_id(psmouse, middle_button_pnp_ids))
>>                 __set_bit(BTN_MIDDLE, dev->keybit);
>>         __set_bit(BTN_RIGHT, dev->keybit);
>>
>> --
>> 2.17.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
