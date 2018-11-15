Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6E8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFAF2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TU4314T9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFAF2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbeKOQAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:00:06 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39864 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeKOQAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:00:05 -0500
Received: by mail-yb1-f193.google.com with SMTP id w17-v6so7910961ybl.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 21:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBZa+UOaDV8TYfXAr244/shDNprkQTt1AVYjh0q1zSg=;
        b=TU4314T9M7hEQBduv68EORGU2Ufr/Wz+AI78lNORymGpWy2/cC1Q9Il6xST8BRNKnO
         XBz/sK7a/7eh1YRd+LSij8lEKqoaJRFxtgBuE/CX8HLhhQR6qLgEOj7YgqO/2Zccyutn
         jb1KqzVxInKix5eNyz8ZQgsXNjtFPbMhmeSx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBZa+UOaDV8TYfXAr244/shDNprkQTt1AVYjh0q1zSg=;
        b=kdIuJL7v5b5NvEGWzDgln5X8M8oQmavkgR5CD1iX3BaW59d+JNogJuOCIt4R1MjXa3
         WctR5u6BCvBgk6R/gtRCgNvZSly+wZd2pABnj0WHM2+zTXLPhR99RYPTGFbm5X9qlxWC
         1Fyn+aW0ewKcJYJsajFqEr6c4t4/tisDGYOi3dnOvlpWwpCDDRGwRorYJROVAgAl9Avv
         gIYEUVruh/ddOfTDy5pKHdoqlxB5euXZap1DLf+Yjia6W3r86PWfaRoAHXVuvfflFgKR
         v7etPB3ixo+x83y+KeYxrl8GyAyB/EN5tcGjWkDjfGqrh8D2irjueWnSEGxKUtAjW89A
         2+mA==
X-Gm-Message-State: AGRZ1gKwmfgfipqZRWAtUEIt08TYZjpAu9L3TsLsG5Fu0cTDRIPWLccR
        8Z557gkqWuvtruMoKRtlQAEmuQ==
X-Google-Smtp-Source: AJdET5etu9Ve+mcscEGVR9rqWITSQHqUdYahtPNsjVEWwwfcX3RByj+ZV1uDb7VWQpMs1OBlX6qFfA==
X-Received: by 2002:a25:20c6:: with SMTP id g189-v6mr4548113ybg.196.1542261219743;
        Wed, 14 Nov 2018 21:53:39 -0800 (PST)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id p13-v6sm7297817ywg.12.2018.11.14.21.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 21:53:39 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v16 14/16] include: pe.h: remove message[] from mz header definition
Date:   Thu, 15 Nov 2018 14:52:53 +0900
Message-Id: <20181115055254.2812-15-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

message[] field won't be part of the definition of mz header.

This change is crucial for enabling kexec_file_load on arm64 because
arm64's "Image" binary, as in PE format, doesn't have any data for it and
accordingly the following check in pefile_parse_binary() will fail:

	chkaddr(cursor, mz->peaddr, sizeof(*pe));

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
---
 include/linux/pe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pe.h b/include/linux/pe.h
index 143ce75be5f0..3482b18a48b5 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -166,7 +166,7 @@ struct mz_hdr {
 	uint16_t oem_info;	/* oem specific */
 	uint16_t reserved1[10];	/* reserved */
 	uint32_t peaddr;	/* address of pe header */
-	char     message[64];	/* message to print */
+	char     message[];	/* message to print */
 };
 
 struct mz_reloc {
-- 
2.19.0

