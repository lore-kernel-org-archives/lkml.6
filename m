Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EC2C1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBC3208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u0WfB6NH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBC3208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932564AbeFTPZ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:25:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37256 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932232AbeFTPYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:24:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id r125-v6so228442wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bcED8CkiPVSBRc7qI0iNRMFkXBn8RO25/zBGmIuPiVM=;
        b=u0WfB6NHI0Vfw7EUk1hYoNDh4hKDvHY5AQ1L20Ifpw+DC9bnAndbsAlNeEdQnwoNmh
         6DBLsQtVWl4D2QlrBsjOWU+CQ88q0QBpIFSovLwoUVVj2Oo+TRuWS+jep3kcbjoHF18h
         g1SSSxxpROYeNG4T89d/1j8RGHCjcwzUHxHDamDEa6mJ0bcDEsQai35SxKS2qNkwqWNV
         VlnjcjgB5lWq9Qtaa/Agqo0s93y929vNRTENIu+a1EFHO94YDA39tUYN8IfaZvaEcGNh
         jHTFif6pvTIQDoJwTGXZLDTxD8rXt6+ccCKoI1BsYITIWQPkDqYzpFDVCxXEEwcLjWEC
         khvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bcED8CkiPVSBRc7qI0iNRMFkXBn8RO25/zBGmIuPiVM=;
        b=eCTG7b+M5Iy+6Mj0t+bXMoxR24LTZY7DnqmrAxB72HTd7zzs7gff+NvpmP188KyxYT
         UE2cU0rONdK1aey5kQVAQKD4TqZRBhSJwQ6Ebps4+Ik6IrerXZqU/mGgRs0oRC3RWgQA
         2FQ8qn28o47PQHYenuaBIM/er3+6uLV5O8OiEA54ed1sO/BCA4Nita74r76A+mrFxemM
         qSi9+XWqdDq4+ap22j94SUESfaqMB1KLdGUwj8w38god79/l7fxmSC9iRi23FQepFNWo
         AqAxqAE8qZfopZc5ekbcPxt0iXZSAqmkVRMe1SkXqOeT3elBTz8EAaiuRZyATaDKpRTJ
         n4hw==
X-Gm-Message-State: APt69E1uvBjgEM2h1P5gdHL5j7wgSmaWTUhY9f3sqb1UHBP1frlKQ3Mr
        Lq3nuPwTQmp/8zYF/X39m/k8sg==
X-Google-Smtp-Source: ADUXVKJIWiVncHhLaq0gFfeTZGXtQPrH564Sy27fJti3VUKRpFj/LKkRGrTK/X22BIXNVbMclEsO2Q==
X-Received: by 2002:a1c:ae8b:: with SMTP id x133-v6mr2238049wme.125.1529508277688;
        Wed, 20 Jun 2018 08:24:37 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id c11-v6sm3959244wrm.65.2018.06.20.08.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 08:24:36 -0700 (PDT)
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
Subject: [PATCH v4 5/7] lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
Date:   Wed, 20 Jun 2018 17:24:24 +0200
Message-Id: <8ccd13e2d13dea7143bd8b5be44b733c03aa3c02.1529507994.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <cover.1529507994.git.andreyknvl@google.com>
References: <cover.1529507994.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to handle the case of tagged user addresses separately.

Untag user pointers passed to these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/strncpy_from_user.c | 2 ++
 lib/strnlen_user.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index b53e1b5d80f4..97467cd2bc59 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -106,6 +106,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	src = untagged_addr(src);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 60d0bbda8f5e..8b5f56466e00 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -108,6 +108,8 @@ long strnlen_user(const char __user *str, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	str = untagged_addr(str);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)str;
 	if (likely(src_addr < max_addr)) {
-- 
2.18.0.rc1.244.gcf134e6275-goog

