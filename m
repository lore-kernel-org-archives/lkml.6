Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524893747; cv=none;
        d=google.com; s=arc-20160816;
        b=eXkO+Lj4DTWCiC5dcBBr3LF8XnnL3USFE4DvSvAFfQT5p2vcKtKyqy/eccw8T58rli
         OSQmnPs56UUQ9H1VAJ/jVCxDBNNb7kCrid+azJvVGCy1GEeIQrSSH64U/h2CsRs9HOGJ
         Fgi/6DVBwex+XjCzpXjV24RjEPF2eNLpRECZs6WsDUb7nZKrI8prgJYuuBZmX7TJw94r
         BoPlTG0wALuQfwO9JWsCaEgRDmHT6pyF+gELUvPJTEB4wYCZrho402UKbpTLBj053EBg
         KQ+74rUr+Etpeb4zAnstsQLuNxSf+bAyE0CKeHXLos+KiJGIn5P2N5lr5MuIwCh78/A6
         fzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=k04MFl14AUhtiW+YWGL6YiIpBsjwROvJeuSUSmZQkcA=;
        b=zmHvao7l3ETFBM4gLOgKs8VqjKEPFwvlhrIwnjGcrJKT8EiscV3zt6JNGStN3SB7YL
         rTYAsak/h/hHQtxYAOUzQ6kmAREHqvP8tnH1DAOiHrAcWaaHqSwNvZtB6ILw6rNzdo96
         rAHYwm/Clc01OY/7YzDvjT1TcEiSL3j2QDJx5Hl5Cf5aHOfepIQjcWWmkdrVrLnIu/ce
         Tih3QoqFvK0nlSrKqyTpxGFjuA3maGvu5OQxAJU0hfKnXLsQBMAKFnXNNIxEyVZXtd0G
         uFld9nLlJ5AE7eRuPxf3ek+LUcB+mZCYa64xNU/wUanbmM7OxFUEwNhSboLoLCeWnvcZ
         mulg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iWSMb62l;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iWSMb62l;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrvtVNqnzddiGKdn/cH0tsNtrQtv1atKAq5JilSt1agqsHoFO2LBBxAEujGxTYAl7hzgOUi0A==
Subject: Re: [PATCH] mm: memory_hotplug: use put_device() if device_register
 fail
To: Michal Hocko <mhocko@kernel.org>
References: <2987b5bdb31e7c18cd837da0f1e32a98fecd3278.1524757165.git.arvind.yadav.cs@gmail.com>
 <20180427145623.GC5404@dhcp22.suse.cz>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
From: arvindY <arvind.yadav.cs@gmail.com>
Message-ID: <5AE40830.2090007@gmail.com>
Date: Sat, 28 Apr 2018 11:05:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180427145623.GC5404@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823954747248901?=
X-GMAIL-MSGID: =?utf-8?q?1598966986930210358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Friday 27 April 2018 08:26 PM, Michal Hocko wrote:
> On Thu 26-04-18 21:12:09, Arvind Yadav wrote:
>> if device_register() returned an error. Always use put_device()
>> to give up the initialized reference and release allocated memory.
> Is this patch correct? The docummentation says
>   * NOTE: _Never_ directly free @dev after calling this function, even
>   * if it returned an error! Always use put_device() to give up your
>   * reference instead.
>
> but we do not have _our_ reference in this path AFAICS. Maybe this is
> just a documentation issue? How have you tested this change btw.?
The document is correct. Here device_register() will initialize object by
making reference count as 1 and also increment reference count for device.

device_register() {
    device_initialize()->kobject_init()->kref_init() - initialize 
object( reference count = 1).
    device_add()->get_device() - increment reference count for device.
}

If device_register() will fail then we have to release the object by making
reference count 0. So we need to call put_object() which will release the
object and other resources like memory etc. so long as the reference
count is nonzero, the object continue to exist in memory.

I have not tested this peace of code. But I have tested other code which
is using Kboject.

~arvind
>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/base/memory.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index bffe861..f5e5601 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -649,13 +649,19 @@ static const struct attribute_group *memory_memblk_attr_groups[] = {
>>   static
>>   int register_memory(struct memory_block *memory)
>>   {
>> +	int ret;
>> +
>>   	memory->dev.bus = &memory_subsys;
>>   	memory->dev.id = memory->start_section_nr / sections_per_block;
>>   	memory->dev.release = memory_block_release;
>>   	memory->dev.groups = memory_memblk_attr_groups;
>>   	memory->dev.offline = memory->state == MEM_OFFLINE;
>>   
>> -	return device_register(&memory->dev);
>> +	ret = device_register(&memory->dev);
>> +	if (ret)
>> +		put_device(&memory->dev);
>> +
>> +	return ret;
>>   }
>>   
>>   static int init_memory_block(struct memory_block **memory,
>> -- 
>> 2.7.4
