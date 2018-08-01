Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F42C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC6620894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lRlOdgOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC6620894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733292AbeHAHxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:53:50 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45217 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733194AbeHAHxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:53:49 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so8266209pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 23:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I/bSHgCgLfsKi5nn/mcCzY507EwWlFvKmT6sX7YW6BM=;
        b=lRlOdgOvYtfW4Ixe2fC290TJNndKz0k6abDY61HVuhINVVpGAugFlKTTwdTNQx8+Mr
         IQ1SoN7H/GpgYKmIxFZNTuWBOKic8/w6wSM4MXoQ6zZFz7vxnkRLJ7r2aUjbiCdYGgFe
         MBOUdz0ianMIp+Bm4H1gV8YMDK8DdGk3l8igA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I/bSHgCgLfsKi5nn/mcCzY507EwWlFvKmT6sX7YW6BM=;
        b=qzJaY1oPtSPDrjbtSaiz8uY93kEHqE3ZcZ6x2mg/aMlA/AN91X7Mw2ANCf2s5VhoDo
         yB1KsNGxri/6163Rp4/auUF8JXe2RWlXhrpxYDdKSLl3gbRawltsduZQE1p5QPkuYfki
         EHFXSs+Iwi8I8kkDWTTbGAaPZ6MgN7tnLeEMIN5ZR2KVyVEQ5u0A3S/AHk/NFSnO4CqQ
         d0n0J8Wfd29H4Pb96WblzIOZZotojIyWvj1vGf4SS9EHOeNyQk+0UMZrSxW8tS+/ecwk
         qr2prDdSgAA6eztKQYle2NoBSYOjereOE6jNOCXvG8NEoiFcx6lf890etG1KuD2m9CIV
         XjyA==
X-Gm-Message-State: AOUpUlFNr4X8C6bPPtbMcYy91//MifeIKgPPztthliJpay8P2VcZkMnc
        kj32aOqK+fFIlu6mmKI8iIWrgw==
X-Google-Smtp-Source: AAOMgpfmUImdbXZBeszOToW3/mDD9Nrp2R7jJY9uiADxozoHu8vmMvZT8Z1mPvc9A8d3TS5hu137VA==
X-Received: by 2002:a17:902:6f02:: with SMTP id w2-v6mr22742023plk.216.1533103792732;
        Tue, 31 Jul 2018 23:09:52 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y5-v6sm49036946pfj.169.2018.07.31.23.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 23:09:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] overflow.h: Add arithmetic shift helper
Date:   Tue, 31 Jul 2018 23:09:45 -0700
Message-Id: <20180801060947.16670-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801060947.16670-1-keescook@chromium.org>
References: <20180801060947.16670-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Add shift_overflow() helper to assist driver authors in ensuring that
shift operations don't cause overflows or other odd conditions.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
[kees: tweaked comments and commit log, dropped unneeded assignment]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/overflow.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 8712ff70995f..69fc366ce865 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -202,6 +202,37 @@
 
 #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
 
+/** check_shift_overflow() - Calculate a left-shifted value and check overflow
+ *
+ * @a: Value to be shifted
+ * @b: How many bits left to shift
+ * @d: Pointer to where to store the result
+ *
+ * Computes *@d = (@a << @s)
+ *
+ * Returns true if '*d' cannot hold the result or when 'a << s' doesn't
+ * make sense. Example conditions:
+ * - 'a << s' causes bits to be lost when stored in *d.
+ * - 's' is garbage (e.g. negative) or so large that the result of
+ *   'a << s' is guaranteed to be 0.
+ * - 'a' is negative.
+ * - 'a << s' sets the sign bit, if any, in '*d'.
+ *
+ * '*d' will hold the results of the attempted shift, but is not
+ * considered "safe for use" if false is returned.
+ */
+#define check_shift_overflow(a, s, d) ({				\
+	typeof(a) _a = a;						\
+	typeof(s) _s = s;						\
+	typeof(d) _d = d;						\
+	u64 _a_full = _a;						\
+	unsigned int _to_shift =					\
+		_s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;		\
+	*_d = (_a_full << _to_shift);					\
+	(_to_shift != _s || *_d < 0 || _a < 0 ||			\
+		(*_d >> _to_shift) != _a);				\
+})
+
 /**
  * array_size() - Calculate size of 2-dimensional array.
  *
-- 
2.17.1

