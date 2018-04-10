Return-Path: <kernel-hardening-return-12958-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48CyDW0aRtgCX7n3br1rIwe2CE/ApmVTmki316I8OatOMSqsMAtzwzntcf/qmjioIB0s3bP
ARC-Seal: i=1; a=rsa-sha256; t=1523385862; cv=none;
        d=google.com; s=arc-20160816;
        b=0P5ubgWwhA09gSbfavLIp2s1j/nYUcSC+BWbMU0GzQPjTcl8dRCEKygN1cnOe1Qol1
         sPHNsXceOq4zPGfbSsTSRS6p462Hg6M7aSD4SLcf2gLhv6KuR15M5OxQFmsXr4FeDdoH
         QK/kDh/REE7LgIFCLc9t20aHP2Anz/MNHFdZnBbLmHdbYZh8RrquwJoe2y6NwRbDXdfY
         k/uruWdEiO2ietW2okn2Fndws3R7+T0oc2gGLBgGF5bNmPmW1Nt1SUznxG11yniceXEP
         /QYgWjzqC2jz1iMFooPg+IrMbroqHUq0pcAVTL7bCW2sVpMmqxpwAyqi0dewlJ1YtfUu
         VC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=qERpecjFXs+m0zF8kmY97dW5txJ7lJ5ATLnnXGTVh5o=;
        b=XVfP23mQ9YK0hLUzIjBufWPhx4yxF6GDpXNVQ0o+jPW75KRFFn7978So54g97GapOT
         WVdAlla7jxM6meovWaUN1m7EOmLCP3H7JBb54SFyXhLABfq4UkV1JVbqYLfsjQ7HAIpo
         V7oICM6UrcAgPaAYX+XR1W8/S2fVPmDJl4X/aPH2UowAw3Rwp3BJ4dTsG5cuXNj8zVJA
         osCqIt3HE/zShAdJC3Ld7g3NmdbFiRaHOiuWa0exQswsQ6xFKljDl+o+3b3QPslGE1AT
         P2bzFiQARdp6IIATadDoEujpt04negw4uoXv5X2gVAYgpzImo7Kh9hAebUpe0LsOtKnF
         A2Jg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12958-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12958-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12958-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12958-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] drm/amdkfd: Remove vla
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher
 <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>
References: <20180409210620.3647-1-labbott@redhat.com>
 <71ff5078-713c-ff8b-8c8d-6d24a7d84c02@amd.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <7aba566e-ed84-91ae-78f1-01659ef7907d@redhat.com>
Date: Tue, 10 Apr 2018 11:43:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <71ff5078-713c-ff8b-8c8d-6d24a7d84c02@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304222291643357?=
X-GMAIL-MSGID: =?utf-8?q?1597385853945127626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/09/2018 11:38 PM, Christian König wrote:
> Am 09.04.2018 um 23:06 schrieb Laura Abbott:
>> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
>> turn on -Wvla. The single VLA usage in the amdkfd driver is actually
>> constant across all current platforms.
> 
> Actually that isn't correct.
> 
> Could be that we haven't upstreamed KFD support for them, but Vega10 have a different interrupt ring entry size and so would cause the error message here.
> 
>> Switch to a constant size array
>> instead.
> 
> I would say to just make make the array bigger.
> 
> Regards,
> Christian.
> 

What array size would accommodate future chips?

>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
>> index 035c351f47c5..c9863858f343 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
>> @@ -139,10 +139,12 @@ static void interrupt_wq(struct work_struct *work)
>>   {
>>       struct kfd_dev *dev = container_of(work, struct kfd_dev,
>>                           interrupt_work);
>> +    uint32_t ih_ring_entry[4];
>> -    uint32_t ih_ring_entry[DIV_ROUND_UP(
>> -                dev->device_info->ih_ring_entry_size,
>> -                sizeof(uint32_t))];
>> +    if (dev->device_info->ih_ring_entry_size > (4 * sizeof(uint32_t))) {
>> +        dev_err(kfd_chardev(), "Ring entry too small\n");
>> +        return;
>> +    }
>>       while (dequeue_ih_ring_entry(dev, ih_ring_entry))
>>           dev->device_info->event_interrupt_class->interrupt_wq(dev,
> 
