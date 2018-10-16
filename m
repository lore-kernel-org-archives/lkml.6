Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1E8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00079208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxAfAsfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00079208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeJPOxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:53:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42468 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeJPOxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:53:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id c8-v6so10519302plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 00:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0PBH0SiDBTS5A/xCIVzOHbzcxzD+kYNUD3TokR7YxPA=;
        b=UxAfAsfi9OW33xPWIKH8W6SO5E0lr4Jnir5detcjPRXnGlVfot+h5RZPOBX4pHw+lP
         usF+WeYQMmGnEApGO+Ms4A+oXJWEOM6MSXnpY+qfi79QXFQAlOD+qen7DjgvKnYn/02t
         IOarYai+UPBJhSNHGJWk+z4VkeV+HDAVqLL3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0PBH0SiDBTS5A/xCIVzOHbzcxzD+kYNUD3TokR7YxPA=;
        b=OTonqDu6Pw1lsY9BOGrfPIcgjp0fdJTG36+cfU70AchFeAwknw9Y+Ic+clS3wv2MGe
         lsr1+E+pEjkZMc699Sv21FQU2QCqksShAZkuRyikwQ8LNCy+pVs0queeKdljnJzOVlxh
         jNSQT1o7a0R0UsO05MmOaaBEyArcGlv0CdO0l8dIfu6BRdS4+8KhbyboZnVFwYEZM1OR
         +aylQKH9s76kDQkhelfB2zUuzwn4Qlxa4XvRGR4AbJhH4Hr4mnsg8ox60UWznYJb+NOW
         zzjBGeso/fEZaMs0GgmLApTkW741isPRfDUlkeaWSApvLqMlmsMUxdJIZaNK6rLGFPu9
         qMrQ==
X-Gm-Message-State: ABuFfoijKAgE0k0qXNzIflu2ojrDHVt5/IigCfDTYU0sBiyGpxFCH8cB
        7p5bJOWtI+aa5oyk4WB9w+RMXZ55tbA=
X-Google-Smtp-Source: ACcGV63QvT8vEmiyCWkXKEHdUgANI0yQz0Pz7bD4n3D1SsXe14j0o2xsD2VfzFhsSNW3mtx/YKwECg==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6-v6mr19704687plt.19.1539673474071;
        Tue, 16 Oct 2018 00:04:34 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id u21-v6sm21775107pfa.176.2018.10.16.00.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 00:04:33 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v5 5/5] parisc: syscalls: ignore nfsservctl for other architectures
Date:   Tue, 16 Oct 2018 12:33:38 +0530
Message-Id: <1539673418-7279-6-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539673418-7279-1-git-send-email-firoz.khan@linaro.org>
References: <1539673418-7279-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an exception to the syscall table checking script.

nfsservctl entry is only provided on x86, and there is no
reason to add it elsewhere. However, including it on the
syscall table caused a warning for most configurations on
non-x86.

<stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 scripts/checksyscalls.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index ee3dfb5..cf93100 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -150,6 +150,7 @@ cat << EOF
 #define __IGNORE_uselib
 #define __IGNORE__sysctl
 #define __IGNORE_arch_prctl
+#define __IGNORE_nfsservctl
 
 /* ... including the "new" 32-bit uid syscalls */
 #define __IGNORE_lchown32
-- 
1.9.1

