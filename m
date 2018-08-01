Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A3EC46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14707208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mhT7DTJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14707208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbeHABnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 21:43:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40543 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732851AbeHABnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 21:43:33 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so7876559plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 17:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I/bSHgCgLfsKi5nn/mcCzY507EwWlFvKmT6sX7YW6BM=;
        b=mhT7DTJxVJJoAYSdt0UZ/7ZB1XpO0tvKo3LeJcciBZD7CSVIG/5E/p+5BzuZDiCWR/
         MrtzSIe4g1Tmj6k9Y3Qy+oe+cCOqlITK/h8DuwbDB2P1NzCbH5LEXSMgfmVyfN65/fQ1
         8gb9CEjboJCxNyyWQbNq3QZJE1rYxjxUQoIdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I/bSHgCgLfsKi5nn/mcCzY507EwWlFvKmT6sX7YW6BM=;
        b=Dn7iW3m2HttfVcfGw2Ww0i7mpVLpi8oI7rrCWIqMOUOvkii+s7DPjHSc07497Ev+WV
         Au/EZKADlfO8eTmcZqBYLQiVgCaPrpfo0tD7fvH9BmSPzPwYvxqgfgalrQNGLQWY1f1X
         CJE6aOA39S8mKuusN7WD1KoJ624QXr0cJqR2oGb0QKcoJ6dRVE5t+9e0H7N0OHl/PzFQ
         7N9G1eWn+j4ELm48OfAz4E+h7c63X1JDL6bz6QsaFvGYK1eB+XvKvIQ9qnpvv1RTb2wb
         O6XWXKEiHl0VJ6CYhzOfAUrx+L7as70PmZHOaS0rs602e7zSkTrcYopqGQ8/NHKexIag
         1imQ==
X-Gm-Message-State: AOUpUlG9O38jPoJws4UToAbqdao4Ix4POyouVc7tNJLK4JOwAckvasBG
        lFrghwwNw2lsks20Fur2EJ6qHQ==
X-Google-Smtp-Source: AAOMgpcV3exqU+XKoTv3t/lJwCop6bAlog7ty6CDElZ7+0d3bCwJ6q5LOqPXcyMp78m6hCHJwPIgvg==
X-Received: by 2002:a17:902:9693:: with SMTP id n19-v6mr22496689plp.212.1533081647203;
        Tue, 31 Jul 2018 17:00:47 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q21-v6sm27421107pfl.156.2018.07.31.17.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 17:00:44 -0700 (PDT)
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
Subject: [PATCH v2 1/3] overflow.h: Add arithmetic shift helper
Date:   Tue, 31 Jul 2018 17:00:37 -0700
Message-Id: <20180801000039.44314-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801000039.44314-1-keescook@chromium.org>
References: <20180801000039.44314-1-keescook@chromium.org>
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

