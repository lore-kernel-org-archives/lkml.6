Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19983C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7F0218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ7P5inR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbfBATVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:21:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35947 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbfBATVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:21:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so6359638edb.3;
        Fri, 01 Feb 2019 11:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XxA8s9wdO6IW3cnV8/xopztWYSpkjV0ZsoK6Genq424=;
        b=NJ7P5inRVEBG2LKCWyqjVrJPjaSv+320pPUMNSzwHg9Hn4OpeWVLt1JAAFpAkH39Ly
         OTxwZnt/VIhMVLB2Zac0q+oz451F3eoSLnSFkUuJ05y9XW5lOOMSYCbIWjPizsUuZ6Us
         Oq0BL799X+kROxbdsDpgvEoC742hPfPtHe2ds2GzyMWTkiYFojrnQa7ClylrAnVDuS3/
         nCurUyfeNGg3fY+Bz1p7828dzxzaU3jhg/88Hjp64x9ZvPJeXqzh0E4FHmbKDMOgJe1a
         7LDpSD5jnyEtM7xl9I66l3xKcm23N5HoO8a3aL2GED9g04Lrxj7AyzthhYbPgB5POCS2
         7akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XxA8s9wdO6IW3cnV8/xopztWYSpkjV0ZsoK6Genq424=;
        b=rFoZdzohxKozb3do1YEXbLwGVn2HgfEdkUT+8TVNYKnWPofGk+G56I0taMus3oCgej
         yvPnZrLaWNdc6AhNRJaEaBpQcrmfagZ0zsD3xDFk/AnWwH+S5k7EEPntkyyArJ97zrs7
         vHWa946sLQ57sUNsTXNDuXZ1BpO88Wa+B/jIm9EO230Thwvu4SuXE+k1w2ACNdmevtIT
         kU1BnpBiEpOdJSXGe8j6Q/ZunRaPhR9EjDKEDLPFmaRoS9yHEHdaLCyjliUd7Azqgmh9
         3F9vGHJ6NXxJ/aTae3aiafDh3eag6+VXdOkBQw03OSdhG5rIutFvqEGNlT3+r1yZN7s4
         PKXQ==
X-Gm-Message-State: AJcUukfYCyLDZBxJtCLoQFdlsE0ujU+Ks7SlH/k9/6xwzjeLxc0I+w2J
        uqWLUSRVzfwNOiLyt9nYMZg=
X-Google-Smtp-Source: ALg8bN5vKbk8i9f2LnmFqd9mJaUKRH1r1OoHlG0/S08xvS4YTJTwXfaw5jifNPFPYw6NJ5tDdq6Tpw==
X-Received: by 2002:a17:906:4e43:: with SMTP id g3mr23155104ejw.24.1549048859579;
        Fri, 01 Feb 2019 11:20:59 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id l18sm2087513edq.87.2019.02.01.11.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 11:20:58 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] efi/arm: Don't expect a return value of ptdump_debugfs_register
Date:   Fri,  1 Feb 2019 12:20:01 -0700
Message-Id: <20190201192001.6495-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit e2a2e56e4082 ("arm64: dump: no need to check return value
of debugfs_create functions") in the arm64 for-next/core branch,
ptdump_debugfs_register does not have a return value, which causes a
build error here:

drivers/firmware/efi/arm-runtime.c:51:9: error: returning 'void' from a
function with incompatible result type 'int'
        return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

The arm version is still awaiting acceptance [1] but in anticipation
of that patch being merged, restructure this function to call
ptdump_debugfs_register without expecting a return value.

[1]: https://lore.kernel.org/lkml/20190122144114.9816-3-gregkh@linuxfoundation.org/

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/firmware/efi/arm-runtime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 23ea1ed409d1..7ae3b797caf8 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -45,10 +45,10 @@ static struct ptdump_info efi_ptdump_info = {
 
 static int __init ptdump_init(void)
 {
-	if (!efi_enabled(EFI_RUNTIME_SERVICES))
-		return 0;
+	if (efi_enabled(EFI_RUNTIME_SERVICES))
+		ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
 
-	return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
+	return 0;
 }
 device_initcall(ptdump_init);
 
-- 
2.20.1

