Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C2BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7392172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mh2bCx/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7392172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeI1NLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:11:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35610 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbeI1NLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:11:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id v133-v6so3746627pgb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBZa+UOaDV8TYfXAr244/shDNprkQTt1AVYjh0q1zSg=;
        b=Mh2bCx/ZN4Zr/xQdf+Ij2U350YGbZV2r17bFphhhLYuMo7nTEzXYoI8KgK05BStuHg
         29FRhfAGp7d3b3cqtE3ewpnaKTCMcgMRrwEW56yUxea7nyOgJ6HWQkIjIbR61Ef6imOo
         yDiAjpO0CKf4ZkwsS5kiFcYyNa0dYA9L6lr/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBZa+UOaDV8TYfXAr244/shDNprkQTt1AVYjh0q1zSg=;
        b=MvwGo6IImuVFVGZ+tyexgH+TD8SNGWXylHjSLYg19daLPSngHxNcKKZOL2NDLEB4tN
         P092PACUEWD+7n7UtFxTdfGq8glOmHn6OvGouWq5dcPw4xo6znzZ83Hcf9ieDi4Iv1lC
         E7hCEv7XhNv8sXi6DD+HS9AS29A/1hX8GNUsoiYFOq/VkguWk69wuBrCRah0p3epwKq9
         0uYBiNnN82fZgQHA3nFyE9PObZZZmeEE2V9q62HNWT8vVt5dTkdau4noWtQYnOdYt9mV
         4nNH1TSbXLi+tUt/J10QGktOq/O38zAyvqyogdwOKvmnV/FEh/uq1iEWhb2u4hmBtA1K
         QyUQ==
X-Gm-Message-State: ABuFfoi1oNCj/TvwlNZuDYSDxFQ2Dsq7Ap4TQ/ep0EAiEhz1OyyLKfhf
        tNYKwgI8nBVbaIHU8WNFzoiFXg==
X-Google-Smtp-Source: ACcGV62gOh3DZWx1Vwu7nEf5PxhFhRq0LyZH5qhvdCcGY3XSjPCfLyXLcgZdADX0Jnuddwgy7W8XUg==
X-Received: by 2002:a63:29c6:: with SMTP id p189-v6mr5419584pgp.188.1538117366876;
        Thu, 27 Sep 2018 23:49:26 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id y128-v6sm5938994pfb.56.2018.09.27.23.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:49:25 -0700 (PDT)
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
Subject: [PATCH v15 14/16] include: pe.h: remove message[] from mz header definition
Date:   Fri, 28 Sep 2018 15:48:39 +0900
Message-Id: <20180928064841.14117-15-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
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

