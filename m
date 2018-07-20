Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43801ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF61B2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZ8Nnv6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF61B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeGTCeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:34:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40285 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731446AbeGTCeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:34:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so5358422pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 18:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TK1WDbeXxDnAkoiR4N4slQI5HJBht91mInwgn17IrQ0=;
        b=VZ8Nnv6BZ94a23iQ0zH0JXowN4YBd3UQvKDC+65woEeUzIrnGOPiTVJUHqB+41bviu
         0mccSQjfmELIkbnUsVSI5vUR9jlVuMOGhNTSO2/OMIOMpsgbWRiCn85TAoppIqRLmpo3
         x6nbwOfmyPAxN34pAhVCll1MlqqlRknOc9LQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TK1WDbeXxDnAkoiR4N4slQI5HJBht91mInwgn17IrQ0=;
        b=BynnKoyi+9Q+X4VDt2xufqy87TrU5LEGAn4Q9766fs8glUA8dfQj1ff4o9xWNBxote
         I2REEzqVTcr8XxYHDBWsKkSGcqg5Z5Fd/8eySrkDERww6fuQlv+Oc2+mWq4IVRs2kOUy
         wG0QiqveKofrqSleu4FAzX1RdgP25rCFkA3LvprddVMsL2k7bgrO1EqnQK47xNoSEm7z
         cDiTeg5PMh9S3EXb8TwpZ+TJCljBBhMZzlM4tmToL2SWQmG4NYBZ3F7h7ntrVDbVCLm1
         WMztWNBD9nWsaBSWZey4pM+mkNwz+7z+Bv6sJpW5OJXR6KX3V5asZzMnUf/MynQ9VZsD
         pNIQ==
X-Gm-Message-State: AOUpUlEizoUoPA3FTdmJzGHLQH5Oqf9wPpOK8Srerz2rltSnycI9e2zr
        GHKVusrhmpXnVHsQXktV4VsEdA==
X-Google-Smtp-Source: AAOMgpdWs0SORXjMLOpLGOYcroI6QhZukGe1nhxjWSHO50TCgxUKDPjEGagisRzpn7jtu3YLf040eg==
X-Received: by 2002:a63:b349:: with SMTP id x9-v6mr73318pgt.337.1532051290075;
        Thu, 19 Jul 2018 18:48:10 -0700 (PDT)
Received: from localhost.localdomain (fs76eedbeb.tkyc508.ap.nuro.jp. [118.238.219.235])
        by smtp.gmail.com with ESMTPSA id 203-v6sm475868pgb.14.2018.07.19.18.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 18:48:09 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 9/9] efivars: Call guid_parse() against guid_t type of variable
Date:   Fri, 20 Jul 2018 10:47:26 +0900
Message-Id: <20180720014726.24031-10-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

uuid_le_to_bin() is deprecated API and take into consideration that variable,
to where we store parsed data, is type of guid_t we switch to guid_parse()
for sake of consistency.

While here, add error checking to it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 fs/efivarfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 71fccccf317e..8c6ab6c95727 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -86,7 +86,9 @@ static int efivarfs_create(struct inode *dir, struct dentry *dentry,
 	/* length of the variable name itself: remove GUID and separator */
 	namelen = dentry->d_name.len - EFI_VARIABLE_GUID_LEN - 1;
 
-	uuid_le_to_bin(dentry->d_name.name + namelen + 1, &var->var.VendorGuid);
+	err = guid_parse(dentry->d_name.name + namelen + 1, &var->var.VendorGuid);
+	if (err)
+		goto out;
 
 	if (efivar_variable_is_removable(var->var.VendorGuid,
 					 dentry->d_name.name, namelen))
-- 
2.17.1

