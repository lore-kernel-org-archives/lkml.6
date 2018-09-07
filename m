Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426A4C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A9B206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JyzLWOrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A9B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeIGMlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:41:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33797 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeIGMlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:41:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id f6-v6so6246844plo.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H8r9Y6sXiWjrMnoHACDZ61CdzVHsVLeFpn0oOZb/59I=;
        b=JyzLWOrGqoQh8eFOMBUNRAUWVulDA6drih+fd8GjQIsmU3ep50Kcg2+k/Rp0wT1lc6
         BwOLxrjdARBYQomVgaLzINl3jX/PhP8dso+o2a48YgTRkjUXOIfC7geUiJ8XDSjYfczY
         byVv4TTS5c6khfV1Lohapgo9TJ8wzjfsKZ4mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H8r9Y6sXiWjrMnoHACDZ61CdzVHsVLeFpn0oOZb/59I=;
        b=gUJzMseyG1FoXbAQGNewzFPyGbRDffCGDi7s+gH1iDMLE4qEd2vx4VhsFHIf0H0WkX
         CuJsT+Dv4iz+zQl0z5c5Nrb0fSonD9pgqgHJeqh4IEXP7pQef3rQ+YjxyjSGcWyCPjvq
         HqBI8EbZOjZS7zhFl2hkpAVogR9R6TtrmtYC4WtaGgLfyiwyY5dR/0sYAxU1OPXMA+Ub
         eZuen76r/UMCZ4iRXi3QHUPNgDTP7m7+eW/Ge4B1gq9IH+p93eQ29aq3qG0GFMMD//Bi
         r7RtH4APFX4WZ5ItdKesMBZVpACmblafhQVfqoyNAvIDl9SE37WHS8A8H1xzYlPcWeAc
         9fgA==
X-Gm-Message-State: APzg51CxtMRf++zaJMTNbhN4Sly4t6IRajtJq8GEkXMLmz3ccwbmmtjj
        Hbw3f4UcDhrxUWB06z9XdoNu7A==
X-Google-Smtp-Source: ANB0VdZFg50Kt25YW660rtBie1bJyJfVIA7pQFzqusIqxeZeKzbgjgKArmCDyC03/n1E+QIoHbBeGA==
X-Received: by 2002:a17:902:c6:: with SMTP id a64-v6mr6713497pla.180.1536307296340;
        Fri, 07 Sep 2018 01:01:36 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id b14-v6sm10811236pfc.178.2018.09.07.01.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 01:01:35 -0700 (PDT)
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
Subject: [PATCH v14 14/16] include: pe.h: remove message[] from mz header definition
Date:   Fri,  7 Sep 2018 17:00:38 +0900
Message-Id: <20180907080040.4967-9-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907080040.4967-1-takahiro.akashi@linaro.org>
References: <20180907080040.4967-1-takahiro.akashi@linaro.org>
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

