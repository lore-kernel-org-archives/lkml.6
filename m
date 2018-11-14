Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FA5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B610F22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUmQUVU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B610F22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbeKOEAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:00:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36108 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732950AbeKOEAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:00:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so525205pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 09:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cOfTDhyV/l13Z99YOBzTU4ASBnqPM4veTV3UrpNLU8U=;
        b=LUmQUVU4WyCs9MbRR4tnyN+m/kS3DLPM5Mvp6v9xlpe0WJ2amPcqceJxIFHZdIFjIs
         QndZSuuA7NjrYNIjrEuVE8m5/o+knkWZmJehE0m1TjvDZ2VgbovIZJKEYb62+Xjj+9JY
         9RNIsJC2lq8l0zkrqYHRb9cgrkj/kpEWhtygo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cOfTDhyV/l13Z99YOBzTU4ASBnqPM4veTV3UrpNLU8U=;
        b=E6AZz43p8Wy58WsgaYfntlk2Qlm9PTdkN1KY7lKfR6a5Ns5fLKutwDlU4n2k2fon9q
         /3zLYweGgCM00s4qZYTDTvrgwrdEQNXf2YLdedRMp41OMWdZL9qHvYDEaGLvrGHnTPpC
         bRwCyJDyFLY97OieIoz19LCvfHqUSXXCiv0SMhU7f4FoG3ADlqieWy1kLWwhD4uiSPR4
         8qEmYW0gKRUHCz1RLi/fojDjif6jk2BmOBPVYgkPbQAWmtSDwnZEuerEJ7F5CyOjdLDi
         F/dApI+xA21YblD76TnbGu8zp/VduWQ5qiYqOBBKN+n5hHP7+sJLR04ibgR+gbwhrmQs
         Yagw==
X-Gm-Message-State: AGRZ1gJzyXxrLapL7KEqAWyv5W97KWMaM41FN4+3jDrtgzz0N6EWYZvi
        2FsVqAm0kgaikGA1OPz785RdQA==
X-Google-Smtp-Source: AJdET5fquKk+Knncpe8vc+VONqbnF/yEHQCAjpLpkisae9UMEtsC5meBewzCV9soZMDDiBxV2cug9Q==
X-Received: by 2002:a63:e80e:: with SMTP id s14mr2670371pgh.30.1542218160608;
        Wed, 14 Nov 2018 09:56:00 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id i2-v6sm21301738pgq.35.2018.11.14.09.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 09:55:59 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] efi/arm: libstub: pack FDT after populating it
Date:   Wed, 14 Nov 2018 09:55:42 -0800
Message-Id: <20181114175544.12860-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114175544.12860-1-ard.biesheuvel@linaro.org>
References: <20181114175544.12860-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 24d7c494ce46 ("efi/arm-stub: Round up FDT allocation to mapping
size") increased the allocation size for the FDT image created by the
stub to a fixed value of 2 MB, to simplify the former code that made
several attempts with increasing values for the size. This is reasonable
given that the allocation is of type EFI_LOADER_DATA, which is released
to the kernel unless it is explicitly memblock_reserve()d by the early
boot code.

However, this allocation size leaked into the 'size' field of the FDT
header metadata, and so the entire allocation remains occupied by the
device tree binary, even if most of it is not used to store device tree
information.

So call fdt_pack() to shrink the FDT data structure to its minimum size
after populating all the fields, so that the remaining memory is no
longer wasted.

Cc: <stable@vger.kernel.org> # v4.12+
Fixes: 24d7c494ce46 ("efi/arm-stub: Round up FDT allocation to mapping size")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/fdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 8830fa601e45..0c0d2312f4a8 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -158,6 +158,10 @@ static efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
 			return efi_status;
 		}
 	}
+
+	/* shrink the FDT back to its minimum size */
+	fdt_pack(fdt);
+
 	return EFI_SUCCESS;
 
 fdt_set_fail:
-- 
2.17.1

