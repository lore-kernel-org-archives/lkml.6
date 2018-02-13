Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AH8x224HYejDUiP3IImerWHzij5YvxEId9+rwn1JEgciM8AamW+sCuiKQA062o64YHFX9noUghXK
ARC-Seal: i=1; a=rsa-sha256; t=1518526629; cv=none;
        d=google.com; s=arc-20160816;
        b=HB8VUvkjX05gN2gfJttyiMblVrTUc3UeLi/9roHlX97rApPjJIgjkRubZX0e3mhzIu
         PiBIGPs3ax/I8Du1SGXMNo32fASIN9NXpNOsrrrymYmA7GPl4GumNyKl2Ai/h0HykSCj
         DvrjB2EuAXkhO+W++LrV7I0pK+qtkIrVsMu3eY3bzo2Ki2Fq5PAAUNViAjjbtchERXzc
         sT3Sz6mK6pJPluTW/4VzAEwGcdWCxEyoDUKRO65gqh43FruJxVTtZyhjk/6Bv1hGYKif
         qcohOW01tGvK0TDHTjtu6IKDotMbLG1rvmM1T/9wpb0qwgI4uT27yjifWCrhcmsCHIEg
         v0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=0Sl/pSBAmhogUaNvfn+MJGMPKl3rMKD53VODufVcwS8=;
        b=wOoWcmNSbhl3rzNHCl7EzruJM9uMBrrAQyUrEY7KU+rHe1Nuc4B/5s6hYSVy/KKTzg
         RD+0GHtYvilIp4zbdRnE1pOfUL1B/btXAvMSMGHTt3lMW+t0Tu0B64V9Cgrtn7cjrh8i
         9mPQtyPXDwHfiznDtYdgAtYJljJsVoKPUXCBT9SL7VqbiiQeq9BMYcUbutd5nniY33ha
         KkB0Q2dyVyShoME2Jdx0CJVTlNhsbVt/m1/XV62OTXMeDZPz1PNBBBKAgqF1CInwHPmU
         c22Mm7b0xjzVl0yNYkhTXLil7ebzAuWiDEp8xlO6efvquuB6y+QRMb3E6655sfbfAfQ8
         g8rQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH v7 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To: Tomasz Figa <tfiga@chromium.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, joro@8bytes.org,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>,
 Rob Clark <robdclark@gmail.com>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>,
 freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Greg KH <gregkh@linuxfoundation.org>, sboyd@codeaurora.org,
 linux-arm-msm@vger.kernel.org
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5DxYhkK61VDAesby6bT+FtG2nqsbHQRvxkhrsSS0KWtog@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <906051dd-8898-ec6f-5ad4-3f37716292cf@arm.com>
Date: Tue, 13 Feb 2018 12:57:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5DxYhkK61VDAesby6bT+FtG2nqsbHQRvxkhrsSS0KWtog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737865178016622?=
X-GMAIL-MSGID: =?utf-8?q?1592290579458563362?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13/02/18 08:24, Tomasz Figa wrote:
> Hi Vivek,
> 
> Thanks for the patch. Please see my comments inline.
> 
> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> From: Sricharan R <sricharan@codeaurora.org>
>>
>> The smmu device probe/remove and add/remove master device callbacks
>> gets called when the smmu is not linked to its master, that is without
>> the context of the master device. So calling runtime apis in those places
>> separately.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> [vivek: Cleanup pm runtime calls]
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 42 ++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 38 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 9e2f917e16c2..c024f69c1682 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -913,11 +913,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>>          struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>          struct arm_smmu_device *smmu = smmu_domain->smmu;
>>          struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>> -       int irq;
>> +       int ret, irq;
>>
>>          if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>>                  return;
>>
>> +       ret = pm_runtime_get_sync(smmu->dev);
>> +       if (ret)
>> +               return;
> 
> pm_runtime_get_sync() will return 0 if the device was powered off, 1
> if it was already/still powered on or runtime PM is not compiled in,
> or a negative value on error, so shouldn't the test be (ret < 0)?
> 
> Moreover, I'm actually wondering if it makes any sense to power up the
> hardware just to program it and power it down again. In a system where
> the IOMMU is located within a power domain, it would cause the IOMMU
> block to lose its state anyway.

This is generally for the case where the SMMU internal state remains 
active, but the programming interface needs to be powered up in order to 
access it.

> Actually, reflecting back on "[PATCH v7 2/6] iommu/arm-smmu: Add
> pm_runtime/sleep ops", perhaps it would make more sense to just
> control the clocks independently of runtime PM? Then, runtime PM could
> be used for real power management, e.g. really powering the block up
> and down, for further power saving.

Unfortunately that ends up pretty much unmanageable, because there are 
numerous different SMMU microarchitectures with fundamentally different 
clock/power domain schemes (multiplied by individual SoC integration 
possibilities). Since this is fundamentally a generic architectural 
driver, adding explicit clock support would probably make the whole 
thing about 50% clock code, with complicated decision trees around every 
hardware access calculating which clocks are necessary for a given 
operation on a given system. That maintainability aspect is why we've 
already nacked such a fine-grained approach in the past.

Robin.
