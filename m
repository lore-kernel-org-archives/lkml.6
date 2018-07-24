Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA467ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2A720874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YBqxVMLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2A720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbeGXIED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:04:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37603 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbeGXIEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:04:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so2192409pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H8r9Y6sXiWjrMnoHACDZ61CdzVHsVLeFpn0oOZb/59I=;
        b=YBqxVMLixn/XZ7QzSmXVIbTgC2hE90UJKhy++UyocFiKZo1r0isSuzudJ9uMFczRAk
         33CyhfGgCIlK92u0bTUhQSMunExi5YOQUhEIe6Myke4ydsrIUkeUMIuKoNyPDP2YFTc5
         pRfh70mIT9IfPcJhoFAMaH2RK39p+KF9d1whU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H8r9Y6sXiWjrMnoHACDZ61CdzVHsVLeFpn0oOZb/59I=;
        b=YLNIxYI0l4OtR3rFotHg37ddYd8z8DcMotv58yUcKl5eubZKLWG8FlWU9/Ak/lkrZe
         VO43Iqm0Qjs+j3Xfk6oVgFTxSlfFvpbz6Kf5Q67KaTtBIuVUvxEka8a4TT4B5itoB5S4
         QvsneNGw71AlrKCvoERSTq/3UgdVli8OrQeZj+npjtTPn4qiRnfmX6P+jhacvqbVn2GF
         ETbjX6jtHB5VvyuX8Jclj8IhvIvxlreagfQkuIx25njGIjTGPJeQYzfdSsDRTFHtCdXs
         +/bzPSaDKyipXZi6CgAlir7DyCaeE46WUOz6zFhv51j3c9a4e/iWfvElTjOEcOsgxxeM
         8saA==
X-Gm-Message-State: AOUpUlE10mlaqiVX/WTFR1Ku269UHgF3PukTVmA2xJ8JO9QLSW6Jq58W
        51zt5dNENmP+0HYHUNsnPw0A8g==
X-Google-Smtp-Source: AAOMgpe159jr6QMwSXbmOfuanH41Nd5SHLHv/V/dCDQSHVNlsCxAKBEi+X3RC9vtgB8JVrA53KQuRA==
X-Received: by 2002:a62:1603:: with SMTP id 3-v6mr16382476pfw.245.1532415544496;
        Mon, 23 Jul 2018 23:59:04 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id z5-v6sm9588659pfi.4.2018.07.23.23.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 23:59:03 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v12 14/16] include: pe.h: remove message[] from mz header definition
Date:   Tue, 24 Jul 2018 15:57:57 +0900
Message-Id: <20180724065759.19186-15-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
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
2.18.0

