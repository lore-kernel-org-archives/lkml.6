Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF4BC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B3720C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bLg1K1y9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B3720C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390408AbeGKUnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:43:40 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45351 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390079AbeGKUmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:42:32 -0400
Received: by mail-pf0-f195.google.com with SMTP id i26-v6so7712458pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8YjMcInXJrnMY6NIy0rzHFpjLepbrpMxKQdqxE6spGc=;
        b=bLg1K1y9hKUijmDINfS3ouKcfvNy5+d5wjgDXlVueRbtbelbFfbmrUR0U21ix2fhqT
         4Lp9lX3OakQPNShWhJWI0SuhscDEO456y+sxZi2JMMcVX7yfTI28e9IPvRfV6UvJSIuD
         wz0HIpWhCNy5e+v0NdScG0G4Rgn8kc+bFROus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8YjMcInXJrnMY6NIy0rzHFpjLepbrpMxKQdqxE6spGc=;
        b=magqyLiCPzz0vIkp4lqLDWXOje6eALpUD3lBMF0uJmXtBJh6JstxR25yA0MXWhn0T1
         /v8buy4ypynhO98lUK8uBtQ6SWnFFEncSoUNAJ0LQii/BiHYE+4pzdhQYbHEQCvIZ/iS
         hDuJbVkH6yYC3bS+JHDs6b4lLVAPNtM5OmnZ60ToPLnMwzv5PC2iYPGYkhS7SZzoRKhS
         rbbLCUDFIYk59hkynxflyY/BH1RWm63izFPKb5fgF5chfAAg6n4pn35Tcw3qT82Reheq
         yz88qlh2PMTVQCFyJBpUTetgyckr0Rtsl1+V89rkawIbBxaEVF0juBt9QeHiES8E45mI
         iZmg==
X-Gm-Message-State: AOUpUlH5bJhXdTx2ttR5OdGfaQBCAyvq+Y1IBJ+0kn9XTO/ugvPaFbra
        vK7PvmywFqUEeFNheCsduqT/Bw==
X-Google-Smtp-Source: AAOMgpdq8mhOY2Hzr/yGTT55d4Jq7NY94UD13bnGGGnvwb73W/D5oA6Uxq+EzLp3sRlLGHyoDXS+aw==
X-Received: by 2002:a63:40c7:: with SMTP id n190-v6mr151000pga.116.1531341389075;
        Wed, 11 Jul 2018 13:36:29 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d7-v6sm34989618pfa.51.2018.07.11.13.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 13:36:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/14] dm verity fec: Remove VLA usage
Date:   Wed, 11 Jul 2018 13:36:11 -0700
Message-Id: <20180711203619.1020-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711203619.1020-1-keescook@chromium.org>
References: <20180711203619.1020-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the newly defined max digest size macro. Also adds a sanity-check
at use-time.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-verity-fec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 684af08d0747..fe5cfd1a5fa5 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -212,12 +212,15 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 	struct dm_verity_fec_io *fio = fec_io(io);
 	u64 block, ileaved;
 	u8 *bbuf, *rs_block;
-	u8 want_digest[v->digest_size];
+	u8 want_digest[AHASH_MAX_DIGESTSIZE];
 	unsigned n, k;
 
 	if (neras)
 		*neras = 0;
 
+	if (WARN_ON(v->digest_size > sizeof(want_digest)))
+		return -EINVAL;
+
 	/*
 	 * read each of the rsn data blocks that are part of the RS block, and
 	 * interleave contents to available bufs
-- 
2.17.1

