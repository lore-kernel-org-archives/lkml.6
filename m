Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbeDIIrA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:47:00 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:19830 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751348AbeDIIq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:46:59 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38709448"
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[RFC_PATCH]_x86/acpi:_Prevent_x2a?=
 =?UTF-8?Q?pic_id_-1_from_being_accounted?=
To: "Li,Rongqing" <lirongqing@baidu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>
References: <1523187531-29837-1-git-send-email-lirongqing@baidu.com>
 <f137d895-b8b9-d2eb-bbf9-3e5cd8089291@cn.fujitsu.com>
 <2AD939572F25A448A3AE3CAEA61328C23758FDF3@BC-MAIL-M28.internal.baidu.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <148150f5-4b33-c064-a877-88c20f63e96e@cn.fujitsu.com>
Date: Mon, 9 Apr 2018 16:46:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <2AD939572F25A448A3AE3CAEA61328C23758FDF3@BC-MAIL-M28.internal.baidu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 1C951472400A.A7CF8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RongQing,

At 04/09/2018 02:38 PM, Li,Rongqing wrote:
> 
> 
>> -----邮件原件-----
>> 发件人: Dou Liyang [mailto:douly.fnst@cn.fujitsu.com]
>> 发送时间: 2018年4月9日 13:38
>> 收件人: Li,Rongqing <lirongqing@baidu.com>; linux-kernel@vger.kernel.org;
>> tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; jgross@suse.com;
>> x86@kernel.org; peterz@infradead.org
>> 主题: Re: [RFC PATCH] x86/acpi: Prevent x2apic id -1 from being accounted
>>
>> Hi RongQing,
>>
>> Is there an local x2apic whose ID is  in your machine?
>>
> 
> I think no

[...]

> [    0.000000] ACPI: X2APIC (apic_id[0xffffffff] uid[0x00] disabled)
> [    0.000000] ACPI: X2APIC (apic_id[0xffffffff] uid[0x01] disabled)
> [    0.000000] ACPI: X2APIC (apic_id[0xffffffff] uid[0x02] disabled)

Ah, sure enough!

[...]
> 
> 
>> At 04/08/2018 07:38 PM, Li RongQing wrote:
>>> local_apic_id of acpi_madt_local_x2apic is u32, it is converted to int
>>> when checked by default_apic_id_valid() and return true if it is
>>> larger than 0x7fffffff, this is wrong
>>>
>>
>> For x2apic enabled systems,
>>
>>     - the byte length of X2APIC ID is 4, and it can be larger than
>>       0x7fffffff in theory
>>
> 
> Yes
> 
>>     - the ->apic_id_valid points to x2apic_apic_id_valid(), which always
>>       return _ture_ , not default_apic_id_valid().
>>
> 
> To this machine, the apic is apic_flat

I see, I am sorry the title and changelog make me misunderstand.

   Here, actually, we prevent all the X2APIC Id from being parsed in
   non-x2apic mode, not just 0xFFFFFFFF. because the values of x2APIC ID
   must be 255 and greater in ACPI MADT.

> 
> -RongQing
> 
>> Thanks,
>> 	dou
>>
>>> and if local_apic_id is invalid, we should prevent it from being
>>> accounted > This fixes a bug that Purley platform displays too many
>>> possible cpu
>>>
>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
>>> ---
>>>    arch/x86/include/asm/apic.h          |  4 ++--
>>>    arch/x86/kernel/acpi/boot.c          | 10 ++++++----
>>>    arch/x86/kernel/apic/apic_common.c   |  2 +-
>>>    arch/x86/kernel/apic/apic_numachip.c |  2 +-
>>>    arch/x86/kernel/apic/x2apic.h        |  2 +-
>>>    arch/x86/kernel/apic/x2apic_phys.c   |  2 +-
>>>    arch/x86/kernel/apic/x2apic_uv_x.c   |  2 +-
>>>    arch/x86/xen/apic.c                  |  2 +-
>>>    8 files changed, 14 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
>>> index 40a3d3642f3a..08acd954f00e 100644
>>> --- a/arch/x86/include/asm/apic.h
>>> +++ b/arch/x86/include/asm/apic.h
>>> @@ -313,7 +313,7 @@ struct apic {
>>>    	/* Probe, setup and smpboot functions */
>>>    	int	(*probe)(void);
>>>    	int	(*acpi_madt_oem_check)(char *oem_id, char
>> *oem_table_id);
>>> -	int	(*apic_id_valid)(int apicid);
>>> +	int	(*apic_id_valid)(u32 apicid);
>>>    	int	(*apic_id_registered)(void);
>>>
>>>    	bool	(*check_apicid_used)(physid_mask_t *map, int apicid);
>>> @@ -486,7 +486,7 @@ static inline unsigned int read_apic_id(void)
>>>    	return apic->get_apic_id(reg);
>>>    }
>>>
>>> -extern int default_apic_id_valid(int apicid);
>>> +extern int default_apic_id_valid(u32 apicid);
>>>    extern int default_acpi_madt_oem_check(char *, char *);
>>>    extern void default_setup_apic_routing(void);
>>>
>>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>>> index 7a37d9357bc4..7412564dc2a7 100644
>>> --- a/arch/x86/kernel/acpi/boot.c
>>> +++ b/arch/x86/kernel/acpi/boot.c
>>> @@ -200,7 +200,7 @@ acpi_parse_x2apic(struct acpi_subtable_header
>> *header, const unsigned long end)
>>>    {
>>>    	struct acpi_madt_local_x2apic *processor = NULL;
>>>    #ifdef CONFIG_X86_X2APIC
>>> -	int apic_id;
>>> +	u32 apic_id;
>>>    	u8 enabled;
>>>    #endif
>>>
>>> @@ -222,10 +222,12 @@ acpi_parse_x2apic(struct acpi_subtable_header
>> *header, const unsigned long end)
>>>    	 * to not preallocating memory for all NR_CPUS
>>>    	 * when we use CPU hotplug.
>>>    	 */
>>> -	if (!apic->apic_id_valid(apic_id) && enabled)
>>> +	if (!apic->apic_id_valid(apic_id)) {
>>>    		printk(KERN_WARNING PREFIX "x2apic entry ignored\n");

Due to the disable APIC entries may not exist physically, please just
printk the warning if the APIC ID is enabled.

if (!apic->apic_id_valid(apic_id)) {
	if(enabled)
		printk...

	return 0;
}



Thanks,
	dou
