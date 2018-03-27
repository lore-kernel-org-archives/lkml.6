Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeC0OAf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:00:35 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:55036 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752909AbeC0OAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:00:31 -0400
Subject: Re: [PATCH] Input: ALPS - add support for 73 03 28 devices (Thinkpad
 L570)
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Masaki Ota <masaki.ota@jp.alps.com>, Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>, Nir Perry <nirperry@gmail.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <7d5077ef-c185-c6b1-d602-df8d9f7dade3@secunet.com>
 <20180323143336.v26rvflt3oq5xppn@pali>
From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Organization: secunet Security Networks
Message-ID: <bbb6a2ea-c8d1-beae-1f83-c234f03d4d77@secunet.com>
Date: Tue, 27 Mar 2018 15:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323143336.v26rvflt3oq5xppn@pali>
Content-Type: text/plain; charset="utf-8"
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 65006A73-BE1A-49A5-86B0-9F78ECB9DD00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

oh ok, understood. Thanks for this hint.

So maybe there is something wrong with the alps_update_dual_info_ss4_v2
function or the reporting of the hardware.

alps_update_dual_info_ss4_v2 detects the ThinkPad L570 as ss4plus device
but not as dualpoint device. This means that the ALPS_DUALPOINT and the
ALPS_DUALPOINT_WITH_PRESSURE flag will not be set which results in a non
function trackstick and hardware mouse buttons. Each time I touch the
trackstick I get the message: "alps: Rejected trackstick packet from non
DualPoint device".

The value of otp[0][0] inside alps_update_dual_info_ss4_v2 is 0xCE. Are
there any ideas why it is not detected as dualpoint device?

Thank you & best regards,

Dennis

On 23.03.2018 15:33, Pali Rohár wrote:
> On Friday 23 March 2018 15:23:55 Dennis Wassenberg wrote:
>> The Lenovo Thinkpad L570 uses V8 protocol.
>> Add 0x73 0x03 0x28 devices to use V8 protovol which makes
>> trackstick and mouse buttons work with Lenovo Thinkpad L570.
>>
>> Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
>> ---
>>  drivers/input/mouse/alps.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> index dbe57da..5523d4e 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -136,6 +136,8 @@
>>  	{ { 0x73, 0x02, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
>>  	{ { 0x73, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 } },			/* Ahtec Laptop */
>>  	{ { 0x73, 0x02, 0x50 }, { ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS } },		/* Dell Vostro 1400 */
>> +	{ { 0x73, 0x03, 0x28 }, { ALPS_PROTO_V8, 0x18, 0x18,
>> +		ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESSURE | ALPS_BUTTONPAD } },		/* Lenovo L570 */
>>  };
>>  
>>  static const struct alps_protocol_info alps_v3_protocol_data = {
> 
> Hi! alps_model_data table is used for fixed identification of v1 and v2
> protocols. Why you need to add there v8 protocol which autodetection is
> already done in alps_identify() function? There is already code:
> 
> 		} else if (e7[0] == 0x73 && e7[1] == 0x03 &&
> 			   (e7[2] == 0x14 || e7[2] == 0x28)) {
> 			protocol = &alps_v8_protocol_data;
> 
> Which matches above your E7 detection 0x73, 0x03, 0x28.
> 
> Also you patch matches basically all v8 device and therefore has
> potential to break proper v8 autodetection for other v8 devices...
> 
