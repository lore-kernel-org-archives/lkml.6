Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4965C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A09521780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJsTQBVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A09521780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbeKMQzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:55:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34773 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730954AbeKMQy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:54:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so5547770plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 22:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iwuQzM0VZ11k1S/77GRmgGuUgIYiEd0SERqYJJ4m9Mg=;
        b=jJsTQBVx6bqeqNChwacMSdjPiZ7MkJnrGDTz7aWPy6lKmObuicwbz74alBnPlhaTHP
         sUb43tXdurhgiYbKZ2Pl4KUSi5QgXvl+chdjwAUodVN7aRxV0OaSma2qjvmfsIHtFuE4
         9gzBz0tDj6c+hJIy1GMIBCMpW4tj6Lgl3yitw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iwuQzM0VZ11k1S/77GRmgGuUgIYiEd0SERqYJJ4m9Mg=;
        b=OkKHsgd4HektrOA+WZWm8jKM5kbpV8wZGGSOrkuNhxIPRmdQbIDKdmkEvGAGCwNUe8
         njZn02nuYnll0yoPxbQ3WwtY6oeWKw5cjJn+IamhHHYVBJhdE/Jee6fdFhbspVRZQ5Qb
         X1s0ry91Jjawrq22szBSEFnMyxEjjkeCXLZXXY4n3Ae8yJJ1IwWreqr5aFZ7rFQL1txk
         EeYQg5NuxK+UJYEA8+kSPYMrOyhkSQkbbEj+uyB0TWvu1RKnhPcZ/T3BIshf2+CGaBLt
         8zRRxAMBbX0+HVN55zDvv5JegxpYqwBCLfpypsZTWBV1kTaHpKuhDpU7AH/HkUjIqVQg
         EUrg==
X-Gm-Message-State: AGRZ1gIsbSsAF67NmydAYK2o/UUQDp1QVoU0QB3o23w903v9mOdEMXeT
        O2w/75UTRaLolc3F1egCGWF5OQ==
X-Google-Smtp-Source: AJdET5dlquPln3x6WmBeYFTureig6KgNz9AqKYBZ7I9sjYp1j9SbNJP7xSc34TC0KOnfHxwsU62K3A==
X-Received: by 2002:a17:902:e089:: with SMTP id cb9-v6mr3799007plb.196.1542092296963;
        Mon, 12 Nov 2018 22:58:16 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id s186-v6sm42437935pfs.164.2018.11.12.22.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 22:58:16 -0800 (PST)
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
Subject: [PATCH v5 1/5] ia64: add __NR_old_getpagesize in uapi header file
Date:   Tue, 13 Nov 2018 12:27:41 +0530
Message-Id: <1542092265-20956-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542092265-20956-1-git-send-email-firoz.khan@linaro.org>
References: <1542092265-20956-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sys_getpagesize entry is present in kernel/entry.S file to
support for old user interface. So we need to add an uapi
entry too.

Add __NR_old_getpagesize in uapi/asm/unistd.h in order to
not break old user space as it is reserved for backwards
compatibility with old __NR_getpagesize.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/ia64/include/uapi/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index 5fe71d4..94b835c 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -161,7 +161,7 @@
 #define __NR_nanosleep			1168
 #define __NR_nfsservctl			1169
 #define __NR_prctl			1170
-/* 1171 is reserved for backwards compatibility with old __NR_getpagesize */
+#define __NR_old_getpagesize		1171
 #define __NR_mmap2			1172
 #define __NR_pciconfig_read		1173
 #define __NR_pciconfig_write		1174
-- 
1.9.1

