Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DB4C46463
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184882087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZso0ALI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184882087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJKLuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 07:50:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36313 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeJKLuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 07:50:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id y11-v6so3546274plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 21:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pvlQjB+1GcKl8f0B/W3F+gqZtLa3iEUkFNrQtPj3HWc=;
        b=ZZso0ALIqKqy3w5dviyj2zQjJEsicQnTcuRJTUAmXDVBXdwqbd57apR/URuhGF/1hC
         jJtdxgZ28ytj3GMbOZWlv5nf8u27sz1b+j32ZqVxDUqC6N2uaFinwc/cOjETxGn2Lft0
         M5rnZjx5XqCUwKoKyL/ytVhj3p3s3fy25rM64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pvlQjB+1GcKl8f0B/W3F+gqZtLa3iEUkFNrQtPj3HWc=;
        b=adligp9sFqngDdHdrn8lOWt/aqkqWSCqw3+4nhnECC5MINHuCwuPCj4faRqNYOWGeC
         aFfJBpUuO7Ajk345RKsYB/aNhAz374a/WdMoIJ+i4A+h6BGlVq9/o5mfUp85js4Ttr1q
         HiL4PQEd/Y/mSVUFswG7LlAqiUe3sTfWcoXvxWIZYBIqDFhk+VkEVcRbtRKm/8puogcK
         d7rDPLMWSOeg7n3/h9CU/g1vJa2mxMsesNgfrjjjb+du15aUSj94GD+MnXCndPmuadyZ
         YcaIznIgBIbs2tyHymsnNnzNATWRKmnHbesSkZriFMLnFHrOV4VYObL1Z4FfoBNa0Hgk
         VozQ==
X-Gm-Message-State: ABuFfogPD5XHnuJxcNUM3WmAATr2k4CQoa0l+cAtGZrjKHWJ/F9eyiUz
        E+r6rCGAZ8tM+RKgTAj3Q74CvA==
X-Google-Smtp-Source: ACcGV61dG57w55vVcWlteGPfLCG5fGiPHw29GhWl59hCQmZE3KHGMUY6L8WP9Th2cukBQHDdbzHy0w==
X-Received: by 2002:a17:902:9896:: with SMTP id s22-v6mr2139054plp.113.1539231930947;
        Wed, 10 Oct 2018 21:25:30 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id n63-v6sm26113748pfn.9.2018.10.10.21.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Oct 2018 21:25:30 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 1/7] ia64: add __NR_old_getpagesize in uapi/asm/unistd.h
Date:   Thu, 11 Oct 2018 09:54:49 +0530
Message-Id: <1539231895-4118-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sys_getpagesize entry is present in entry.S file to support
for old user interface. So we need to add an uapi entry too.

Add __NR_old_getpagesize in order to not break old user space
as it is reserved for backwards compatibility with old __NR_
getpagesize.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/ia64/include/uapi/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index 5fe71d4..4d590c9 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -161,7 +161,7 @@
 #define __NR_nanosleep			1168
 #define __NR_nfsservctl			1169
 #define __NR_prctl			1170
-/* 1171 is reserved for backwards compatibility with old __NR_getpagesize */
+#define __NR_old_getpagesize            1171
 #define __NR_mmap2			1172
 #define __NR_pciconfig_read		1173
 #define __NR_pciconfig_write		1174
-- 
1.9.1

