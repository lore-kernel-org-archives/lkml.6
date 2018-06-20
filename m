Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145B0C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A19208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lEJigrz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A19208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932411AbeFTPYk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:24:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42768 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754093AbeFTPYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:24:34 -0400
Received: by mail-wr0-f195.google.com with SMTP id w10-v6so3725337wrk.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XKjQm946wgqBcvKf36FFRVltlqNjqNquoHht/aDg6nU=;
        b=lEJigrz2OiWBxMqQ2GbgTMNaf8HM5o4WfSODpVX11gR3uVG3NYEkX6OOAxhXBkO2VM
         jomcNT4FHr5zvHDoAr14vO7x6jbK/mhwcwrRvRYcV3f14W3VEREc3BgU5Uu4PLBrMPvd
         AxlLMDnVf6PytDxds14J7F6wIztQmBZ8ZVXxk0wQd7oBiM5FB87jNG8Z8VbYARGtapY0
         Jqj71BFYcO6Arm4MqZyQEoxU7h9jidia7mGzCLpPPKekORuZtnizCR4o1aemqWBVwI7r
         m/qrma4RcAX2hw+LUNMM9RiOQUTiUZer0boGMlOxJt1C6TjzUg1yXvyarAOiHl0ijDnv
         X7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XKjQm946wgqBcvKf36FFRVltlqNjqNquoHht/aDg6nU=;
        b=QoWpqBRSvDlt7DkhtFyCRcT0npg+eIYhqQYq7JO6o7/gpY9EgMifG8MQ4qBKxi7zTK
         GBje4aicVg/dWcU4eRA/un6c875yKMYKEhjt8KKFsn5wckfnNV1oD2WON3x3ryNZsFVT
         PKs1S5ttaLKrOhNMKaOQN8SajHT0ZqvQ0tb5o1N+if6QuHryXaMGiBhXXcmuUVXCT4md
         HPCGvoyW3yif0pwowJtyZ93ZO/qPbvqY7FhzjNMvejyPn3yu30USwBGYb5Jya/hgTyRb
         8MlxuEnM/DX0O84fNlY3wOunfT0LhtxgIetPs+bxPm5Jz9tYMFA1UCrwEGwJO5qNxiie
         rzOQ==
X-Gm-Message-State: APt69E0sY3M9OBLEmPlzUa8+vjTuuNyU8PLJJ+O7qhNNZHETYloZbOAR
        tR9PS06cgn5DS3+ZKo8nev28sg==
X-Google-Smtp-Source: ADUXVKKaG9tLMBQSmpdBkcvCAygtoJeNPH5U1f8+dJ0VYDreDtubosvrhkERRf+42VqZN8GkOQZ0gA==
X-Received: by 2002:adf:a706:: with SMTP id c6-v6mr19077169wrd.61.1529508272731;
        Wed, 20 Jun 2018 08:24:32 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id c11-v6sm3959244wrm.65.2018.06.20.08.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 08:24:32 -0700 (PDT)
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
Subject: [PATCH v4 2/7] uaccess: add untagged_addr definition for other arches
Date:   Wed, 20 Jun 2018 17:24:21 +0200
Message-Id: <a937551f03c4617aa400fb75130627df7ed09506.1529507994.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <cover.1529507994.git.andreyknvl@google.com>
References: <cover.1529507994.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow arm64 syscalls accept tagged pointers from userspace, we must
untag them when they are passed to the kernel. Since untagging is done in
generic parts of the kernel (like the mm subsystem), the untagged_addr
macro should be defined for all architectures.

Define it as a noop for other architectures besides arm64.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index efe79c1cdd47..c045b4eff95e 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -13,6 +13,10 @@
 
 #include <asm/uaccess.h>
 
+#ifndef untagged_addr
+#define untagged_addr(addr) addr
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
-- 
2.18.0.rc1.244.gcf134e6275-goog

