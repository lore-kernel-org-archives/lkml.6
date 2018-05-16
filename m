Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeEPIhu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:37:50 -0400
Received: from foss.arm.com ([217.140.101.70]:43902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbeEPIhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:37:46 -0400
Subject: Re: [PATCH v9 07/11] arm64: kexec_file: add crash dump support
From: James Morse <james.morse@arm.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-8-takahiro.akashi@linaro.org>
 <f8d8305d-42f5-e1e2-20c4-733cb38cbb8d@arm.com>
Message-ID: <3d70c7d1-4985-a427-ecc6-a7edc84edfff@arm.com>
Date: Wed, 16 May 2018 09:34:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f8d8305d-42f5-e1e2-20c4-733cb38cbb8d@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akashi,

On 15/05/18 18:11, James Morse wrote:
> On 25/04/18 07:26, AKASHI Takahiro wrote:
>> Enabling crash dump (kdump) includes
>> * prepare contents of ELF header of a core dump file, /proc/vmcore,
>>   using crash_prepare_elf64_headers(), and
>> * add two device tree properties, "linux,usable-memory-range" and
>>   "linux,elfcorehdr", which represent repsectively a memory range
>>   to be used by crash dump kernel and the header's location

>> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
>> index 37c0a9dc2e47..ec674f4d267c 100644
>> --- a/arch/arm64/kernel/machine_kexec_file.c
>> +++ b/arch/arm64/kernel/machine_kexec_file.c
>> @@ -76,6 +81,78 @@ int arch_kexec_walk_mem(struct kexec_buf *kbuf,

>> +static void fill_property(void *buf, u64 val64, int cells)
>> +{
>> +	u32 val32;
>> +
>> +	if (cells == 1) {
>> +		val32 = cpu_to_fdt32((u32)val64);
>> +		memcpy(buf, &val32, sizeof(val32));
>> +	} else {
> 
>> +		memset(buf, 0, cells * sizeof(u32) - sizeof(u64));
>> +		buf += cells * sizeof(u32) - sizeof(u64);
> 
> Is this trying to clear the 'top' cells and shuffle the pointer to point at the
> 'bottom' 2? I'm pretty sure this isn't endian safe.

It came to me at 2am: this only works on big-endian, which is exactly what you
want as that is the DT format.


> Do we really expect a system to have #address-cells > 2?


Thanks,

James
