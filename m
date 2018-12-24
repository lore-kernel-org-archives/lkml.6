Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AA8C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F15217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BE5t+fL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbeLXRVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 12:21:17 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33625 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeLXRVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 12:21:16 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so13513250qtp.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 09:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4OrDwa1rKL98Mft8nlw89p0fxqKHRgZE62ZIu44HOOU=;
        b=BE5t+fL3uk9qaN1rYqk+9esUmYgln7w8k9hl1bu4t+/2IFpSn8njV+aVHBtz9PwPw9
         Heje8Y288sKQAWS+N+VX9T+T40P9hKZntnx8EbrWIMI130evAFMHSkyZUCIM+dDhqhZM
         PC8lprYQJLoRKJ+hckd9lQmAwpxty7SLybiIf23SEsKB47iutzj+Ji0A/RWRssa67PsJ
         Q9s5uOTz5nrxMO9NjlhL6jqHFl9B4pY/PxfLxLshUmw4ewLCiDN5q0vBEs9Ol9WjLBbo
         dwLEmdIfydZlBGk7Dk1H6A+ksNBs33EU4VHDQKuVz2IhUFeG4fXWx+yVk0Q4C4OhOhdl
         9VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4OrDwa1rKL98Mft8nlw89p0fxqKHRgZE62ZIu44HOOU=;
        b=IlgpYWRUQeLfLGzGVVKWaKJUKhDYL/8PgsYl5lucwwaQGi4EgxnyXDarbEvUkvNyAe
         PcFI5+mhY++vVhAjk79EVFmBDol7/YWB2t1IfwCVTqwywkTaBXeQ2g0f5hPYOLWkTT6X
         ZAinthqc2Ra1sEvJXCYBk+n0IlnCSmtVUuAVyMTda9M2WYB1flQrq6JBiFJ6v0yZH+F0
         WkmgdW1EYDsKkqUaRye87sO7Kw9KIEHIpzLRqDgB1ZAsgxP1E22pNnoOOtOCKo14XEM2
         T9CRlZ9oIZCcv+LK/dxXbMDm7wT+chtvdlkiLzsVJUuvptEsSTXxWpxMcRUvS3pE8W93
         FmFw==
X-Gm-Message-State: AJcUukc7bxeie03SbH9BZkgGcfNN/6P063FLM0okq4pYSbqy0cR9B7EE
        VtBUPzTpjbWCurTElTzw4Ddt2g==
X-Google-Smtp-Source: ALg8bN7Lksil31fM2YaXGu7o54Uw6mf4fW9sbZlF2I9IEv4FmCEnpgebIS6HgpeX+vsvrh9+7NJCyA==
X-Received: by 2002:a0c:e010:: with SMTP id j16mr12706478qvk.111.1545672075477;
        Mon, 24 Dec 2018 09:21:15 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d45sm11751553qtd.56.2018.12.24.09.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 09:21:14 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     sfr@canb.auug.org.au, lorenzo.pieralisi@arm.com,
        hanjun.guo@linaro.org, sudeep.holla@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] ACPI/IORT: fix build when CONFIG_IOMMU_API=n
Date:   Mon, 24 Dec 2018 12:20:58 -0500
Message-Id: <20181224172058.56206-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rivers/acpi/arm64/iort.c:880:1: error: expected identifier or '(' before '{' token
 { return NULL; }
 ^
drivers/acpi/arm64/iort.c:879:39: warning: 'iort_fwspec_iommu_ops' used but never defined
 static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
                                       ^~~~~~~~~~~~~~~~~~~~~
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index fdd90ffceb85..5d29783ee5bd 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -876,7 +876,7 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 	return (resv == its->its_count) ? resv : -ENODEV;
 }
 #else
-static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev);
+static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
 { return NULL; }
 static inline int iort_add_device_replay(const struct iommu_ops *ops,
 					 struct device *dev)
-- 
2.17.2 (Apple Git-113)

