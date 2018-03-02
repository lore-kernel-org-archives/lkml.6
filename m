Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELvVFcH2Zn8/Kid9gYqz2/Eh9ev2GVeU+Lzz9wJekGFu+320dhCIQVn0o1yROXF2xVHIJB5I
ARC-Seal: i=1; a=rsa-sha256; t=1519987735; cv=none;
        d=google.com; s=arc-20160816;
        b=tUVtU5kXnBbPWYgvkg5MhNWhNnlJC4kCcOq790g1KnEQBhisdjhmOB+G8PpbpacyJK
         fxstMiOZPzWSQ1uXz1zRjBhz0UeCmAuhS7U+G+RfoS9fTCRw3vdWkdYRn70nnxg2zo+w
         pj7JCDiMg3nyMOz/oyghb+s8m5lqzhwSs+UrOmvEOBLL4p7YrglMnGEylM7tArwtKKTU
         +AdkFCysRolufBLMWXNlNLcfZCorsLdnCUme1B6vNAVZ10Olj8vEx4Z2vhOS+A8Zp2wI
         PznE+7cq/+x0gz8y9tTbTZJPkY8NJYpm7EfElI0FZ9KiytS5ObM9QazvZKlCYPrM+a6Z
         zI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=WpohzkF+hXNZhO/aX3qwgQmz69Cd/aponEdL13MCi1E=;
        b=fxzOQWAVjccjti9hXdgmWkBtwzysddOMGVJa0402FrFyD28ZQ1ArUilFv0zscIQskT
         QkyviLMK+7IaR8aG9DqTL6mxdMfaG1fBaXJwLUKXQLmm3viHFg2ekvZgH4KUvO36m1FU
         eZzcuUX/5dj/Emq2gShGiyOxkxva2OMmcH3ECDtlixCsvi1juk9k+RjvadLFwsET01LP
         mFxvP0E8122TD3OGGLNWMdIcM1ntEpIEcC1FAeNI0pOBAIhjUtJE0AJfw1642nCv2Pze
         8ItH0t+vwUtNkwCLsXFKtGTMuwAzGOdKzwKOXuBx2QGkotdBhqfll3uXIUDB+CE9XGzQ
         lTZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Subject: Re: [PATCH v15 0/9] LPC: legacy ISA I/O support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
	<lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>, <hanjun.guo@linaro.org>,
	<robh+dt@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<mark.rutland@arm.com>, <olof@lixom.net>, <dann.frazier@canonical.com>,
	<andy.shevchenko@gmail.com>, <robh@kernel.org>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
 <1519933978.10722.366.camel@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>, <minyard@acm.org>,
	<devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<rdunlap@infradead.org>, <gregkh@linuxfoundation.org>,
	<akpm@linux-foundation.org>, <frowand.list@gmail.com>, <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <5b7024af-33c8-48c8-22bc-8d36ca3eadd8@huawei.com>
Date: Fri, 2 Mar 2018 10:48:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1519933978.10722.366.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593479231373740190?=
X-GMAIL-MSGID: =?utf-8?q?1593822659268493927?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/03/2018 19:52, Andy Shevchenko wrote:
> On Tue, 2018-02-27 at 00:40 +0800, John Garry wrote:
>> > This patchset supports the IPMI-bt device attached to the Low-Pin-
>> > Count
>> > interface implemented on Hisilicon Hip06/Hip07 SoC.
>> >                         -----------
>> >                         | LPC host|
>> >                         |         |
>> >                         -----------
>> >                              |
>> >                 _____________V_______________LPC
>> >                   |                       |
>> >                   V                       V
>> >                                      ------------
>> >                                      |  BT(ipmi)|
>> >                                      ------------
>> >
>> > When master accesses those peripherals beneath the Hip06/Hip07 LPC, a
>> > specific
>> > LPC driver is needed to make LPC host generate the standard LPC I/O
>> > cycles with
>> > the target peripherals'I/O port addresses. But on curent arm64 world,
>> > there is
>> > no real I/O accesses. All the I/O operations through in/out accessors
>> > are based
>> > on MMIO ranges; on Hip06/Hip07 LPC the I/O accesses are performed
>> > through driver
>> > specific accessors rather than MMIO.
>> > To solve this issue and keep the relevant existing peripherals'
>> > drivers untouched,
>> > this patchset:
>> >    - introduces a generic I/O space management framework, logical PIO,
>> > to support
>> >       I/O operations on host controllers operating either on MMIO
>> > buses or on buses
>> >      requiring specific driver I/O accessors;
>> >    - redefines the in/out accessors to provide a unified interface for
>> > both MMIO
>> >      and driver specific I/O operations. Using logical PIO, th call of
>> > in/out() from
>> >      the host children drivers, such as ipmi-si, will be redirected to
>> > the
>> >      corresponding device-specific I/O hooks to perform the I/O
>> > accesses.
>> >
>> > Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC
>> > peripherals can
>> > be supported without any changes on the existing ipmi-si driver.
>> >
>> > The whole patchset has been tested on Hip07 D05 board both using DTB
>> > and ACPI.
>> >
> I did a review and don't see the patch 8 is ready to go.
>
> So, to move things forward I may suggest to reorder series that some
> small preparation stuff can go first w/o dependency to the actual Logic
> PIO / LPC.
>


Hi Andy,

As mentioned in the reply to patch #8, as a practical exercise I don't 
see the reason to change it now. Let's conclude that issue first before 
deciding on patchset revising.

Thanks very much,
John
