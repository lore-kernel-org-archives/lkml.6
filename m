Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98CAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D062159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DmEWTtJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D062159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeI0UoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:44:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45066 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeI0UoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:44:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23-v6so2021456pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7063lwYrgYG2z+eMzXz0Gmdpv5PtmN+NtlFSGmDtuMc=;
        b=DmEWTtJ3/AV39KYsmV2tEa3GK2GlOv4arRMn+CHzz99VR+QZc2I8T97iBLDtR2GBuX
         TBx/+7mv2YMUpewBb/ME0ZZLoZiq76c+VoSuHw1DC5J7hLaYL6xKqrjQNjYs4rAiLEi/
         WnqEJiYdFg3mB7wg4RP65W+DH0TqtF62D/bOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7063lwYrgYG2z+eMzXz0Gmdpv5PtmN+NtlFSGmDtuMc=;
        b=YPYQwUtqV12HJ+hhlVtnY6txopRKdKdU6IZTyQP0O5eaTimW6y+a47L+XT8sQC0J83
         C1QXpdPrtzLcSef7O6bnuK6xyNTIQD24v2JQ3l9edR0evzx4ek6l6eTZIm8isuY/EcRn
         /MvyMopf+6RG+rCzenZNmH02UV8jNSyCa1oIKjNoWYMj2uuqtU8GwckIxKJT4X1DUdC9
         N5TNLpKxnL5eoCEz9n/k4rNYeC/o8GgjzOmcsab5sqj4EKP3WU1z3Xoe06Cd5lQzhCsS
         v8EEyHTE+XsOvjPf8Li5xx32RA+E0QO1OX/Q7uD04mhZmJynPJeI7SEdbatLT5zhaR49
         Ohjg==
X-Gm-Message-State: ABuFfoj1hJMYmMAUVpMAQ+FdpDttRVcar7Zj45gU21P901iLuGjH/797
        Nlu+wFMPAwlVMhu1eaZ+YyHGBg==
X-Google-Smtp-Source: ACcGV60hzAovtMFr9sbmK3f2L74IHb0SRD09fSSeTGTdRM7q9qezoNCGJRvcQpSq5cxvC+iUkbXAPA==
X-Received: by 2002:a65:4289:: with SMTP id j9-v6mr10672342pgp.284.1538058330071;
        Thu, 27 Sep 2018 07:25:30 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.105.186])
        by smtp.gmail.com with ESMTPSA id f81-v6sm9717421pfh.46.2018.09.27.07.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 07:25:29 -0700 (PDT)
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
Subject: [PATCH v2 5/5] parisc: add __IGNORE* entries in asm/unistd.h
Date:   Thu, 27 Sep 2018 19:54:27 +0530
Message-Id: <1538058267-3765-6-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add __IGNORE* entries for nfsservctl, io_pgetevents and rseq
in the file asm/unistd.h as it is correct to keep __IGNORE*
entry in non uapi header asm/unistd.h while uapi/asm/unistd.h
must hold information only useful for user space applications.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/asm/unistd.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 93fd9f6..9294e10 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -13,6 +13,9 @@
 #define __IGNORE_pkey_mprotect
 #define __IGNORE_pkey_alloc
 #define __IGNORE_pkey_free
+#define __IGNORE_nfsservctl
+#define __IGNORE_io_pgetevents
+#define __IGNORE_rseq
 
 #ifndef ASM_LINE_SEP
 # define ASM_LINE_SEP ;
-- 
1.9.1

