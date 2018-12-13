Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B77C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D68C20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+sCtSQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D68C20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeLMM3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:29:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39682 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeLMM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:29:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so1419011lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 04:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dV/hTXIxVkiR8Pqom795rivE/QoTWKlVk+8ZPKo7nNc=;
        b=Z+sCtSQI6d1w2PyQTZN3DSOEeHe7h7NWF/mHHQ5hviG9BVIsKVRhe0TzIsW6hh54Oh
         4aeDLIWayzBhy9/AO0Td3p7RTvtnUp2s0KLQtj1EYYICt+THa6dEROo4n8h2Mwwkc8hn
         8tfeOSyVhTBGl/KxBge1amBG07ixCE7syRkHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dV/hTXIxVkiR8Pqom795rivE/QoTWKlVk+8ZPKo7nNc=;
        b=Zm4/s+K/5JSUgBKy1gzS/bmcqOyw9fwR63CUk9LjbUt0l03zN3CVUfpjjK4a2fKZQ7
         liPonwJ7odQ4SU6cjnX20NACd+hOpCwwHWPOS1DLR5h0eEhknDv2ZGNrWR6R1bkuH3PZ
         WvDYI356VPxPksazqvWJvABdYw8Uf8hkCrHPjcbQ9Q2DNPyAs+0+w00aB8mOoec8X64z
         B0BbsPQcMArZ/Yrjx4YgCQ/nlP8tg/2gy5Ci9EvrLnqCTNuQalCSEzn1zIBQuxPpQTR5
         29XqwBgm4YUV/lDz0oqAP3NW8+ekN0fb1VgwvaHVayIsPk3Bco+UFEfqkZhP9g/wItGB
         sB4g==
X-Gm-Message-State: AA+aEWaAuTqC+OMngLuoqzSaHl2UQsymN4n957HXnzZTrrdcaoDoUBNj
        ibB9tJVfMsYqeaVBBq00Fido1oug+Ci1kA==
X-Google-Smtp-Source: AFSGD/WGnUbCwnqR/8YLOOwvbJvg9i/miEeExHChmrNw4pOVz/psFSmn5g2Q2lZYF2tfTcwXEDrBKw==
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr13430696lfe.154.1544704188129;
        Thu, 13 Dec 2018 04:29:48 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id q67sm328120lfe.19.2018.12.13.04.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 04:29:47 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        mingo@redhat.com, rostedt@goodmis.org, akpm@linux-foundation.org,
        broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [RFC PATCH 2/3] lib/ubsan: default UBSAN_ALIGNMENT to not set
Date:   Thu, 13 Dec 2018 13:29:09 +0100
Message-Id: <20181213122910.24193-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213122910.24193-1-anders.roxell@linaro.org>
References: <20181213122910.24193-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting an allmodconfig kernel, there are a lot of false-positives.
With a message like this 'UBSAN: Undefined behaviour in...' with a call
trace that follows.

Reworked so that when building a allmodconfig kernel that turns
everything into '=m' or '=y' will turn off UBSAN_ALIGNMENT.

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/Kconfig.ubsan | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 98fa559ebd80..a2ae4a8e4fa6 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -27,15 +27,19 @@ config UBSAN_SANITIZE_ALL
 	  Enabling this option will get kernel image size increased
 	  significantly.
 
-config UBSAN_ALIGNMENT
-	bool "Enable checking of pointers alignment"
+config UBSAN_NO_ALIGNMENT
+	bool "Disable checking of pointers alignment"
 	depends on UBSAN
-	default y if !HAVE_EFFICIENT_UNALIGNED_ACCESS
+	default y if HAVE_EFFICIENT_UNALIGNED_ACCESS
 	help
-	  This option enables detection of unaligned memory accesses.
-	  Enabling this option on architectures that support unaligned
+	  This option disables the check of unaligned memory accesses.
+	  This option should be used when building allmodconfig.
+	  Disabling this option on architectures that support unaligned
 	  accesses may produce a lot of false positives.
 
+config UBSAN_ALIGNMENT
+	def_bool !UBSAN_NO_ALIGNMENT
+
 config TEST_UBSAN
 	tristate "Module for testing for undefined behavior detection"
 	depends on m && UBSAN
-- 
2.19.2

