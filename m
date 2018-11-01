Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D310C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5DB205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ghzf3ows"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5DB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbeKBI5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:57:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41411 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbeKBI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:57:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id k13so102247pga.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mqwkVDx8u21GZbkxyEls8saDvhV3qOz0dHFNVOWzQMc=;
        b=ghzf3owsbJIK+PJoK3cC+CdhuUv60OBp8ax7gZKsHciTLIK8NKtyqwBVgqfu5NMzVz
         i5psgC2FJiv/qUsDBTAJK7l8/n0abs22B7BgXoYcazUEfAgfrEN03l3rUr0h82UVY1p4
         XI4Mz8y3d0OmCQIcH/Xls4uVKQ21M0n/qGZgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mqwkVDx8u21GZbkxyEls8saDvhV3qOz0dHFNVOWzQMc=;
        b=YDGnGZ7UDXK+gsY+d8e+fc02Fe8FUxe94e6lVEMCxO0Y7n1xzZdxAemiwnxeiOP2Ot
         Plhlk68OmHu+VsnfXb/nik8X19+KFK8KQDttwCbZV07+LZOs/8MH94YXRDOfXpphRfzj
         Wxv2H3K3KnXNxLCiZ9EsHYdCp4XsBlAYpZxPxwC6TNCtDb0mGtsJnXNvF84MG8hT6IJJ
         JSih1Bfb6OFXO37y+7f6obV0Y9XLb7vItZJdvu1Ter1AaMJVce6s7bUPk08ifOY7wP1n
         vF1hgXzXM6y1ZclHkrjzxS6ha3347AaHCV09qQ3ZX2mbQUoutw/53iTj0jL5BK2gyfgH
         TkIQ==
X-Gm-Message-State: AGRZ1gJEBBmDSQ5SpblHNF9eNaeu3y7AQgcP/nQIh/iankcp9lctRxea
        SqYQ05GPtHXJ+B1DtD6wJtTFFLrIAn61uw==
X-Google-Smtp-Source: AJdET5chxSgFncYycqyj0cEiVkQHMwSWVi7kyjaJ4Qfm1xD2Lx0cQZf2/W8VEXfiIF9l+SfJCgqu5A==
X-Received: by 2002:a63:eb42:: with SMTP id b2-v6mr8870158pgk.348.1541116329557;
        Thu, 01 Nov 2018 16:52:09 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d2-v6sm35463574pfn.118.2018.11.01.16.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 16:52:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 6/8] pstore: Replace open-coded << with BIT()
Date:   Thu,  1 Nov 2018 16:51:58 -0700
Message-Id: <20181101235200.28584-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181101235200.28584-1-keescook@chromium.org>
References: <20181101235200.28584-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor clean-up to use BIT() (as already done in pstore_ram.h).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/pstore.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 877ed81de346..3549f2ba865c 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -189,10 +189,10 @@ struct pstore_info {
 };
 
 /* Supported frontends */
-#define PSTORE_FLAGS_DMESG	(1 << 0)
-#define PSTORE_FLAGS_CONSOLE	(1 << 1)
-#define PSTORE_FLAGS_FTRACE	(1 << 2)
-#define PSTORE_FLAGS_PMSG	(1 << 3)
+#define PSTORE_FLAGS_DMESG	BIT(0)
+#define PSTORE_FLAGS_CONSOLE	BIT(1)
+#define PSTORE_FLAGS_FTRACE	BIT(2)
+#define PSTORE_FLAGS_PMSG	BIT(3)
 
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
-- 
2.17.1

