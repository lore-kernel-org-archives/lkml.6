Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CE8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F67208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bl4PyH5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F67208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeGQExA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:53:00 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44283 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbeGQEwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:52:35 -0400
Received: by mail-pl0-f66.google.com with SMTP id m16-v6so16241853pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8YjMcInXJrnMY6NIy0rzHFpjLepbrpMxKQdqxE6spGc=;
        b=Bl4PyH5O0iBK/KBUspRFI9jqAFWVLoYggS6GlmSQWSKD6k7QMIXU9QPXSUiKp34N5t
         QpBFYfZu8ncmutceKRu+/RJUeFCL5Zue4A9/uE6vwCyUbVvouRHjcidff+4lxWtI9ThZ
         RvmLtrw65zyKPohYblxh7ZgDEAdf2eF++Okk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8YjMcInXJrnMY6NIy0rzHFpjLepbrpMxKQdqxE6spGc=;
        b=hbEPQc3G78Cswx6yxiSMRnnORrFKl1mKZqjuhkfRGcZ/hbdShT1QAcCbekGrCx65ka
         3Lk+hj6f08bnjlouUAtqP8bEFUZguBfJ9ZgvhaWmUbDwBh45WQRvGN4eyiCKv4Empbsn
         hYJoWzMP/++FQ5Dzsvj0drqYjZ4w4/jNM6Pxu0NCAoLnB4ajOHC1jmBoaMEQImNA6KT+
         QdzyUrzYsf6nqy9VwIDtI8yVflCaHvSpFzzQ7l26hzqGNSltICjGATztFvI3KURij/Is
         DgUkJ3S7fkoB12QzQ8k0aUjrbmKhGKFQeQnyIUcXs+//P9mRsSV0MCAX618jWApCK5qY
         i6Rg==
X-Gm-Message-State: AOUpUlEFR57ouRW2kXVENj+FSe8Wd7WpAQemDKgI0aY4/3NIskimE88p
        Ijk4dGfMWdKYYcVu7fw3+I0elQ==
X-Google-Smtp-Source: AAOMgpcIrVTauvZOWWhT1QnQca6SiTA3kYMd6lRP49OSThBVAAgWP9FffU7cyXpYzxAWQf2VgmbDrQ==
X-Received: by 2002:a17:902:6a89:: with SMTP id n9-v6mr15834plk.302.1531801320240;
        Mon, 16 Jul 2018 21:22:00 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 65-v6sm46918384pfq.81.2018.07.16.21.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:21:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/11] dm verity fec: Remove VLA usage
Date:   Mon, 16 Jul 2018 21:21:45 -0700
Message-Id: <20180717042150.37761-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717042150.37761-1-keescook@chromium.org>
References: <20180717042150.37761-1-keescook@chromium.org>
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

