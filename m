Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40878C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B49421746
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFPgt1tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B49421746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbeI1NKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:10:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32900 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1NKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:10:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so3653262pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7VTwSew5JIQjBLJLLspuwEGyotzVxuUjhT6Cc4QWEY=;
        b=bFPgt1tplsXabUlQ6hCzj2urb7BtDmJeuUmQva+Qncik1zkUYv5VHI6lhF9oOye8/v
         Y+S8c0we9UP5r2SRWTJPjX3n6RRhyhpPNrtbFUtyk0LpbSHuAhLhWx3E0PCMQvFW8dky
         /BDwKAUo+vJkN8g49u451SCfEhAxV+z5uq9VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7VTwSew5JIQjBLJLLspuwEGyotzVxuUjhT6Cc4QWEY=;
        b=LMHpPceaxX/uE1dU7m1rYSvgKNgvGevQIlUPTpaZeeThMkdV2IPRswLsFc2oJKX9pX
         6u3C76IrYlYHlGBChFIxYhzodCKScBJTR9UyFWKKkrGI82iu48lsK89tCd9ddsbK5LU5
         FJtJhMUz3kEO817De2cUqowKxXdeYiQUxo8ZkAsFF6g44B5eQ/pIbI+ZbGRk8k/Vn3vd
         MVz5l7QlzjrzIT0BTwMus2GiPg3aGpE/s5ehgiG67yuqZQc4i47LiFPPMHK2GBMpscMe
         p2NEJ8E0w0/ogRgxfwBL4KGXmVpnMqHe93a2ZciINtzHEAPwTHW/foRYtqFqOFOM0Oqg
         e1+g==
X-Gm-Message-State: ABuFfoif+7JbaKaeIc3aCJEaDh3QoK6ANc7mbZgQ1yUOfNFDZJ9ZlY73
        Gjs6GoakuS+wNAHAjG0oi574YA==
X-Google-Smtp-Source: ACcGV60VsEfy4rHhSlzP39UhpLCxpTClvNHcMNcg8Na087wbleYoeOwk+QV8NKrRCfjQRYnCHYZgfw==
X-Received: by 2002:a62:3644:: with SMTP id d65-v6mr15022082pfa.133.1538117279596;
        Thu, 27 Sep 2018 23:47:59 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id f6-v6sm5312638pgf.52.2018.09.27.23.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:47:58 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v15 01/16] asm-generic: add kexec_file_load system call to unistd.h
Date:   Fri, 28 Sep 2018 15:48:26 +0900
Message-Id: <20180928064841.14117-2-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928064841.14117-1-takahiro.akashi@linaro.org>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial user of this system call number is arm64.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index df4bedb9b01c..acea91e49523 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -736,9 +736,11 @@ __SYSCALL(__NR_statx,     sys_statx)
 __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_rseq 293
 __SYSCALL(__NR_rseq, sys_rseq)
+#define __NR_kexec_file_load 294
+__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 
 #undef __NR_syscalls
-#define __NR_syscalls 294
+#define __NR_syscalls 295
 
 /*
  * 32 bit systems traditionally used different
-- 
2.19.0

