Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB3AECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324CA20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="NUUsh97x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324CA20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbeJ0IDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 04:03:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36912 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbeJ0IDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 04:03:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id c15-v6so2656303eds.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 16:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EU/2CyNaWbgJo/TSrHiDrprabowWA3/XO6olfTldUfc=;
        b=NUUsh97xpTJp4q6Lmp5b4KDvmHdTeylKiFHY7VDVv6gK6EuJ/dPEkaBvhZwYzxn5WO
         rBf4cO1a956vt2cNIhmfQFSlpB9lduLqlZRXzKNiYH0e+3rrCM2yubqVQVnrfv92Dl+T
         cMcJ4Wcu+lUraF93ZrEbqEDMQP7lCz+Bmvqno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EU/2CyNaWbgJo/TSrHiDrprabowWA3/XO6olfTldUfc=;
        b=dTh9IDijeRXZMU/9Sc9mwzFqCdZ3uq5IVl+2elBP2MQOql/aeu8XU8DgTFrcd5lFdY
         KuYyJ3D0cipO+TjapKfPgqFO++a9wEuim+LVwWW3mAuQeDAlhll2PDPwK9LtwUrytqC6
         8OZsjFIfVSUCR+AWuoOnb3ibKTndvh6NFXCcOMiKsuTBzZ6EiqcTYUHDyT4BK3pJYrAc
         5x/iBrA93cICVZqtuF6+4yos4utnWouPGBNE+l9eG47EAMNFcr12UOABDnlCarqKHoC/
         kNYRHgGe48YDNgPO1iI5y3mBq2K8X6dIaqXH9LzKKx2KvuarWb7B1vp2Ran3DXxlDZp1
         EoLg==
X-Gm-Message-State: AGRZ1gLApQcHdWHA5PaSm2370IhHNfrvdRBULXqrFmI4Q2BrfKBCURrr
        hDWf5kHHmIk75vnexhlAFfB3kFJZ8SWiQA==
X-Google-Smtp-Source: AJdET5fhL5lt8cD+Tnvp8RF/HtNSMo/P9XGOIFkoM9nHIYblEU8yzIopJl3av+ho5AmdSqV1bP+3NQ==
X-Received: by 2002:a17:906:2201:: with SMTP id s1-v6mr3696889ejs.31.1540596256060;
        Fri, 26 Oct 2018 16:24:16 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id o13-v6sm3986746edc.95.2018.10.26.16.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 16:24:15 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 3/7] kernel.h: implement fmtmatch() wrapper around fmtcheck()
Date:   Sat, 27 Oct 2018 01:24:05 +0200
Message-Id: <20181026232409.16100-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181026232409.16100-1-linux@rasmusvillemoes.dk>
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users may prefer to check a "user-supplied" string upfront and
return EINVAL rather than using the the template as a fallback for
printf'ing later. fmtmatch() is simply a shorthand for

  fmtcheck(a, b, c | FMTCHECK_SILENT) == a.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/kernel.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8e9154e100c3..c2b710426227 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -507,11 +507,18 @@ _fmtcheck(const char *fmt, const char *tmpl, unsigned flags)
 	return fmt;
 }
 #endif
+
+static inline bool
+_fmtmatch(const char *fmt, const char *tmpl, unsigned flags)
+{
+       return _fmtcheck(fmt, tmpl, flags | FMTCHECK_SILENT) == fmt;
+}
 /*
  * Use of fmtcheck is pointless if the template is not a string
  * literal, so try to enforce that.
  */
 #define fmtcheck(fmt, tmpl, flags) _fmtcheck(fmt, "" tmpl "", flags)
+#define fmtmatch(fmt, tmpl, flags) _fmtmatch(fmt, "" tmpl "", flags)
 
 extern __scanf(2, 3)
 int sscanf(const char *, const char *, ...);
-- 
2.19.1.6.gbde171bbf5

