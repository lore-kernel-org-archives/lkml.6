Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELvsu2J0uTH9cLPTd6g1kksK1DkDLdCwdOHvxkeuD2Cmq3aDreKyD/nH7ziorUeF8+JCFfNz
ARC-Seal: i=1; a=rsa-sha256; t=1519919129; cv=none;
        d=google.com; s=arc-20160816;
        b=MC8+D363PIR5Nj9oafIaWZYTUwqa7/zMFvVLZDWczN0NPmiL+kphIW5cZm8n51SZrO
         6MyQ7JmePxdGVpsd6a5J7Hk7FWlu+evcS/FbY5HoALtd8ztzQw1wCx9/hKeV9p0vWwsQ
         1mhog/iAbBQvLEbSbr/vF24q8qJyNx/74xoWJBpwbDHbK2iJ/HqOaFgss4uy32ZrOAlB
         mAHqwJhWipbHKUwSEvKYIvoU1EbTg41GfpGNvXA20BCC/mUlBipKig8Q/Gj2zMtbhqm7
         dFtsoNokO+zI6Q69LLFkphNwLZ4QYa2JcfaE+MtOg5QRL2lQFPKYGzVjgT/gAF10tBKi
         wnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=0q7sCKCObWNNqKXGTduezalDWmUdXri/tT2TgTaKN+k=;
        b=MoWxOrwgKd4FEwNfAW2Q2Pmi3qZLMRVOBsEx0gWON+d9KKp7i/syU+6iCKN80aoriu
         0SBduDHK7ykM9TAIXjF6jbzdPqFuC9sH9ysffjG83Z+mBQFQ+31g89fXk2RqYA9+caLw
         YfU1rZUVwUVV6Dk4BQq7VlNxoSGTrtd4HqkVZhQehe1zPv0oY295jqQ28/XBU0vL+3mb
         zv/k+uOGGDD8Sp1mezEMtewYXka3Oc4OlRtsrufCMSkVz+Gw/XPWi300I+ES+3cYw8ft
         6bpvqi0C74Omv7b+IsBr5ZDJSZ88/GodPP/A55mRwoqDDsWriDqoaNIWHVYJ/ijr8Teo
         fDAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Subject: Re: [PATCH v7 00/13] Support PPTT for ARM64
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com,
 catalin.marinas@arm.com, gregkh@linuxfoundation.org, mark.rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 dietmar.eggemann@arm.com, morten.rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <8b5bfd7e-57ea-bb34-85f8-69007a3847e6@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <1890b2e2-375e-f44f-c224-8cfa23a0add3@arm.com>
Date: Tue, 27 Feb 2018 12:49:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <8b5bfd7e-57ea-bb34-85f8-69007a3847e6@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684134324692162?=
X-GMAIL-MSGID: =?utf-8?q?1593750721005744963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/01/2018 06:06 AM, Sudeep Holla wrote:
> Hi Jeremy,
> 
> On 28/02/18 22:06, Jeremy Linton wrote:
>> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
>> used to describe the processor and cache topology. Ideally it is
>> used to extend/override information provided by the hardware, but
>> right now ARM64 is entirely dependent on firmware provided tables.
>>
>> This patch parses the table for the cache topology and CPU topology.
>> When we enable ACPI/PPTT for arm64 we map the physical_id to the
>> PPTT node flagged as the physical package by the firmware.
>> This results in topologies that match what the remainder of the
>> system expects. To avoid inverted scheduler domains we then
>> set the MC domain equal to the largest cache within the socket
>> below the NUMA domain.
>>
> I remember reviewing and acknowledging most of the cacheinfo stuff with
> couple of minor suggestions for v6. I don't see any Acked-by tags in
> this series and don't know if I need to review/ack any more cacheinfo
> related patches.

Hi,

Yes, I didn't put them in because I changed the functionality in 2/13 
and there is a bug fix in 5/13. I thought you might want to do a quick 
diff of the git v6->v7 tree.

Although given that most of the changes were in response to your 
comments in v6 I probably should have just put the tags in.


Thanks,
