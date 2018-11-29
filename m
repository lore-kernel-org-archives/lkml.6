Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6310FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BF6213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nj8ypOD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BF6213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeK3ES6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:18:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42183 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbeK3ES5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:18:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so2675801wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6pQ+cWziH5wp1GX7RQuhsmgKROae0TuArs9rA7OjYM=;
        b=Nj8ypOD3m5NUeeLg32+/ZRUO7WepVP/zGVgu7Q921+VN4GoCB30KMRPfmc9P+sW49v
         rMiPjx0DQtqOXP9JaRFfCLdDDHMfoHsuOoAIdB+OiFMa/PFbB4pLv8CLFnBg221Co+IH
         L6oKyi3GO0r2h4sxm4Ofk5UlIbTgInq0LD8QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6pQ+cWziH5wp1GX7RQuhsmgKROae0TuArs9rA7OjYM=;
        b=eRWCa6epoaRjIkdEhg3mDyw06eBkDUC/WE8c+z/RZIBMmDNhB4t/3MWlMLdNXMCCcN
         gPQHJewj4qSMwesiWWR5R2d4HIk40Y1J2SI5UL/TZO718lrz6Hutdh0CU1el5uwMxTEv
         dnUu+fGSferAyOBRbvDNqijcxMLn/L6hq4zPf/XP45Fe4zU3T/TYdkUyinkPNvMfEQq+
         FtJvg0iA6Ns2wew1xA4CUTZqPHmUPz62OdYJuNqu34mUz9M7xJhjzK4INoTH/pqdkbED
         KOYj/Ci7lgdizvxIMMaq087iVzfDheNNgs34UakHc/IcTSOzk3GzBHloLHKtW8wFd8fW
         cmBQ==
X-Gm-Message-State: AA+aEWZuzcjP5i7LOB0OXFQUWZh0MoGfX/8SbNQ4tI+jWr3Tfcx7jNg4
        VYlP7BPt7m+JXcBUQ1o0NblZyA==
X-Google-Smtp-Source: AFSGD/VVgmfXys2/4O6hgmmTiO6iAk3Y0l4xXqOWR0QWW8elwsyYjXQ2K835W7rQTRusmkDrUw4tSQ==
X-Received: by 2002:adf:f550:: with SMTP id j16mr2112685wrp.258.1543511571113;
        Thu, 29 Nov 2018 09:12:51 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f070:d240:312e:9f99])
        by smtp.gmail.com with ESMTPSA id y185sm1593882wmg.34.2018.11.29.09.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:12:50 -0800 (PST)
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
Subject: [PATCH 02/11] efi/fdt: Indentation fix
Date:   Thu, 29 Nov 2018 18:12:21 +0100
Message-Id: <20181129171230.18699-3-ard.biesheuvel@linaro.org>
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

Closing bracket seems to end a for statement when it is actually ending
the contained if. Add some brackets to have clear delimitation of each
scope.

No functional change/fix, just fix the indentation.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/fdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 0c0d2312f4a8..a3614f9b5f75 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -376,7 +376,7 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
 	tables = (efi_config_table_t *) sys_table->tables;
 	fdt = NULL;
 
-	for (i = 0; i < sys_table->nr_tables; i++)
+	for (i = 0; i < sys_table->nr_tables; i++) {
 		if (efi_guidcmp(tables[i].guid, fdt_guid) == 0) {
 			fdt = (void *) tables[i].table;
 			if (fdt_check_header(fdt) != 0) {
@@ -385,7 +385,8 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
 			}
 			*fdt_size = fdt_totalsize(fdt);
 			break;
-	 }
+		}
+	}
 
 	return fdt;
 }
-- 
2.19.1

