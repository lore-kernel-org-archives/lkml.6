Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754535AbeDBVp4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 17:45:56 -0400
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:41054 "EHLO
        godking.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754512AbeDBVpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 17:45:55 -0400
Subject: Re: [ibm-acpi-devel] [PATCH] Add Second Fan Support for Thinkpad P50
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1522693621-3124-1-git-send-email-agk@godking.net>
 <20180402190837.mlwkviu2syhv6re6@khazad-dum.debian.net>
Cc: ibm-acpi@hmh.eng.br, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        ibm-acpi-devel@lists.sourceforge.net, dvhart@infradead.org,
        andy@infradead.org
From: Alexander Kappner <agk@godking.net>
Message-ID: <8e50ae03-f7ce-fc88-d441-be559e13e55a@godking.net>
Date: Mon, 2 Apr 2018 14:45:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180402190837.mlwkviu2syhv6re6@khazad-dum.debian.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I tested this successfully on my P50 (see below). Thanks for Ack'ing. 


ak@REDDOT:~$ sensors
thinkpad-isa-0000
Adapter: ISA adapter
fan1:        3778 RPM
fan2:        3771 RPM
...



On 04/02/2018 01:22 PM, Andy Shevchenko wrote:
> I would rather name it ..._QB() instead
> 
> Better of course to use three letters, though let's leave this when we
> really have a need.
Agreed; ideally we'd use a bitmask. 


On 04/02/2018 12:08 PM, Henrique de Moraes Holschuh wrote:
> On Mon, 02 Apr 2018, Alexander Kappner wrote:
>> The Thinkpad P50 has 2 fans. Add the 2FAN quirk so the tpacpi driver
>> properly reports both fan speeds.
>> Because the P50 doesn't report the version of its EC controller, we need to
>> identify it by BIOS version (N1).
>>
>> Signed-off-by: Alexander Kappner <agk@godking.net>
> 
> I assume you tested this on real hardware?  If so:
> 
> Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> 
>> ---
>>  drivers/platform/x86/thinkpad_acpi.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
>> index d5eaf3b1..ebdc300 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -8699,16 +8699,24 @@ static const struct attribute_group fan_attr_group = {
>>  	  .ec = TPID(__id1, __id2),		\
>>  	  .quirks = __quirks }
>>  
>> +#define TPACPI_FAN_QL_BIOS(__id1, __id2, __quirks)	\
>> +	{ .vendor = PCI_VENDOR_ID_LENOVO,	\
>> +	  .bios = TPID(__id1, __id2),		\
>> +	  .ec = TPACPI_MATCH_ANY,		\
>> +	  .quirks = __quirks }
>> +
>>  static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>>  	TPACPI_FAN_QI('1', 'Y', TPACPI_FAN_Q1),
>>  	TPACPI_FAN_QI('7', '8', TPACPI_FAN_Q1),
>>  	TPACPI_FAN_QI('7', '6', TPACPI_FAN_Q1),
>>  	TPACPI_FAN_QI('7', '0', TPACPI_FAN_Q1),
>>  	TPACPI_FAN_QL('7', 'M', TPACPI_FAN_2FAN),
>> +	TPACPI_FAN_QL_BIOS('N', '1', TPACPI_FAN_2FAN) // Thinkpad P50 has 2 fans
>>  };
>>  
>>  #undef TPACPI_FAN_QL
>>  #undef TPACPI_FAN_QI
>> +#undef TPACPI_FAN_QL_BIOS
>>  
>>  static int __init fan_init(struct ibm_init_struct *iibm)
>>  {
> 
