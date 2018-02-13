Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518511056; cv=none;
        d=google.com; s=arc-20160816;
        b=Objtm49f/5qZCkuK1vHofSBxTrgmXx14aDA0/VzbU5i5/hEfAeeEotvuBz7KWGaVuf
         ddg1slFNr6i849ImxQERfxhb0UKXUiYvoPdnzNFZR2nUfzg9r2FjblMDqpi1Iu2Q/iSH
         Vty9bOOr93DKxnmuTG0aOn7T5lIlIm7IY+Kh29ohdJzleRlFlScmNGupyVLkIQ5n52Rw
         3tu2BQN27+Jm0NaaKsW2697ssqFFf/EHrmDI/j0iQngLnxQttsKHQPkDcHsLBveaMICv
         mqi/ig1j1Wk1km+AqWfSCNBNEl+5Fk3cqASs1zTh8olOBffEyWFm60qwLPddS2f5C0t9
         IpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=MaechsA5XcwsMkh6AvJdZRDthLwnkQdJptK7LZebCRk=;
        b=q5vioUp4WXujSuajNh6Tz6uZhNenVZPivP+6xgwbqphCUCY91cHgDpZO7hJNAD4jnx
         NNejFDDv0JA8Z1XnsV5XjyHr10pa1q4LQXLa/mtT8FIRMwHO85gufotxLjsOLJwjHFj1
         0ih4q7wz91E0wuE1m/1JqnqakKNecUmDpE9ZLJQFWD03vmekLEVnuADAHST1bekZMAfc
         MniXlA4nXNtNfoJ7Se3L0vuI1KJ1UBrv1ADSKBqf+RewHzKBaw17V/VPgbuJvws4h55L
         G48oVLs3FhtWoqF/ZpyGrZVuLgNAoK+WsQ+nJvez+xGgGcyVsVz4cR2nMKe0rcJWQ3dy
         6xOA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=QHgZeKVr;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=QHgZeKVr;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x225BVi2IHmwq9jBi0y9QvroDuAV4TGOTp9ch6xIbn6tkmNowaxq9GYKbh7WlizKMdOoxHU2ipA==
MIME-Version: 1.0
In-Reply-To: <1517999482-17317-5-git-send-email-vivek.gautam@codeaurora.org>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org> <1517999482-17317-5-git-send-email-vivek.gautam@codeaurora.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 13 Feb 2018 17:31:57 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BQAs9=N27_Z0pJNSrndFY3vFin2KBP44UtiW+tMXy5nQ@mail.gmail.com>
Message-ID: <CAAFQd5BQAs9=N27_Z0pJNSrndFY3vFin2KBP44UtiW+tMXy5nQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] iommu/arm-smmu: Add the device_link between
 masters and smmu
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
X-GMAIL-THRID: =?utf-8?q?1591737871126335112?=
X-GMAIL-MSGID: =?utf-8?q?1592274249451780778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vivek,

Thanks for the patch. Please see my comments inline.

On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> From: Sricharan R <sricharan@codeaurora.org>
>
> Finally add the device link between the master device and
> smmu, so that the smmu gets runtime enabled/disabled only when the
> master needs it. This is done from add_device callback which gets
> called once when the master is added to the smmu.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index c024f69c1682..c7e924d553bd 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -215,6 +215,9 @@ struct arm_smmu_device {
>
>         /* IOMMU core code handle */
>         struct iommu_device             iommu;
> +
> +       /* runtime PM link to master */
> +       struct device_link *link;
>  };
>
>  enum arm_smmu_context_fmt {
> @@ -1425,6 +1428,17 @@ static int arm_smmu_add_device(struct device *dev)
>
>         pm_runtime_put_sync(smmu->dev);
>
> +       /*
> +        * Establish the link between smmu and master, so that the
> +        * smmu gets runtime enabled/disabled as per the master's
> +        * needs.
> +        */
> +       smmu->link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
> +       if (!smmu->link)
> +               dev_warn(smmu->dev,
> +                        "Unable to create device link between %s and %s\n",
> +                        dev_name(smmu->dev), dev_name(dev));

How likely it is that the master can work normally even if the link
add fails? Perhaps we should just return an error here?

> +
>         return 0;
>
>  out_rpm_put:
> @@ -1449,6 +1463,8 @@ static void arm_smmu_remove_device(struct device *dev)
>         cfg  = fwspec->iommu_priv;
>         smmu = cfg->smmu;
>
> +       device_link_del(smmu->link);

We allowed smmu->link in arm_smmu_add_device(), but here we don't
check it. Looking at the code, device_link_del() doesn't seem to check
either.

Note that this problem would go away if we fail add_device on
device_link_add() failure, as I suggested above, so no change would be
necessary.

Best regards,
Tomasz
