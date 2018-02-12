Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933071AbeBLI6j (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:58:39 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:46674 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932630AbeBLI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:58:37 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37000793"
Subject: Re: [PATCH v3 0/5] x86/apic: Fix restoring boot irq mode in reboot
 and kexec/kdump
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mingo@kernel.org>, <tglx@linutronix.de>, <x86@kernel.org>,
        <joro@8bytes.org>, <uobergfe@redhat.com>, <prarit@redhat.com>
References: <20180209121008.28980-1-bhe@redhat.com>
 <caff6f56-d8e3-1c61-e23b-1d335b6771a2@cn.fujitsu.com>
 <87wozi7pwy.fsf@xmission.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <3bff2f47-ae3e-58e0-420a-378ff3f55b65@cn.fujitsu.com>
Date: Mon, 12 Feb 2018 16:58:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87wozi7pwy.fsf@xmission.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 5705748AE766.A9E97
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

At 02/12/2018 01:11 PM, Eric W. Biederman wrote:
> Dou Liyang <douly.fnst@cn.fujitsu.com> writes:
> 
>> Hi all,
>>
>> One thing confused me.
>>
>> The disconnect_bsp_APIC() may restore the interrupt delivery mode into
>> virtual wire mode. it uses the vector F as the spurious interrput, But,
>> IMO, using the vector 0xFF(SPURIOUS_APIC_VECTOR) may more suitable and
>> will give us more detail. Why the disconnect_bsp_APIC() use vector F
>> here?
> 
> I would say this needs a documentation search before changing this.
> 
> This code originates in:
> 208fb93162d5 ("[PATCH] kexec: x86_64: restore apic virtual wire mode on shutdown")
> 
> The example in the Multi-Processor Specification v1.4 shows setting
> up the SPIV to vector 0x0f.
> 
Thanks for your detailed explanation, I found the example A-1 in this
spec.

> I don't know what is canonical and what will interact best with DOS,
> and that erra of setup.  The vector 0x0f seems an odd choice as
> it is below 0x20 putting it in the range of vectors that are
> reserved for processor exceptions.
> 
> The constant SPURIOUS_APIC_VECTOR is definitely not something we want
> to be using at this point as that is a linux specific setting and used
> when Linux is up and running.  So it is completely inapplicable.
> 
> This is all about restoring how the apics were configured at boot time
> so it may be appropriate to copy and store this value, if it was not
> architectural.
> 
> At a practical level at this point I suspect we are ok as the setting
> of the SPIV this way has not caused any known problems in the last
> decade.   If someone wants to dig through the archtectural documents
> and the real world practice and find a better value and explain the
> change I would not oppose it.

Indeed, I understand.


Thanks,
	dou

> 
> All I know for certain is using the constant SPURIOUS_APIC_VECTOR
> is completely inappropriate (as that constant is about how linux uses
> vectors) and thus the patch below is wrong.
> 
>> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
>> index 25ddf02598d2..550deaad6a9a 100644
>> --- a/arch/x86/kernel/apic/apic.c
>> +++ b/arch/x86/kernel/apic/apic.c
>> @@ -2130,7 +2130,7 @@ void disconnect_bsp_APIC(int virt_wire_setup)
>>          value = apic_read(APIC_SPIV);
>>          value &= ~APIC_VECTOR_MASK;
>>          value |= APIC_SPIV_APIC_ENABLED;
>> -       value |= 0xf;
>> +       value |= SPURIOUS_APIC_VECTOR;
>>          apic_write(APIC_SPIV, value);
>>
>>          if (!virt_wire_setup) {
>>
> 
> Eric
> 
> 
> 
