Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518510686; cv=none;
        d=google.com; s=arc-20160816;
        b=rplxWqkNproJgPF4aumGin9Np7yg8Vh0jeGTM1QVccUw0QMNqUdZPftdGrV7ZZvRhf
         PSCo22Oa96TYV/KjCikqXwi5oe3+TM7QdrNDviv1IaFcSSj9YQq1s9H/o7wUBQrGp6OL
         0RACQgHL+JAd+iRSvUzXN9Vr5jTQVx0n15qQ9Gkir9ErWIu5pVXgniDG8R4Q1Cl2UA/E
         M8sdl/A1qxtws9PYAt05wt/uN6CSH+i2tM0FrGnl2nkYwbEvGGGofTGDO5iiy4qPEIRJ
         S/jWdJpS5v/Broomf3gBX19KWyGJDXKvEegRWR1pnvdsMdizilif1/DWE6i09u0r7JbH
         MTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=3qImykOaVkEOo/IUvwo5zkUlsXQPmIDn/KImcx8EjYI=;
        b=0Wu5lbC4FlQaHJjMlHTtoYVwfEb2VRyjoRTWTDlEiyXVxzcJYBV5yB/X8Fr/XSwX9A
         SoxkbNiugEspJUaU9mAphYmYK5NmMfKfrlWTJN2rK1D8WfGXoMTWMO8nnObxqFi3Cs21
         vBteZPP2Yn5FFbcaqAvb+NB4+KYdPzdHPXiYQIWU6o1A1rQiD0SiKJOFwinImFl7F/t5
         k5A35WtTdKOetoL+mQw+pCuLnhxi2hK+mmHdNJQ0l5mpJNS9IAAdvT1bg8U0KCoG/pra
         ybM1CDAHA0N/TuejhmemS2hEgTJJWrpE+/QCwcST7yyX+0/EXRWA2HP2h8GFftCZuaOz
         65kA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=CSrhdcjJ;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=CSrhdcjJ;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x224jC15za5LUQ198XP5/S/hkyxCUW78K1bFLHhMF/EB6lZkJ9EyxpK0zMMWsSYG/ivZ1EknG7Q==
MIME-Version: 1.0
In-Reply-To: <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org> <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 13 Feb 2018 17:24:53 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DxYhkK61VDAesby6bT+FtG2nqsbHQRvxkhrsSS0KWtog@mail.gmail.com>
Message-ID: <CAAFQd5DxYhkK61VDAesby6bT+FtG2nqsbHQRvxkhrsSS0KWtog@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
	Rob Clark <robdclark@gmail.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel <dri-devel@lists.freedesktop.org>, freedreno@lists.freedesktop.org,
	David Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>, sboyd@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737865178016622?=
X-GMAIL-MSGID: =?utf-8?q?1592273861426142221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vivek,

Thanks for the patch. Please see my comments inline.

On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> From: Sricharan R <sricharan@codeaurora.org>
>
> The smmu device probe/remove and add/remove master device callbacks
> gets called when the smmu is not linked to its master, that is without
> the context of the master device. So calling runtime apis in those places
> separately.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [vivek: Cleanup pm runtime calls]
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c | 42 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 9e2f917e16c2..c024f69c1682 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -913,11 +913,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>         struct arm_smmu_device *smmu = smmu_domain->smmu;
>         struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> -       int irq;
> +       int ret, irq;
>
>         if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>                 return;
>
> +       ret = pm_runtime_get_sync(smmu->dev);
> +       if (ret)
> +               return;

pm_runtime_get_sync() will return 0 if the device was powered off, 1
if it was already/still powered on or runtime PM is not compiled in,
or a negative value on error, so shouldn't the test be (ret < 0)?

Moreover, I'm actually wondering if it makes any sense to power up the
hardware just to program it and power it down again. In a system where
the IOMMU is located within a power domain, it would cause the IOMMU
block to lose its state anyway.

Actually, reflecting back on "[PATCH v7 2/6] iommu/arm-smmu: Add
pm_runtime/sleep ops", perhaps it would make more sense to just
control the clocks independently of runtime PM? Then, runtime PM could
be used for real power management, e.g. really powering the block up
and down, for further power saving.

+Generally similar comments for other places in this patch.

> +
>         /*
>          * Disable the context bank and free the page tables before freeing
>          * it.
> @@ -932,6 +936,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>
>         free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>         __arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
> +
> +       pm_runtime_put_sync(smmu->dev);

Is there any point in the put being sync here?

[snip]

> @@ -2131,6 +2152,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>         if (err)
>                 return err;
>
> +       platform_set_drvdata(pdev, smmu);
> +
> +       pm_runtime_enable(dev);

I suspect this may be a disaster for systems where IOMMUs are located
inside power domains, because the driver doesn't take care of the
IOMMU block losing its state on physical power down, as I mentioned in
my comments above.

Best regards,
Tomasz
