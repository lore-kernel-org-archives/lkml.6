Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x225OujqbcN5AdMKcXehbksfJCG6iCXLJGbDq9kIkV2GB7VOaj9IB1BmH0GzieHsWLgD18NEL
ARC-Seal: i=1; a=rsa-sha256; t=1517999526; cv=none;
        d=google.com; s=arc-20160816;
        b=h7ESUGv9EgDgaZbNfy47jKB50mu+ETlWpa5u52gQEPa+IiynozaV9/LkX8uZL0YR5M
         4TgJgGVYiQcAF3jyAuWoVcpDG8GvsV8B8Oeh65LSpg1aEEnO3qN4uAyjOytslh14Rmxx
         /7SQtGSz4zQvpui0yh/FZTcdwmJXXT80wVAdGmoa8mluYOuypdqtTwARrClPmE+bpqsz
         IfoJhg57JSGxlu0AG68pcdwAvcHvax1aLObEWVPko53+ynduaP9ccif+W8/1D3khkxn0
         REnFLrET7g5tyzc3Hoik6xKH/F94ZjzhUtFc8tyQ7W+xGD7exDV1plvYulliflUHAJ2S
         jCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=8U+iN46xj9qrDvjJtqlGFYvqqkf3OR97hIwqHRczs8I=;
        b=EYjwiAl3OxQ6FjWCmYPh5EpusNcVjM9GbUIYHpiXvWsRkd51GOkEo2DfSQPbt/yZUc
         1n9Vk5iq+X2Ni+I+i0FyC6HHUXU3YpqrzeWlPV5elTta/f1Kd6a1F/kjIYi4zE49BhxX
         GVJxLzGj4BklqrZKoNF13uuOv2/4OCTnGMPUgJcpp/373V4N7KVsQsCXAspptoX8+DH7
         /olxwJG7L8E3CkNvtclXvBib3vWet4C+ym7Gnif1akaof6GqYpwkVDGS5VwRSpPP4RvI
         B/X7Xry4rkDUzMjqQV3UQi3mOHx10tao15giiNakym9xsLSqw/fjX3ZcBZk1dBrywEms
         KjQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n3bXvP2F;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FhoM/swA;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n3bXvP2F;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FhoM/swA;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D81F760767
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
Subject: [PATCH v7 4/6] iommu/arm-smmu: Add the device_link between masters and smmu
Date: Wed,  7 Feb 2018 16:01:20 +0530
Message-Id: <1517999482-17317-5-git-send-email-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737871126335112?=
X-GMAIL-MSGID: =?utf-8?q?1591737871126335112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sricharan R <sricharan@codeaurora.org>

Finally add the device link between the master device and
smmu, so that the smmu gets runtime enabled/disabled only when the
master needs it. This is done from add_device callback which gets
called once when the master is added to the smmu.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c024f69c1682..c7e924d553bd 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -215,6 +215,9 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	/* runtime PM link to master */
+	struct device_link *link;
 };
 
 enum arm_smmu_context_fmt {
@@ -1425,6 +1428,17 @@ static int arm_smmu_add_device(struct device *dev)
 
 	pm_runtime_put_sync(smmu->dev);
 
+	/*
+	 * Establish the link between smmu and master, so that the
+	 * smmu gets runtime enabled/disabled as per the master's
+	 * needs.
+	 */
+	smmu->link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
+	if (!smmu->link)
+		dev_warn(smmu->dev,
+			 "Unable to create device link between %s and %s\n",
+			 dev_name(smmu->dev), dev_name(dev));
+
 	return 0;
 
 out_rpm_put:
@@ -1449,6 +1463,8 @@ static void arm_smmu_remove_device(struct device *dev)
 	cfg  = fwspec->iommu_priv;
 	smmu = cfg->smmu;
 
+	device_link_del(smmu->link);
+
 	ret = pm_runtime_get_sync(smmu->dev);
 	if (ret)
 		return;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
