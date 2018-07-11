Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6EAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7E220854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4yi+GBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7E220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeGKHor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:44:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33441 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeGKHor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:44:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so2644712pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PItXgTakqtWpQdCyBHziU3bBiq2X1/Ekd+7Czkvk2eo=;
        b=J4yi+GBUU3ZdD5V4QCTl0/VkFq/9LrXzrTTb2HIvOgzhrh/gTY46d4Uqtztfl1/Twb
         8Ld6FN7tnjq+cMQvaZKFpTifxHsmR7SCzzSWO68TGLBVO+sSrRKZwsqxMr0B9u97hoQT
         iP7C1slL0HeldBkE4fSunJLeI+cYDK9ISaY7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PItXgTakqtWpQdCyBHziU3bBiq2X1/Ekd+7Czkvk2eo=;
        b=cD2YjVFU8+nXGlMq4DtxgEfI7XQWRmKTvbfBgX6jKs9wFeDPK5kX5bGFtabp4Vz/Cs
         33+jfHDpa2c7jBxvVagQNlehdN09XZlmPHhyOmH4tpiNkruezkuK5PhKqiEJd4+tnbt+
         98BsHLl8J72VV51TyPn14aI0r8em24FPedl5wSjhFWLzTlmzcKGCwh6EyyqLkYZQUQ3/
         TbVYrpYFYTOA1VsBUKRHnIlI2mhopE4W0ktGGQT5zhUUjXTrFExjboEZch/s2tDQJX4P
         cBLL51pFT15w3/FDwM1pN7TCQB990b/2HDPnPKG8+Hp3uCZQb0GSbGh7Qa4vP3a4zcI1
         /IJw==
X-Gm-Message-State: APt69E3Yf+X73F1UWPYUG8N7pHH87LipJ+fHF6gqb/SK0of4Pb0VnNw9
        1ZQr1WuFZ8fpV9f/8HKTKtmh8w==
X-Google-Smtp-Source: AAOMgpefz8mOdK8ZGM6jri9hzMiv+EHqTvGtd3jBnKRw3BiTe9GT351x2i4CU9+pIcFvXuqbWwobNw==
X-Received: by 2002:a65:5bc4:: with SMTP id o4-v6mr19428518pgr.448.1531294911472;
        Wed, 11 Jul 2018 00:41:51 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id s144-v6sm4342686pfs.123.2018.07.11.00.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 00:41:50 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v11 04/15] kexec_file: kexec_walk_memblock() only walks a dedicated region at kdump
Date:   Wed, 11 Jul 2018 16:41:52 +0900
Message-Id: <20180711074203.3019-5-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180711074203.3019-1-takahiro.akashi@linaro.org>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump case, there exists only one dedicated memoblock region as usable
memory (crashk_res). With this patch, kexec_walk_memblock() runs a given
callback function on this region.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b088324fb3ad..ebf06c3e168d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -511,6 +511,9 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 	phys_addr_t mstart, mend;
 	struct resource res = { };
 
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return func(&crashk_res, kbuf);
+
 	if (kbuf->top_down) {
 		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
 						&mstart, &mend, NULL) {
-- 
2.17.0

