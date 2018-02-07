Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x224mJnFrR+qSU6a3Qp3zcXuwDksGTUNxol1p8IKCW0SN6yd3rv/Aj+3KLL00Biaz6fZBhKdM
ARC-Seal: i=1; a=rsa-sha256; t=1517999505; cv=none;
        d=google.com; s=arc-20160816;
        b=fTmpGzd1Tsy4bFYKr9sASQOZv9a+NHsPA0fUN7Mo8J0HCR+3Wjt/mZaIAEH1Zha9tX
         mo45VmjMF9164MwTsMmPilVstc1v+p9giTY0i64j+wqp/Kb/0AyXMzS82BCYRdSTaKXA
         nIFD54HarpPpUlus/JYKGfwssR7VDVIiigmH+Hg1gLR0NzlZ0vVT81h7hzoH87sG70Jz
         b0h4L8hdlPGw8k8LDl78lnlFSFnMfe7r5rn7wGTyN/pqzoHB1PnzfYA5QBTAGB9wSZGd
         l33wvu18udxyCZ2Dt9b/3H17AOdb10fqIhdXjNdaplOjV0YzPkfLIzdcOtX9reTz3SuU
         Qz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=pKjVePRHiQltmewVilz29PPZAGayLz76swbviy7Z7Hw=;
        b=R1zSbVd6GTbMduzqlxIlwS6zW/+7c3RPvU7dGinXZmdPe2YXw4/uJl5MDl0bmzxLlR
         qAQFmx0Bd3oUb3itCXuLUrXOlxSHxzOERweUsWrlHH8ZpiCaKF3frzcClquRAwL5lkF+
         8am+hVT0ttQ/caLAVe4rUMTzLD1YYBPigKN2FBIiqncWa0S6ja7ppHmDET0/3IuP7ycZ
         gB1SsGC2l6PgCmHh/5TiLdBRnzOMVJfwluHPZGvKkz/cUGzlv4EaXMBRuJi5XoW7UruD
         /v1CuIgBojVhYFIrq5f8ZcSJFicccGK9NqFgYDOcTOPPYCd8bCiS/pnCvgdrv8NnbofG
         lMSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IrW5KVa/;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cLU5OLyk;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IrW5KVa/;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cLU5OLyk;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99F1660272
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
Subject: [PATCH v7 1/6] base: power: runtime: Export pm_runtime_get/put_suppliers
Date: Wed,  7 Feb 2018 16:01:17 +0530
Message-Id: <1517999482-17317-2-git-send-email-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737849838824813?=
X-GMAIL-MSGID: =?utf-8?q?1591737849838824813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The device link allows the pm framework to tie the supplier and
consumer. So, whenever the consumer is powered-on the supplier
is powered-on first.

There are however cases in which the consumer wants to power-on
the supplier, but not itself.
E.g., A Graphics or multimedia driver wants to power-on the SMMU
to unmap a buffer and finish the TLB operations without powering
on itself. Some of these unmap requests are coming from the
user space when the controller itself is not powered-up, and it
can be huge penalty in terms of power and latency to power-up
the graphics/mm controllers.
There can be an argument that the supplier should handle this case
on its own and there should not be a need for the consumer to
power-on the supplier. But as discussed on the thread [1] about
ARM-SMMU runtime pm, we don't want to introduce runtime pm calls
in atomic path in arm_smmu_unmap.

[1] https://patchwork.kernel.org/patch/9827825/

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 8bef3cb2424d..5b8226c8af19 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1579,6 +1579,7 @@ void pm_runtime_get_suppliers(struct device *dev)
 
 	device_links_read_unlock(idx);
 }
+EXPORT_SYMBOL_GPL(pm_runtime_get_suppliers);
 
 /**
  * pm_runtime_put_suppliers - Drop references to supplier devices.
@@ -1597,6 +1598,7 @@ void pm_runtime_put_suppliers(struct device *dev)
 
 	device_links_read_unlock(idx);
 }
+EXPORT_SYMBOL_GPL(pm_runtime_put_suppliers);
 
 void pm_runtime_new_link(struct device *dev)
 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
