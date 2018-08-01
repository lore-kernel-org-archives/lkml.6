Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4906C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF6320862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j/jNjm5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF6320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbeHAXNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:13:31 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45923 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeHAXNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:13:31 -0400
Received: by mail-pl0-f67.google.com with SMTP id j8-v6so9004pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 14:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y9gTulMBBTJUGk4SgomdwgBXUzuch8+LlOsBDLCewZM=;
        b=j/jNjm5JRFOT94MonXpmYjJKgZir+FR3iMvTkV6k0nOKrMPMDe2R3AZKSeg6I15yPq
         +6BMwMwyZc+vSxqyl4sGXOw3/QViDrrYHJ6IYnJMLLjfKSCozDF7CvXSMcZybUWfI3+O
         OkC9W4AUbIpRfmFKEoAYB2Buq1mj7ntD4SUH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y9gTulMBBTJUGk4SgomdwgBXUzuch8+LlOsBDLCewZM=;
        b=gLx4moELtmJsV6NBlxgymDsW3YGe0ENLoI2JfGEriiPTLxAZzbIV3QbeUrbOpUGUyf
         TYpd/hpqFgcnpBiYZkBylmiOigg6/UJ+eBwP9t84T43/f+3TpajCnYvJwuLykqqIH8Ks
         FAEbVQlE/REOxjUyT0z7u4CWbktnAoa4Vdx22u9nfBUhlOZdW1UxQhiuROso1ifM3cYK
         BDjwbJjqiibN9er+CQQuHj1Snx2vXWH29gloSLnqWEB/XXH2uB84mtIpemZkGR9e7G9l
         bR2qVH3/BEvvLN01fqvOybl4GhXel1pR2Ix1mZYEFVnyPMQm3dziGrZKYv2353lhe+ys
         qSIQ==
X-Gm-Message-State: AOUpUlHsP9ieJYcPOMYo/x/MwokustbfrzXo6eRGtajB60ybbe5QBonX
        k5YEnXyxZF4EkzA1RH2kcMAZug==
X-Google-Smtp-Source: AAOMgpdDAYXDfZEss0ZXGDMzIDpNnyKoPKWUZEtfZuJi9PA1TdpJfu7LelCM4irW85ma0rpRTFBykQ==
X-Received: by 2002:a17:902:ab95:: with SMTP id f21-v6mr37594plr.264.1533158747265;
        Wed, 01 Aug 2018 14:25:47 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a15-v6sm43167pfe.32.2018.08.01.14.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 14:25:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v4 1/3] overflow.h: Add arithmetic shift helper
Date:   Wed,  1 Aug 2018 14:25:39 -0700
Message-Id: <20180801212541.22889-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801212541.22889-1-keescook@chromium.org>
References: <20180801212541.22889-1-keescook@chromium.org>
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
index 8712ff70995f..40b48e2133cb 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -202,6 +202,37 @@
 
 #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
 
+/** check_shl_overflow() - Calculate a left-shifted value and check overflow
+ *
+ * @a: Value to be shifted
+ * @s: How many bits left to shift
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
+#define check_shl_overflow(a, s, d) ({					\
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

