Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x226luj/21McUVYY7ZgWy91v9Cv2UIsbeR6rZJR4y7Aply2v0z2u1xHKimtbvYiTkKmq4vwMn
ARC-Seal: i=1; a=rsa-sha256; t=1517999520; cv=none;
        d=google.com; s=arc-20160816;
        b=fsYHkIC0q05aDvpFIufZ7adh3S7e1AHp6LytgJa/jYQ4q8P6FZ0zetMj1urItJLUtB
         hHmJIyA4vutLyJj7pZfk4fdJoOcJVZFW0MjdSrxz2YJBRkL9jknxzSVFMeW0UNsQCXBA
         RAp4n874xrBgtYlU/nc8piht/mtnXI+S/rPBlsYcViruGwVu+SCr9OEgxr6B7XKaDQp4
         9XT7p+33WYSHwmM1lotpvcwJ05VZBCNN3iZ6qAQbhnrRJ39XFz6HHaaFrGmGKnlukww2
         5H9e729n1wZMa+92uQYXUTrM5ZF2UsMtTqXqt0b7pWIM695Nce7lED61oVEFG7XXtoDD
         V5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=C+b6uNMG0xjr1YoTlOhk6oXGJd8pmwrHR6U/xtY6o30=;
        b=S72Rg0OGFuPm+VoXpm/4eoUrf5VJYE7xk58tTVUnkbNTCH9gtmLKwruPX5fwQbgbEX
         lQMxpOM+zAcLf/eV5dDReRB6MylONQTGT4jlcTXqpSDTxsWWkikZHhBUlHYo8AVQLHAw
         wFRZFGVoaFYA459zCE/k8UWClegJI7Zsh7lqhs3GlVeEp7Li6/t22te8mMmeQrhj4JQe
         ZtbPOy6OP40DvBTOiYOMkkA2eppQtqpb0QMM1sk2dbFM0S2bqG8OhHglCEBlaE9Xrw1W
         3sW47kjNh9QNz0ENByuBrSlnmTe6IXyaw6wHKsrKTA98MPf4rZD4wcy4h/ItjVS59hEb
         LPPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=gp/fuyOH;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WG2K7uMR;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=gp/fuyOH;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WG2K7uMR;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4B6360272
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From: Vivek Gautam <vivek.gautam@codeaurora.org>
To: joro@8bytes.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	rjw@rjwysocki.net,
	robin.murphy@arm.com,
	will.deacon@arm.com,
	robdclark@gmail.com,
	iommu@lists.linux-foundation.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Cc: alex.williamson@redhat.com,
	gregkh@linuxfoundation.org,
	airlied@linux.ie,
	sboyd@codeaurora.org,
	sricharan@codeaurora.org,
	m.szyprowski@samsung.com,
	architt@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	vivek.gautam@codeaurora.org
Subject: [PATCH v7 3/6] iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
Date: Wed,  7 Feb 2018 16:01:19 +0530
Message-Id: <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737865178016622?=
X-GMAIL-MSGID: =?utf-8?q?1591737865178016622?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sricharan R <sricharan@codeaurora.org>

The smmu device probe/remove and add/remove master device callbacks
gets called when the smmu is not linked to its master, that is without
the context of the master device. So calling runtime apis in those places
separately.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
[vivek: Cleanup pm runtime calls]
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9e2f917e16c2..c024f69c1682 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -913,11 +913,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	int irq;
+	int ret, irq;
 
 	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
 
+	ret = pm_runtime_get_sync(smmu->dev);
+	if (ret)
+		return;
+
 	/*
 	 * Disable the context bank and free the page tables before freeing
 	 * it.
@@ -932,6 +936,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
+
+	pm_runtime_put_sync(smmu->dev);
 }
 
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
@@ -1407,14 +1413,22 @@ static int arm_smmu_add_device(struct device *dev)
 	while (i--)
 		cfg->smendx[i] = INVALID_SMENDX;
 
-	ret = arm_smmu_master_alloc_smes(dev);
+	ret = pm_runtime_get_sync(smmu->dev);
 	if (ret)
 		goto out_cfg_free;
 
+	ret = arm_smmu_master_alloc_smes(dev);
+	if (ret)
+		goto out_rpm_put;
+
 	iommu_device_link(&smmu->iommu, dev);
 
+	pm_runtime_put_sync(smmu->dev);
+
 	return 0;
 
+out_rpm_put:
+	pm_runtime_put_sync(smmu->dev);
 out_cfg_free:
 	kfree(cfg);
 out_free:
@@ -1427,7 +1441,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct arm_smmu_master_cfg *cfg;
 	struct arm_smmu_device *smmu;
-
+	int ret;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
@@ -1435,8 +1449,15 @@ static void arm_smmu_remove_device(struct device *dev)
 	cfg  = fwspec->iommu_priv;
 	smmu = cfg->smmu;
 
+	ret = pm_runtime_get_sync(smmu->dev);
+	if (ret)
+		return;
+
 	iommu_device_unlink(&smmu->iommu, dev);
 	arm_smmu_master_free_smes(fwspec);
+
+	pm_runtime_put_sync(smmu->dev);
+
 	iommu_group_remove_device(dev);
 	kfree(fwspec->iommu_priv);
 	iommu_fwspec_free(dev);
@@ -2131,6 +2152,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	platform_set_drvdata(pdev, smmu);
+
+	pm_runtime_enable(dev);
+
+	err = pm_runtime_get_sync(dev);
+	if (err)
+		return err;
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2172,9 +2201,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
+	pm_runtime_put_sync(dev);
 
 	/*
 	 * For ACPI and generic DT bindings, an SMMU will be probed before
@@ -2211,8 +2240,13 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_err(&pdev->dev, "removing device with active domains!\n");
 
+	pm_runtime_get_sync(smmu->dev);
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	pm_runtime_put_sync(smmu->dev);
+
+	pm_runtime_disable(smmu->dev);
+
 	return 0;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
