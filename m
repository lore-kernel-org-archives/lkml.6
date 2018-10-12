Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E3BC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8DE2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJvuJ0bA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8DE2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeJLRQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:16:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34528 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbeJLRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:16:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id f78-v6so157894pfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xAyKOwFhfVXa41JpM3wlj86fUqX7JkMwQFyIDNIJdFg=;
        b=jJvuJ0bAhmAXwPBw7RAzIpinAzJxzdC1HqcHuqYFRGdgM6pfw1ADcl5aU4Vrb+duh+
         LO9Ae6BY0dP/VPS/w2gbaOILtlhhVAiG88kYZ8N4KFfwQPgs9L0fhFq7Qz6hZAfs/GU1
         CXimR/rFV0cxgePmVhXMRqZxx2s2uPffriiUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xAyKOwFhfVXa41JpM3wlj86fUqX7JkMwQFyIDNIJdFg=;
        b=gR3roiuacdUBm6QeOYVS316MQm+nEd+0TtP8BzA2ETAclJtXW3QuFplJQIfGRtFPiz
         E7BI9ZXEBE//AGjYfWo1fuTFVqv0P5bFO2kGgUpzHROYIYGwfCE8XxQhD3OIYQYuJyH6
         Zi+FWC8Qn3KhUAOGluQRJoraEnAKai4HJ6Vb2yoCm5xZUvM1Fff0/25UbKYLOvzH6eTB
         4ibtWrptJ9ldJV9lFm7K/bxKBI8k5P57VXtPnucweRhtsQdHgJu8iN8AAnCdn97btUXN
         glKK+rkLBc5gB7oYthLDOx5anMoJwMp/4wO/sqlsTIDKwJGQDP+tRxJMJsjzsBSMKTZ6
         gRAQ==
X-Gm-Message-State: ABuFfoi8qD6mAPowVIbTQEIcXOE+V4/rf1SQrRA+UXLiVagUg/RWYkax
        UnJrqG1YuXIkxqEuT/BgDr8ssg==
X-Google-Smtp-Source: ACcGV61wUu9m904S/6vlWcjtb5h78EEGzObbRA9GBVwjTxNcf2cHZ1gYKlBGtKA0Yb/cIdTuO2RpxA==
X-Received: by 2002:a62:670a:: with SMTP id b10-v6mr5285319pfc.243.1539337507342;
        Fri, 12 Oct 2018 02:45:07 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.108.175])
        by smtp.gmail.com with ESMTPSA id j19-v6sm1254191pfi.137.2018.10.12.02.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 02:45:06 -0700 (PDT)
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
Subject: [PATCH v4 5/6] parisc: wire up rseq system call
Date:   Fri, 12 Oct 2018 15:14:01 +0530
Message-Id: <1539337442-3676-6-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up rseq system call requires an architecture specific
implementation as it not present now.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/kernel/syscalls/syscall.tbl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 7c9f268..91317be 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -366,4 +366,6 @@
 347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
 348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
 349     common  statx                           sys_statx
-350	common  io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
\ No newline at end of file
+350	common  io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
+# rseq requires an architecture specific implementation
+351	common	rseq				sys_rseq
-- 
1.9.1

