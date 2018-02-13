Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518509052; cv=none;
        d=google.com; s=arc-20160816;
        b=DYGAsUeA92+dOjRQd1XtZGzF56A+exQPihrNfbubjWs4zdswoSr2WcYd8lnj1d6LWW
         qv9AQnJ4gnfUzOybm2JBQUi63pn2c6tvbpXfsWZgSxzeFo+cVaNcwVbyc4z0Ui1Q3Tsc
         Qe6iCQUyM+9KxVsaIt3xh54n0O6EBw6ktovQRsPiBKGofUtA+gV2lJMxS2hP0vPz3+fe
         Q3NeRHhlGJP1DU+Hf+mmRss8NFZIez4w9TPFCLs5+vJwCZyk+wKDTO5wP4+vHInS+268
         Quo3vWQKgePf4T9/5Phy26Z2bwfxkrevvenwn2uA2M95qsJj49vxppYrlvZ8X/9xGdtY
         elbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=KSEe8sooJZLGzHQBewQf9xocluTnQeakksjHEwUXMI4=;
        b=l4FztVaLQVqhTuG2qDvEL5kWtUen4ZKdniw2bEIlbsgVRdknmF8x6OmqQgQxfJ71HO
         LmQiUig8ga+19qYnvJmYCKo/OreGR/N22nG/dqNaCl9CjdrdyR3wMXHaKBUVKoAB+DZD
         6Sx6rupvOQSRgK/Vr6nA7b3g1LLrc3GXuDPqWTVqS4AQzkWLoHNEcDhk032Da90L94Te
         TfC2hKRVoKwSHOR6fepKea/JON3aYXeFXHb8n/pnJ2ju1/mqxnOwWESCRI34X9KQSr16
         Cib76zXStLo+70Zq6SePGubEU1PRHwAXzB8BKNBZyemPKHNkbNGuWEfvOqgb44h5BDJJ
         7rDw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=KYEFY77a;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=KYEFY77a;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x226tRkA6LFn9CtiDdtr8ZnTXKkkW0t/ivoJMhIe+oVeLcNteioWBdEgPaErneTJhnAmGcmtdkg==
MIME-Version: 1.0
In-Reply-To: <1517999482-17317-3-git-send-email-vivek.gautam@codeaurora.org>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org> <1517999482-17317-3-git-send-email-vivek.gautam@codeaurora.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 13 Feb 2018 17:03:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B2u8RL-tdB3qgPxVUcXnsBSEhXRBZWxqO-w6rYKAiOtg@mail.gmail.com>
Message-ID: <CAAFQd5B2u8RL-tdB3qgPxVUcXnsBSEhXRBZWxqO-w6rYKAiOtg@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] iommu/arm-smmu: Add pm_runtime/sleep ops
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
X-GMAIL-THRID: =?utf-8?q?1591737857427495630?=
X-GMAIL-MSGID: =?utf-8?q?1592272148197084935?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vivek,

Thanks for the patch. Please see some comments inline.

On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> From: Sricharan R <sricharan@codeaurora.org>
>
> The smmu needs to be functional only when the respective
> master's using it are active. The device_link feature
> helps to track such functional dependencies, so that the
> iommu gets powered when the master device enables itself
> using pm_runtime. So by adapting the smmu driver for
> runtime pm, above said dependency can be addressed.
>
> This patch adds the pm runtime/sleep callbacks to the
> driver and also the functions to parse the smmu clocks
> from DT and enable them in resume/suspend.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Archit Taneja <architt@codeaurora.org>
> [vivek: Clock rework to request bulk of clocks]
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 69e7c60792a8..9e2f917e16c2 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -48,6 +48,7 @@
>  #include <linux/of_iommu.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>
> @@ -205,6 +206,8 @@ struct arm_smmu_device {
>         u32                             num_global_irqs;
>         u32                             num_context_irqs;
>         unsigned int                    *irqs;
> +       struct clk_bulk_data            *clocks;
> +       int                             num_clks;

nit: Perhaps "num_clocks" to be consistent with "clocks"?

>
>         u32                             cavium_id_base; /* Specific to Cavium */
>
> @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>  struct arm_smmu_match_data {
>         enum arm_smmu_arch_version version;
>         enum arm_smmu_implementation model;
> +       const char * const *clks;
> +       int num_clks;

nit: Perhaps s/clks/clocks/ here or s/clocks/clks/ in struct arm_smmu_device?

>  };
>
>  #define ARM_SMMU_MATCH_DATA(name, ver, imp)    \
> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
>
>  ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>  ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
> @@ -2001,6 +2006,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>         data = of_device_get_match_data(dev);
>         smmu->version = data->version;
>         smmu->model = data->model;
> +       smmu->num_clks = data->num_clks;
>
>         parse_driver_options(smmu);
>
> @@ -2039,6 +2045,28 @@ static void arm_smmu_bus_init(void)
>  #endif
>  }
>
> +static int arm_smmu_init_clks(struct arm_smmu_device *smmu)
> +{
> +       int i;
> +       int num = smmu->num_clks;
> +       const struct arm_smmu_match_data *data;
> +
> +       if (num < 1)
> +               return 0;
> +
> +       smmu->clocks = devm_kcalloc(smmu->dev, num,
> +                                   sizeof(*smmu->clocks), GFP_KERNEL);
> +       if (!smmu->clocks)
> +               return -ENOMEM;
> +
> +       data = of_device_get_match_data(smmu->dev);
> +
> +       for (i = 0; i < num; i++)
> +               smmu->clocks[i].id = data->clks[i];

I'd argue that arm_smmu_device_dt_probe() is a better place for all
the code above, since this function is called regardless of whether
the device is probed from DT or not. Going further,
arm_smmu_device_acpi_probe() could fill smmu->num_clks and ->clocks
using ACPI-like way (as opposed to OF match data) if necessary.

Best regards,
Tomasz
