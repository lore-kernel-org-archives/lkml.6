Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B2CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAD121529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ay1bv2lJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAD121529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbeITUvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:51:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38681 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387971AbeITUvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:51:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so4514706pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b7XES3pVDyKMb278bmG0nPev8a+WvFLHfK478xOeOjg=;
        b=Ay1bv2lJYEgF9XilsiFdNboG5HRVJrj57TyTjfPCKIWIfMFhJakuRIB3PSn/z6gp+Q
         jozVCiIag9vk7ULAnGaX++EmdR6AIqcQ5LbIBwT4dZG/GcOdl/70ibqZO5yo7pvahYF2
         betknv3j6EsiX/+MB711r9d6R91LsCo9+whkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b7XES3pVDyKMb278bmG0nPev8a+WvFLHfK478xOeOjg=;
        b=gOFHzZcO/Am8/bR6i+vqmLtPADcFHpQCzXdsye4mTeFl+wsmwqKWFi7JSC+tt2B3lD
         zPTTJ2J6dGUe6h674Et4tALsH/7S34mPIIh2kNEusxMysbr7Wxfnjel0Pw+4Uu279Kc3
         LDFW3rMuuYvETBHbPNQ1eupLWHmXUJku6C5o0iagHVfEGaKqWvLIYGf3Zwm/AKu+m/pc
         2yur5gJvr0t40yZgK/pQ8RgxXfKBUS7UI3aLT5PELx/N3Hl9srEDaMhs7nNtFaMkhWOX
         rNGdvKyRUl6WFpjaGU6eDQwEiklQtXtYmWimj0SI1CZJz5oDW2obSv1nt7r2jfmko7sW
         rOwg==
X-Gm-Message-State: APzg51DplrvdbllU83IRgWKLwIA9NBlnGvAi2sAHRDyT75Fw5ePMpksz
        sPvrAVH+hqQUaFS8TZ072sHXTQ==
X-Google-Smtp-Source: ANB0VdZJDwFc+k+MN6HpSotu9JwqWgfJ8B6o2F49oQ2a/5zcGyQ+LJxIVeOc71HqA5HkdEcrugaWww==
X-Received: by 2002:a63:ca09:: with SMTP id n9-v6mr37191235pgi.287.1537456029607;
        Thu, 20 Sep 2018 08:07:09 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.107.142])
        by smtp.gmail.com with ESMTPSA id k64-v6sm36222991pfg.141.2018.09.20.08.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 08:07:09 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 5/5] m68k: added __IGNORE* entries in asm/unistd.h
Date:   Thu, 20 Sep 2018 20:36:13 +0530
Message-Id: <1537455973-12468-6-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added few __IGNORE* entries for seccomp, pkey_mprotect,
pkey_alloc, pkey_free, io_pgetevents and rseq in the file
asm/unistd.h as it is correct to keep __IGNORE* entry in
non uapi header asm/unistd.h while uapi/asm/unistd.h must
hold information only useful for user space applications.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/m68k/include/asm/unistd.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 5072e94..cc5f640 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -31,4 +31,11 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 
+#define __IGNORE_seccomp
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+#define __IGNORE_io_pgetevents
+#define __IGNORE_rseq
+
 #endif /* _ASM_M68K_UNISTD_H_ */
-- 
1.9.1

