Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D39DC07E85
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74B020863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uc4XkjOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74B020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbeK3ETB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:19:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37026 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730479AbeK3ES7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:18:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so2682184wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Waq/8fI6AT262jsKSvQj9K7UesrlRkejH4UAHjKMNCA=;
        b=Uc4XkjOYHS6lq4IwDZn/uFWPGv7LiKhYHci8x235j3KyPlfRryVOQpYtC8dqYYOxcF
         T+jA1CSFiVwdadzUlxL+FPcGO/KUX2ReQPr3CTMogoETBAIgYuMdz3H25fARNHYpxk2f
         Y2S7AjhdFVPn3xDHr7QAqc+XLdVX3qy/R0dRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Waq/8fI6AT262jsKSvQj9K7UesrlRkejH4UAHjKMNCA=;
        b=P9maF3lDEkzc7iHwFsKis2DukFh/tR0whnzQ7gCy6jeeil0uy36g6GIFMFPV9P4TAG
         G1himr2cj1Kqsu4w5/n6JvNAOFcVrQDyHdx/YMi7ULQcRAxt7Ns18QuTuHkaKWthYWnw
         QG5eXIO2bLeXvJLgdPwi7eYgCx+tAmHdO0nzIp2zSmgAK2l4+ceBCq9h+isZu2XitgcK
         7o9lhIYeVY2ygi0PzOg6apPmY9YB3iCNLtGTauG/Q4eA2Gy7gEKR5hUC9cvAhM+aPgLi
         XGmrpPgCeFI1npE2t1P0RLGnYxyH1jVZnVTSPP72KdMs35XdV3T8GBOdvgHnIrXVdv5v
         lusA==
X-Gm-Message-State: AA+aEWZS2YS08AU5zEczVjp5pFR3NxLV0WdTsJHH8BAkoByA2lWmFqOr
        gGOjCpEMrON5S+zIdHVE0bv2AQ==
X-Google-Smtp-Source: AFSGD/U0k8oe7h2NJgR/LFD+jPCPu2HUE3Ret5egBlb5zfKLEHBfnMycPs28v+cFJGfbwmHbl8Akjg==
X-Received: by 2002:adf:a50c:: with SMTP id i12mr2053360wrb.220.1543511573188;
        Thu, 29 Nov 2018 09:12:53 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f070:d240:312e:9f99])
        by smtp.gmail.com with ESMTPSA id y185sm1593882wmg.34.2018.11.29.09.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:12:51 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: [PATCH 03/11] efi/fdt: Simplify get_fdt flow
Date:   Thu, 29 Nov 2018 18:12:22 +0100
Message-Id: <20181129171230.18699-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Reorganize get_fdt lookup loop, clearly showing that:
- Nothing is done for table entries that do not have fdt_guid
- Once an entry with fdt_guid is found, break out of the loop

No functional changes.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/fdt.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index a3614f9b5f75..0dc7b4987cc2 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -370,23 +370,24 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
 {
 	efi_guid_t fdt_guid = DEVICE_TREE_GUID;
 	efi_config_table_t *tables;
-	void *fdt;
 	int i;
 
-	tables = (efi_config_table_t *) sys_table->tables;
-	fdt = NULL;
+	tables = (efi_config_table_t *)sys_table->tables;
 
 	for (i = 0; i < sys_table->nr_tables; i++) {
-		if (efi_guidcmp(tables[i].guid, fdt_guid) == 0) {
-			fdt = (void *) tables[i].table;
-			if (fdt_check_header(fdt) != 0) {
-				pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
-				return NULL;
-			}
-			*fdt_size = fdt_totalsize(fdt);
-			break;
+		void *fdt;
+
+		if (efi_guidcmp(tables[i].guid, fdt_guid) != 0)
+			continue;
+
+		fdt = (void *)tables[i].table;
+		if (fdt_check_header(fdt) != 0) {
+			pr_efi_err(sys_table, "Invalid header detected on UEFI supplied FDT, ignoring ...\n");
+			return NULL;
 		}
+		*fdt_size = fdt_totalsize(fdt);
+		return fdt;
 	}
 
-	return fdt;
+	return NULL;
 }
-- 
2.19.1

