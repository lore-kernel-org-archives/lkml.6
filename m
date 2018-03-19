Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELv47R0IgNmx8j8JolyU06l4MUCI/rcosgb4vMAg3H3SmngHnkVVk3ernR9aP3jZMARHhGDo
ARC-Seal: i=1; a=rsa-sha256; t=1521456547; cv=none;
        d=google.com; s=arc-20160816;
        b=oWrBU8O+n8hGDK/KzSMMc78X8LindYxSDHBi7BofgEST+NC21ARl2eWsoSfyXOOHZg
         uMhPckqD+f1db/uJpWANK/vO+30cIa+rXDkxTbRNFfnj66n8TPufxQRu60WsRpQX0XkZ
         Nc5PYlc8vODteTYYfmscJgUSdq6YT5AusqdkT8zuCzrKA9hxcH5sdnsUhy+Tl2r7vf1e
         EJTJXlVCcIG5JznVBuqrHp08mw3FJztkyzEhRLh/XaIj3fQ9FoggKGOWjnER0VzB76lu
         VqgbT1MqRZMqo4I8kKugun0xM+njyN65c6nJ5BRAxXSd5lbpT4DSPTSKLi7wN18/IV2V
         WKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=wVlUDH61JV56Unqdie3ceZaOVqQJnzvHbXJqAi5ytQg=;
        b=z9WsbqsI/HYwDQexVULaTACD2+9KCq6dETCOWAfL/N3uCUu6qDvPU1vLzFbbItQ955
         FBvQmMp6q5W7j4FeHcri41v139/3J3qHqCnWjA1EjxSUtmUCVQl2Bu2jc07hBgr9hDoW
         zxKrHsXUINs1ZYnC42MjET5pV0JlPGRyEUawrS9lRtHmFU9EBgwT4N3hKwL2kXBvhmLl
         WA1olVHhVImVGzsgO/JSfc//nJ2p1yige6Fn1uBDnGGGck62UhlCGOnL4czN5BoDY87p
         EO991ERSXD8UvxUrRImTo+zA3LbfyY2IAo6c8Lqlytx04KYSCE5rHqV5ZqWBs8Ma5yFh
         yDcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Subject: Re: [PATCH v17 08/10] ACPI / scan: do not enumerate Indirect IO host
 children
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <1521051359-34473-9-git-send-email-john.garry@huawei.com>
 <2309217.pWfZsU88YQ@aspire.rjw.lan>
CC: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
	<lorenzo.pieralisi@arm.com>, <hanjun.guo@linaro.org>, <robh+dt@kernel.org>,
	<bhelgaas@google.com>, <arnd@arndb.de>, <mark.rutland@arm.com>,
	<olof@lixom.net>, <dann.frazier@canonical.com>, <andy.shevchenko@gmail.com>,
	<robh@kernel.org>, <andriy.shevchenko@linux.intel.com>, <joe@perches.com>,
	<benh@kernel.crashing.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxarm@huawei.com>, <minyard@acm.org>, <devicetree@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <rdunlap@infradead.org>,
	<gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
	<frowand.list@gmail.com>, <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <906b3868-39a5-3807-23a4-dfc52c2e82c4@huawei.com>
Date: Mon, 19 Mar 2018 10:48:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <2309217.pWfZsU88YQ@aspire.rjw.lan>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594938018903038038?=
X-GMAIL-MSGID: =?utf-8?q?1595362820579967383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 19/03/2018 10:30, Rafael J. Wysocki wrote:
> On Wednesday, March 14, 2018 7:15:57 PM CET John Garry wrote:
>> > Through the logical PIO framework systems which otherwise have
>> > no IO space access to legacy ISA/LPC devices may access these
>> > devices through so-called "indirect IO" method. In this, IO
>> > space accesses for non-PCI hosts are redirected to a host
>> > LLDD to manually generate the IO space (bus) accesses. Hosts
>> > are able to register a region in logical PIO space to map to
>> > its bus address range.
>> >
>> > Indirect IO child devices have an associated host-specific bus
>> > address. Special translation is required to map between
>> > a logical PIO address for a device and it's host bus address.
>> >
>> > Since in the ACPI tables the child device IO resources would
>> > be the host-specific values, it is required the ACPI scan code
>> > should not enumerate these devices, and that this should be
>> > the responsibility of the host driver so that it can "fixup"
>> > the resources so that they map to the appropriate logical PIO
>> > addresses.
>> >
>> > To avoid enumerating these child devices, we add a check from
>> > acpi_device_enumeration_by_parent() as to whether the parent
>> > for a device is a member of a known list of "indirect IO" hosts.
>> > For now, the HiSilicon LPC host controller ID is added.
>> >
>> > Signed-off-by: John Garry <john.garry@huawei.com>
>> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> You have my ACK here already.
>
> Since I've ACKed the [7/10] too, I don't think there's anything more I can do
> about this series and I'm assuming that it will be routed through other trees.
>
> Thanks!
>

Hi Rafael,

Thanks for this.

Yes, I am working on getting this whole series routed through another 
tree. Actually I think 7+8 could go separately since there is no build 
dependency, but I will try to keep the series together.

All the best, And thanks again,
John
