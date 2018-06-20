Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B10C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A57A208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPbnnnAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A57A208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932226AbeFTPYi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:24:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46860 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754088AbeFTPYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:24:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id v13-v6so3708091wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mm1YNP9Ul3FYJxo+KbOILzENXhNHWqhxl+fse8OVffY=;
        b=iPbnnnAt3M8bu/Ho4NjyfbSAFKix3zP+XQfYWw4RRZbsdaybrOEFdvT1NBzs/gY0sf
         bSeAe3PE0G96300Ua7EzTuvBfpsM9rlYd7bANlf65xvDStKUPuwxgKzFLWHnH0L0CQSs
         jMgUOO6mzAXmEKg1So3ZI8wmRM9exvTYo0I5RE6jjzytNC0C7fdas0QQl2w6Q/wShwbL
         6gT0FXgpJOw06XL+ZwsNazJdeux+BlUiQ/+w9saPXRVUZdLI1ZiLysdzff2otLlz/uRZ
         AqdYLRPdfPFvVZp8II7H3JmqKR8rKvP9ZC9rBvtWsTlZCvGIpCYk7nfLzut4+1ulekRa
         2suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mm1YNP9Ul3FYJxo+KbOILzENXhNHWqhxl+fse8OVffY=;
        b=CVt1PfOANauKPLHxZV2Xwp0FE7TabXKPsDYZ7l3Aiui1cRvaG0dFrLWEghzOK0bc8f
         q4AJd+i9Mx08QaHBYTMpUYj03kBA/iAeYNXnGpRS8rPYqvyj1pkGQdMbvdGUXyyjDX4c
         Dew2Xh4fvBcMixClIp67w75B5XKpU0j59VzV1C7/qi5VwWDFWHW6Nvr45UE5aCRpkeBr
         CQlsSl3fQ21MhDNcXnerOd+K88Kg7+sCD0HROFcmdnNEx9xQ+wATZpeRgGPvR0U2HLpf
         o75BR6rz++pPG8FHEokV1iMnsslBm/SBjwcuyZE4wWVRf7k9hu04+X73dDfWJ5STwbR+
         ML6g==
X-Gm-Message-State: APt69E0q+Gth7rF9vMKYoKVj/zrEABzd0VaERpLerXJVovh11waWCbP4
        037+c2MC0tw9r9p/t4YSt39qtw==
X-Google-Smtp-Source: ADUXVKKXRALsqaTpNj7ivIBU4ORwT4h9PJi4fUAXo7LPNLo1V3M0y/Twv51y3Wg70ebG+ok55pQEAA==
X-Received: by 2002:adf:bb51:: with SMTP id x17-v6mr1438112wrg.244.1529508271396;
        Wed, 20 Jun 2018 08:24:31 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id c11-v6sm3959244wrm.65.2018.06.20.08.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 08:24:30 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v4 1/7] arm64: add type casts to untagged_addr macro
Date:   Wed, 20 Jun 2018 17:24:20 +0200
Message-Id: <6d0ef0da936f76a215a5bae7784eba67ce1967e5.1529507994.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <cover.1529507994.git.andreyknvl@google.com>
References: <cover.1529507994.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the untagged_addr macro accept all kinds of address types
(void *, unsigned long, etc.) and allows not to specify type casts in each
place where it is used. This is done by using __typeof__.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e66b0fca99c2..2d6451cbaa86 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -102,7 +102,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
  * up with a tagged userland pointer. Clear the tag to get a sane pointer to
  * pass on to access_ok(), for instance.
  */
-#define untagged_addr(addr)		sign_extend64(addr, 55)
+#define untagged_addr(addr)		\
+	((__typeof__(addr))sign_extend64((__u64)(addr), 55))
 
 #define access_ok(type, addr, size)	__range_ok(addr, size)
 #define user_addr_max			get_fs
-- 
2.18.0.rc1.244.gcf134e6275-goog

