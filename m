Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518529997; cv=none;
        d=google.com; s=arc-20160816;
        b=fN47spAbnACJoTHqWyMBzHW71XZzzFZUPmI9nxO3wWG/2IOi5qI9sSzb6R/KDyFpm3
         mdGz1kDMDeb57FZ0HaydfMPC+3JvNSID4U2eJ622iXBaqKHJ2eYyycE7nqfd9FueClgW
         e05dnWlZnuDFbl4GS/Al/B+n7YX/v6YY2Fkhu8iNc1xpouInuypGLALuT14MdXQpwQGg
         F61LHjC/uoerxKVqrTmSnwkUIssc95lhzHcGj5mGwJZBhHS+AX7z9HkeUfXe2CYaRDOi
         wtF8Vowq6Z310naCM0I5OenPettdDBNhQwXhHu/7XXNCdPboLcve0CwZE41B9fqKiB+j
         Q3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=YXuCr88dR8+Y7HRy2UpzlUIDGaXrEtpSxTWVwKeFRc0=;
        b=gobwtc9apJljrdRIxIQnQydBwjHWcllnx/hYo5WIvlxwe+oDkdEnLyzYwpSiri+xbf
         yEL48DeiVu6PLlJ1BTEZ59TnmTtyWKqLpp4StbACexsX5dVfTFfr9zUdJQ3x1ACgJRsZ
         H1z5MEv5Li9egzSAtQzXK5/KtwNtK/t78KpFssOav5sp6Gddat7h5/kxfQOc+JYAcxLr
         5A9958NzfqnuqDXFr3CjvDisgNjju4wnoqy8YEzbMp5wrMhbxTC0kNmn/0dml72jo2sT
         +wVTBPkRiqJIw+3CUFdC2H1rSrLGTv8E76uK3U910SvuIAm41HQxzaLCnsXFF76NJiRI
         pw5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=esyXta+A;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=esyXta+A;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x225p01To9/J+9WRPgYF1cvC9J/FqlsMKqngF9UsQ+kMkcT6ypmxBJr7NCCMHvECM8jnxIll79g==
MIME-Version: 1.0
In-Reply-To: <906051dd-8898-ec6f-5ad4-3f37716292cf@arm.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5DxYhkK61VDAesby6bT+FtG2nqsbHQRvxkhrsSS0KWtog@mail.gmail.com> <906051dd-8898-ec6f-5ad4-3f37716292cf@arm.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 13 Feb 2018 22:52:53 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DJtQYPg5S3Ep2bK27+D5rQiKuA-uPfMDUon3FudmGF0w@mail.gmail.com>
Message-ID: <CAAFQd5DJtQYPg5S3Ep2bK27+D5rQiKuA-uPfMDUon3FudmGF0w@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
	"list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>,
	freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
	Greg KH <gregkh@linuxfoundation.org>, sboyd@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737865178016622?=
X-GMAIL-MSGID: =?utf-8?q?1592294110785319416?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 9:57 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 13/02/18 08:24, Tomasz Figa wrote:
>>
>> Hi Vivek,
>>
>> Thanks for the patch. Please see my comments inline.
>>
>> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>>
>>> From: Sricharan R <sricharan@codeaurora.org>
>>>
>>> The smmu device probe/remove and add/remove master device callbacks
>>> gets called when the smmu is not linked to its master, that is without
>>> the context of the master device. So calling runtime apis in those places
>>> separately.
>>>
>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>> [vivek: Cleanup pm runtime calls]
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> ---
>>>   drivers/iommu/arm-smmu.c | 42
>>> ++++++++++++++++++++++++++++++++++++++----
>>>   1 file changed, 38 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 9e2f917e16c2..c024f69c1682 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -913,11 +913,15 @@ static void arm_smmu_destroy_domain_context(struct
>>> iommu_domain *domain)
>>>          struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>          struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>          struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>>> -       int irq;
>>> +       int ret, irq;
>>>
>>>          if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>>>                  return;
>>>
>>> +       ret = pm_runtime_get_sync(smmu->dev);
>>> +       if (ret)
>>> +               return;
>>
>>
>> pm_runtime_get_sync() will return 0 if the device was powered off, 1
>> if it was already/still powered on or runtime PM is not compiled in,
>> or a negative value on error, so shouldn't the test be (ret < 0)?
>>
>> Moreover, I'm actually wondering if it makes any sense to power up the
>> hardware just to program it and power it down again. In a system where
>> the IOMMU is located within a power domain, it would cause the IOMMU
>> block to lose its state anyway.
>
>
> This is generally for the case where the SMMU internal state remains active,
> but the programming interface needs to be powered up in order to access it.

That's true for Qualcomm SMMU, but I think that would be different for
existing users of the driver?

>
>> Actually, reflecting back on "[PATCH v7 2/6] iommu/arm-smmu: Add
>> pm_runtime/sleep ops", perhaps it would make more sense to just
>> control the clocks independently of runtime PM? Then, runtime PM could
>> be used for real power management, e.g. really powering the block up
>> and down, for further power saving.
>
>
> Unfortunately that ends up pretty much unmanageable, because there are
> numerous different SMMU microarchitectures with fundamentally different
> clock/power domain schemes (multiplied by individual SoC integration
> possibilities). Since this is fundamentally a generic architectural driver,
> adding explicit clock support would probably make the whole thing about 50%
> clock code, with complicated decision trees around every hardware access
> calculating which clocks are necessary for a given operation on a given
> system. That maintainability aspect is why we've already nacked such a
> fine-grained approach in the past.

Hmm, I think we are talking about different things here. My suggestion
would not add much more code to the driver than this patch does, calls
to arm_smmu_enable_clocks() instead of pm_runtime_get_sync() and
arm_smmu_disable_clocks() instead of pm_runtime_put(). The
implementation of both functions would be a simple call to clk_bulk_
API (possibly even no need to put this into functions, just call
directly).

Best regards,
Tomasz
