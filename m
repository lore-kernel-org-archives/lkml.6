Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEFEC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5C620846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKMog7X2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5C620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754732AbeFTRqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:46:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37019 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754612AbeFTRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:40:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id r125-v6so997163wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p85QUjRuow4dpc/B2Caf2sJdJzBwj5MZiQXcRPnXZZs=;
        b=cKMog7X2WPJDh2SetkEA2LzVcfeVlPSabg492BhqyjJtuk+uD7mTbXUGHMgXgkX0+z
         nce3cY4HpUrBw2dF+w26cohuQ4LNOVcnNXjygWthLCk5admFeUUoeT0ZzaFLe4N4HFjx
         fKpPqS151IMpsM7atSDyWsyMpcCrNy9NQlI2dNd4Du2t4dOjlcjw00mWxwEZWwpfndjG
         3EWMUA95vJDt0+oxJwNAjTg5w4uOiJKAvYJnJZM0head/QBtWLMSQ9Z84Hk09NAOo4YB
         lU0wq9CXKzi00S9pI0LIKDVfcUUf8vgBMRQOCs7XSLki1DUDDpXZ2akjY+iCFrfUVKk/
         6VyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p85QUjRuow4dpc/B2Caf2sJdJzBwj5MZiQXcRPnXZZs=;
        b=iW6gAh15BRTUA02Z1Iuy53ZyV7HPe/qx5j1rmE1UCx0jlgC/ICto/u+FRbk9oXUSb/
         VLgYbJxGDCuyidjUPqI8/O8CjgsTi/RBV0TRL1v8Uk47YKvDqCkf9GNcLx+wZ4L7BZFK
         xfrQsMMn/h8DtfnHENoLTbpsDbJmyhSXMk8n+mLSHDckzgA+mW9SmBMvyrjnTFcUyg9i
         HmKld5Bcjf2dpdMsqlOUWGUxNUsVuoQlTmpc2IMupCdiCHkStp8QkWKx37enG+L0VHpB
         hhAQzEa4WzFehngtLW7tvkeQJCQjIj3DCjx5LGX2ISl8+QLDhopEc/PTfmPS3olzF4Ir
         BHtw==
X-Gm-Message-State: APt69E0Nt7AAGk0TcSC/2kf3Duy9NGrFYXN0agS3dfWRNatmDD/IaCC6
        PqdERVQpM6ehvx+Mr0th2TiH0w==
X-Google-Smtp-Source: ADUXVKI9lnsolI1QB0qhbD0NkTANy1JGmjbguTtaYpBwlZAz0SNSWmijMIO+Jx4xdTEuQeLjLXl71Q==
X-Received: by 2002:a1c:4adb:: with SMTP id n88-v6mr2543982wmi.121.1529516418195;
        Wed, 20 Jun 2018 10:40:18 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id f18-v6sm4388598wro.1.2018.06.20.10.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:40:17 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v3 07/17] khwasan, arm64: fix up fault handling logic
Date:   Wed, 20 Jun 2018 19:39:53 +0200
Message-Id: <719e17667dcf93c2789c2b6c873aa424cfe378b9.1529515183.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <cover.1529515183.git.andreyknvl@google.com>
References: <cover.1529515183.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show_pte in arm64 fault handling relies on the fact that the top byte of
a kernel pointer is 0xff, which isn't always the case with KHWASAN enabled.
Reset the top byte.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b8eecc7b9531..b7b152783d54 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -32,6 +32,7 @@
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/kasan.h>
 
 #include <asm/bug.h>
 #include <asm/cmpxchg.h>
@@ -134,6 +135,8 @@ void show_pte(unsigned long addr)
 	pgd_t *pgdp;
 	pgd_t pgd;
 
+	addr = (unsigned long)khwasan_reset_tag((void *)addr);
+
 	if (addr < TASK_SIZE) {
 		/* TTBR0 */
 		mm = current->active_mm;
-- 
2.18.0.rc1.244.gcf134e6275-goog

