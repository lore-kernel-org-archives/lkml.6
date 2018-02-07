Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x227CBWJBc//qIxqqUEVXNPGHYDDR5WM2XcCoMLEkkb+md0vn5qfq8+0HHHlX6hl2uqeCbNvU
ARC-Seal: i=1; a=rsa-sha256; t=1517999541; cv=none;
        d=google.com; s=arc-20160816;
        b=llaC3sh8emrh/yQi9F1ZlA2ZtHW7Q8yxdheTNBE4yVPZV+MhM2q2rQ1MbmPSZzEik4
         zg0iCPdPa0tnjcePFIKHvNfgAoZkm/m7Lb06lWtPQpqWcZwvpGJr9nvgr1HlC0KNiNz5
         7UXlhAfpAQCrkRHKn3OoHp4DX6FQ/kw0b9ly24ncZ6qukcW1GaOcVD2rG/8MSFJu2Ylg
         YxudTxcy7+taNedClp2njopwzaG7cHb25TJi0UxRfhgQ6kHkjIvnOdlElN87m3OqtpgV
         YvSFNZ2Cqtnri9R7nRwb5gkqwtSVCWtFpIWdebEHhDGyFY1+tj/cGZ6bedYJ/XASlMQx
         4klw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=GAYsFhRKtS+DGntjqcrp92XcwgwAeQopfzdTga6yJpY=;
        b=mIOfGlC1tAar/6JcyRHLlJqE7BbbMoBn05eHqCnOtaQu1k5IZZ0h8O8HXE7YHw0qZN
         48DcuTqL3SyqTWpoXJRPQCsM1nPhkTPk8I6k2spu7FLZzcoFt8bbRfb/xU6jGTwmXQXB
         uJQdkfOWJmJpiHj5QWX77HL+3HQ8QgrCHViCOlHEM3XqecYUDk9EuTrV8jGe6Orpw8qH
         57rl9CIItsoPKMMJXbdMYBTgd2VrUQQDiduvQdvKXn2TPI33sN4zKyb7rz1/VGA8ZTdF
         jqUI745wn8IX4gwMh/NCMPXcB9g5dOuRy/BqahJF79nDBOfAFrnz61Jc9qyRH3KVXp66
         b4Pw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kQwbTNNP;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HthXyIdz;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kQwbTNNP;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=HthXyIdz;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 057B260790
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
Subject: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime suppliers
Date: Wed,  7 Feb 2018 16:01:22 +0530
Message-Id: <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737886832187485?=
X-GMAIL-MSGID: =?utf-8?q?1591737886832187485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

While handling the concerned iommu, there should not be a
need to power control the drm devices from iommu interface.
If these drm devices need to be powered around this time,
the respective drivers should take care of this.

Replace the pm_runtime_get/put_sync(<drm_device>) with
pm_runtime_get/put_suppliers(<drm_device>) calls, to power-up
the connected iommu through the device link interface.
In case the device link is not setup these get/put_suppliers()
calls will be a no-op, and the iommu driver should take care of
powering on its devices accordingly.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index b23d33622f37..1ab629bbee69 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -40,9 +40,9 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 	int ret;
 
-	pm_runtime_get_sync(mmu->dev);
+	pm_runtime_get_suppliers(mmu->dev);
 	ret = iommu_attach_device(iommu->domain, mmu->dev);
-	pm_runtime_put_sync(mmu->dev);
+	pm_runtime_put_suppliers(mmu->dev);
 
 	return ret;
 }
@@ -52,9 +52,9 @@ static void msm_iommu_detach(struct msm_mmu *mmu, const char * const *names,
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 
-	pm_runtime_get_sync(mmu->dev);
+	pm_runtime_get_suppliers(mmu->dev);
 	iommu_detach_device(iommu->domain, mmu->dev);
-	pm_runtime_put_sync(mmu->dev);
+	pm_runtime_put_suppliers(mmu->dev);
 }
 
 static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
@@ -63,9 +63,9 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 	size_t ret;
 
-//	pm_runtime_get_sync(mmu->dev);
+	pm_runtime_get_suppliers(mmu->dev);
 	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
-//	pm_runtime_put_sync(mmu->dev);
+	pm_runtime_put_suppliers(mmu->dev);
 	WARN_ON(ret < 0);
 
 	return (ret == len) ? 0 : -EINVAL;
@@ -76,9 +76,9 @@ static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova,
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 
-	pm_runtime_get_sync(mmu->dev);
+	pm_runtime_get_suppliers(mmu->dev);
 	iommu_unmap(iommu->domain, iova, len);
-	pm_runtime_put_sync(mmu->dev);
+	pm_runtime_put_suppliers(mmu->dev);
 
 	return 0;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
