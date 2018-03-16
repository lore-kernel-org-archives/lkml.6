Return-Path: <benjamin.gaignard@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521190383; cv=none;
        d=google.com; s=arc-20160816;
        b=uQ0U+72JmLCgU+QtF+RFf37gjUmWsgq+pPouzHeixTNbE8M3rCaDCM9pZ6YG/UQQsC
         Lzo/Y6gGkbsOTl0v4y4LgS9aKiAwWElRFiWD0YM1fPH3R7M/Jw3fLfibu4Gn+ceaIFJW
         9IRiTlcAudR8fz2PWQldDnXl5sAQt8XbohRdBk0IvW3o8Rctf/rrlsTzOExMramaDxGW
         u2vXqycyxUUmA78vA0nlpHmPCPhT2Ahn3VCvmBI3sCmsxFAjJWcvQq5GszvQQPuGyxYD
         /53v1yr2CfnJ2uAIws0fG6Q8XcOfR31J2xy4BbihwBxPDOzcJn6mIw6Ok3kavTuBjZ0V
         Y1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=UmarsF5MbxV3e5fKXnAFFr46IpH0jMaRp1xAiK1ftno=;
        b=LeT4wF/byeINK2ghv4BxR6JiR43e6oWSHUJ81w61b7W3oMsXEkdDGwAaSKBkXNlryo
         +LJq7dHU/EfHFIC8WlpiMQ7mzE7XsYsSMM+pTg8J3fUFJnvtlrGmCCwWM4sd0KXRVmom
         n6XLSEYCmj4bbe2YjJmYm3Nkm3zadk3eX0dHh2Wf+nNqE/8wfj8t+m9TX3pOR14X+W4j
         pxQ+AItzWNqf1leefOikQXsaZWU/6I6ATFerVJE6qvTILxNqINYVJzcyI/GDGbZ7C9dh
         d15rsC36fl0snWP/r2CgM7NwLJ5vC9t/f7FvteSrx0cC20ZanBvJMXG20UsWbuoOjItC
         7TEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WDvtXkQD;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WDvtXkQD;
       spf=pass (google.com: domain of benjamin.gaignard@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=benjamin.gaignard@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtqqCMfl97X6zgAEMk+6wBPcZSVAFsA8L9HAHdDZsMPyozPEwzlHGx46AUe2S1JEw+9gq0LBAXe7GhIXYWpQbk=
MIME-Version: 1.0
In-Reply-To: <20180315171059.GA10254@kroah.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
 <20180227140926.22996-2-benjamin.gaignard@st.com> <20180315171059.GA10254@kroah.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Fri, 16 Mar 2018 09:53:02 +0100
Message-ID: <CA+M3ks5DHQNoEZQ9AM_g2fSGafFbMtpP=D7hfL9EXLvc-GH65w@mail.gmail.com>
Subject: Re: [PATCH 1/3] driver core: check notifier_call_chain return value
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>,
	devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593563501482605185?=
X-GMAIL-MSGID: =?utf-8?q?1595083727770431297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-15 18:10 GMT+01:00 Greg KH <gregkh@linuxfoundation.org>:
> On Tue, Feb 27, 2018 at 03:09:24PM +0100, Benjamin Gaignard wrote:
>> When being notified that a driver is about to be bind a listener
>> could return NOTIFY_BAD.
>> Check the return to be sure that the driver could be bind.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  drivers/base/dd.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index de6fd092bf2f..9275f2c0fed2 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -304,9 +304,12 @@ static int driver_sysfs_add(struct device *dev)
>>  {
>>       int ret;
>>
>> -     if (dev->bus)
>> -             blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>> -                                          BUS_NOTIFY_BIND_DRIVER, dev);
>> +     if (dev->bus) {
>> +             if (blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>> +                                              BUS_NOTIFY_BIND_DRIVER, dev) ==
>> +                                              NOTIFY_BAD)
>> +                     return -EINVAL;
>
> checkpatch does not complain about this?

No (even with --strict), it should be indented with tabs

>
> And what is going to break when we enable this, as we have never checked
> this before?

I could have miss some occurences but when greping with BUS_NOTIFY_*
patern I haven't any problematic cases.
When notifiers don't care of the message they almost all return
NOTIFY_DONE, some return NOTIFY_OK but none
return NOTIFY_BAD. That I wrote the test like "== NOTIFY_BAD" and not
"!= NOTIFY_OK".

I have checked this list of files (I hope I haven't forgot any occurence)
arch/powerpc/kernel/isa-bridge.c
arch/powerpc/kernel/iommu.c
arch/powerpc/kernel/dma-swiotlb.c
arch/powerpc/platforms/pasemi/setup.c
arch/powerpc/platforms/512x/pdm360ng.c
arch/powerpc/platforms/cell/iommu.c
arch/arm/mach-mvebu/coherency.c
arch/arm/common/sa1111.c
arch/arm/mach-keystone/keystone.c -> this one return NOTIFY_BAD if dev
is NULL which is never the case.
arch/arm/mach-highbank/highbank.c
arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
arch/arm/mach-omap2/omap_device.c
drivers/base/power/clock_ops.c
drivers/platform/x86/silead_dmi.c
drivers/input/serio/i8042.c
drivers/input/mouse/psmouse-smbus.c
drivers/w1/w1.c
drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
drivers/i2c/i2c-dev.c drivers/acpi/acpi_lpss.c
drivers/gpu/vga/vgaarb.c
drivers/xen/pci.c drivers/xen/xen-pciback/pci_stub.c
drivers/xen/arm-device.c
drivers/iommu/s390-iommu.c
drivers/iommu/iommu.c
drivers/iommu/dmar.c
drivers/iommu/intel-iommu.c
drivers/usb/core/usb.c
drivers/s390/cio/ccwgroup.c
drivers/net/ethernet/ibm/emac/core.c

Benjamin

>
> thanks,
>
> greg k-h
