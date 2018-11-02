Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF3C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402012081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SyljX0Fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402012081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeKCC0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:26:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37445 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeKCC0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:26:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so1296621pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qddL7HZd/lZK+Srg7fwIVx8jlZhLuoxjkC7Np29U/7Q=;
        b=SyljX0FvhHDK1Kre7YLubwVo8ngPk+byge563qS3IquXVDihRS/12F7vggTP9CXfjf
         xU1t1lTPDcObldTrz/zN5s8kOlsTIBaCFhLAoW20i2e7cPy3jQK+BnBOyyORvg5qVTSJ
         UJip3C+Ho/ZoST0Nr8mQfj9xTgRs0jQnnXiNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qddL7HZd/lZK+Srg7fwIVx8jlZhLuoxjkC7Np29U/7Q=;
        b=YylX9nqatTYmXDeGdl0QI1lHxie6PbP+hjTyOghUxar0XpzSgT+9G2JzjjDjKt5Jrl
         KtBQXJVeLoDjk4fjpD/PpFr3gf0jkmKmet8GJugMJE8W2Z45n5sW+6PBzitNVvRXPjR/
         f5dsMYKxNyAWcwTBXP9zHqq1IFCqH2W5LX34lcMfg9vT7gvX4tR3lpwYx9j8HeR69zeW
         XRHY3npDVAEbODRovE9Waunn8HqUmu1pUIYiOqMbdhPFaJ6PPtw1aVVcM/KHox4fqQlB
         5kARJA2UHRrp9qLbPd3Cpw/xCczoSAmzcHu7chG4zzPFtmoeiH8s3exj+0F17ehbPfyO
         GuCg==
X-Gm-Message-State: AGRZ1gJnRXXFktqehThploltmqwFegB3lj79Yu2/MNPdZkVwekH8Xqbx
        zAoU3zbHB2feqvlwUo9bWtAghg==
X-Google-Smtp-Source: AJdET5eWUGzz3fWsIniTrLX8U7yKATPA2/eBtlWSpIUcgJ66SbfD3yB8ftUcH0I34p1BY4pAglkcFQ==
X-Received: by 2002:a17:902:9009:: with SMTP id a9-v6mr12606518plp.134.1541179110162;
        Fri, 02 Nov 2018 10:18:30 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id d5-v6sm19222675pfo.131.2018.11.02.10.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 10:18:28 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Rakesh Pillai <pillair@qti.qualcomm.com>,
        Govind Singh <govinds@qti.qualcomm.com>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/3] ath10k: don't assume this is a PCI dev in generic code
Date:   Fri,  2 Nov 2018 10:17:48 -0700
Message-Id: <20181102171749.38680-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181102171749.38680-1-briannorris@chromium.org>
References: <20181102171749.38680-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all devices using this driver are backed by a PCI device, so it's
not fair to assume 'to_pci_dev()' is valid. Fortunately, we only were
using this to convert straight back to a bare 'device', which means we
were only doing no-op pointer arithmetic, and not actually accessing
potentially out-of-bounds memory. But this is still bad practice.

Just use 'ar->dev' directly, since that's really all we're looking for.

Fixes: 209b2a68de76 ("ath10k: add platform regulatory domain support")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index a1c2801ded10..5c4ee66382d9 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8313,7 +8313,6 @@ static u32 ath10k_mac_wrdd_get_mcc(struct ath10k *ar, union acpi_object *wrdd)
 
 static int ath10k_mac_get_wrdd_regulatory(struct ath10k *ar, u16 *rd)
 {
-	struct pci_dev __maybe_unused *pdev = to_pci_dev(ar->dev);
 	acpi_handle root_handle;
 	acpi_handle handle;
 	struct acpi_buffer wrdd = {ACPI_ALLOCATE_BUFFER, NULL};
@@ -8321,7 +8320,7 @@ static int ath10k_mac_get_wrdd_regulatory(struct ath10k *ar, u16 *rd)
 	u32 alpha2_code;
 	char alpha2[3];
 
-	root_handle = ACPI_HANDLE(&pdev->dev);
+	root_handle = ACPI_HANDLE(ar->dev);
 	if (!root_handle)
 		return -EOPNOTSUPP;
 
-- 
2.19.1.930.g4563a0d9d0-goog

