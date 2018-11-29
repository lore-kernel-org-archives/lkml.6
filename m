Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6241C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FB121019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LRsGk6n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FB121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeK3KQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:16:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37299 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeK3KQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:16:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so1792057plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j9eLDiNrGtWvv9JRRa/v14r7DjmZRHktyyODtmPpqUw=;
        b=LRsGk6n9AfWKCd8tkP5bEvhtYn6QevdBkonknNuwpk/IViqUqUuCoL4lN8Cc+8vUQG
         6pO2TJVK9WVm5XJtgh246kEruDCwSIGeqMxXCKfpN0QJFB+SB0AONQ25s7whrdhCy8+M
         HIVZ57vpXJxUnermmdbx9sgYLGCCMSdnZkxWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j9eLDiNrGtWvv9JRRa/v14r7DjmZRHktyyODtmPpqUw=;
        b=c15DMkYjYrXMOGgmaYY+sI7WltihlCk1tj4c+hU5XKuqw4DinYjfR7YDgpfyjF0UWE
         Lnk2livsB1nk6eJXH9ekaNvy5ft7pLFc6VopwY4DgVeSL5FQbRVw6lU+gIQSWzH7iGj+
         DwHVKOCOdsszWM4hwaWrRYTui3sBbZ5pLLRJHxnohv9ee1gi50oz2SE4aHCsJc02EbV0
         d74YyC10StmS61fD7KO6IExGEhB1p99IVshc/lx2oDue6D5mZWZWN0KpCDs/J27iPyYw
         nc7xWOCP9RFOgYVBhlFR1+vjBW6eZTy0EOC6Wdcnw4JYQNa1OqRBN2vT2150ocH4h/Uu
         xkQQ==
X-Gm-Message-State: AA+aEWaaL3lvJcW5Xah9/T+HkDmnXkuh9Stt4rR1kaW1GsIn3/xL/8he
        V/dzDJvLToKyODB2PsSmAkYNaQ==
X-Google-Smtp-Source: AFSGD/WsFDGtPtneqpgTDaJMnXgel7y86SYzqkyuHXaHMK8OPAEwCeJHnXq4HExQzTGCtrELAvpSfg==
X-Received: by 2002:a17:902:7201:: with SMTP id ba1mr3343102plb.105.1543532941935;
        Thu, 29 Nov 2018 15:09:01 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y66-v6sm4263011pfy.24.2018.11.29.15.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:08:56 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH -next v2 12/12] pstore/ram: Do not treat empty buffers as valid
Date:   Thu, 29 Nov 2018 15:08:41 -0800
Message-Id: <20181129230841.29955-13-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129230841.29955-1-keescook@chromium.org>
References: <20181129230841.29955-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The ramoops backend currently calls persistent_ram_save_old() even
if a buffer is empty. While this appears to work, it is does not seem
like the right thing to do and could lead to future bugs so lets avoid
that. It also prevents misleading prints in the logs which claim the
buffer is valid.

I got something like:

	found existing buffer, size 0, start 0

When I was expecting:

	no valid data in buffer (sig = ...)

This bails out early (and reports with pr_debug()), since it's an
acceptable state.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index e6375439c5ac..c11711c2cc83 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -511,6 +511,11 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 	sig ^= PERSISTENT_RAM_SIG;
 
 	if (prz->buffer->sig == sig) {
+		if (buffer_size(prz) == 0) {
+			pr_debug("found existing empty buffer\n");
+			return 0;
+		}
+
 		if (buffer_size(prz) > prz->buffer_size ||
 		    buffer_start(prz) > buffer_size(prz)) {
 			pr_info("found existing invalid buffer, size %zu, start %zu\n",
-- 
2.17.1

