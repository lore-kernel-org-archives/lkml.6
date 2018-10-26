Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8B2ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E2220868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Eh0lhl7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E2220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeJ0Ci5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:38:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45277 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeJ0Ci4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:38:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id v6-v6so608926pfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xV0ZaleE/jXu3ZKg00hiZ6CZL7FElj5DrU38CJY5PTc=;
        b=Eh0lhl7DBaqZLst0NUJKIAIjEgYCEaNi5L8ECrhrGrS5gY/XVYkJrufy5JntJ8uaX+
         W5K+Jov/tnJQEp+ht8KF6O2NFDG//5I69xwfLoc6+7AN2JSHWbCW1RU2ItqW/VdrvAD9
         hqgx9sXGnHhmf9qK8C+O0dnE/m/BnkOYCcBAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xV0ZaleE/jXu3ZKg00hiZ6CZL7FElj5DrU38CJY5PTc=;
        b=BRfr0TkIofif4Nf1LnKwpfcUpcIF+pf3Qh1wlZz6tQpPRrJHPSht3qRIi2xCwdC1cr
         5ITUUtaSvPY3CewqO5f+KDsNIPmupLy6lMw9A9MO9QmQLy9JfIVQUAy4/8p7j3n1X36v
         a/xcXtREP6KfG5xN/5r17S0il+kqFoChe31xugqsecdUKGlVVzPo/FrJWHsNOZSBDmVB
         XUOVxsr/UwMPbc+bWv9u2dcvo7Z7Vq3/a/aEZHJaOz7F64X79VW7cskvxKz7/2ZZUF5N
         knLtV2fdlhzAoICpnceOKT7jWoS5SMBwI7VnEKSfEJ05zkSnLP+wXK5/BgMwnKDsvhjJ
         4IcA==
X-Gm-Message-State: AGRZ1gJhGtugfgGltcnmM5wgvptIDtA6OXjZAPyNSzOs6h/lwTTMacEQ
        rFjCz2/ZciAhSS+HHtE6J3Fz2W4nK8k=
X-Google-Smtp-Source: AJdET5fbDX5hZwf/aBzz53hkKvlByu2wt07CW5iqki6eWazmEJqqlOPkyJHXMJ+e45ZIY1vOltEpkA==
X-Received: by 2002:a63:6746:: with SMTP id b67-v6mr4463627pgc.310.1540576857216;
        Fri, 26 Oct 2018 11:00:57 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id v5-v6sm17521243pfd.64.2018.10.26.11.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 11:00:56 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Subject: [RFC 5/6] pstore: donot treat empty buffers as valid
Date:   Fri, 26 Oct 2018 11:00:41 -0700
Message-Id: <20181026180042.52199-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181026180042.52199-1-joel@joelfernandes.org>
References: <20181026180042.52199-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pstore currently calls persistent_ram_save_old even if a buffer is
empty. While this appears to work, it is simply not the right thing to
do and could lead to bugs so lets avoid that. It also prevent misleading
prints in the logs which claim the buffer is valid.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/pstore/ram_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 0792595ebcfb..1299aa3ea734 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -495,7 +495,7 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 
 	sig ^= PERSISTENT_RAM_SIG;
 
-	if (prz->buffer->sig == sig) {
+	if (prz->buffer->sig == sig && buffer_size(prz)) {
 		if (buffer_size(prz) > prz->buffer_size ||
 		    buffer_start(prz) > buffer_size(prz))
 			pr_info("found existing invalid buffer, size %zu, start %zu\n",
-- 
2.19.1.568.g152ad8e336-goog

