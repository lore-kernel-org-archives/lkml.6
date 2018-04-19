Return-Path: <longman@redhat.com>
X-Google-Smtp-Source: AIpwx48iNh3B7MmHCf9l4m0si42txiabmODf6pONPP+wHkNhgM42Pznu9EU4VpjAtcPbUmjVXaxJ
ARC-Seal: i=1; a=rsa-sha256; t=1524163459; cv=none;
        d=google.com; s=arc-20160816;
        b=Wzwqk5naaSpbYTsIXeNOi+LCngUUES2gIADtTC9KxglBf/b+NFpmTEZWmXAn2I9bFA
         wCbihX37wc5Icz5Mm7i5OotrLD0DNGy9Ym3e7yi75gNAvFYbDgFIdV0wIW7mVDxS9Hes
         ePHw7OWdXeXkYWjpzWt2jf8lF7VTDU3NBZDWXG+3LBvJYbd1ryZQsCh4mmswtZwqPkVJ
         eT8o00yvR121GHRC29D8BlLZXsmBibC4PfDR6mcga6NycH3JgYENAnKl7MBeD3RZkUQo
         TRDUsb/fK65+mj0ATOsWsmbtm6ytYhPC7eDjRmuJ/MQX3i+A1Fj7FR/zWIdNsERR2c8m
         poqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=QkJ4mndqJ7VKe584COiXmkmYJ8BtwI3tiEcwleCL/Q8=;
        b=lzbOCeR5pp/teZu6r58Zqe5sqpAd8pDlkoMDaUWhLMrQwKUUn6wpwjrWVJplGe3w7D
         qL3S1Y3aSgpycpQ/rNVEjAqwGP4di0uPtqGmC9zcaPsZ2KrR29RWS5iKx9nHQ3coD0G8
         s5bOW/L1pBZsHv7BwYf3++ioh9yOnRt9rpQ7wKqrwyxSP6g2D702dp6Chljf3admxxEC
         TsHARhE4hGjNezn/fDKSDoFH+44B8X0DnTqfACVztfwYUhEYRSIJZCRRpkWL3vP0VoDV
         dvX3KzqqBqMVqiKZtITKZZ1+GFknhRv875dXkkNL6HLz1YCcEwc8lxKjGhsLRGLgyvj/
         iyXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of longman@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=longman@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of longman@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=longman@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH] proc/stat: Separate out individual irq counts into
 /proc/stat_irqs
To: Randy Dunlap <rdunlap@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
References: <1524157769-30775-1-git-send-email-longman@redhat.com>
 <3b8d1463-a671-add0-9b92-51e7518f1c07@infradead.org>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <289f924e-3556-0cd9-1b81-8b8f53b7a6e4@redhat.com>
Date: Thu, 19 Apr 2018 14:44:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <3b8d1463-a671-add0-9b92-51e7518f1c07@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598195278130024579?=
X-GMAIL-MSGID: =?utf-8?q?1598201223725367239?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/19/2018 01:38 PM, Randy Dunlap wrote:
> On 04/19/18 10:09, Waiman Long wrote:
>> It was found that reading /proc/stat could be time consuming on
>> systems with a lot of irqs. For example, reading /proc/stat in a
>> certain 2-socket Skylake server took about 4.6ms because it had over
>> 5k irqs. In that particular case, the majority of the CPU cycles for
>> reading /proc/stat was spent in the kstat_irqs() function.  Therefore,
>> application performance can be impacted if the application reads
>> /proc/stat rather frequently.
>>
>> The "intr" line within /proc/stat contains a sum total of all the irqs
>> that have happened followed by a list of irq counts for each individual
>> irq number. In many cases, the first number is good enough. The
>> individual irq counts may not provide that much more information.
>>
>> In order to avoid this kind of performance issue, all these individual
>> irq counts are now separated into a new /proc/stat_irqs file. The
>> sum total irq count will stay in /proc/stat and be duplicated in
>> /proc/stat_irqs. Applications that need to look up individual irq counts
>> will now have to look into /proc/stat_irqs instead of /proc/stat.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  fs/proc/stat.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 41 insertions(+), 7 deletions(-)
> Also please update Documentation/filesystems/proc.txt.
>
> thanks,

Right. I forgot to do that. Will send out v2 to fix that.

-Longman
