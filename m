Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8407EC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B86021EFA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EVMgSCxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B86021EFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbeHITnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:43:15 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33365 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732658AbeHITnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:43:14 -0400
Received: by mail-pl0-f65.google.com with SMTP id b90-v6so2831980plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjdZOltjtYWDyJJerGHK5HPOkjVhAOMmtOfinQzFu2c=;
        b=EVMgSCxeg7CCqYuz8hEYRRK7T2kzw7gTr+BBdhyv3G8QraxZ4PTn7WEzovnpNVrAhJ
         0G1ChoKKfw1K+LtxhqVY/MCM6jE5ZCdZ0oVkPjCVmaEUGTmxdxgjfVmI9GSz2dYPSfwW
         gd+tGv+N4NoTfLpzk2zsNAHA/dEwRoroM51wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjdZOltjtYWDyJJerGHK5HPOkjVhAOMmtOfinQzFu2c=;
        b=BB7YSiys5mU8atpKr0TiMK43JY7uUchjl+KLDZ+hHAL4ifMtQNqnCyyhYh5UFihvF5
         S/bSuGNW2OwiIOilZ2nvf8SaDoO1fyKAHda9NiMw6D7DWLWejxkrPfH1n0rr17esFkdb
         ahpQ91lFfIkxy+gQKVz1o/rzrbXTTVwPbeQEP69RCL9lbZcDFWpbsMoOuiGXuC/ule3/
         g8R6sg27wrwbanea+Ihmnq1cSsRt8O7KQDO2U3YJ9wge845dpYL2lXIRfnMm/dKBl7LV
         p+j9BWjimNfx55sUSblmx1XRGI6AwhLT5032ceAbTP1cGctgjT1GS1kAFujsYMkAEr6j
         /FdQ==
X-Gm-Message-State: AOUpUlEQhvx903GlYVWOTyKhrvRE0RtrbxuPtUPoobawHfMTFz3Nidop
        yGivRZ1cZI+bB7Q+cS61ZhoHyA==
X-Google-Smtp-Source: AA+uWPxd8yPzs/ZPTRyWnX1s3vPAB6rsZ/SKS8nNNc5OLtHl9fUhc4Zis2cCM/gHiGuYwyGOwr6yZw==
X-Received: by 2002:a17:902:724c:: with SMTP id c12-v6mr2801361pll.326.1533835045459;
        Thu, 09 Aug 2018 10:17:25 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id d75-v6sm12866009pfd.49.2018.08.09.10.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:17:25 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 2/7] firmware: coreboot: Unmap ioregion on failure
Date:   Thu,  9 Aug 2018 10:17:17 -0700
Message-Id: <20180809171722.144325-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180809171722.144325-1-swboyd@chromium.org>
References: <20180809171722.144325-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both callers of coreboot_table_init() ioremap the pointer that comes in
but they don't unmap the memory on failure. Both of them also fail probe
immediately with the return value of coreboot_table_init(), leaking a
mapping when it fails. Plug the leak so the mapping isn't left unused.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Fixes: 570d30c2823f ("firmware: coreboot: Expose the coreboot table as a bus")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/coreboot_table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 19db5709ae28..0d3e140444ae 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -138,6 +138,9 @@ int coreboot_table_init(struct device *dev, void __iomem *ptr)
 		ptr_entry += entry.size;
 	}
 
+	if (ret)
+		iounmap(ptr);
+
 	return ret;
 }
 EXPORT_SYMBOL(coreboot_table_init);
-- 
Sent by a computer through tubes

