Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522929089; cv=none;
        d=google.com; s=arc-20160816;
        b=IcRo51JdgDR2diuDHS1Vg2oXETrFz/gNNUYMFkfYOy8L2GLhhtbx6J/kxXcVip5lQX
         nyza2KhYkD1l01nAkRoJBUZ9X1VhcVlmf4VvUDUYkfmCLLibrEf9f+ivhAc93jKEdEgu
         u0MUEvKrMO+WneVzRQF+qKiEsfssl9TXd2bwG0H8tcqXIzhAHCMnz1EJvNe5CzJUw99S
         eI8bGheAAnNrPqCvM2Sfuiw1wEXJzOODXiUH/T1bCVop+TYabuy4jyhanLVPQi9ui3Eo
         RT4DDkPRA3lsxb5rHFdgRcFpz0+nrLYBMGKqePBgBVsLxw4PWJcLXnyvK9gX9wIQsyUb
         i0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=bbaUvJKgBfwFsxHGlQqdojxB1GfqQmrQfZIboIwU8Z0=;
        b=au9OahKSfx47FBg1WjQ6zGt8iDy79taCsifJzLu+Huj/076Gpa5mPSRE6JhLudMwAB
         NW5VMJ6gk3EHgOZk6Xu+iqrryWQ+luTBFVsvhbl3+CuqAlkJb4t6vA/UpizMkSGMaM4W
         s9f7SwGqYITIHiXmVeX8ieCHxaNPjrSEcItgX3yjoHp/lj5slJAmBWYnLRqhzja0u/k8
         CKGv8/O035cmt6s0PD8B5b+T+7AeKtD8ORmMzpO4mRp55dBQ1ksl/bNW2I2zDtPA6PLv
         O3ItB0mXlh2AWbj5ZsmnHKs6JO0ewsIv+bA7OaP2MMjqk2Pi5YA4Rl1fECRxF1653/Xo
         mUww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx4/SQuZCW2ZOuaTG2YMcTpH3QMPUpPXzTmr4GlshxwvMpump0zddg1cdgcyRJgFj8LaDjZaDag==
Subject: Re: [PATCH 2/2] efi: Add embedded peripheral firmware support
To: Peter Jones <pjones@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "Luis R . Rodriguez" <mcgrof@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org, linux-efi@vger.kernel.org
References: <20180331121944.8618-1-hdegoede@redhat.com>
 <20180331121944.8618-2-hdegoede@redhat.com>
 <20180403195332.tezh6alee26aic2s@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <b43da07e-5ca6-ce06-c786-5dcbbfc4b300@redhat.com>
Date: Thu, 5 Apr 2018 13:51:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403195332.tezh6alee26aic2s@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596455691844480056?=
X-GMAIL-MSGID: =?utf-8?q?1596906893428029257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 03-04-18 21:53, Peter Jones wrote:
> On Sat, Mar 31, 2018 at 02:19:44PM +0200, Hans de Goede wrote:
>> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
>> index fddc5f706fd2..1a5ea950f58f 100644
>> --- a/drivers/firmware/efi/efi.c
>> +++ b/drivers/firmware/efi/efi.c
>> @@ -455,6 +455,7 @@ int __init efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md)
>>   		u64 end;
>>   
>>   		if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
>> +		    md->type != EFI_BOOT_SERVICES_CODE &&
>>   		    md->type != EFI_BOOT_SERVICES_DATA &&
>>   		    md->type != EFI_RUNTIME_SERVICES_DATA) {
>>   			continue;
> 
> Might be worth adding a comment here to ensure nobody comes along later
> and adds something like EFI_BOOT_LOADER_DATA or other stuff that's
> allocated later here.  I don't want to accidentally patch our way into
> having the ability to stumble across a firmware blob somebody dumped
> into the middle of a grub config file, especially since you only need to
> collide crc32 (within the same length) to pre-alias a match.

As discussed elsewhere in the thread, I'm going to switch to doing a
kmemdup on the found firmware, so this chunk will go away :)

> 
> ...
>> +static int __init efi_check_md_for_embedded_firmware(
>> +	efi_memory_desc_t *md, const struct embedded_fw_desc *desc)
>> +{
> ...
>> +	if (found_fw_count >= MAX_EMBEDDED_FIRMWARES) {
>> +		pr_err("Error already have %d embedded firmwares\n",
>> +		       MAX_EMBEDDED_FIRMWARES);
>> +		return -ENOSPC;
>> +	}
> 
> Doesn't seem like this needs to be pr_err(); after all we have already
> found a valid match, so the firmware vendor has done something
> moderately stupid, but we have a firmware that will probably work.  Of
> course it still needs to return != 0, but pr_warn() or even pr_info()
> seems more reasonable.

We break from the search loop as soon as a firmware is found, this can
only trigger if someone adds a second firmware to the dmi data and then
does not update MAX_EMBEDDED_FIRMWARES...

But mcgrof wants me to switch to a linked list here, so this is going
away too.

> Aside from those nits, looks good to me.
> 
> Reviewed-by: Peter Jones <pjones@redhat.com>

Thanks, but v2 is going to have so much changes that I don't feel
comfortable bringing this forward to v2.

Regards,

Hans
