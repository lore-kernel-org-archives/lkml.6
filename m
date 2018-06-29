Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17465C43145
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8EF27986
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZACXIEqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8EF27986
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030379AbeF2A3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:29:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41229 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935951AbeF2A2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:28:55 -0400
Received: by mail-pg0-f68.google.com with SMTP id l65-v6so3178497pgl.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8YjMcInXJrnMY6NIy0rzHFpjLepbrpMxKQdqxE6spGc=;
        b=ZACXIEqzUy/qd1XXayCIX39szLzUHtIUUrUSzsEmKCXEC7vKVRlzYERBjpnuFYD8f/
         hOZ7W3JhqLeyyg1iOS3L0PXQF9Hce1e0iwT3Kpar7HHE0YqBfk6ytACKlRU/FMrD8rWA
         5C+jlgS/D1KjmPC116e8dT1SQzqRGzsBziAR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8YjMcInXJrnMY6NIy0rzHFpjLepbrpMxKQdqxE6spGc=;
        b=lM7Xuiq23lhBqJ5443dVH7pyrjb7fp0MWjopUDnQywi1QrGzqwqURS3X5F9FrqJcYU
         T0TVQeiz9GcY/IznYB6ycu0chV147iVnosuwa8erOm/OppjUVc1gEwCXpfGq/a1Jf6VX
         tAkfF9AyDl+WJ32EOIEqBM7UE7dy9wpXhXdeDXxDe2HkeDhpSlGdUGVnSxQ6Wj0zOTEE
         K1YJauncC2p00D6cSV+Qd2HtZUpe+E716/4DQBjHQcbFWNwGx6lpAijp94WzRCRJIOvS
         DTVaEmAS93Niu2fWx64/gbyA/EmaTZDFErHZfb2ZoXceM78rSkxlUMlIjzam0r4HrXWz
         Sulw==
X-Gm-Message-State: APt69E39MFHDSJysICI/cdlliVHDGtJJwUsxz5YRc/jU10afytLE8EXW
        o/BETrJnyCEH6/Qsb+0VYltdxQ==
X-Google-Smtp-Source: AAOMgpfIlakhyiLXVaIFY8i7TNkl/x4ruDsl4VsPDdERUm9ygm4atD2SZxplz0XFo6uxQczHNIbT0w==
X-Received: by 2002:a62:6502:: with SMTP id z2-v6mr12170203pfb.76.1530232134899;
        Thu, 28 Jun 2018 17:28:54 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id g25-v6sm2464862pge.52.2018.06.28.17.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 17:28:53 -0700 (PDT)
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
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] dm verity fec: Remove VLA usage
Date:   Thu, 28 Jun 2018 17:28:40 -0700
Message-Id: <20180629002843.31095-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629002843.31095-1-keescook@chromium.org>
References: <20180629002843.31095-1-keescook@chromium.org>
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

